Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267202AbSLEDeD>; Wed, 4 Dec 2002 22:34:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267203AbSLEDeD>; Wed, 4 Dec 2002 22:34:03 -0500
Received: from havoc.gtf.org ([64.213.145.173]:26525 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S267202AbSLEDeC>;
	Wed, 4 Dec 2002 22:34:02 -0500
Date: Wed, 4 Dec 2002 22:41:31 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: David Gibson <david@gibson.dropbear.id.au>,
       James Bottomley <James.Bottomley@steeleye.com>,
       "Adam J. Richter" <adam@yggdrasil.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] generic device DMA implementation
Message-ID: <20021205034131.GA26616@gtf.org>
References: <20021205004744.GB2741@zax.zax> <200212050144.gB51iH105366@localhost.localdomain> <20021205023847.GA1500@zax.zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021205023847.GA1500@zax.zax>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 05, 2002 at 01:38:47PM +1100, David Gibson wrote:
> It seems the "try to get consistent memory, but otherwise give me
> inconsistent" is only useful on machines which:
> 	(1) Are not fully consisent, BUT
> 	(2) Can get consistent memory without disabling the cache, BUT
> 	(3) Not very much of it, so you might run out.
> 
> The point is, there has to be an advantage to using consistent memory
> if it is available AND the possibility of it not being available.

Agreed here.  Add to this

(4) quite silly from an API taste perspective.


> Otherwise, drivers which absolutely need consistent memory, no matter
> the cost, should use consistent_alloc(), all other drivers just use
> kmalloc() (or whatever) then use the DMA flushing functions which
> compile to NOPs on platforms with consistent memory.

Ug.  This is travelling backwards in time.

kmalloc is not intended to allocate memory for DMA'ing.  I (and others)
didn't spend all that time converting drivers to the PCI DMA API just to
see all that work undone.

Note that I am speaking from a driver API perspective, however.  If you
are talking about using kmalloc "under the hood" while still presenting
the same driver interface, that's fine.

	Jeff



