Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261290AbUKNMHw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261290AbUKNMHw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 07:07:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261291AbUKNMHw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 07:07:52 -0500
Received: from port-212-202-157-208.static.qsc.de ([212.202.157.208]:31693
	"EHLO zoidberg.portrix.net") by vger.kernel.org with ESMTP
	id S261290AbUKNMHq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 07:07:46 -0500
Message-ID: <41974A6C.20302@ppp0.net>
Date: Sun, 14 Nov 2004 13:07:08 +0100
From: Jan Dittmer <jdittmer@ppp0.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.3) Gecko/20040926 Thunderbird/0.8 Mnenhy/0.6.0.104
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
CC: johnpol@2ka.mipt.ru
Subject: [PATCH] matrox w1: fix integer to pointer conversion warnings
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Get rid of some pointer to integer conversion warnings
in the matrox w1 bus driver.

Signed-off-by: Jan Dittmer <jdittmer@ppp0.net>

diff -Nru a/drivers/w1/matrox_w1.c b/drivers/w1/matrox_w1.c
--- a/drivers/w1/matrox_w1.c	2004-11-14 13:03:45 +01:00
+++ b/drivers/w1/matrox_w1.c	2004-11-14 13:03:45 +01:00
@@ -78,11 +78,12 @@

 struct matrox_device
 {
-	unsigned long base_addr;
-	unsigned long port_index, port_data;
+	char *base_addr;
+	char *port_index, *port_data;
 	u8 data_mask;

-	unsigned long phys_addr, virt_addr;
+	unsigned long phys_addr;
+	char *virt_addr;
 	unsigned long found;

 	struct w1_bus_master *bus_master;
@@ -181,8 +182,7 @@

 	dev->phys_addr = pci_resource_start(pdev, 1);

-	dev->virt_addr =
-		(unsigned long) ioremap_nocache(dev->phys_addr, 16384);
+	dev->virt_addr = ioremap_nocache(dev->phys_addr, 16384);
 	if (!dev->virt_addr) {
 		dev_err(&pdev->dev, "%s: failed to ioremap(0x%lx, %d).\n",
 			__func__, dev->phys_addr, 16384);
