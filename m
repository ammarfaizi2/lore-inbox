Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310990AbSCHSIz>; Fri, 8 Mar 2002 13:08:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310300AbSCHSIp>; Fri, 8 Mar 2002 13:08:45 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:32004 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S310983AbSCHSIi>; Fri, 8 Mar 2002 13:08:38 -0500
Date: Fri, 8 Mar 2002 10:07:51 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Futexes IV (Fast Lightweight Userspace Semaphores)
In-Reply-To: <E16i8x2-0008TV-00@wagner.rustcorp.com.au>
Message-ID: <Pine.LNX.4.33.0203080953420.2608-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 5 Mar 2002, Rusty Russell wrote:
>
> 1) FUTEX_UP and FUTEX_DOWN defines. (Robert Love)
> 2) Fix for the "decrement wraparound" problem (Paul Mackerras)
> 3) x86 fixes: tested on dual x86 box.

This doesn't work on highmem machines - doing the conversion from "<struct
page, offset>" to "page_address(page)+offset" is simply not legal (not
even for pure hashing purposes - page_address() changes as you kmap it).

You need to keep the <struct page,offset> tuple in that format, and no
other. And when you actually touch the page, you need to do the
kmap()/kunmap() (and you must not keep it mapped while you sleep, because
that might trivially make the kernel run out of virtual mappings).

		Linus

