Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264771AbRF1W2V>; Thu, 28 Jun 2001 18:28:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264779AbRF1W2L>; Thu, 28 Jun 2001 18:28:11 -0400
Received: from pizda.ninka.net ([216.101.162.242]:2462 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S264771AbRF1W14>;
	Thu, 28 Jun 2001 18:27:56 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15163.44893.949350.415471@pizda.ninka.net>
Date: Thu, 28 Jun 2001 15:27:41 -0700 (PDT)
To: Jes Sorensen <jes@sunsite.dk>
Cc: "MEHTA,HIREN (A-SanJose,ex1)" <hiren_mehta@agilent.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: (reposting) how to get DMA'able memory within 4GB on 64-bit m achi ne
In-Reply-To: <d3u2109rho.fsf@lxplus015.cern.ch>
In-Reply-To: <FEEBE78C8360D411ACFD00D0B7477971880AD5@xsj02.sjs.agilent.com>
	<d33d8kbdel.fsf@lxplus015.cern.ch>
	<15163.43319.82354.562310@pizda.ninka.net>
	<d3u2109rho.fsf@lxplus015.cern.ch>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jes Sorensen writes:
 > >>>>> "David" == David S Miller <davem@redhat.com> writes:
 > 
 > David> Jes Sorensen writes:
 > >>  Because on ia64 you will get back a 64 bit pointer if you use
 > >> pci_set_dma_mask() to set a 64 bit mask before calling the pci
 > >> functions in question.
 > 
 > David> Please note that this is nonstandard and undocumented behavior.
 > 
 > David> This is not a supported API at all, and the way 64-bit DMA will
 > David> eventually be done across all platforms is likely to be
 > David> different.
 > 
 > Well please also note there has been requests for proper 64 bit DMA
 > support for over 3 years or so by now.

Hey Jes, figure this out, I did all the work to get proper 32 bit DMA
to work.  I was waiting 3 years for that and I did all the work
myself.  I was patient, people needing 64-bit DMA can be patient as
well and wait 1 or 2 weeks for 2.5.x to start up so we can make these
kinds of changes.

 > The interface we use works well, so why should it be changed for other
 > architecures? Instead it would make a lot more sense to support it on
 > other architectures that can do 64 bit DMA.

Because it makes not one iota of sense to have a 64-bit dma_addr_t on
a 32-bit system where none of this DAC crap is relevant.

That is why.

Send Linus a patch which makes dma_addr_t 64-bit on ix86, see how far
you get.  And I would totally agree with him, the overhead of the
larger type is totally stupid for %99 of cases on x86.

Sure, if HIGHMEM or whatever is set, it may make sense.  But I think
eating the 64-bit type in all drivers using dma_addr_t, even one's
only capable of 32-bit PCI addressing, is bogus as well.

This is why I wanted a seperate dma64_addr_t and pci64_*() routines to
match.  So the overhead only existed where it was absolutely needed.
People already bark at me about the overhead of adding dma_addr_t when
"virt_to_bus and bus_to_virt worked perfectly fine without having to
 keep track of these DMA cookies everywhere" and to a certain extent
they are right.  So we should avoid making this worse when possible.

Later,
David S. Miller
davem@redhat.com


