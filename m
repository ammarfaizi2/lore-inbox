Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271188AbTHCOFg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 10:05:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271189AbTHCOFf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 10:05:35 -0400
Received: from AMarseille-201-1-2-252.w193-253.abo.wanadoo.fr ([193.253.217.252]:3624
	"EHLO gaston") by vger.kernel.org with ESMTP id S271188AbTHCOFd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 10:05:33 -0400
Subject: [PATCH] IDE: Small fix for "hold" flag
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1059919513.3519.124.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 03 Aug 2003 16:05:13 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo !

The "hold" flag we added a few weeks ago to IDE to deal with
some laptop hotswap bays isn't properly kept around in ide_unregister(),
this fixes it. This fix is necessary for PowerMac media bay to work
properly (and this is also the only driver using this flag so far)

Please apply,
Ben.

diff -urN linux-2.4/drivers/ide/ide.c linuxppc_benh_devel/drivers/ide/ide.c
--- linux-2.4/drivers/ide/ide.c	2003-07-14 18:31:40.000000000 +0200
+++ linuxppc_benh_devel/drivers/ide/ide.c	2003-08-03 11:17:20.000000000 +0200
@@ -798,6 +798,7 @@
 	hwif->swdma_mask		= old_hwif.swdma_mask;
 
 	hwif->chipset			= old_hwif.chipset;
+	hwif->hold			= old_hwif.hold;
 
 #ifdef CONFIG_BLK_DEV_IDEPCI
 	hwif->pci_dev			= old_hwif.pci_dev;
@@ -2221,7 +2222,6 @@

