Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422692AbWJNPvv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422692AbWJNPvv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 11:51:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422701AbWJNPvv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 11:51:51 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:12239 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1422692AbWJNPvu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 11:51:50 -0400
Date: Sat, 14 Oct 2006 16:51:49 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-m68k@list.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: [PATCH] serial167 __user annotations, NULL noise removal
Message-ID: <20061014155148.GN29920@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/char/serial167.c |   52 +++++++++++++++++++++++-----------------------
 1 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/drivers/char/serial167.c b/drivers/char/serial167.c
index 461bfe0..3af7f09 100644
--- a/drivers/char/serial167.c
+++ b/drivers/char/serial167.c
@@ -839,7 +839,7 @@ #endif
     local_irq_save(flags);
 	if (info->xmit_buf){
 	    free_page((unsigned long) info->xmit_buf);
-	    info->xmit_buf = 0;
+	    info->xmit_buf = NULL;
 	}
 
 	base_addr[CyCAR] = (u_char)channel;
@@ -1354,7 +1354,7 @@ #endif
 
 static int
 get_serial_info(struct cyclades_port * info,
-                           struct serial_struct * retinfo)
+                           struct serial_struct __user * retinfo)
 {
   struct serial_struct tmp;
 
@@ -1376,7 +1376,7 @@ get_serial_info(struct cyclades_port * i
 
 static int
 set_serial_info(struct cyclades_port * info,
-                           struct serial_struct * new_info)
+                           struct serial_struct __user * new_info)
 {
   struct serial_struct new_serial;
   struct cyclades_port old_info;
@@ -1503,7 +1503,7 @@ send_break( struct cyclades_port * info,
 } /* send_break */
 
 static int
-get_mon_info(struct cyclades_port * info, struct cyclades_monitor * mon)
+get_mon_info(struct cyclades_port * info, struct cyclades_monitor __user * mon)
 {
 
    if (copy_to_user(mon, &info->mon, sizeof(struct cyclades_monitor)))
@@ -1516,7 +1516,7 @@ get_mon_info(struct cyclades_port * info
 }
 
 static int
-set_threshold(struct cyclades_port * info, unsigned long *arg)
+set_threshold(struct cyclades_port * info, unsigned long __user *arg)
 {
    volatile unsigned char *base_addr = (u_char *)BASE_ADDR;
    unsigned long value;
@@ -1533,7 +1533,7 @@ set_threshold(struct cyclades_port * inf
 }
 
 static int
-get_threshold(struct cyclades_port * info, unsigned long *value)
+get_threshold(struct cyclades_port * info, unsigned long __user *value)
 {
    volatile unsigned char *base_addr = (u_char *)BASE_ADDR;
    int channel;
@@ -1546,7 +1546,7 @@ get_threshold(struct cyclades_port * inf
 }
 
 static int
-set_default_threshold(struct cyclades_port * info, unsigned long *arg)
+set_default_threshold(struct cyclades_port * info, unsigned long __user *arg)
 {
    unsigned long value;
 
@@ -1558,13 +1558,13 @@ set_default_threshold(struct cyclades_po
 }
 
 static int
-get_default_threshold(struct cyclades_port * info, unsigned long *value)
+get_default_threshold(struct cyclades_port * info, unsigned long __user *value)
 {
    return put_user(info->default_threshold,value);
 }
 
 static int
-set_timeout(struct cyclades_port * info, unsigned long *arg)
+set_timeout(struct cyclades_port * info, unsigned long __user *arg)
 {
    volatile unsigned char *base_addr = (u_char *)BASE_ADDR;
    int channel;
@@ -1581,7 +1581,7 @@ set_timeout(struct cyclades_port * info,
 }
 
 static int
-get_timeout(struct cyclades_port * info, unsigned long *value)
+get_timeout(struct cyclades_port * info, unsigned long __user *value)
 {
    volatile unsigned char *base_addr = (u_char *)BASE_ADDR;
    int channel;
@@ -1601,7 +1601,7 @@ set_default_timeout(struct cyclades_port
 }
 
 static int
-get_default_timeout(struct cyclades_port * info, unsigned long *value)
+get_default_timeout(struct cyclades_port * info, unsigned long __user *value)
 {
    return put_user(info->default_timeout,value);
 }
@@ -1613,6 +1613,7 @@ cy_ioctl(struct tty_struct *tty, struct 
   unsigned long val;
   struct cyclades_port * info = (struct cyclades_port *)tty->driver_data;
   int ret_val = 0;
+  void __user *argp = (void __user *)arg;
 
 #ifdef SERIAL_DEBUG_OTHER
     printk("cy_ioctl %s, cmd = %x arg = %lx\n", tty->name, cmd, arg); /* */
@@ -1620,28 +1621,28 @@ #endif
 
     switch (cmd) {
         case CYGETMON:
-            ret_val = get_mon_info(info, (struct cyclades_monitor *)arg);
+            ret_val = get_mon_info(info, argp);
 	    break;
         case CYGETTHRESH:
-	    ret_val = get_threshold(info, (unsigned long *)arg);
+	    ret_val = get_threshold(info, argp);
  	    break;
         case CYSETTHRESH:
-            ret_val = set_threshold(info, (unsigned long *)arg);
+            ret_val = set_threshold(info, argp);
 	    break;
         case CYGETDEFTHRESH:
-	    ret_val = get_default_threshold(info, (unsigned long *)arg);
+	    ret_val = get_default_threshold(info, argp);
  	    break;
         case CYSETDEFTHRESH:
-            ret_val = set_default_threshold(info, (unsigned long *)arg);
+            ret_val = set_default_threshold(info, argp);
 	    break;
         case CYGETTIMEOUT:
-	    ret_val = get_timeout(info, (unsigned long *)arg);
+	    ret_val = get_timeout(info, argp);
  	    break;
         case CYSETTIMEOUT:
-            ret_val = set_timeout(info, (unsigned long *)arg);
+            ret_val = set_timeout(info, argp);
 	    break;
         case CYGETDEFTIMEOUT:
-	    ret_val = get_default_timeout(info, (unsigned long *)arg);
+	    ret_val = get_default_timeout(info, argp);
  	    break;
         case CYSETDEFTIMEOUT:
             ret_val = set_default_timeout(info, (unsigned long)arg);
@@ -1664,21 +1665,20 @@ #endif
 
 /* The following commands are incompletely implemented!!! */
         case TIOCGSOFTCAR:
-            ret_val = put_user(C_CLOCAL(tty) ? 1 : 0, (unsigned long *) arg);
+            ret_val = put_user(C_CLOCAL(tty) ? 1 : 0, (unsigned long __user *) argp);
             break;
         case TIOCSSOFTCAR:
-            ret_val = get_user(val, (unsigned long *) arg);
+            ret_val = get_user(val, (unsigned long __user *) argp);
 	    if (ret_val)
 		    break;
             tty->termios->c_cflag =
                     ((tty->termios->c_cflag & ~CLOCAL) | (val ? CLOCAL : 0));
             break;
         case TIOCGSERIAL:
-            ret_val = get_serial_info(info, (struct serial_struct *) arg);
+            ret_val = get_serial_info(info, argp);
             break;
         case TIOCSSERIAL:
-            ret_val = set_serial_info(info,
-                                   (struct serial_struct *) arg);
+            ret_val = set_serial_info(info, argp);
             break;
         default:
 	    ret_val = -ENOIOCTLCMD;
@@ -1773,7 +1773,7 @@ #endif
 	tty->driver->flush_buffer(tty);
     tty_ldisc_flush(tty);
     info->event = 0;
-    info->tty = 0;
+    info->tty = NULL;
     if (info->blocked_open) {
 	if (info->close_delay) {
 	    msleep_interruptible(jiffies_to_msecs(info->close_delay));
@@ -2250,7 +2250,7 @@ #endif
 		info->card = index;
 		info->line = port_num;
 		info->flags = STD_COM_FLAGS;
-		info->tty = 0;
+		info->tty = NULL;
 		info->xmit_fifo_size = 12;
 		info->cor1 = CyPARITY_NONE|Cy_8_BITS;
 		info->cor2 = CyETC;
-- 
1.4.2.GIT
