Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129914AbRBOTvM>; Thu, 15 Feb 2001 14:51:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129909AbRBOTvC>; Thu, 15 Feb 2001 14:51:02 -0500
Received: from [199.108.253.116] ([199.108.253.116]:43141 "EHLO
	redmailwall2.attws.com") by vger.kernel.org with ESMTP
	id <S129249AbRBOTuv>; Thu, 15 Feb 2001 14:50:51 -0500
Content-Type: text/plain; charset=US-ASCII
From: root <root@marge.springfield.attws.com>
To: jgarzik@mandrakesoft.com
Subject: patch for mini-pci ethernet card
Date: Fri, 16 Feb 2001 14:52:46 -0400
X-Mailer: KMail [version 1.2]
Cc: tulip-users@lists.sourceforge.net, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <01021519112800.09592@marge.springfield>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a HP Pavilon 5290 laptop. It has a a mini-pci modem/ethernet combo 
integrated card.

Searching in the Internet I found a patch for the ethernet to work with the 
tulip driver for kernel 2.2.x series, However, I found no patch for the 2.4.x 
kernel series, so I made one.

Here is what /proc/pci detects as the ethernet card.

  Bus  0, device  16, function  0:
    Ethernet controller: PCI device 1113:1216 (Accton Technology Corporation) 
(rev 17).
      IRQ 11.
      Master Capable.  Latency=64.  Min Gnt=255.Max Lat=255.
      I/O at 0x1c00 [0x1cff].
      Non-prefetchable 32 bit memory at 0xe8000000 [0xe80003ff].

This patch merely adds the configuration for that card in the tulip driver 
tables. 
I made this patch against kernel 2.4.1 and it works fine on my laptop.

Apply this patch against linux/drivers/net/tulip/tulip_core.c

Anyone with a similar laptop please test it and see if it works for you

My name is Paul Pacheco, email: paul.pacheco@wavecode.com

So, Here is the patch:


--- tulip_core.c.orig	Fri Feb 16 14:30:38 2001
+++ tulip_core.c	Fri Feb 16 14:47:54 2001
@@ -150,6 +150,9 @@
   { "Davicom DM9102/DM9102A", 128, 0x0001ebef,
 	HAS_MII | HAS_MEDIA_TABLE | CSR12_IN_SROM | HAS_ACPI,
 	tulip_timer },
+  { "EN2242 tulip work-alike", 128, 0x0801fbff,
+        HAS_MII | HAS_MEDIA_TABLE | ALWAYS_CHECK_MII | HAS_ACPI | HAS_NWAY,
+        t21142_timer },
   {0},
 };
 
@@ -177,6 +180,7 @@
 	{ 0x1282, 0x9100, PCI_ANY_ID, PCI_ANY_ID, 0, 0, DM910X },
 	{ 0x1282, 0x9102, PCI_ANY_ID, PCI_ANY_ID, 0, 0, DM910X },
 	{ 0x1113, 0x1217, PCI_ANY_ID, PCI_ANY_ID, 0, 0, MX98715 },
+        { 0x1113, 0x1216, PCI_ANY_ID, PCI_ANY_ID, 0, 0, COMET },
 	{0, }
 };
 MODULE_DEVICE_TABLE(pci, tulip_pci_tbl);


