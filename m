Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261651AbUCVD3S (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 22:29:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261652AbUCVD3S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 22:29:18 -0500
Received: from fw.osdl.org ([65.172.181.6]:63631 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261651AbUCVD3P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 22:29:15 -0500
Date: Sun, 21 Mar 2004 19:28:59 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: David Woodhouse <dwmw2@infradead.org>
cc: Jeff Garzik <jgarzik@pobox.com>, Russell King <rmk+lkml@arm.linux.org.uk>,
       Christoph Hellwig <hch@infradead.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: can device drivers return non-ram via vm_ops->nopage?
In-Reply-To: <1079913775.17681.499.camel@imladris.demon.co.uk>
Message-ID: <Pine.LNX.4.58.0403211927250.1106@ppc970.osdl.org>
References: <20040320121345.2a80e6a0.akpm@osdl.org>  <20040320205053.GJ2045@holomorphy.com>
  <20040320222639.K6726@flint.arm.linux.org.uk>  <20040320224500.GP2045@holomorphy.com>
  <1079901914.17681.317.camel@imladris.demon.co.uk>  <20040321204931.A11519@infradead.org>
  <1079902670.17681.324.camel@imladris.demon.co.uk> 
 <Pine.LNX.4.58.0403211349340.1106@ppc970.osdl.org> 
 <20040321222327.D26708@flint.arm.linux.org.uk> <405E1859.5030906@pobox.com>
  <20040321225117.F26708@flint.arm.linux.org.uk>  <Pine.LNX.4.58.0403211504550.1106@ppc970.osdl.org>
  <405E23A5.7080903@pobox.com>  <Pine.LNX.4.58.0403211542051.1106@ppc970.osdl.org>
 <1079913775.17681.499.camel@imladris.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 22 Mar 2004, David Woodhouse wrote:
> 
> You are assuming that dma_alloc_coherent() will always return memory of
> that second kind -- host-side RAM, not PCI-side. That hasn't previously
> been a requirement, and there are machines out there on which it makes a
> lot more sense for dma_alloc_coherent() to use some SRAM which happens
> to be hanging off the I/O bus than it does to use host RAM.

So? Those architectures can just allocate "struct page" entries for that 
memory too. 

There is a point where we should not care about idiotic architectures any 
more. We should care about what happens in 99% of all architectures, and 
the rest get to work around their _own_ quirks. We do not make the VM 
uglier for some insane "it can happen" case.

		Linus
