Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965113AbVJEVyU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965113AbVJEVyU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 17:54:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965131AbVJEVyT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 17:54:19 -0400
Received: from xproxy.gmail.com ([66.249.82.202]:16132 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965113AbVJEVyS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 17:54:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=JgOS12Xt99d+A3FkGy0KH5zMxZqvsItR/HX3BAfjq37o6m7ew4mNwApRWPSEEkp88M940KCtd6dI6u9dDAfhYdjVolPO0D9LW8XMCd+GTELVafaeYQiQ4NO95Ogapae/SwZXg2vYZKYka6N9c0q7c21jACGAZqcReLkIA1Mal+o=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: [PATCH] small cleanup for kernel/printk.c - CodingStyle, Whitespace, printk() loglevels...
Date: Wed, 5 Oct 2005 23:56:49 +0200
User-Agent: KMail/1.8.2
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510052356.49823.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Small CodingStyle cleanup for kernel/printk.c
  Removes some trailing whitespace
  Breaks long lines and make other small changes to conform to CodingStyle
  Add explicit printk loglevels in two places.

Linus: Sorry to Cc: you on something as trivial as this, but you /are/ listed as
the author of the file and I couldn't find a relevant maintainer (except for
perhaps Andrew (so I added him to CC as well)).


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

Patch has been compile tested.

 kernel/printk.c |   78 ++++++++++++++++++++++++++++++--------------------------
 1 files changed, 42 insertions(+), 36 deletions(-)

--- linux-2.6.14-rc3-git5-orig/kernel/printk.c	2005-10-03 21:55:39.000000000 +0200
+++ linux-2.6.14-rc3-git5/kernel/printk.c	2005-10-05 23:46:54.000000000 +0200
@@ -10,7 +10,7 @@
  * elsewhere, in preparation for a serial line console (someday).
  * Ted Ts'o, 2/11/93.
  * Modified for sysctl support, 1/8/97, Chris Horn.
- * Fixed SMP synchronization, 08/08/99, Manfred Spraul 
+ * Fixed SMP synchronization, 08/08/99, Manfred Spraul
  *     manfreds@colorfullife.com
  * Rewrote bits to get rid of console_lock
  *	01Mar01 Andrew Morton <andrewm@uow.edu.au>
