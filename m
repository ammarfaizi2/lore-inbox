Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310206AbSEEL2k>; Sun, 5 May 2002 07:28:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310654AbSEEL2j>; Sun, 5 May 2002 07:28:39 -0400
Received: from mailout08.sul.t-online.com ([194.25.134.20]:49118 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S310206AbSEEL2h>; Sun, 5 May 2002 07:28:37 -0400
Date: Sun, 5 May 2002 13:26:45 +0200
From: Erich Schubert <erich@debian.org>
To: linux-kernel@vger.kernel.org
Subject: Problems with VIA Apollo Pro Chipsets
Message-ID: <20020505112645.GA20633@marvin.xmldesign.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
X-GPG: 4B3A135C 6073 C874 8488 BCDA A6A9  B761 9ED0 78EF 4B3A 135C
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a system using the Gigabyte GA-6VTXDR-C Motherboard which showed
the VIA Southbridge symptoms with our 3ware Escalade RAID Controller.
On heavy load (such as kernel compilation) i get random segmentation
faults on different places, not reproduceable but every now and then.

I noticed that the quirk_vialatency was not enabled, and modified
quirks.c accordingly - but this did not yet solve the issues :-(

Any idea? (except handing the system back to the manufacturer and
asking for a working system...)

Note for this patch: in the line above my addition, 0x3112 has now an
according definition in include/linux/pci_ids.h, so this "Not out yet"
could be replaced with the Chipset name:
#define PCI_DEVICE_ID_VIA_8361          0x3112

--- /usr/src/linux/drivers/pci/quirks.c	Mon Feb 25 20:38:03 2002
+++ /home/erich/coding/v2.4.18/drivers/pci/quirks.c	Sun May  5 12:38:07 2002
@@ -487,6 +487,7 @@
 	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8363_0,	quirk_vialatency },
 	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8371_1,	quirk_vialatency },
 	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_VIA,	0x3112	/* Not out yet ? */,	quirk_vialatency },
+	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C598_1,	quirk_vialatency },
 	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C576,	quirk_vsfx },
 	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C597_0,	quirk_viaetbf },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C597_0,	quirk_vt82c598_id },


Gruss,
Erich Schubert

--
erich@(mucl.de|debian.org)        --        GPG Key ID: 4B3A135C
A polar bear is a rectangular bear after a coordinate transform.
Die kürzeste Verbindung zwischen zwei Menschen ist ein Lächeln.
