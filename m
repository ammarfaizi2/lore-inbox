Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129032AbRBHIlT>; Thu, 8 Feb 2001 03:41:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129030AbRBHIlI>; Thu, 8 Feb 2001 03:41:08 -0500
Received: from mspool.gts.cz ([212.47.0.11]:27410 "EHLO mspool.gts.cz")
	by vger.kernel.org with ESMTP id <S129032AbRBHIkv>;
	Thu, 8 Feb 2001 03:40:51 -0500
Date: Thu, 8 Feb 2001 09:40:42 +0100
From: Martin Mares <mj@suse.cz>
To: "Zink, Dan" <Dan.Zink@compaq.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'al10@inf.tu-dresden.de'" <al10@inf.tu-dresden.de>
Subject: Re: [Patch] ServerWorks peer bus fix for 2.4.x
Message-ID: <20010208094042.B119@albireo.ucw.cz>
In-Reply-To: <8C91B010B3B7994C88A266E1A72184D3116FCD@cceexc19.americas.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <8C91B010B3B7994C88A266E1A72184D3116FCD@cceexc19.americas.cpqcorp.net>; from Dan.Zink@compaq.com on Wed, Feb 07, 2001 at 06:46:24PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> The ServerWorks peer bus problem is still present on the 2.4.1 kernel.  The
> problem stems from the fact that there can be more than one secondary bus
> for a given north bridge.  For example, the Compaq Proliant DL580 has two
> "root busses" coming off of a single north bridge.  I'm including below an
> email from Adam Lackorzynski.  In his email, he includes a patch that fixes
> the problem.  I think Martin objected because he thought the patch got the
> meaning of the two config registers wrong, but it is, in fact, correct.

What leads you to your belief it's correct? The lspci dump Adam has sent
to the list shows that there's something utterly wrong with our understanding
of the ServerWorks config registers -- they seem to say that the primary
bus numbers are 00 and 01, but in reality they are 00 and 02.

For now, it will be better to comment out the whole ServerWorks fixup thing
and let the generic peer bus code do its magic work -- it's far better to rely
on BIOS and chipset to behave sanely (i.e., BIOS reporting last_bus not lower
than the real one and chipset not decoding out-of-range bus numbers) than on
guesses of register values which are probably wrong, at least until we have
some more examples for comparison.

Dan, can you send me outputs of 'lspci -MH1 -vvx' and 'lspci -vvxxx -s0:0'
and also try commenting out the lines

	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_SERVERWORKS,	PCI_DEVICE_ID_SERVERWORKS_HE,		pci_fixup_serverworks },
	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_SERVERWORKS,	PCI_DEVICE_ID_SERVERWORKS_LE,		pci_fixup_serverworks },
	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_SERVERWORKS,	PCI_DEVICE_ID_SERVERWORKS_CMIC_HE,	pci_fixup_serverworks },

in arch/i386/kernel/pci-pc.c, please?

				Have a nice fortnight
-- 
Martin `MJ' Mares <mj@ucw.cz> <mj@suse.cz> http://atrey.karlin.mff.cuni.cz/~mj/
This message transmited on 100% recycled electrons.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
