Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750769AbVKTGt5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750769AbVKTGt5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 01:49:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750801AbVKTGsv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 01:48:51 -0500
Received: from smtp104.sbc.mail.re2.yahoo.com ([68.142.229.101]:23418 "HELO
	smtp104.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1750769AbVKTGrN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 01:47:13 -0500
Message-Id: <20051120064420.957542000.dtor_core@ameritech.net>
References: <20051120063611.269343000.dtor_core@ameritech.net>
Date: Sun, 20 Nov 2005 01:36:25 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [git pull 14/14] Fix missing initialization in ir-kbd-gpio.c
Content-Disposition: inline; filename=ir-kbd-gpio-init-input-dev.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix missing initialization in ir-kbd-gpio.c

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/media/video/ir-kbd-gpio.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

Index: work/drivers/media/video/ir-kbd-gpio.c
===================================================================
--- work.orig/drivers/media/video/ir-kbd-gpio.c
+++ work/drivers/media/video/ir-kbd-gpio.c
@@ -673,7 +673,6 @@ static int ir_probe(struct device *dev)
 	snprintf(ir->phys, sizeof(ir->phys), "pci-%s/ir0",
 		 pci_name(sub->core->pci));
 
-	ir->sub = sub;
 	ir_input_init(input_dev, &ir->ir, ir_type, ir_codes);
 	input_dev->name = ir->name;
 	input_dev->phys = ir->phys;
@@ -688,6 +687,9 @@ static int ir_probe(struct device *dev)
 	}
 	input_dev->cdev.dev = &sub->core->pci->dev;
 
+	ir->input = input_dev;
+	ir->sub = sub;
+
 	if (ir->polling) {
 		INIT_WORK(&ir->work, ir_work, ir);
 		init_timer(&ir->timer);
@@ -708,7 +710,6 @@ static int ir_probe(struct device *dev)
 	/* all done */
 	dev_set_drvdata(dev, ir);
 	input_register_device(ir->input);
-	printk(DEVNAME ": %s detected at %s\n",ir->name,ir->phys);
 
 	/* the remote isn't as bouncy as a keyboard */
 	ir->input->rep[REP_DELAY] = repeat_delay;

