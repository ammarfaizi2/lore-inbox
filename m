Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932285AbVLHTcq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932285AbVLHTcq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 14:32:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932284AbVLHTcq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 14:32:46 -0500
Received: from mta09-winn.ispmail.ntl.com ([81.103.221.49]:24219 "EHLO
	mta09-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S932277AbVLHTcp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 14:32:45 -0500
Message-ID: <43988D11.80809@gentoo.org>
Date: Thu, 08 Dec 2005 19:44:17 +0000
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051205)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
CC: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] via82cxxx IDE: Add VT8251 ISA bridge
Content-Type: multipart/mixed;
 boundary="------------020308030704030504000600"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020308030704030504000600
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Some motherboards (such as the Asus P5V800-MX) ship a
PCI_DEVICE_ID_VIA_82C586_1 IDE controller alongside a VT8251 southbridge.

This southbridge is currently unrecognised in the via82cxxx IDE driver,
preventing those users from getting DMA access to disks.

Signed-off-by: Daniel Drake <dsd@gentoo.org>

--

Bart, I submitted this 2 weeks ago but sent it to your old pw.edu.pl address 
by accident. Sorry about that!

--------------020308030704030504000600
Content-Type: text/x-patch;
 name="via82cxxx-vt8251-southbridge.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="via82cxxx-vt8251-southbridge.patch"

--- linux-2.6.15-rc2/include/linux/pci_ids.h.orig	2005-11-22 22:29:42.000000000 +0000
+++ linux-2.6.15-rc2/include/linux/pci_ids.h	2005-11-22 22:30:13.000000000 +0000
@@ -1243,6 +1243,7 @@
 #define PCI_DEVICE_ID_VIA_8378_0	0x3205
 #define PCI_DEVICE_ID_VIA_8783_0	0x3208
 #define PCI_DEVICE_ID_VIA_8237		0x3227
+#define PCI_DEVICE_ID_VIA_8251		0x3287
 #define PCI_DEVICE_ID_VIA_3296_0	0x0296
 #define PCI_DEVICE_ID_VIA_8231		0x8231
 #define PCI_DEVICE_ID_VIA_8231_4	0x8235
--- linux-2.6.15-rc2/drivers/ide/pci/via82cxxx.c.orig	2005-11-22 22:29:05.000000000 +0000
+++ linux-2.6.15-rc2/drivers/ide/pci/via82cxxx.c	2005-11-22 22:29:27.000000000 +0000
@@ -80,6 +80,7 @@ static struct via_isa_bridge {
 	u16 flags;
 } via_isa_bridges[] = {
 	{ "vt6410",	PCI_DEVICE_ID_VIA_6410,     0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST },
+	{ "vt8251",	PCI_DEVICE_ID_VIA_8251,     0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST },
 	{ "vt8237",	PCI_DEVICE_ID_VIA_8237,     0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST },
 	{ "vt8235",	PCI_DEVICE_ID_VIA_8235,     0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST },
 	{ "vt8233a",	PCI_DEVICE_ID_VIA_8233A,    0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST },

--------------020308030704030504000600--
