Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283586AbRLDXWG>; Tue, 4 Dec 2001 18:22:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283581AbRLDXVq>; Tue, 4 Dec 2001 18:21:46 -0500
Received: from dubb05h09-0.dplanet.ch ([212.35.36.9]:51210 "EHLO
	dubb05h09-0.dplanet.ch") by vger.kernel.org with ESMTP
	id <S283579AbRLDXVg>; Tue, 4 Dec 2001 18:21:36 -0500
Date: Wed, 5 Dec 2001 00:21:11 +0100
From: starfire@dplanet.ch
Message-Id: <200112042321.AAA19847@dubb05h09-0.dplanet.ch>
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.8W6MhE4GVHOI8P

Date: Wed, 5 Dec 2001 00:20:53 +0100
From: Andreas Tscharner <starfire@dplanet.ch>
To: Torvalds Linus <torvalds@transmeta.com>,Tosatti Marcelo <marcelo@conectiva.com.br>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,mj@ucw.cz
Subject: [PATCH] ALi M15x3 ISA DMA Hang
Message-Id: <20011205002053.6945539c.starfire@dplanet.ch>
Organization: No Such Penguin
X-Mailer: Sylpheed version 0.6.5claws25 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Linus,
Hi Marcelo,
Hi all,

The following little patch adds the Ali M15x3 chipset to the list of the buggy ones. The use of this DMA causes a hang without the workaround.

The OSS and ALSA modules for the OPL3/SA2 and OPL3/SAx soundchip use this DMA.

This combination of chipset and soundchip can be found in many Acer Laptops, for example in the whole Acer Extensa Series. Trying to make music on this machines always causes a complete system freeze.

The patch is against a debianized 2.4.16 Kernel, but it should work also with vanilla. It was originally written by Angelo Di Filippo <adifilip@ubiquity.it> for Kernel 2.3.45. I adapted it to 2.4.16.


--- drivers/pci/quirks.c.orig	Tue Dec  4 10:54:33 2001
+++ drivers/pci/quirks.c	Tue Dec  4 10:59:09 2001
@@ -468,6 +468,7 @@
 	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C586_0,	quirk_isa_dma_hangs },
 	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C596,	quirk_isa_dma_hangs },
 	{ PCI_FIXUP_FINAL,      PCI_VENDOR_ID_INTEL,    PCI_DEVICE_ID_INTEL_82371SB_0,  quirk_isa_dma_hangs },
+	{ PCI_FIXUP_FINAL,      PCI_VENDOR_ID_AL,       PCI_DEVICE_ID_AL_M1533,         quirk_isa_dma_hangs },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_S3,	PCI_DEVICE_ID_S3_868,		quirk_s3_64M },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_S3,	PCI_DEVICE_ID_S3_968,		quirk_s3_64M },
 	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_INTEL, 	PCI_DEVICE_ID_INTEL_82437, 	quirk_triton }, 


Best regards
	Andreas
-- 
Andreas Tscharner                                     starfire@dplanet.ch
-------------------------------------------------------------------------
"Programming today is a race between software engineers striving to build 
bigger and better idiot-proof programs, and the Universe trying to produce
bigger and better idiots. So far, the Universe is winning." -- Rich Cook 

--=.8W6MhE4GVHOI8P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)

iD8DBQE8DVpmd6icl+PTsS8RAiJgAJ47VWcmOsSMW2waX9NKgCOFUPbk7gCfehym
UpAqlW98jbh3X55Dbc+obRw=
=AgDC
-----END PGP SIGNATURE-----

--=.8W6MhE4GVHOI8P--

