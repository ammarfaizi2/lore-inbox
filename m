Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262656AbSJHCZI>; Mon, 7 Oct 2002 22:25:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262663AbSJHCZI>; Mon, 7 Oct 2002 22:25:08 -0400
Received: from ool-182fa350.dyn.optonline.net ([24.47.163.80]:20871 "EHLO
	nikolas.hn.org") by vger.kernel.org with ESMTP id <S262656AbSJHCZH>;
	Mon, 7 Oct 2002 22:25:07 -0400
Date: Mon, 7 Oct 2002 22:30:36 -0400
From: Nick Orlov <nick.orlov@mail.ru>
To: Bruce Lowekamp <lowekamp@CS.WM.EDU>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20-pre8 swaps ide controller order on A7V266-E
Message-ID: <20021008023036.GA14477@nikolas.hn.org>
Mail-Followup-To: Bruce Lowekamp <lowekamp@CS.WM.EDU>,
	linux-kernel@vger.kernel.org
References: <15570000.1033586626@chorus.cs.wm.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="qMm9M+Fa2AknHoGS"
Content-Disposition: inline
In-Reply-To: <15570000.1033586626@chorus.cs.wm.edu>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline

On Wed, Oct 02, 2002 at 03:23:46PM -0400, Bruce Lowekamp wrote:
> 
> Starting with 2.4.19 and continuing in 2.4.20-pre8, the order the kernel 
> associates with the two IDE controllers (one VIA vt8233 and one PDC20265 
> intended for RAID use) on the A7V266-E has been reversed.  The BIOS and 
> GRUB consider the VIA to be first, so root(hd0,0) loads the kernel from the 
> first device on the VIA controller.  Prior to 2.4.19, the OS then booted 
> with that drive identified as hda.  Beginning with 2.4.19, however, the 
> kernel instead identifies the PDC as ide0 and ide1, and puts the VIA at 
> ide2 and ide3, resulting in the boot drive being hde.
> 
> I found an earlier mention of this on the mailing list, but no solution or 
> workaround was suggested.  We are using a workaround where 2.4.19 and later 
> kernels are booted with root=/dev/hde1 and earlier with hda1, and fstab 
> lists both hda2 and hde2 as swap partitions, simply failing to insert one. 
> This works, but the general ugliness and maintenance headaches since this 
> is different than the typical machine config we use around here make it 
> difficult to use in the long run.
> 
> I'm not sure what the process of identifying order of controllers involves, 
> but the discrepancy between the BIOS, older kernels, and newer kernels 
> seems like something that should be fixed if possible.
> 
> Thanks for any help,
> Bruce Lowekamp

You can apply this tiny patch.
Works for me just fine.

I have another version of patch - slightly bigger. It introduces new
config option CONFIG_PDC20265_PRIMARY. But peoples here don't like those
solutions. I was fighting a little bit and then gave up.

Hope it helps.

-- 
With best wishes,
	Nick Orlov.


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=koi8-r
Content-Disposition: attachment; filename="pdc20265.patch"

--- linux/drivers/ide/ide-pci.c.orig	2002-08-01 21:41:29.000000000 -0400
+++ linux/drivers/ide/ide-pci.c	2002-08-01 21:10:27.000000000 -0400
@@ -405,7 +405,7 @@
 #ifndef CONFIG_PDC202XX_FORCE
         {DEVID_PDC20246,"PDC20246",	PCI_PDC202XX,	NULL,		INIT_PDC202XX,	NULL,		{{0x00,0x00,0x00}, {0x00,0x00,0x00}},	OFF_BOARD,	16 },
         {DEVID_PDC20262,"PDC20262",	PCI_PDC202XX,	ATA66_PDC202XX,	INIT_PDC202XX,	NULL,		{{0x00,0x00,0x00}, {0x00,0x00,0x00}},	OFF_BOARD,	48 },
-        {DEVID_PDC20265,"PDC20265",	PCI_PDC202XX,	ATA66_PDC202XX,	INIT_PDC202XX,	NULL,		{{0x00,0x00,0x00}, {0x00,0x00,0x00}},	ON_BOARD,	48 },
+        {DEVID_PDC20265,"PDC20265",	PCI_PDC202XX,	ATA66_PDC202XX,	INIT_PDC202XX,	NULL,		{{0x00,0x00,0x00}, {0x00,0x00,0x00}},	OFF_BOARD,	48 },
         {DEVID_PDC20267,"PDC20267",	PCI_PDC202XX,	ATA66_PDC202XX,	INIT_PDC202XX,	NULL,		{{0x00,0x00,0x00}, {0x00,0x00,0x00}},	OFF_BOARD,	48 },
 #else /* !CONFIG_PDC202XX_FORCE */
 	{DEVID_PDC20246,"PDC20246",	PCI_PDC202XX,	NULL,		INIT_PDC202XX,	NULL,		{{0x50,0x02,0x02}, {0x50,0x04,0x04}}, 	OFF_BOARD,	16 },

--qMm9M+Fa2AknHoGS--
