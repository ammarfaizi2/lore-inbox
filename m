Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129063AbQKAO6d>; Wed, 1 Nov 2000 09:58:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129118AbQKAO6X>; Wed, 1 Nov 2000 09:58:23 -0500
Received: from chac.inf.utfsm.cl ([200.1.19.54]:49167 "EHLO chac.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id <S129063AbQKAO6M>;
	Wed, 1 Nov 2000 09:58:12 -0500
Message-Id: <200011011326.eA1DQsv01572@sleipnir.valparaiso.cl>
To: pollard@cats-chateau.net
cc: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.2.18Pre Lan Performance Rocks! 
In-Reply-To: Message from Jesse Pollard <pollard@cats-chateau.net> 
   of "Tue, 31 Oct 2000 21:42:13 MDT." <00103121504302.20791@tabby> 
Date: Wed, 01 Nov 2000 10:26:54 -0300
From: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Pollard <pollard@cats-chateau.net> said:
> On Tue, 31 Oct 2000, Horst von Brand wrote:
> >Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil> said:
> >
> >[...]
> >
> >> Also pay attention to the security aspects of a true "zero copy" TCP stack.
> >> It means that SOMETIMES a user buffer will recieve data that is destined
> >> for a different process.

> >Why? AFAIKS, given proper handling of the issues involved, this can't
> >happen (sure can get tricky, but can be done in principle. Or am I
> >off-base?)

> As I understand the current implementation, this can't. One of the
> optimization s I had read about (for a linux test) used zero copy to/from
> user buffer as well as zero copy in the kernel. I believe the DMA went
> directly to the users memory.

Right. This means you have to ensure (somehow blocking the process(es) with
access to the buffer(s) involved) that nobody can see half-filled buffers.
Tricky, but not impossible, at least not in principle. Or play VM games and
switch the areas underneath atomically. The VM games we have been told are
costlier than the average copy on "typical" machines (PCs, presumably ;-),
plus you'd have to either ensure aligned buffers (how?) or keep two copies
of whatever surrounds them (where is the advantage then?).
-- 
Horst von Brand                             vonbrand@sleipnir.valparaiso.cl
Casilla 9G, Vin~a del Mar, Chile                               +56 32 672616

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
