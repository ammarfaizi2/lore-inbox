Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262068AbUK3NRU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262068AbUK3NRU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 08:17:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262071AbUK3NRT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 08:17:19 -0500
Received: from mta1.cl.cam.ac.uk ([128.232.0.15]:36260 "EHLO mta1.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S262068AbUK3NRD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 08:17:03 -0500
To: Arjan van de Ven <arjan@infradead.org>
cc: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>, Andrea Arcangeli <andrea@suse.de>,
       linux-kernel@vger.kernel.org, Steven.Hand@cl.cam.ac.uk,
       Christian.Limpach@cl.cam.ac.uk, Keir.Fraser@cl.cam.ac.uk,
       "David S. Miller" <davem@redhat.com>,
       William Lee Irwin III <wli@holomorphy.com>, Ian.Pratt@cl.cam.ac.uk
Subject: Re: [4/7] Xen VMM patch set : /dev/mem io_remap_page_range for CONFIG_XEN 
In-reply-to: Your message of "Tue, 30 Nov 2004 13:14:10 +0100."
             <1101816850.2640.43.camel@laptop.fenrus.org> 
Date: Tue, 30 Nov 2004 13:16:56 +0000
From: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>
Message-Id: <E1CZ7sH-0006Si-00@mta1.cl.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, 2004-11-30 at 12:09 +0000, Ian Pratt wrote:
> > > On Tue, 2004-11-30 at 08:56 +0000, Ian Pratt wrote:
> > > 
> > > > In the Xen case, we actually need to use io_remap_page_range for
> > > > all /dev/mem accesses, so as to be able to map the BIOS area, DMI
> > > > tables etc.
> > > 
> > > look at the /dev/mem patches in the -mm tree... there might be
> > > infrastructure there that is useful to you
> > 
> > Thanks for the pointer. Having looked through, it's orthogonal
> > and can't help us, though doesn't conflict with our patch either
> > (fuzz 2).
> 
> well.. it makes all non-ram unaccessible... so what's left is only the
> stuff Xen wants to make accessible anyway :)

Ha -- I'd missed that because I hadn't spotted the addition of
devmem_is_allowed to /arch/i386/mm/init.c

I'm really rather pleased to see this attempt at disambiguating
what /dev/mem can be used for. What's nice from our POV is it now
explicitly prevents the cases that we couldn't easily support in
Xen.  We'd observed that nothing seemed to break, so presumed
they weren't very common.

The next logical step with that patch would be to have mmap_mem
call io_remap_page_range rather than remap_pfn_range, at which
point it would solve our problem. I'm not sure what this would
mean for architectures other than i386.

Ian
