Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316093AbSETQAt>; Mon, 20 May 2002 12:00:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316096AbSETQAs>; Mon, 20 May 2002 12:00:48 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:46600 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316093AbSETQAr>; Mon, 20 May 2002 12:00:47 -0400
Date: Mon, 20 May 2002 09:00:53 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: linux-kernel@vger.kernel.org, <alan@lxorguk.ukuu.org.uk>
Subject: Re: AUDIT: copy_from_user is a deathtrap. 
In-Reply-To: <E179fAd-0005vs-00@wagner.rustcorp.com.au>
Message-ID: <Pine.LNX.4.44.0205200856460.23874-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 20 May 2002, Rusty Russell wrote:
>
> Not quite:
> 	copy_from_user(xxx);
>
> Is my suggestion.  No error return.

The fact is, that that would still make you have to audit all the users,
AND you'd be left up shit creek for the users who _need_ the error return,
so now you not only have to fix all existing broken stuff, you have to fix
the _correct_ stuff too some strange way. I agree with returning SIGSEGV,
but it is NOT a _replacement_ for getting the right error return from
read/write.

So what's your point? You want to dumb down the interfaces until you can't
make mistakes, and only idiots will be able to use the system.

As long as you continue to push an interface that DOES NOT WORK, there's
no way you can win this argument. read()/write() _needs_ to work, and
that's not a "warm and fuzzy" kind of thing you can play with.

		Linus

