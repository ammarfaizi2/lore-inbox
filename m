Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965064AbVLVEyV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965064AbVLVEyV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 23:54:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965110AbVLVEx4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 23:53:56 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:37072 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965064AbVLVEva
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 23:51:30 -0500
To: linux-m68k@vger.kernel.org
Subject: [PATCH 29/36] m68k: amiserial __user annotations
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1EpIQL-0004tN-Nl@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Thu, 22 Dec 2005 04:51:29 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>
Date: 1135011762 -0500

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 drivers/char/amiserial.c |   19 +++++++++----------
 1 files changed, 9 insertions(+), 10 deletions(-)

d8103271df26858cf0469fb46f7d5221d7bd62de
diff --git a/drivers/char/amiserial.c b/drivers/char/amiserial.c
index 2bf4fe3..ccc1ca8 100644
--- a/drivers/char/amiserial.c
+++ b/drivers/char/amiserial.c
@@ -1096,7 +1096,7 @@ static void rs_unthrottle(struct tty_str
  */
 
 static int get_serial_info(struct async_struct * info,
-			   struct serial_struct * retinfo)
+			   struct serial_struct __user * retinfo)
 {
 	struct serial_struct tmp;
 	struct serial_state *state = info->state;
@@ -1120,7 +1120,7 @@ static int get_serial_info(struct async_
 }
 
 static int set_serial_info(struct async_struct * info,
-			   struct serial_struct * new_info)
+			   struct serial_struct __user * new_info)
 {
 	struct serial_struct new_serial;
  	struct serial_state old_state, *state;
@@ -1201,7 +1201,7 @@ check_and_exit:
  * 	    transmit holding register is empty.  This functionality
  * 	    allows an RS485 driver to be written in user space. 
  */
-static int get_lsr_info(struct async_struct * info, unsigned int *value)
+static int get_lsr_info(struct async_struct * info, unsigned int __user *value)
 {
 	unsigned char status;
 	unsigned int result;
@@ -1292,6 +1292,7 @@ static int rs_ioctl(struct tty_struct *t
 	struct async_struct * info = (struct async_struct *)tty->driver_data;
 	struct async_icount cprev, cnow;	/* kernel counter temps */
 	struct serial_icounter_struct icount;
+	void __user *argp = (void __user *)arg;
 	unsigned long flags;
 
 	if (serial_paranoia_check(info, tty->name, "rs_ioctl"))
@@ -1306,19 +1307,17 @@ static int rs_ioctl(struct tty_struct *t
 
 	switch (cmd) {
 		case TIOCGSERIAL:
-			return get_serial_info(info,
-					       (struct serial_struct *) arg);
+			return get_serial_info(info, argp);
 		case TIOCSSERIAL:
-			return set_serial_info(info,
-					       (struct serial_struct *) arg);
+			return set_serial_info(info, argp);
 		case TIOCSERCONFIG:
 			return 0;
 
 		case TIOCSERGETLSR: /* Get line status register */
-			return get_lsr_info(info, (unsigned int *) arg);
+			return get_lsr_info(info, argp);
 
 		case TIOCSERGSTRUCT:
-			if (copy_to_user((struct async_struct *) arg,
+			if (copy_to_user(argp,
 					 info, sizeof(struct async_struct)))
 				return -EFAULT;
 			return 0;
@@ -1377,7 +1376,7 @@ static int rs_ioctl(struct tty_struct *t
 			icount.brk = cnow.brk;
 			icount.buf_overrun = cnow.buf_overrun;
 
-			if (copy_to_user((void *)arg, &icount, sizeof(icount)))
+			if (copy_to_user(argp, &icount, sizeof(icount)))
 				return -EFAULT;
 			return 0;
 		case TIOCSERGWILD:
-- 
0.99.9.GIT

