Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278112AbRJRT61>; Thu, 18 Oct 2001 15:58:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278108AbRJRT5N>; Thu, 18 Oct 2001 15:57:13 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:60171 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S278112AbRJRT5F>; Thu, 18 Oct 2001 15:57:05 -0400
Date: Thu, 18 Oct 2001 16:35:43 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fork() failing
In-Reply-To: <Pine.LNX.4.33.0110181247520.1801-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0110181633270.12429-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 18 Oct 2001, Linus Torvalds wrote:

> 
> On Thu, 18 Oct 2001, David S. Miller wrote:
> >
> > There are also some platforms using 1-order allocations
> > for page tables as well.
> >
> > But I don't know if I agree with this special casing.
> 
> Well, it's not really any _new_ special casing - we've always had the
> special case for order-0, the patch just expands it to order-1 too.
> 
> That said, I think a separate flag saying "don't try too hard", which can
> be used for all orders, including 0 and 1, and just says that "ok, we want
> you to balance things, but if this allocation fails that's not a big
> deal".
> 
> So the flag would just always be implicit in allocations of higher orders,
> because big orders are basically impossible to guarantee..

Read my last mail on this thread... A single flag saying "we can fail
easily" does not sound good to me.

Imagine people changing the point where the 

	if ((gfp_mask & __GFP_FAIL))
		return;

check is done (inside the freeing routines).

I would like to have a _defined_ meaning for a "fail easily" allocation,
and a simple unique __GFP_FAIL flag can't give us that IMO.



