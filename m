Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262208AbSLGKuq>; Sat, 7 Dec 2002 05:50:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267746AbSLGKup>; Sat, 7 Dec 2002 05:50:45 -0500
Received: from dp.samba.org ([66.70.73.150]:37001 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S262208AbSLGKuo>;
	Sat, 7 Dec 2002 05:50:44 -0500
Date: Sat, 7 Dec 2002 21:19:43 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: "David S. Miller" <davem@redhat.com>
Cc: James.Bottomley@steeleye.com, adam@yggdrasil.com,
       linux-kernel@vger.kernel.org, willy@debian.org
Subject: Re: [RFC] generic device DMA implementation
Message-ID: <20021207101943.GD22230@zax.zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	"David S. Miller" <davem@redhat.com>, James.Bottomley@steeleye.com,
	adam@yggdrasil.com, linux-kernel@vger.kernel.org, willy@debian.org
References: <davem@redhat.com> <200212061829.gB6ITAt03038@localhost.localdomain> <20021206.103113.98609883.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021206.103113.98609883.davem@redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 06, 2002 at 10:31:13AM -0800, David Miller wrote:
>    From: James Bottomley <James.Bottomley@steeleye.com>
>    Date: Fri, 06 Dec 2002 12:29:10 -0600
> 
>    How about (as Adam suggested) two dma allocation API's
>    
>    1) dma_alloc_consistent which behaves identically to pci_alloc_consistent
>    2) dma_alloc which can take the conformance flag and can be used to tidy up 
>    the drivers that need to know about cache flushing.
>    
> Now that the situation is much more clear, I'm feeling a lot
> better about this.
> 
> I have only one request, in terms of naming.  What we're really
> doing is adding a third class of memory, it really isn't consistent
> and it really isn't streaming.  It's inconsistent memory meant to
> be used for "consistent memory things".

Not really... it seems to me its abdicating the choice of consistent
versus streaming memory to the platform.  Or to look at it another
way, the actual guarantees it provides are identical to those of
streaming DMA, but this gives the platform an opportunity to optimise
by controlling the allocation rather than demanding it deal with
memory from any old place as pci_map_* must do.

A driver using this sort of memory should be at least isomorphic to
one using streaming memory (maybe identical, depending on exactly
which functions are which etc.).

> So could someone come up with a clever name for this thing? :-)

Given that, how about "fast-streaming" DMA memory.

-- 
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
