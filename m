Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262070AbVDEVr5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262070AbVDEVr5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 17:47:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262065AbVDEVpq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 17:45:46 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:2189 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262052AbVDEVn5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 17:43:57 -0400
Date: Tue, 5 Apr 2005 23:43:31 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Cc: linux-serial@vger.kernel.org
Subject: fix u32 vs. pm_message_t in drivers/
Message-ID: <20050405214331.GA1842@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

-rc2-mm1 still contains few places where u32 and pm_message_t. This
fixes drivers/serial [should change no code]. Please apply,
								Pavel

--- clean-mm/drivers/serial/amba-pl010.c	2004-12-25 13:35:01.000000000 +0100
+++ linux-mm/drivers/serial/amba-pl010.c	2005-04-05 12:13:37.000000000 +0200
@@ -772,7 +772,7 @@
 	return 0;
 }
 
-static int pl010_suspend(struct amba_device *dev, u32 state)
+static int pl010_suspend(struct amba_device *dev, pm_message_t state)
 {
 	struct uart_amba_port *uap = amba_get_drvdata(dev);
 
--- clean-mm/drivers/serial/imx.c	2005-04-05 10:55:20.000000000 +0200
+++ linux-mm/drivers/serial/imx.c	2005-04-05 12:13:37.000000000 +0200
@@ -825,7 +825,7 @@
 	.cons           = IMX_CONSOLE,
 };
 
-static int serial_imx_suspend(struct device *_dev, u32 state, u32 level)
+static int serial_imx_suspend(struct device *_dev, pm_message_t state, u32 level)
 {
         struct imx_port *sport = dev_get_drvdata(_dev);
 
--- clean-mm/drivers/serial/pmac_zilog.c	2005-02-03 22:27:18.000000000 +0100
+++ linux-mm/drivers/serial/pmac_zilog.c	2005-04-05 12:13:37.000000000 +0200
@@ -1590,7 +1590,7 @@
 }
 
 
-static int pmz_suspend(struct macio_dev *mdev, u32 pm_state)
+static int pmz_suspend(struct macio_dev *mdev, pm_message_t pm_state)
 {
 	struct uart_pmac_port *uap = dev_get_drvdata(&mdev->ofdev.dev);
 	struct uart_state *state;
--- clean-mm/drivers/serial/pxa.c	2004-12-25 13:35:01.000000000 +0100
+++ linux-mm/drivers/serial/pxa.c	2005-04-05 12:13:37.000000000 +0200
@@ -797,7 +797,7 @@
 	.cons		= PXA_CONSOLE,
 };
 
-static int serial_pxa_suspend(struct device *_dev, u32 state, u32 level)
+static int serial_pxa_suspend(struct device *_dev, pm_message_t state, u32 level)
 {
         struct uart_pxa_port *sport = dev_get_drvdata(_dev);
 
--- clean-mm/drivers/serial/s3c2410.c	2005-03-19 00:31:50.000000000 +0100
+++ linux-mm/drivers/serial/s3c2410.c	2005-04-05 12:13:37.000000000 +0200
@@ -1156,7 +1156,7 @@
 
 #ifdef CONFIG_PM
 
-int s3c24xx_serial_suspend(struct device *dev, u32 state, u32 level)
+int s3c24xx_serial_suspend(struct device *dev, pm_message_t state, u32 level)
 {
 	struct uart_port *port = s3c24xx_dev_to_port(dev);
 
--- clean-mm/drivers/serial/sa1100.c	2005-03-19 00:31:50.000000000 +0100
+++ linux-mm/drivers/serial/sa1100.c	2005-04-05 12:13:37.000000000 +0200
@@ -854,7 +854,7 @@
 	.cons			= SA1100_CONSOLE,
 };
 
-static int sa1100_serial_suspend(struct device *_dev, u32 state, u32 level)
+static int sa1100_serial_suspend(struct device *_dev, pm_message_t state, u32 level)
 {
 	struct sa1100_port *sport = dev_get_drvdata(_dev);
 
--- clean-mm/drivers/serial/serial_txx9.c	2005-02-03 22:27:18.000000000 +0100
+++ linux-mm/drivers/serial/serial_txx9.c	2005-04-05 12:13:37.000000000 +0200
@@ -1095,7 +1095,7 @@
 	}
 }
 
-static int pciserial_txx9_suspend_one(struct pci_dev *dev, u32 state)
+static int pciserial_txx9_suspend_one(struct pci_dev *dev, pm_message_t state)
 {
 	int line = (int)(long)pci_get_drvdata(dev);
 
--- clean-mm/drivers/serial/vr41xx_siu.c	2005-03-19 00:31:50.000000000 +0100
+++ linux-mm/drivers/serial/vr41xx_siu.c	2005-04-05 12:13:37.000000000 +0200
@@ -1026,7 +1026,7 @@
 	return 0;
 }
 
-static int siu_suspend(struct device *dev, u32 state, u32 level)
+static int siu_suspend(struct device *dev, pm_message_t state, u32 level)
 {
 	struct uart_port *port;
 	int i;

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
