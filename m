Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270293AbUJUHio@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270293AbUJUHio (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 03:38:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270266AbUJUHiA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 03:38:00 -0400
Received: from smtp804.mail.sc5.yahoo.com ([66.163.168.183]:53659 "HELO
	smtp804.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S270405AbUJUHaO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 03:30:14 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH 7/7] Input: remove pm_dev from core
Date: Thu, 21 Oct 2004 02:30:02 -0500
User-Agent: KMail/1.6.2
Cc: LKML <linux-kernel@vger.kernel.org>
References: <200410210223.45498.dtor_core@ameritech.net> <200410210228.57067.dtor_core@ameritech.net> <200410210229.33358.dtor_core@ameritech.net>
In-Reply-To: <200410210229.33358.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200410210230.04156.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1971, 2004-10-20 00:57:45-05:00, dtor_core@ameritech.net
  Input: get rid of pm_dev in input core as it is deprecated and
         nothing uses it anyway.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 drivers/input/input.c                      |    4 ----
 drivers/input/touchscreen/h3600_ts_input.c |    5 +++--
 include/linux/input.h                      |    1 -
 3 files changed, 3 insertions(+), 7 deletions(-)


===================================================================



diff -Nru a/drivers/input/input.c b/drivers/input/input.c
--- a/drivers/input/input.c	2004-10-21 02:14:33 -05:00
+++ b/drivers/input/input.c	2004-10-21 02:14:33 -05:00
@@ -17,7 +17,6 @@
 #include <linux/module.h>
 #include <linux/random.h>
 #include <linux/major.h>
-#include <linux/pm.h>
 #include <linux/proc_fs.h>
 #include <linux/kmod.h>
 #include <linux/interrupt.h>
@@ -460,9 +459,6 @@
 	struct list_head * node, * next;
 
 	if (!dev) return;
-
-	if (dev->pm_dev)
-		pm_unregister(dev->pm_dev);
 
 	del_timer_sync(&dev->timer);
 
diff -Nru a/drivers/input/touchscreen/h3600_ts_input.c b/drivers/input/touchscreen/h3600_ts_input.c
--- a/drivers/input/touchscreen/h3600_ts_input.c	2004-10-21 02:14:33 -05:00
+++ b/drivers/input/touchscreen/h3600_ts_input.c	2004-10-21 02:14:33 -05:00
@@ -100,6 +100,7 @@
  */
 struct h3600_dev {
 	struct input_dev dev;
+	struct pm_dev *pm_dev;
 	struct serio *serio;
 	unsigned char event;	/* event ID from packet */
 	unsigned char chksum;
@@ -452,8 +453,8 @@
 
 	//h3600_flite_control(1, 25);     /* default brightness */
 #ifdef CONFIG_PM
-	ts->dev.pm_dev = pm_register(PM_ILLUMINATION_DEV, PM_SYS_LIGHT,
-					h3600ts_pm_callback);
+	ts->pm_dev = pm_register(PM_ILLUMINATION_DEV, PM_SYS_LIGHT,
+				h3600ts_pm_callback);
 	printk("registered pm callback\n");
 #endif
 	input_register_device(&ts->dev);
diff -Nru a/include/linux/input.h b/include/linux/input.h
--- a/include/linux/input.h	2004-10-21 02:14:33 -05:00
+++ b/include/linux/input.h	2004-10-21 02:14:33 -05:00
@@ -806,7 +806,6 @@
 	unsigned int repeat_key;
 	struct timer_list timer;
 
-	struct pm_dev *pm_dev;
 	struct pt_regs *regs;
 	int state;
 
