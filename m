Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267233AbSLEF5i>; Thu, 5 Dec 2002 00:57:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267236AbSLEF5i>; Thu, 5 Dec 2002 00:57:38 -0500
Received: from dp.samba.org ([66.70.73.150]:53156 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267233AbSLEF5h>;
	Thu, 5 Dec 2002 00:57:37 -0500
Date: Thu, 5 Dec 2002 16:02:33 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Miles Bader <miles@gnu.org>
Cc: James Bottomley <James.Bottomley@steeleye.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] generic device DMA implementation
Message-ID: <20021205050233.GD1500@zax.zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Miles Bader <miles@gnu.org>,
	James Bottomley <James.Bottomley@steeleye.com>,
	linux-kernel@vger.kernel.org
References: <200212042146.gB4Lkw804422@localhost.localdomain> <buou1htryc1.fsf@mcspd15.ucom.lsi.nec.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <buou1htryc1.fsf@mcspd15.ucom.lsi.nec.co.jp>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 05, 2002 at 11:31:10AM +0900, Miles Bader wrote:
> James Bottomley <James.Bottomley@steeleye.com> writes:
> > > How is the driver supposed to tell whether a given dma_addr_t value
> > > represents consistent memory or not?  It seems like an
> > > (arch-specific) `dma_addr_is_consistent' function is necessary, but
> > > I couldn't see one in your patch.
> > 
> > If you have a machine that has both consistent and inconsistent blocks, you 
> > need to encode that in dma_addr_t (which is a platform definable type).
> > 
> > The sync functions would just decode the type and either nop or perform the 
> > sync.
> 
> My thinking was that a driver might want to do things like --
> 
>   if (dma_addr_is_consistent (some_funky_addr)) {
>     do it quickly;
>   } else
>     do_it_the_slow_way (some_funky_addr);
> 
> in other words, something besides just calling the sync functions, in
> the case where the memory was consistent.

Yes, but using consistent memory is not necessarily the fast way - in
fact it probably won't be.  Machines which don't do DMA cache snooping
will need to disable caching to get consistent memory, so using
consistent memory is very slow - on such a machine explicit syncs are
preferable wherever possible.

On a machine which is nicely consistent, the cache "flushes" should
become NOPs, so we'd expect the two sides of that if to do the same
thing.

-- 
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
