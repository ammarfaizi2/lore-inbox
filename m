Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262291AbVAEHyM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262291AbVAEHyM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 02:54:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262297AbVAEHyM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 02:54:12 -0500
Received: from cantor.suse.de ([195.135.220.2]:50854 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262291AbVAEHx7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 02:53:59 -0500
Date: Wed, 5 Jan 2005 08:53:57 +0100
From: Olaf Hering <olh@suse.de>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] request_irq: avoid slash in proc directory entries
Message-ID: <20050105075357.GA12473@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


A few users of request_irq pass a string with '/'.
As a result, ls -l /proc/irq/*/* will fail to list these entries.

 drivers/input/serio/maceps2.c     |    2 +-
 drivers/macintosh/via-pmu.c       |    2 +-
 drivers/net/wan/hostess_sv11.c    |    2 +-
 include/asm-sh/mpc1211/keyboard.h |    2 +-
 include/asm-sh64/keyboard.h       |    2 +-
 sound/isa/opl3sa2.c               |    2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)


Signed-off-by: Olaf Hering <olh@suse.de>

diff -purNx tags linux-2.6.10.orig/drivers/input/serio/maceps2.c linux-2.6.10-olh/drivers/input/serio/maceps2.c
--- linux-2.6.10.orig/drivers/input/serio/maceps2.c	2004-12-31 09:28:47.000000000 +0100
+++ linux-2.6.10-olh/drivers/input/serio/maceps2.c	2005-01-01 19:34:58.000000000 +0100
@@ -90,7 +90,7 @@ static int maceps2_open(struct serio *de
 {
 	struct maceps2_data *data = (struct maceps2_data *)dev->port_data;
 
-	if (request_irq(data->irq, maceps2_interrupt, 0, "PS/2 port", dev)) {
+	if (request_irq(data->irq, maceps2_interrupt, 0, "PS2 port", dev)) {
 		printk(KERN_ERR "Could not allocate PS/2 IRQ\n");
 		return -EBUSY;
 	}
diff -purNx tags linux-2.6.10.orig/drivers/macintosh/via-pmu.c linux-2.6.10-olh/drivers/macintosh/via-pmu.c
--- linux-2.6.10.orig/drivers/macintosh/via-pmu.c	2004-12-31 09:29:17.000000000 +0100
+++ linux-2.6.10-olh/drivers/macintosh/via-pmu.c	2005-01-01 19:30:45.000000000 +0100
@@ -418,7 +418,7 @@ static int __init via_pmu_start(void)
 	}
 
 	if (pmu_kind == PMU_KEYLARGO_BASED && gpio_irq != -1) {
-		if (request_irq(gpio_irq, gpio1_interrupt, 0, "GPIO1/ADB", (void *)0))
+		if (request_irq(gpio_irq, gpio1_interrupt, 0, "GPIO1-ADB", (void *)0))
 			printk(KERN_ERR "pmu: can't get irq %d (GPIO1)\n", gpio_irq);
 		gpio_irq_enabled = 1;
 	}
diff -purNx tags linux-2.6.10.orig/drivers/net/wan/hostess_sv11.c linux-2.6.10-olh/drivers/net/wan/hostess_sv11.c
--- linux-2.6.10.orig/drivers/net/wan/hostess_sv11.c	2004-08-14 07:37:27.000000000 +0200
+++ linux-2.6.10-olh/drivers/net/wan/hostess_sv11.c	2005-01-01 19:34:46.000000000 +0100
@@ -263,7 +263,7 @@ static struct sv11_device *sv11_init(int
 	/* We want a fast IRQ for this device. Actually we'd like an even faster
 	   IRQ ;) - This is one driver RtLinux is made for */
 	   
-	if(request_irq(irq, &z8530_interrupt, SA_INTERRUPT, "Hostess SV/11", dev)<0)
+	if(request_irq(irq, &z8530_interrupt, SA_INTERRUPT, "Hostess SV-11", dev)<0)
 	{
 		printk(KERN_WARNING "hostess: IRQ %d already in use.\n", irq);
 		goto fail1;
diff -purNx tags linux-2.6.10.orig/include/asm-sh/mpc1211/keyboard.h linux-2.6.10-olh/include/asm-sh/mpc1211/keyboard.h
--- linux-2.6.10.orig/include/asm-sh/mpc1211/keyboard.h	2004-08-14 07:36:58.000000000 +0200
+++ linux-2.6.10-olh/include/asm-sh/mpc1211/keyboard.h	2005-01-01 19:35:52.000000000 +0100
@@ -57,7 +57,7 @@ extern unsigned char pckbd_sysrq_xlate[1
 #define AUX_IRQ 12
 
 #define aux_request_irq(hand, dev_id)					\
-	request_irq(AUX_IRQ, hand, SA_SHIRQ, "PS/2 Mouse", dev_id)
+	request_irq(AUX_IRQ, hand, SA_SHIRQ, "PS2 Mouse", dev_id)
 
 #define aux_free_irq(dev_id) free_irq(AUX_IRQ, dev_id)
 
diff -purNx tags linux-2.6.10.orig/include/asm-sh64/keyboard.h linux-2.6.10-olh/include/asm-sh64/keyboard.h
--- linux-2.6.10.orig/include/asm-sh64/keyboard.h	2004-08-14 07:36:44.000000000 +0200
+++ linux-2.6.10-olh/include/asm-sh64/keyboard.h	2005-01-01 19:36:07.000000000 +0100
@@ -65,7 +65,7 @@ extern unsigned char pckbd_sysrq_xlate[1
 #endif
 
 #define aux_request_irq(hand, dev_id)					\
-	request_irq(AUX_IRQ, hand, SA_SHIRQ, "PS/2 Mouse", dev_id)
+	request_irq(AUX_IRQ, hand, SA_SHIRQ, "PS2 Mouse", dev_id)
 
 #define aux_free_irq(dev_id) free_irq(AUX_IRQ, dev_id)
 
diff -purNx tags linux-2.6.10.orig/sound/isa/opl3sa2.c linux-2.6.10-olh/sound/isa/opl3sa2.c
--- linux-2.6.10.orig/sound/isa/opl3sa2.c	2004-12-31 09:29:29.000000000 +0100
+++ linux-2.6.10-olh/sound/isa/opl3sa2.c	2005-01-01 19:35:34.000000000 +0100
@@ -713,7 +713,7 @@ static int __devinit snd_opl3sa2_probe(i
 		chip->single_dma = 1;
 	if ((err = snd_opl3sa2_detect(chip)) < 0)
 		goto __error;
-	if (request_irq(xirq, snd_opl3sa2_interrupt, SA_INTERRUPT, "OPL3-SA2/3", (void *)chip)) {
+	if (request_irq(xirq, snd_opl3sa2_interrupt, SA_INTERRUPT, "OPL3-SA2", (void *)chip)) {
 		snd_printk(KERN_ERR "opl3sa2: can't grab IRQ %d\n", xirq);
 		err = -ENODEV;
 		goto __error;
