Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267235AbSLEGIj>; Thu, 5 Dec 2002 01:08:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267238AbSLEGIi>; Thu, 5 Dec 2002 01:08:38 -0500
Received: from dp.samba.org ([66.70.73.150]:11685 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267235AbSLEGIi>;
	Thu, 5 Dec 2002 01:08:38 -0500
Date: Thu, 5 Dec 2002 17:12:24 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Miles Bader <miles@gnu.org>
Cc: "Adam J. Richter" <adam@yggdrasil.com>, jgarzik@pobox.com,
       davem@redhat.com, James.Bottomley@SteelEye.com,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] generic device DMA implementation
Message-ID: <20021205061224.GH1500@zax.zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Miles Bader <miles@gnu.org>, "Adam J. Richter" <adam@yggdrasil.com>,
	jgarzik@pobox.com, davem@redhat.com, James.Bottomley@SteelEye.com,
	linux-kernel@vger.kernel.org
References: <200212050121.RAA03254@adam.yggdrasil.com> <20021205024039.GB1500@zax.zax> <buolm35rxgv.fsf@mcspd15.ucom.lsi.nec.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <buolm35rxgv.fsf@mcspd15.ucom.lsi.nec.co.jp>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 05, 2002 at 11:49:52AM +0900, Miles Bader wrote:
> David Gibson <david@gibson.dropbear.id.au> writes:
> > For cases like this, I'm talking about replacing the
> > consistent_alloc() with a kmalloc(), then using the cache flush
> > macros.  Is there any machine for which this is not sufficient?
> 
> I'm not entirely sure what you mean by `using the cache flush macros,'
> but on one of my platforms, PCI consistent memory must be allocated from
> a special area.

Well, yes, you only need the cache flush macros on memory that *isn't*
consistent.

> It's also not clear what you mean by `for cases like this' -- do you
> mean, replace _all_ uses of xxx_alloc_consistent with kmalloc, or do you
> mean just those cases where pci_alloc_consistent currently returns 0?

I mean replace xxx_alloc_consistent() with kmalloc() and appropriate
calls to map_single() (or whatever) in those cases where we actually
care about reducing our usage of (genuinely) consistent memory and it
is possible to do so.

> If the former, it obviously doesn't work on my platform; if the latter,
> I guess this is what James' patch assumes the platform-specific
> dma_alloc_consistent function will do.

Well, with James approach you need a dma_sync() of some sort in pretty
much exactly the same places you need a map_single() or similar if you
used kmalloc() to start with.

-- 
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
