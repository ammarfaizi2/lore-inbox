Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275765AbRJFWdx>; Sat, 6 Oct 2001 18:33:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275767AbRJFWdo>; Sat, 6 Oct 2001 18:33:44 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:20997 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S275765AbRJFWdj>; Sat, 6 Oct 2001 18:33:39 -0400
Date: Sun, 7 Oct 2001 00:34:05 +0200 (CEST)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: %u-order allocation failed
In-Reply-To: <20011006201303.20370@smtp.wanadoo.fr>
Message-ID: <Pine.LNX.3.96.1011007003227.18004B-100000@artax.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >OK, but my patch uses vmalloc only as a fallback when buddy fails. The
> >probability that buddy fails is small. It is slower but with very small
> >probability.
> >
> >It is perfectly OK to have a bit slower access to task_struct with
> >probability 1/1000000.
> >
> >But it is ***BAD*BUG*** if allocation of task_struct fails with
> >probability 1/1000000.
> 
> I missed the beginning of the thread, sorry if that question was
> already answered,
> 
> What about all the code that still consider kmalloc'ed memory is
> safe for use with virt_to_bus and friends and is contiguous
> physically for DMA ? In some cases (non-PCI devices, embedded
> platforms, etc...), the pci_consistent API is not an option.
> That means that __GFP_VMALLOC can't be part of GFP_KERNEL or
> many driver will break in horrible ways (random memory corruption).

You are right. Code that allocates more than page and expects it to be
physicaly contignuous is broken by design. Even rewrite the driver or
allocate memory on boot. It will be very hard to audit all drivers for it.

Mikulas

