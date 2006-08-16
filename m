Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751154AbWHPM01@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751154AbWHPM01 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 08:26:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751153AbWHPM00
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 08:26:26 -0400
Received: from ns2.suse.de ([195.135.220.15]:50378 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751148AbWHPM0Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 08:26:25 -0400
Date: Wed, 16 Aug 2006 14:25:57 +0200
From: Andi Kleen <ak@suse.de>
To: Christoph Hellwig <hch@infradead.org>
Cc: Evgeniy Polyakov <johnpol@2ka.mipt.ru>, Arnd Bergmann <arnd@arndb.de>,
       David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/1] network memory allocator.
Message-Id: <20060816142557.acccdfcf.ak@suse.de>
In-Reply-To: <20060816084808.GA7366@infradead.org>
References: <20060814110359.GA27704@2ka.mipt.ru>
	<200608152221.22883.arnd@arndb.de>
	<20060816053545.GB22921@2ka.mipt.ru>
	<20060816084808.GA7366@infradead.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Aug 2006 09:48:08 +0100
Christoph Hellwig <hch@infradead.org> wrote:

> On Wed, Aug 16, 2006 at 09:35:46AM +0400, Evgeniy Polyakov wrote:
> > On Tue, Aug 15, 2006 at 10:21:22PM +0200, Arnd Bergmann (arnd@arndb.de) wrote:
> > > Am Monday 14 August 2006 13:04 schrieb Evgeniy Polyakov:
> > > > ?* full per CPU allocation and freeing (objects are never freed on
> > > > ????????different CPU)
> > > 
> > > Many of your data structures are per cpu, but your underlying allocations
> > > are all using regular kzalloc/__get_free_page/__get_free_pages functions.
> > > Shouldn't these be converted to calls to kmalloc_node and alloc_pages_node
> > > in order to get better locality on NUMA systems?
> > >
> > > OTOH, we have recently experimented with doing the dev_alloc_skb calls
> > > with affinity to the NUMA node that holds the actual network adapter, and
> > > got significant improvements on the Cell blade server. That of course
> > > may be a conflicting goal since it would mean having per-cpu per-node
> > > page pools if any CPU is supposed to be able to allocate pages for use
> > > as DMA buffers on any node.
> > 
> > Doesn't alloc_pages() automatically switches to alloc_pages_node() or
> > alloc_pages_current()?
> 
> That's not what's wanted.  If you have a slow interconnect you always want
> to allocate memory on the node the network device is attached to.

That's not true on all NUMA systems (that they have a slow interconnect)
I think on x86-64 I would prefer if it was distributed evenly or maybe even 
on the CPU who is finally going to process it.

-Andi "not all NUMA is an Altix"
