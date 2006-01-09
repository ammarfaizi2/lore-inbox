Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964880AbWAIQ6W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964880AbWAIQ6W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 11:58:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964882AbWAIQ6W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 11:58:22 -0500
Received: from [81.2.110.250] ([81.2.110.250]:3499 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S964880AbWAIQ6V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 11:58:21 -0500
Subject: PATCH: Fix typos, exclamation mark frenzy and missing device id on
	messages
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 09 Jan 2006 17:01:19 +0000
Message-Id: <1136826079.6659.36.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I sent this out a couple of months ago and the driver author said it
he'd merge it. Nothing has happened since so I'm submitting it directly.

No functionality changes just texts.

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.15-mm2/drivers/char/tlclk.c linux-2.6.15-mm2/drivers/char/tlclk.c
--- linux.vanilla-2.6.15-mm2/drivers/char/tlclk.c	2006-01-09 14:31:46.000000000 +0000
+++ linux-2.6.15-mm2/drivers/char/tlclk.c	2006-01-09 14:40:29.000000000 +0000
@@ -211,7 +211,7 @@
 	result = request_irq(telclk_interrupt, &tlclk_interrupt,
 			     SA_INTERRUPT, "telco_clock", tlclk_interrupt);
 	if (result == -EBUSY) {
-		printk(KERN_ERR "telco_clock: Interrupt can't be reserved!\n");
+		printk(KERN_ERR "telco_clock: Interrupt can't be reserved.\n");
 		return -EBUSY;
 	}
 	inb(TLCLK_REG6);	/* Clear interrupt events */
@@ -741,7 +741,7 @@
 
 	ret = register_chrdev(tlclk_major, "telco_clock", &tlclk_fops);
 	if (ret < 0) {
-		printk(KERN_ERR "telco_clock: can't get major! %d\n", tlclk_major);
+		printk(KERN_ERR "tlclk: can't get major %d.\n", tlclk_major);
 		return ret;
 	}
 	alarm_events = kzalloc( sizeof(struct tlclk_alarms), GFP_KERNEL);
@@ -750,7 +750,7 @@
 
 	/* Read telecom clock IRQ number (Set by BIOS) */
 	if (!request_region(TLCLK_BASE, 8, "telco_clock")) {
-		printk(KERN_ERR "tlclk: request_region failed! 0x%X\n",
+		printk(KERN_ERR "tlclk: request_region 0x%X failed.\n",
 			TLCLK_BASE);
 		ret = -EBUSY;
 		goto out2;
@@ -758,7 +758,7 @@
 	telclk_interrupt = (inb(TLCLK_REG7) & 0x0f);
 
 	if (0x0F == telclk_interrupt ) { /* not MCPBL0010 ? */
-		printk(KERN_ERR "telclk_interrup = 0x%x non-mcpbl0010 hw\n",
+		printk(KERN_ERR "telclk_interrup = 0x%x non-mcpbl0010 hw.\n",
 			telclk_interrupt);
 		ret = -ENXIO;
 		goto out3;
@@ -768,7 +768,7 @@
 
 	ret = misc_register(&tlclk_miscdev);
 	if (ret < 0) {
-		printk(KERN_ERR " misc_register retruns %d\n", ret);
+		printk(KERN_ERR "tlclk: misc_register returns %d.\n", ret);
 		ret = -EBUSY;
 		goto out3;
 	}
@@ -776,8 +776,7 @@
 	tlclk_device = platform_device_register_simple("telco_clock",
 				-1, NULL, 0);
 	if (!tlclk_device) {
-		printk(KERN_ERR " platform_device_register retruns 0x%X\n",
-			(unsigned int) tlclk_device);
+		printk(KERN_ERR "tlclk: platform_device_register failed.\n");
 		ret = -EBUSY;
 		goto out4;
 	}
@@ -785,7 +784,7 @@
 	ret = sysfs_create_group(&tlclk_device->dev.kobj,
 			&tlclk_attribute_group);
 	if (ret) {
-		printk(KERN_ERR "failed to create sysfs device attributes\n");
+		printk(KERN_ERR "tlclk: failed to create sysfs device attributes.\n");
 		sysfs_remove_group(&tlclk_device->dev.kobj,
 			&tlclk_attribute_group);
 		goto out5;

