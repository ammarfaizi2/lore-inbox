Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277630AbRJHXrC>; Mon, 8 Oct 2001 19:47:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277629AbRJHXqy>; Mon, 8 Oct 2001 19:46:54 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:57349 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S277633AbRJHXqm>; Mon, 8 Oct 2001 19:46:42 -0400
Date: Mon, 8 Oct 2001 16:46:04 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: David Woodhouse <dwmw2@infradead.org>
cc: Peter Rival <frival@zk3.dec.com>, <paulus@samba.org>,
        "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>,
        <jay.estabrook@compaq.com>, <rth@twiddle.net>
Subject: Re: [PATCH] change name of rep_nop 
In-Reply-To: <13962.1002580586@redhat.com>
Message-ID: <Pine.LNX.4.33.0110081643230.1064-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 8 Oct 2001, David Woodhouse wrote:
>
> While we're on the subject of stupidly named routines and x86-isms, I'm
> having trouble reconciling this text in Documentation/cachetlb.txt:
>
> 	1) void flush_cache_all(void)
>
> 	        The most severe flush of all.  After this interface runs,
> 	        the entire cpu cache is flushed.
>
> ... with this implementation in include/asm-i386/pgtable.h:
>
> 	#define flush_cache_all()			do { } while (0)
>
> That really doesn't seem to be doing what it says on the tin.

There's no way we should implement "simon_says".

There's a difference between stupiud hardware changing memory from under
us through mapping tricks, and cache coherency in general.

What you want is the "memory_went_away_from_us()" kind of cache flush,
which has nothing at all to do with cache coherency. And it should be
explicitly and clearly named THAT, and you should not blame the fact that
x86 is always 100% cache coherent and that the normal cache coherency
routines should _never_ be anything but a nop.

Also note that wbinvd is known to corrupted the caches and lead to lockups
on certain x86 cores. You need to be a _lot_ more careful than just doing
it indiscriminately from a driver.

		Linus

