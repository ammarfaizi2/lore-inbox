Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270640AbRIFNPJ>; Thu, 6 Sep 2001 09:15:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270645AbRIFNO7>; Thu, 6 Sep 2001 09:14:59 -0400
Received: from gnu.in-berlin.de ([192.109.42.4]:24591 "EHLO gnu.in-berlin.de")
	by vger.kernel.org with ESMTP id <S270640AbRIFNOq>;
	Thu, 6 Sep 2001 09:14:46 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Thu, 6 Sep 2001 15:04:51 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PNPBIOS: warning: >= 16 resources, overflow?
Message-ID: <20010906150451.A5256@bytesex.org>
In-Reply-To: <slrn9pedo0.3eu.kraxel@bytesex.org> <E15exwY-0007xb-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E15exwY-0007xb-00@the-village.bc.nu>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2001 at 01:07:38PM +0100, Alan Cox wrote:
> > lspnp (comes with pcmcia-cs) would be more intresting.  The pnpbios code
> > fills a "struct pci_dev" for each device reported by the pnpbios, and it
> > looks like your portable has one device with alot ressources, so the
> > ressources array in struct pci_dev can't hold them all.  There is a
> > #define in include/linux/pci.h for the array size ...
> 
> For the motherboard memory/io ranges it might be worth teaching the
> pnp bios parser to actually reserve the regions as it scans them ?

No trivial way.  Need to read some more code to see how the parser
works and if the data structures are build in a way that I have the
informations I need at any point to do that "on-the-fly" in the
pnp bios node => struct pci_dev parser.

BTW:  There is another issue I've noticed on my Desktop box, where I'm
not sure what the best way to deal with:  Some pnpbios-reported I/O
ranges clash with stuff reserved by pci quirks:


This we have in PCI space (good old Intel BX):

bogomips root ~# lspci -v -s 00:04.3
00:04.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 02)
        Flags: medium devsel, IRQ 9


drivers/pci/quirks.c reserves this for the ACPI bridge:

bogomips root ~# cat /proc/ioports
[ ... ]
e400-e43f : Intel Corporation 82371AB PIIX4 ACPI
e800-e81f : Intel Corporation 82371AB PIIX4 ACPI


pnpbios lists the ACPI ports too:

bogomips root ~# lspnp -v
[ ... ]
0f PNP0c02 system peripheral: other
        io 0x0290-0x0297
        io 0xe400-0xe43f
        io 0xe800-0xe83f

Hmm...

  Gerd

-- 
Damn lot people confuse usability and eye-candy.
