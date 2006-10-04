Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030823AbWJDLWX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030823AbWJDLWX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 07:22:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030821AbWJDLWX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 07:22:23 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:56045 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030816AbWJDLWW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 07:22:22 -0400
Subject: Re: [git patches] libata updates
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeff Garzik <jeff@garzik.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20061004060212.GA4653@havoc.gtf.org>
References: <20061004060212.GA4653@havoc.gtf.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 04 Oct 2006 12:47:14 +0100
Message-Id: <1159962434.25772.19.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-10-04 am 02:02 -0400, ysgrifennodd Jeff Garzik:
> Final libata batch for 2.6.19.  Meant to send this a couple days ago.
> 
> Nothing interesting:  minor bugfix, some cleanups, improved diagnostics.

Please also include the following. The first fixes support for rev c8 of
the ALi/ULi PATA. The second keeps pcmcia in sync so ide_cs and
pata_pcmcia are interchangable, both are only changes to constants.

Right now rev 0xC8 and higher don't work with libata but 0xc8 is in the
field now.

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-mm3/drivers/ata/pata_ali.c linux-2.6.18-mm3/drivers/ata/pata_ali.c
--- linux.vanilla-2.6.18-mm3/drivers/ata/pata_ali.c	2006-10-03 19:23:02.000000000 +0100
+++ linux-2.6.18-mm3/drivers/ata/pata_ali.c	2006-10-03 23:26:09.000000000 +0100
@@ -34,7 +34,7 @@
 #include <linux/dmi.h>
 
 #define DRV_NAME "pata_ali"
-#define DRV_VERSION "0.6.5"
+#define DRV_VERSION "0.6.6"
 
 /*
  *	Cable special cases
@@ -630,7 +630,7 @@
 		pci_read_config_byte(pdev, 0x53, &tmp);
 		if (rev <= 0x20)
 			tmp &= ~0x02;
-		if (rev == 0xc7)
+		if (rev >= 0xc7)
 			tmp |= 0x03;
 		else
 			tmp |= 0x01;	/* CD_ROM enable for DMA */
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-mm3/drivers/ata/pata_pcmcia.c linux-2.6.18-mm3/drivers/ata/pata_pcmcia.c
--- linux.vanilla-2.6.18-mm3/drivers/ata/pata_pcmcia.c	2006-10-03 19:23:02.000000000 +0100
+++ linux-2.6.18-mm3/drivers/ata/pata_pcmcia.c	2006-09-28 15:24:37.000000000 +0100
@@ -42,7 +42,7 @@
 
 
 #define DRV_NAME "pata_pcmcia"
-#define DRV_VERSION "0.2.9"
+#define DRV_VERSION "0.2.11"
 
 /*
  *	Private data structure to glue stuff together
@@ -355,6 +355,8 @@
 	PCMCIA_DEVICE_PROD_ID12("SAMSUNG", "04/05/06", 0x43d74cb4, 0x6a22777d),
 	PCMCIA_DEVICE_PROD_ID12("SMI VENDOR", "SMI PRODUCT", 0x30896c92, 0x703cc5f6),
 	PCMCIA_DEVICE_PROD_ID12("TOSHIBA", "MK2001MPL", 0xb4585a1a, 0x3489e003),
+	PCMCIA_DEVICE_PROD_ID1("TRANSCEND    512M   ", 0xd0909443),
+	PCMCIA_DEVICE_PROD_ID12("TRANSCEND", "TS4GCF120", 0x709b1bf1, 0xf54a91c8),
 	PCMCIA_DEVICE_PROD_ID12("WIT", "IDE16", 0x244e5994, 0x3e232852),
 	PCMCIA_DEVICE_PROD_ID1("STI Flash", 0xe4a13209),
 	PCMCIA_DEVICE_PROD_ID12("STI", "Flash 5.0", 0xbf2df18d, 0x8cb57a0e),

