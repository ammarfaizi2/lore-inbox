Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133061AbRECTaE>; Thu, 3 May 2001 15:30:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133040AbRECT3d>; Thu, 3 May 2001 15:29:33 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:43270 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S133095AbRECT2n>; Thu, 3 May 2001 15:28:43 -0400
Date: Thu, 3 May 2001 12:28:35 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Edward Spidre <beamz_owl@yahoo.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@redhat.com>
Subject: Re: Possible PCI subsystem bug in 2.4
In-Reply-To: <20010503191655.67673.qmail@web10701.mail.yahoo.com>
Message-ID: <Pine.LNX.4.21.0105031219300.30680-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 3 May 2001, Edward Spidre wrote:
>
> Sure, I'm more than willing to test out patches. Just
> let me know which version of source to apply it
> against.

Ok, this is not a patch per se, just a description of what I think should
work..

In include/asm-i386/pci.h, change the line

	#define PCIBIOS_MIN_MEM		0x10000000

into

	extern unsigned long pci_mem_start;
	#define PCIBIOS_MIN_MEM		(pci_mem_start)

In arch/i386/kernel/setup.c, at the very end of the
"setup_arch()" function, add

	/* Start PCI allocations at max_low_memory rounded up to 1MB */
	pci_mem_start = ((max_low_pfn << PAGE_SHIFT) + 0xfffff) & ~0xfffff;

and somewhere in the same file, add the actual variable:

	unsigned long pci_mem_start = 0x10000000;

and you're done. Does this work for you?

Alan, do you have access to that Dell laptop to test? The thing looks
obvious, but I'd rather not apply it to my tree until somebody sends me
the above back as a tested patch.. Call me a sissy.

		Linus

