Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422687AbWJNPwj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422687AbWJNPwj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 11:52:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422699AbWJNPwj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 11:52:39 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:14031 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1422687AbWJNPwi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 11:52:38 -0400
Date: Sat, 14 Oct 2006 16:52:36 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] hp drivers/input stuff: C99 initializers, NULL noise removal, __user annotations
Message-ID: <20061014155236.GO29920@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/input/misc/hp_sdc_rtc.c |    8 ++++----
 drivers/input/serio/hil_mlc.c   |   18 +++++++++---------
 drivers/input/serio/hp_sdc.c    |    4 ++--
 3 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/input/misc/hp_sdc_rtc.c b/drivers/input/misc/hp_sdc_rtc.c
index 1be9639..ab4da79 100644
--- a/drivers/input/misc/hp_sdc_rtc.c
+++ b/drivers/input/misc/hp_sdc_rtc.c
@@ -60,7 +60,7 @@ static struct fasync_struct *hp_sdc_rtc_
 
 static DECLARE_WAIT_QUEUE_HEAD(hp_sdc_rtc_wait);
 
-static ssize_t hp_sdc_rtc_read(struct file *file, char *buf,
+static ssize_t hp_sdc_rtc_read(struct file *file, char __user *buf,
 			       size_t count, loff_t *ppos);
 
 static int hp_sdc_rtc_ioctl(struct inode *inode, struct file *file,
@@ -385,14 +385,14 @@ static int hp_sdc_rtc_set_i8042timer (st
 	return 0;
 }
 
-static ssize_t hp_sdc_rtc_read(struct file *file, char *buf,
+static ssize_t hp_sdc_rtc_read(struct file *file, char __user *buf,
 			       size_t count, loff_t *ppos) {
 	ssize_t retval;
 
         if (count < sizeof(unsigned long))
                 return -EINVAL;
 
-	retval = put_user(68, (unsigned long *)buf);
+	retval = put_user(68, (unsigned long __user *)buf);
 	return retval;
 }
 
@@ -696,7 +696,7 @@ static int __init hp_sdc_rtc_init(void)
 	if ((ret = hp_sdc_request_timer_irq(&hp_sdc_rtc_isr)))
 		return ret;
 	misc_register(&hp_sdc_rtc_dev);
-        create_proc_read_entry ("driver/rtc", 0, 0, 
+        create_proc_read_entry ("driver/rtc", 0, NULL,
 				hp_sdc_rtc_read_proc, NULL);
 
 	printk(KERN_INFO "HP i8042 SDC + MSM-58321 RTC support loaded "
diff --git a/drivers/input/serio/hil_mlc.c b/drivers/input/serio/hil_mlc.c
index bdfde04..49e11e2 100644
--- a/drivers/input/serio/hil_mlc.c
+++ b/drivers/input/serio/hil_mlc.c
@@ -391,23 +391,23 @@ static int hilse_operate(hil_mlc *mlc, i
 }
 
 #define FUNC(funct, funct_arg, zero_rc, neg_rc, pos_rc) \
-{ HILSE_FUNC,		{ func: &funct }, funct_arg, zero_rc, neg_rc, pos_rc },
+{ HILSE_FUNC,		{ .func = funct }, funct_arg, zero_rc, neg_rc, pos_rc },
 #define OUT(pack) \
-{ HILSE_OUT,		{ packet: pack }, 0, HILSEN_NEXT, HILSEN_DOZE, 0 },
+{ HILSE_OUT,		{ .packet = pack }, 0, HILSEN_NEXT, HILSEN_DOZE, 0 },
 #define CTS \
-{ HILSE_CTS,		{ packet: 0    }, 0, HILSEN_NEXT | HILSEN_SCHED | HILSEN_BREAK, HILSEN_DOZE, 0 },
+{ HILSE_CTS,		{ .packet = 0    }, 0, HILSEN_NEXT | HILSEN_SCHED | HILSEN_BREAK, HILSEN_DOZE, 0 },
 #define EXPECT(comp, to, got, got_wrong, timed_out) \
-{ HILSE_EXPECT,		{ packet: comp }, to, got, got_wrong, timed_out },
+{ HILSE_EXPECT,		{ .packet = comp }, to, got, got_wrong, timed_out },
 #define EXPECT_LAST(comp, to, got, got_wrong, timed_out) \
-{ HILSE_EXPECT_LAST,	{ packet: comp }, to, got, got_wrong, timed_out },
+{ HILSE_EXPECT_LAST,	{ .packet = comp }, to, got, got_wrong, timed_out },
 #define EXPECT_DISC(comp, to, got, got_wrong, timed_out) \
-{ HILSE_EXPECT_DISC,	{ packet: comp }, to, got, got_wrong, timed_out },
+{ HILSE_EXPECT_DISC,	{ .packet = comp }, to, got, got_wrong, timed_out },
 #define IN(to, got, got_error, timed_out) \
-{ HILSE_IN,		{ packet: 0    }, to, got, got_error, timed_out },
+{ HILSE_IN,		{ .packet = 0    }, to, got, got_error, timed_out },
 #define OUT_DISC(pack) \
-{ HILSE_OUT_DISC,	{ packet: pack }, 0, 0, 0, 0 },
+{ HILSE_OUT_DISC,	{ .packet = pack }, 0, 0, 0, 0 },
 #define OUT_LAST(pack) \
-{ HILSE_OUT_LAST,	{ packet: pack }, 0, 0, 0, 0 },
+{ HILSE_OUT_LAST,	{ .packet = pack }, 0, 0, 0, 0 },
 
 struct hilse_node hil_mlc_se[HILSEN_END] = {
 
diff --git a/drivers/input/serio/hp_sdc.c b/drivers/input/serio/hp_sdc.c
index ba7b920..9907ad3 100644
--- a/drivers/input/serio/hp_sdc.c
+++ b/drivers/input/serio/hp_sdc.c
@@ -310,7 +310,7 @@ static void hp_sdc_tasklet(unsigned long
 				 * in tasklet/bh context.
 				 */
 				if (curr->act.irqhook) 
-					curr->act.irqhook(0, 0, 0, 0);
+					curr->act.irqhook(0, NULL, 0, 0);
 			}
 			curr->actidx = curr->idx;
 			curr->idx++;
@@ -525,7 +525,7 @@ actdone:
 		up(curr->act.semaphore);
 	}
 	else if (act & HP_SDC_ACT_CALLBACK) {
-		curr->act.irqhook(0,0,0,0);
+		curr->act.irqhook(0,NULL,0,0);
 	}
 	if (curr->idx >= curr->endidx) { /* This transaction is over. */
 		if (act & HP_SDC_ACT_DEALLOC) kfree(curr);
-- 
1.4.2.GIT
