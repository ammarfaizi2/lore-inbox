Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261648AbUCVDFi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 22:05:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261651AbUCVDFi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 22:05:38 -0500
Received: from fw.osdl.org ([65.172.181.6]:1411 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261648AbUCVDFd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 22:05:33 -0500
Date: Sun, 21 Mar 2004 19:05:24 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
cc: Jeff Garzik <jgarzik@pobox.com>, David Woodhouse <dwmw2@infradead.org>,
       Christoph Hellwig <hch@infradead.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: can device drivers return non-ram via vm_ops->nopage?
In-Reply-To: <20040322003429.GE3649@dualathlon.random>
Message-ID: <Pine.LNX.4.58.0403211904510.1106@ppc970.osdl.org>
References: <20040321204931.A11519@infradead.org> <1079902670.17681.324.camel@imladris.demon.co.uk>
 <Pine.LNX.4.58.0403211349340.1106@ppc970.osdl.org> <20040321222327.D26708@flint.arm.linux.org.uk>
 <405E1859.5030906@pobox.com> <20040321225117.F26708@flint.arm.linux.org.uk>
 <Pine.LNX.4.58.0403211504550.1106@ppc970.osdl.org> <405E23A5.7080903@pobox.com>
 <Pine.LNX.4.58.0403211542051.1106@ppc970.osdl.org> <20040321235854.H26708@flint.arm.linux.org.uk>
 <20040322003429.GE3649@dualathlon.random>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 22 Mar 2004, Andrea Arcangeli wrote:
>
> On Sun, Mar 21, 2004 at 11:58:54PM +0000, Russell King wrote:
> > On Sun, Mar 21, 2004 at 03:51:31PM -0800, Linus Torvalds wrote:
> > > That might be the minimal fix, since it would basically involve:
> > >  - change whatever offensive "virt_to_page()" calls into 
> > >    "dma_map_to_page()".
> > >  - implement "dma_map_to_page()" for all architectures.
> > > 
> > > Would that make people happy?
> > 
> > Unfortunately this doesn't make dwmw2 happy - he claims to have machines
> > which implement dma_alloc_coherent using RAM which doesn't have any
> > struct page associated with it.
> 
> I would suggest to add a ->nopage_dma (or whatever other name for an
> additional callback in the vm_ops) that will return a non pageable "pfn"

No.

Fix the broken architecture instead.

		Linus