@@ -148,7 +148,7 @@ static int __init console_setup(char *st
 	if (!strcmp(str, "ttyb"))
 		strcpy(name, "ttyS1");
 #endif
-	for(s = name; *s; s++)
+	for (s = name; *s; s++)
 		if ((*s >= '0' && *s <= '9') || *s == ',')
 			break;
 	idx = simple_strtoul(s, NULL, 10);
@@ -169,11 +169,11 @@ static int __init log_buf_len_setup(char
 		size = roundup_pow_of_two(size);
 	if (size > log_buf_len) {
 		unsigned long start, dest_idx, offset;
-		char * new_log_buf;
+		char *new_log_buf;
 
 		new_log_buf = alloc_bootmem(size);
 		if (!new_log_buf) {
-			printk("log_buf_len: allocation failed\n");
+			printk(KERN_WARNING "log_buf_len: allocation failed\n");
 			goto out;
 		}
 
@@ -193,10 +193,9 @@ static int __init log_buf_len_setup(char
 		log_end -= offset;
 		spin_unlock_irqrestore(&logbuf_lock, flags);
 
-		printk("log_buf_len: %d\n", log_buf_len);
+		printk(KERN_NOTICE "log_buf_len: %d\n", log_buf_len);
 	}
 out:
-
 	return 1;
 }
 
@@ -217,7 +216,7 @@ __setup("log_buf_len=", log_buf_len_setu
  *	9 -- Return number of unread characters in the log buffer
  *     10 -- Return size of the log buffer
  */
-int do_syslog(int type, char __user * buf, int len)
+int do_syslog(int type, char __user *buf, int len)
 {
 	unsigned long i, j, limit, count;
 	int do_clear = 0;
@@ -244,7 +243,8 @@ int do_syslog(int type, char __user * bu
 			error = -EFAULT;
 			goto out;
 		}
-		error = wait_event_interruptible(log_wait, (log_start - log_end));
+		error = wait_event_interruptible(log_wait,
+							(log_start - log_end));
 		if (error)
 			goto out;
 		i = 0;
@@ -264,7 +264,7 @@ int do_syslog(int type, char __user * bu
 			error = i;
 		break;
 	case 4:		/* Read/clear last kernel messages */
-		do_clear = 1; 
+		do_clear = 1;
 		/* FALL THRU */
 	case 3:		/* Read last kernel messages */
 		error = -EINVAL;
@@ -288,11 +288,11 @@ int do_syslog(int type, char __user * bu
 		limit = log_end;
 		/*
 		 * __put_user() could sleep, and while we sleep
-		 * printk() could overwrite the messages 
+		 * printk() could overwrite the messages
 		 * we try to copy to user space. Therefore
 		 * the messages are copied in reverse. <manfreds>
 		 */
-		for(i = 0; i < count && !error; i++) {
+		for (i = 0; i < count && !error; i++) {
 			j = limit-1-i;
 			if (j + log_buf_len < log_end)
 				break;
@@ -306,10 +306,10 @@ int do_syslog(int type, char __user * bu
 		if (error)
 			break;
 		error = i;
-		if(i != count) {
+		if (i != count) {
 			int offset = count-error;
 			/* buffer overflow during copy, correct user buffer. */
-			for(i=0;i<error;i++) {
+			for (i = 0; i < error; i++) {
 				if (__get_user(c,&buf[i+offset]) ||
 				    __put_user(c,&buf[i])) {
 					error = -EFAULT;
@@ -351,7 +351,7 @@ out:
 	return error;
 }
 
-asmlinkage long sys_syslog(int type, char __user * buf, int len)
+asmlinkage long sys_syslog(int type, char __user *buf, int len)
 {
 	return do_syslog(type, buf, len);
 }
@@ -404,21 +404,19 @@ static void call_console_drivers(unsigne
 	cur_index = start;
 	start_print = start;
 	while (cur_index != end) {
-		if (	msg_level < 0 &&
-			((end - cur_index) > 2) &&
-			LOG_BUF(cur_index + 0) == '<' &&
-			LOG_BUF(cur_index + 1) >= '0' &&
-			LOG_BUF(cur_index + 1) <= '7' &&
-			LOG_BUF(cur_index + 2) == '>')
-		{
+		if (msg_level < 0 && ((end - cur_index) > 2) &&
+				LOG_BUF(cur_index + 0) == '<' &&
+				LOG_BUF(cur_index + 1) >= '0' &&
+				LOG_BUF(cur_index + 1) <= '7' &&
+				LOG_BUF(cur_index + 2) == '>') {
 			msg_level = LOG_BUF(cur_index + 1) - '0';
 			cur_index += 3;
 			start_print = cur_index;
 		}
 		while (cur_index != end) {
 			char c = LOG_BUF(cur_index);
-			cur_index++;
 
+			cur_index++;
 			if (c == '\n') {
 				if (msg_level < 0) {
 					/*
@@ -461,7 +459,7 @@ static void zap_locks(void)
 	static unsigned long oops_timestamp;
 
 	if (time_after_eq(jiffies, oops_timestamp) &&
-			!time_after(jiffies, oops_timestamp + 30*HZ))
+			!time_after(jiffies, oops_timestamp + 30 * HZ))
 		return;
 
 	oops_timestamp = jiffies;
@@ -495,7 +493,7 @@ __attribute__((weak)) unsigned long long
 
 /*
  * This is printk.  It can be called from any context.  We want it to work.
- * 
+ *
  * We try to grab the console_sem.  If we succeed, it's easy - we log the output and
  * call the console drivers.  If we fail to get the semaphore we place the output
  * into the log buffer and return.  The current holder of the console_sem will
@@ -639,13 +637,19 @@ EXPORT_SYMBOL(vprintk);
 
 #else
 
-asmlinkage long sys_syslog(int type, char __user * buf, int len)
+asmlinkage long sys_syslog(int type, char __user *buf, int len)
 {
 	return 0;
 }
 
-int do_syslog(int type, char __user * buf, int len) { return 0; }
-static void call_console_drivers(unsigned long start, unsigned long end) {}
+int do_syslog(int type, char __user *buf, int len)
+{
+	return 0;
+}
+
+static void call_console_drivers(unsigned long start, unsigned long end)
+{
+}
 
 #endif
 
@@ -851,9 +855,9 @@ EXPORT_SYMBOL(console_start);
  * print any messages that were printed by the kernel before the
  * console driver was initialized.
  */
-void register_console(struct console * console)
+void register_console(struct console *console)
 {
-	int     i;
+	int i;
 	unsigned long flags;
 
 	if (preferred_console < 0)
@@ -878,7 +882,8 @@ void register_console(struct console * c
 	 *	See if this console matches one we selected on
 	 *	the command line.
 	 */
-	for(i = 0; i < MAX_CMDLINECONSOLES && console_cmdline[i].name[0]; i++) {
+	for (i = 0; i < MAX_CMDLINECONSOLES && console_cmdline[i].name[0];
+			i++) {
 		if (strcmp(console_cmdline[i].name, console->name) != 0)
 			continue;
 		if (console->index >= 0 &&
@@ -933,9 +938,9 @@ void register_console(struct console * c
 }
 EXPORT_SYMBOL(register_console);
 
-int unregister_console(struct console * console)
+int unregister_console(struct console *console)
 {
-        struct console *a,*b;
+        struct console *a, *b;
 	int res = 1;
 
 	acquire_console_sem();
@@ -949,10 +954,10 @@ int unregister_console(struct console * 
 				b->next = a->next;
 				res = 0;
 				break;
-			}  
+			}
 		}
 	}
-	
+
 	/* If last console is removed, we re-enable picking the first
 	 * one that gets registered. Without that, pmac early boot console
 	 * would prevent fbcon from taking over.
@@ -994,7 +999,7 @@ void tty_write_message(struct tty_struct
 int __printk_ratelimit(int ratelimit_jiffies, int ratelimit_burst)
 {
 	static DEFINE_SPINLOCK(ratelimit_lock);
-	static unsigned long toks = 10*5*HZ;
+	static unsigned long toks = 10 * 5 * HZ;
 	static unsigned long last_msg;
 	static int missed;
 	unsigned long flags;
@@ -1007,6 +1012,7 @@ int __printk_ratelimit(int ratelimit_jif
 		toks = ratelimit_burst * ratelimit_jiffies;
 	if (toks >= ratelimit_jiffies) {
 		int lost = missed;
+
 		missed = 0;
 		toks -= ratelimit_jiffies;
 		spin_unlock_irqrestore(&ratelimit_lock, flags);
@@ -1021,7 +1027,7 @@ int __printk_ratelimit(int ratelimit_jif
 EXPORT_SYMBOL(__printk_ratelimit);
 
 /* minimum time in jiffies between messages */
-int printk_ratelimit_jiffies = 5*HZ;
+int printk_ratelimit_jiffies = 5 * HZ;
 
 /* number of messages we send before ratelimiting */
 int printk_ratelimit_burst = 10;
