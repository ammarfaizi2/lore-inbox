Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265160AbUAEGEv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 01:04:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265802AbUAEGEu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 01:04:50 -0500
Received: from smtp814.mail.sc5.yahoo.com ([66.163.170.84]:26728 "HELO
	smtp814.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265160AbUAEGEs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 01:04:48 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH 1/3] Fix compile error in 98busmouse.c module
Date: Mon, 5 Jan 2004 01:01:19 -0500
User-Agent: KMail/1.5.4
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <200401030350.43437.dtor_core@ameritech.net> <200401050059.25031.dtor_core@ameritech.net>
In-Reply-To: <200401050059.25031.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401050101.20789.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

===================================================================


ChangeSet@1.1580, 2004-01-04 23:57:27-05:00, dtor_core@ameritech.net
  Input: Fix 98busmouse compile error -
         have interrupt routine return IRQ_HANDLED


 98busmouse.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)


===================================================================



diff -Nru a/drivers/input/mouse/98busmouse.c b/drivers/input/mouse/98busmouse.c
--- a/drivers/input/mouse/98busmouse.c	Mon Jan  5 00:45:57 2004
+++ b/drivers/input/mouse/98busmouse.c	Mon Jan  5 00:45:57 2004
@@ -74,7 +74,7 @@
 static int pc98bm_irq = PC98BM_IRQ;
 static int pc98bm_used = 0;
 
-static void pc98bm_interrupt(int irq, void *dev_id, struct pt_regs *regs);
+static irqreturn_t pc98bm_interrupt(int irq, void *dev_id, struct pt_regs *regs);
 
 static int pc98bm_open(struct input_dev *dev)
 {
@@ -113,7 +113,7 @@
 	},
 };
 
-static void pc98bm_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+static irqreturn_t pc98bm_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
 	char dx, dy;
 	unsigned char buttons;
@@ -137,6 +137,8 @@
 	input_sync(&pc98bm_dev);
 
 	outb(PC98BM_ENABLE_IRQ, PC98BM_CONTROL_PORT);
+
+	return IRQ_HANDLED;
 }
 
 #ifndef MODULE
