Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317294AbSFLB3g>; Tue, 11 Jun 2002 21:29:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317296AbSFLB3f>; Tue, 11 Jun 2002 21:29:35 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:15876 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317294AbSFLB3f>; Tue, 11 Jun 2002 21:29:35 -0400
Date: Tue, 11 Jun 2002 18:29:39 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: dent@cosy.sbg.ac.at, <adilger@clusterfs.com>, <da-x@gmx.net>,
        <patch@luckynet.dynu.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.21 - list.h cleanup 
In-Reply-To: <E17Hwek-0002Y8-00@wagner.rustcorp.com.au>
Message-ID: <Pine.LNX.4.44.0206111824050.16686-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 12 Jun 2002, Rusty Russell wrote:
>
> The only really sane way to implement "CONFIG_SMALL_NO_INLINES" that I
> can think of is to have headers do

inlines, when used properly, are _not_ larger than not inlining.

Quite often, inlining means that much of the code goes away due to
constants etc (alloc_pages(), for example), while in other cases the code
itself ends up being smaller because a small function takes up space due
to clobbering registers, memory, and all the function calling sequence
itself.

This is _very_ much the case with the list.h inlines we're talking about.
They'd be larger, slower, and the resulting assembly code would be less
readable if they weren't inlined.

However, we do have some inlines that are just too large, and have often
grown up over time. They should not be a CONFIG_SMALL_NO_INLINES thing,
though, they should just be moved into proper .c file.s

(There are also inlines that _look_ large, but which just go away when
attacked by an optimizing compiler. See all the "get_user()" stuff with
case statements etc)

None of these ugly header file tricks, please.

		Linus

