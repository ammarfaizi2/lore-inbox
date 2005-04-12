Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262567AbVDLTL2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262567AbVDLTL2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 15:11:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262572AbVDLTJy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 15:09:54 -0400
Received: from fire.osdl.org ([65.172.181.4]:47305 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262210AbVDLKcf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:32:35 -0400
Message-Id: <200504121032.j3CAWT1W005609@shell0.pdx.osdl.net>
Subject: [patch 118/198] fix u32 vs. pm_message_t in drivers/
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, pavel@ucw.cz
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:32:23 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Pavel Machek <pavel@ucw.cz>

-rc2-mm1 still contains few places where u32 and pm_message_t.  This fixes
drivers/serial [should change no code].

Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/drivers/serial/amba-pl010.c  |    2 +-
 25-akpm/drivers/serial/imx.c         |    2 +-
 25-akpm/drivers/serial/pmac_zilog.c  |    2 +-
 25-akpm/drivers/serial/pxa.c         |    2 +-
 25-akpm/drivers/serial/s3c2410.c     |    2 +-
 25-akpm/drivers/serial/sa1100.c      |    2 +-
 25-akpm/drivers/serial/serial_txx9.c |    2 +-
 25-akpm/drivers/serial/vr41xx_siu.c  |    2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

diff -puN drivers/serial/amba-pl010.c~fix-u32-vs-pm_message_t-in-drivers drivers/serial/amba-pl010.c
--- 25/drivers/serial/amba-pl010.c~fix-u32-vs-pm_message_t-in-drivers	2005-04-12 03:21:31.930282760 -0700
+++ 25-akpm/drivers/serial/amba-pl010.c	2005-04-12 03:21:31.943280784 -0700
@@ -772,7 +772,7 @@ static int pl010_remove(struct amba_devi
 	return 0;
 }
 
-static int pl010_suspend(struct amba_device *dev, u32 state)
+static int pl010_suspend(struct amba_device *dev, pm_message_t state)
 {
 	struct uart_amba_port *uap = amba_get_drvdata(dev);
 
diff -puN drivers/serial/imx.c~fix-u32-vs-pm_message_t-in-drivers drivers/serial/imx.c
--- 25/drivers/serial/imx.c~fix-u32-vs-pm_message_t-in-drivers	2005-04-12 03:21:31.931282608 -0700
+++ 25-akpm/drivers/serial/imx.c	2005-04-12 03:21:31.944280632 -0700
@@ -825,7 +825,7 @@ static struct uart_driver imx_reg = {
 	.cons           = IMX_CONSOLE,
 };
 
-static int serial_imx_suspend(struct device *_dev, u32 state, u32 level)
+static int serial_imx_suspend(struct device *_dev, pm_message_t state, u32 level)
 {
         struct imx_port *sport = dev_get_drvdata(_dev);
 
diff -puN drivers/serial/pmac_zilog.c~fix-u32-vs-pm_message_t-in-drivers drivers/serial/pmac_zilog.c
--- 25/drivers/serial/pmac_zilog.c~fix-u32-vs-pm_message_t-in-drivers	2005-04-12 03:21:31.933282304 -0700
+++ 25-akpm/drivers/serial/pmac_zilog.c	2005-04-12 03:21:31.946280328 -0700
@@ -1590,7 +1590,7 @@ static int pmz_detach(struct macio_dev *
 }
 
 
-static int pmz_suspend(struct macio_dev *mdev, u32 pm_state)
+static int pmz_suspend(struct macio_dev *mdev, pm_message_t pm_state)
 {
 	struct uart_pmac_port *uap = dev_get_drvdata(&mdev->ofdev.dev);
 	struct uart_state *state;
diff -puN drivers/serial/pxa.c~fix-u32-vs-pm_message_t-in-drivers drivers/serial/pxa.c
--- 25/drivers/serial/pxa.c~fix-u32-vs-pm_message_t-in-drivers	2005-04-12 03:21:31.934282152 -0700
+++ 25-akpm/drivers/serial/pxa.c	2005-04-12 03:21:31.946280328 -0700
@@ -797,7 +797,7 @@ static struct uart_driver serial_pxa_reg
 	.cons		= PXA_CONSOLE,
 };
 
-static int serial_pxa_suspend(struct device *_dev, u32 state, u32 level)
+static int serial_pxa_suspend(struct device *_dev, pm_message_t state, u32 level)
 {
         struct uart_pxa_port *sport = dev_get_drvdata(_dev);
 
diff -puN drivers/serial/s3c2410.c~fix-u32-vs-pm_message_t-in-drivers drivers/serial/s3c2410.c
--- 25/drivers/serial/s3c2410.c~fix-u32-vs-pm_message_t-in-drivers	2005-04-12 03:21:31.936281848 -0700
+++ 25-akpm/drivers/serial/s3c2410.c	2005-04-12 03:21:31.948280024 -0700
@@ -1156,7 +1156,7 @@ int s3c24xx_serial_remove(struct device 
 
 #ifdef CONFIG_PM
 
-int s3c24xx_serial_suspend(struct device *dev, u32 state, u32 level)
+int s3c24xx_serial_suspend(struct device *dev, pm_message_t state, u32 level)
 {
 	struct uart_port *port = s3c24xx_dev_to_port(dev);
 
diff -puN drivers/serial/sa1100.c~fix-u32-vs-pm_message_t-in-drivers drivers/serial/sa1100.c
--- 25/drivers/serial/sa1100.c~fix-u32-vs-pm_message_t-in-drivers	2005-04-12 03:21:31.937281696 -0700
+++ 25-akpm/drivers/serial/sa1100.c	2005-04-12 03:21:31.949279872 -0700
@@ -854,7 +854,7 @@ static struct uart_driver sa1100_reg = {
 	.cons			= SA1100_CONSOLE,
 };
 
-static int sa1100_serial_suspend(struct device *_dev, u32 state, u32 level)
+static int sa1100_serial_suspend(struct device *_dev, pm_message_t state, u32 level)
 {
 	struct sa1100_port *sport = dev_get_drvdata(_dev);
 
diff -puN drivers/serial/serial_txx9.c~fix-u32-vs-pm_message_t-in-drivers drivers/serial/serial_txx9.c
--- 25/drivers/serial/serial_txx9.c~fix-u32-vs-pm_message_t-in-drivers	2005-04-12 03:21:31.939281392 -0700
+++ 25-akpm/drivers/serial/serial_txx9.c	2005-04-12 03:21:31.949279872 -0700
@@ -1095,7 +1095,7 @@ static void __devexit pciserial_txx9_rem
 	}
 }
 
-static int pciserial_txx9_suspend_one(struct pci_dev *dev, u32 state)
+static int pciserial_txx9_suspend_one(struct pci_dev *dev, pm_message_t state)
 {
 	int line = (int)(long)pci_get_drvdata(dev);
 
diff -puN drivers/serial/vr41xx_siu.c~fix-u32-vs-pm_message_t-in-drivers drivers/serial/vr41xx_siu.c
--- 25/drivers/serial/vr41xx_siu.c~fix-u32-vs-pm_message_t-in-drivers	2005-04-12 03:21:31.940281240 -0700
+++ 25-akpm/drivers/serial/vr41xx_siu.c	2005-04-12 03:21:31.950279720 -0700
@@ -1026,7 +1026,7 @@ static int siu_remove(struct device *dev
 	return 0;
 }
 
-static int siu_suspend(struct device *dev, u32 state, u32 level)
+static int siu_suspend(struct device *dev, pm_message_t state, u32 level)
 {
 	struct uart_port *port;
 	int i;
_
