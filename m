Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267458AbSLFAD1>; Thu, 5 Dec 2002 19:03:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267450AbSLFACM>; Thu, 5 Dec 2002 19:02:12 -0500
Received: from dp.samba.org ([66.70.73.150]:45517 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267458AbSLFACB>;
	Thu, 5 Dec 2002 19:02:01 -0500
Date: Fri, 6 Dec 2002 11:06:25 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: davem@redhat.com, James.Bottomley@steeleye.com, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org, miles@gnu.org
Subject: Re: [RFC] generic device DMA implementation
Message-ID: <20021206000625.GS1500@zax.zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	"Adam J. Richter" <adam@yggdrasil.com>, davem@redhat.com,
	James.Bottomley@steeleye.com, jgarzik@pobox.com,
	linux-kernel@vger.kernel.org, miles@gnu.org
References: <200212051157.DAA04682@adam.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200212051157.DAA04682@adam.yggdrasil.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 05, 2002 at 03:57:53AM -0800, Adam J. Richter wrote:
> David Gibson wrote:
> >Since, with James's approach you'd need a dma sync function (which
> >might compile to NOP) in pretty much the same places you'd need
> >map/sync calls, I don't see that it does make the source noticeably
> >simpler.
> 
>         Because then you don't have to have a branch for
> case where the platform *does* support consistent memory.

Sorry, you're going to have to explain where this extra branch is, I
don't see it.

> >>       If were to try the approach of using pci_{map,sync}_single
> >> always (i.e., just writing the code not to use alloc_consistent),
> >> that would have a performance cost on machines where using
> >> consistent memory for writing small amounts of data is cheaper than
> >> the cost of the cache flushes that would otherwise be required.
> >
> >Well, I'm only talking about the cases where we actually care about
> >reducing the use of consistent memory.
> 
>         Then you're not fully weighing the benefits of this facility.
> The primary beneficiaries of this facility are device drivers for
> which we'd like to have the performance advantages of consistent
> memory when available (at least on machines that always return
> consistent memory) but which we'd also like to have work as

What performance advantages of consistent memory?  Can you name any
non-fully-consistent platform where consistent memory is preferable
when it is not strictly required?  For, all the non-consistent
platforms I'm aware of getting consistent memory means disabling the
cache and therefore is to be avoided wherever it can be.

> efficiently as possible on platforms that lack consistent memory or
> have so little that we want the device driver to still work even when
> no consistent memory is available.  That includes all PCI devices that
> users of the inconsistent parisc machines want to use.

-- 
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
