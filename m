Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261805AbUKJAAO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261805AbUKJAAO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 19:00:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261784AbUKJAAN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 19:00:13 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:53424 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261805AbUKIX6p
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 18:58:45 -0500
Date: Tue, 9 Nov 2004 18:33:48 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Lukas Hejtmanek <xhejtman@mail.muni.cz>
Cc: Andrew Morton <akpm@osdl.org>, zaphodb@zaphods.net,
       linux-kernel@vger.kernel.org, piggin@cyberone.com.au
Subject: Re: Kernel 2.6.9 Multiple Page Allocation Failures
Message-ID: <20041109203348.GD8414@logos.cnet>
References: <20041103222447.GD28163@zaphods.net> <20041104121722.GB8537@logos.cnet> <20041104181856.GE28163@zaphods.net> <20041109164113.GD7632@logos.cnet> <20041109223558.GR1309@mail.muni.cz> <20041109144607.2950a41a.akpm@osdl.org> <20041109224423.GC18366@mail.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041109224423.GC18366@mail.muni.cz>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 09, 2004 at 11:44:23PM +0100, Lukas Hejtmanek wrote:
> On Tue, Nov 09, 2004 at 02:46:07PM -0800, Andrew Morton wrote:
> > > > Can you please run your workload which cause 0-order page allocation 
> > > > failures with the following patch, pretty please? 
> > > > 
> > > > We will have more information on the free areas state when the allocation 
> > > > fails.
> > > > 
> > > > Andrew, please apply it to the next -mm, will you?
> > > 
> > > here is the trace:
> > >  klogd: page allocation failure. order:0, mode: 0x20
> > >   [__alloc_pages+441/862] __alloc_pages+0x1b9/0x363
> > >   [__get_free_pages+42/63] __get_free_pages+0x25/0x3f
> > >   [kmem_getpages+37/201] kmem_getpages+0x21/0xc9
> > >   [cache_grow+175/333] cache_grow+0xab/0x14d
> > >   [cache_alloc_refill+376/537] cache_alloc_refill+0x174/0x219
> > >   [__kmalloc+137/140] __kmalloc+0x85/0x8c
> > >   [alloc_skb+75/224] alloc_skb+0x47/0xe0
> > >   [e1000_alloc_rx_buffers+72/227] e1000_alloc_rx_buffers+0x44/0xe3
> > >   [e1000_clean_rx_irq+402/1095] e1000_clean_rx_irq+0x18e/0x447
> > >   [e1000_clean+85/202] e1000_clean+0x51/0xca
> > 
> > What kernel is in use here?
> > 
> > There was a problem related to e1000 and TSO which was leading to these
> > over-aggressive atomic allocations.  That was fixed (within ./net/)
> > post-2.6.9.
> 
> I use vanilla 2.6.9.

Lukas,

So you can be hitting the e1000/TSO issue - care to retest with 
2.6.10-rc1-mm3/4 please?

Thanks a lot for testing!
