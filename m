Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132056AbRDJUQo>; Tue, 10 Apr 2001 16:16:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132142AbRDJUQe>; Tue, 10 Apr 2001 16:16:34 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:17682 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S132056AbRDJUQW>; Tue, 10 Apr 2001 16:16:22 -0400
Date: Tue, 10 Apr 2001 13:16:10 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andi Kleen <ak@suse.de>
cc: David Howells <dhowells@cambridge.redhat.com>,
        Andrew Morton <andrewm@uow.edu.au>, Ben LaHaise <bcrl@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] i386 rw_semaphores fix
In-Reply-To: <20010410220551.A24251@gruyere.muc.suse.de>
Message-ID: <Pine.LNX.4.31.0104101313390.13071-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 10 Apr 2001, Andi Kleen wrote:
>
> I guess 386 could live with an exception handler that emulates it.

That approach is fine, although I'd personally prefer to take the
exception just once and just rewrite the instuction as a "call". The
places that need xadd would have to follow some strict guidelines (long
modrms or other instructions to pad out to enough size, and have the
arguments in fixed registers)

> (BTW an generic exception handler for CMPXCHG would also be very useful
> for glibc -- currently it has special checking code for 386 in its mutexes)
> The 386 are so slow that nobody would probably notice a bit more slowness
> by a few exceptions.

Ehh. I find that the slower the machine is, the more easily I _notice_
that it is slow. So..

		Linus

