Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965070AbVJUW1O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965070AbVJUW1O (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 18:27:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965185AbVJUW1O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 18:27:14 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:8068 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S965070AbVJUW1N
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 18:27:13 -0400
Date: Sat, 22 Oct 2005 00:25:16 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: wsong <wsong.cn@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: [PATCH 2.6.14-rc3] sis5513.c: enable ATA133 for the SiS965 southbridge
Message-ID: <20051021222516.GA18899@electric-eye.fr.zoreil.com>
References: <20051005205906.GA4320@farad.aurel32.net> <58cb370e0510060240x2f2e31c3kd0609a06172d86a4@mail.gmail.com> <20051007094135.GA16386@farad.aurel32.net> <4346A41E.3020505@verizon.net> <6f9b6d3e0510211335x202a437co1919df4f7e5aeb2f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f9b6d3e0510211335x202a437co1919df4f7e5aeb2f@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

wsong <wsong.cn@gmail.com> :
> This patch has conflict with sata_sis driver. They both register this
> id 0x0180. But pci ide driver is loaded first. So if you have sata
> drive connected as root, dang, you'll get kernel panic. I had this
> problem with 2.6.14_rc4-mm1. Simply delete the third line from
> structure sis5513_pci_tbl resolved it.
> 
> I know it's just a work around.

The lspci I have received for a k8s-mx exhibit a 5513 whose PCI ID is
already correctly set. If the ID masking and register remapping is not
really relevant on a 180, the code below could be enough. If it is wrong,
it may be better to check the availability of a good backup system before
using it.

Some features documentation suggest that the 760 and the 755 should
mostly go along with the same southbridge. 

Signed-off-by: Francois Romieu <romieu@fr.zoreil.com>

diff --git a/drivers/ide/pci/sis5513.c b/drivers/ide/pci/sis5513.c
--- a/drivers/ide/pci/sis5513.c
+++ b/drivers/ide/pci/sis5513.c
@@ -20,6 +20,7 @@
  * ATA16/33 support from specs
  * ATA133 support for SiS961/962 by L.C. Chang <lcchang@sis.com.tw>
  * ATA133 961/962/963 fixes by Vojtech Pavlik <vojtech@suse.cz>
+ * ATA133 965 hack by Ueimor <romieu@fr.zoreil.com>
  *
  * Documentation:
  *	SiS chipset documentation available under NDA to companies only
@@ -87,6 +88,9 @@ static const struct {
 	u8 chipset_family;
 	u8 flags;
 } SiSHostChipInfo[] = {
+	{ "SiS760",	PCI_DEVICE_ID_SI_760,	ATA_133  },
+	{ "SiS755",	PCI_DEVICE_ID_SI_755,	ATA_133  },
+
 	{ "SiS745",	PCI_DEVICE_ID_SI_745,	ATA_100  },
 	{ "SiS735",	PCI_DEVICE_ID_SI_735,	ATA_100  },
 	{ "SiS733",	PCI_DEVICE_ID_SI_733,	ATA_100  },
