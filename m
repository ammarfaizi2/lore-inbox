Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261939AbTKMCs7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 21:48:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261959AbTKMCs7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 21:48:59 -0500
Received: from smtp11.eresmas.com ([62.81.235.111]:25737 "EHLO
	smtp11.eresmas.com") by vger.kernel.org with ESMTP id S261939AbTKMCs5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 21:48:57 -0500
Message-ID: <3FB2F08E.1050705@wanadoo.es>
Date: Thu, 13 Nov 2003 03:46:38 +0100
From: Xose Vazquez Perez <xose@wanadoo.es>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: gl, es, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>,
       Tosatti <marcelo.tosatti@cyclades.com>
Subject: [PATCH]-2.4.23-rc1 pci-irq.c bad PCI ident of 440GX host bridge 
X-Enigmail-Version: 0.63.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------080907080401010702010700"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080907080401010702010700
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

hi,

someone needs a new glasses ;-)

The code is using PCI_DEVICE_ID_INTEL_82450GX(0x84c5) to identify a 440GX
Host Bridge. And that id is the *Memory Controller* of 450KX/GX chipsets.
WRONG!

The Host Bridge of 440GX chipset is 82443GX. And it got _two_ PCI
ident 0x71a0(AGP enable) and 0x71a2(with AGP disable).

This patch comes from http://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=107880
by Phil Oester <bugzilla@linuxace.com>

People with INTEL 440GX boards is going to get troubles without this patch.

-thanks-
--
bug reports to ty.coon@yoyodine.org

--------------080907080401010702010700
Content-Type: text/plain;
 name="440GX.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="440GX.diff"

--- linux/arch/i386/kernel/pci-irq.c	2003-11-10 21:42:05.000000000 +0100
+++ new/arch/i386/kernel/pci-irq.c	2003-11-13 02:33:27.000000000 +0100
@@ -575,7 +575,8 @@
 {
 	/* We must not touch 440GX even if we have tables. 440GX has
 	   different IRQ routing weirdness */
-	if(pci_find_device(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82450GX, NULL))
+	if(pci_find_device(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82443GX_0, NULL) ||
+	   pci_find_device(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82443GX_2, NULL))
 		return 0;
 	switch(device)
 	{
--- linux/include/linux/pci_ids.h	2003-11-10 21:42:51.000000000 +0100
+++ new/include/linux/pci_ids.h	2003-11-13 02:35:31.000000000 +0100
@@ -1891,6 +1891,9 @@
 #define PCI_DEVICE_ID_INTEL_82443MX_1	0x7199
 #define PCI_DEVICE_ID_INTEL_82443MX_2	0x719a
 #define PCI_DEVICE_ID_INTEL_82443MX_3	0x719b
+#define PCI_DEVICE_ID_INTEL_82443GX_0	0x71a0
+#define PCI_DEVICE_ID_INTEL_82443GX_1	0x71a1
+#define PCI_DEVICE_ID_INTEL_82443GX_2	0x71a2
 #define PCI_DEVICE_ID_INTEL_82372FB_0	0x7600
 #define PCI_DEVICE_ID_INTEL_82372FB_1	0x7601
 #define PCI_DEVICE_ID_INTEL_82372FB_2	0x7602


--------------080907080401010702010700--

