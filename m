Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267859AbRGRLhJ>; Wed, 18 Jul 2001 07:37:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267860AbRGRLg7>; Wed, 18 Jul 2001 07:36:59 -0400
Received: from mail.gris.uni-tuebingen.de ([134.2.176.16]:42767 "HELO
	mail.gris.uni-tuebingen.de") by vger.kernel.org with SMTP
	id <S267859AbRGRLgr>; Wed, 18 Jul 2001 07:36:47 -0400
Date: Wed, 18 Jul 2001 13:36:49 +0200 (CEST)
From: Alexander Ehlert <alexander.ehlert@uni-tuebingen.de>
To: <linux-kernel@vger.kernel.org>
Subject: Right Semantics for ioremap, remap_page_range
Message-ID: <Pine.LNX.4.32.0107181334442.809-100000@frodo.sau98.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm currently trying to write a linux kernel driver for an experimental
graphics board we're developing at our institute. It's fitted
with an plx9054 and got some sdram on board connected to the plx.
Now I come this far, that I actually detect the board, set some modes
and do an ioremap on pci_resource_start(pdev,2) which is the
base for 64Mb Ram Onboard. After ioremap() I actually like
to do remap_page_range through fileops/mmap call. I just copied
that code from drivers/char/mem.c, but just using the ioremapped
address as offset in remap_page_range, doesn't seem to work, instead
I think I just mmap some totally different area... Now, what do I have to
use for that offset? What I currently do in the init function is
something like that:

...
priv.pcibar2 = (char*)ioremap(pci_resource_start(pdev,2),
                              pci_resource_len(pdev,2));
...

and later on in the mmap method I do:

static int mmap_plx9054(file, vma) {
unsigned long pcibase = (unsigned long)priv.pcibar2;
...
remap_page_range(vma->vma_start, pcibase, len, vma->vm_page_prot);
...
}

I just use pcibase as offset, anything wrong here?

Cheers, Alex

PS: Is there someone who knows about the plx9054?

-- 

Small things make base men proud.
		-- William Shakespeare, "Henry VI"


