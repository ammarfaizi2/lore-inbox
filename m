Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278105AbRJRTvc>; Thu, 18 Oct 2001 15:51:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278108AbRJRTvX>; Thu, 18 Oct 2001 15:51:23 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:44814 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S278105AbRJRTvP>; Thu, 18 Oct 2001 15:51:15 -0400
Date: Thu, 18 Oct 2001 12:50:52 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: "David S. Miller" <davem@redhat.com>
cc: <marcelo@conectiva.com.br>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fork() failing
In-Reply-To: <20011018.122525.82054118.davem@redhat.com>
Message-ID: <Pine.LNX.4.33.0110181247520.1801-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 18 Oct 2001, David S. Miller wrote:
>
> There are also some platforms using 1-order allocations
> for page tables as well.
>
> But I don't know if I agree with this special casing.

Well, it's not really any _new_ special casing - we've always had the
special case for order-0, the patch just expands it to order-1 too.

That said, I think a separate flag saying "don't try too hard", which can
be used for all orders, including 0 and 1, and just says that "ok, we want
you to balance things, but if this allocation fails that's not a big
deal".

So the flag would just always be implicit in allocations of higher orders,
because big orders are basically impossible to guarantee..

		Linus

