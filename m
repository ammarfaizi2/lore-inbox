Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262486AbSJVMm6>; Tue, 22 Oct 2002 08:42:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262491AbSJVMm6>; Tue, 22 Oct 2002 08:42:58 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:44036 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S262486AbSJVMm5>; Tue, 22 Oct 2002 08:42:57 -0400
Date: Tue, 22 Oct 2002 16:48:51 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Andreas Hartmann <andreas.hartmann@fiducia.de>
Cc: "Alan Cox <alan" <alan@lxorguk.ukuu.org.uk>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: PCI: Failed to allocate resource in 2.4.20pre10 and 11 - broken	IRQ-router?
Message-ID: <20021022164851.A3371@jurassic.park.msu.ru>
References: <OFD7C667D3.0FFAD96B-ON41256C5A.0043BB37@fag.fiducia.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <OFD7C667D3.0FFAD96B-ON41256C5A.0043BB37@fag.fiducia.de>; from andreas.hartmann@fiducia.de on Tue, Oct 22, 2002 at 01:48:45PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2002 at 01:48:45PM +0100, Andreas Hartmann wrote:
> CMD64x is switched off in *both* config-files of the kernel. I switched it on in
> the 2.4.20pre10 kernel, but the result is the same.

Ugh. It's a silly typo in the "transparent bridges" patch.

Thanks for the report, Andreas.

Ivan.

--- 2.4.20p11/drivers/pci/pci.c	Tue Oct 22 16:27:00 2002
+++ linux/drivers/pci/pci.c	Tue Oct 22 16:37:18 2002
@@ -1386,7 +1386,7 @@ int pci_setup_device(struct pci_dev * de
 		/* The PCI-to-PCI bridge spec requires that subtractive
 		   decoding (i.e. transparent) bridge must have programming
 		   interface code of 0x01. */ 
-		dev->transparent = ((class & 0xff) == 1);
+		dev->transparent = ((dev->class & 0xff) == 1);
 		pci_read_bases(dev, 2, PCI_ROM_ADDRESS1);
 		break;
 
