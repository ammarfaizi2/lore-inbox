Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315725AbSETCyT>; Sun, 19 May 2002 22:54:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315726AbSETCyS>; Sun, 19 May 2002 22:54:18 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:6153 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S315725AbSETCyR>; Sun, 19 May 2002 22:54:17 -0400
Date: Sun, 19 May 2002 19:54:32 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: linux-kernel@vger.kernel.org, <alan@lxorguk.ukuu.org.uk>
Subject: Re: AUDIT: copy_from_user is a deathtrap. 
In-Reply-To: <E179cYq-0004I3-00@wagner.rustcorp.com.au>
Message-ID: <Pine.LNX.4.44.0205191951460.22433-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 20 May 2002, Rusty Russell wrote:
>
> If read always returns the amount read (ignoring any copy_to_user
> errors), then you can repeat it by seeking backwards[1] and redoing the
> read.

No.

> So copy_to_user can simply deliver a SIGSEGV and return "success", and
> everything will work (except sockets, pipes, etc).

I don't mind the SIGSEGV, but I refuse to make a stupid change that has
absolutely _zero_ reason for it.

The current "copy_to/from_user()" is perfectly fine. It's very simple to
do

	if (copy_from_user(xxx))
		return -EFAULT;

and it is not AT ALL simpler to do

	ret = copy_from_user(xxx);
	if (ret)
		return ret;

which is apparently your suggestion.

So a lot of people didn't get it? Arnaldo seems to have fixed a lot of
them already, and maybe you who apparently care can add _documentation_,
but the fact is that there is no reason to make a less powerful interface.

		Linus

