Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293630AbSCPA7M>; Fri, 15 Mar 2002 19:59:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293631AbSCPA7D>; Fri, 15 Mar 2002 19:59:03 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:45840 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S293630AbSCPA6t>; Fri, 15 Mar 2002 19:58:49 -0500
Date: Fri, 15 Mar 2002 16:58:14 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: bit ops on unsigned long?
In-Reply-To: <E16m2Qu-0007mc-00@wagner.rustcorp.com.au>
Message-ID: <Pine.LNX.4.33.0203151656320.1379-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 16 Mar 2002, Rusty Russell wrote:
>
> 	nfs is broken in 2.5 ATM because it does set_bit on an "int".
> Can be *please* just bite the bullet and change the prototype on these
> ops so we stop seeing the same mistakes over and over?

The problem with the prototype is that it's not always correct.

It's fine to pass non-"unsigned long *" pointers to set_bit, if you know
the pointers are otherwise aligned. Things like buffer bitmaps etc.

How does the patch look? If it has a lot of unnecessary casts, I don't
want it, but if the casts are only in things like ext2_setbit(), then that
might be ok..

		Linus

