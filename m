Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317458AbSFHW2F>; Sat, 8 Jun 2002 18:28:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317459AbSFHW2E>; Sat, 8 Jun 2002 18:28:04 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:61967 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317458AbSFHW2E> convert rfc822-to-8bit; Sat, 8 Jun 2002 18:28:04 -0400
Date: Sat, 8 Jun 2002 15:28:26 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Peter =?ISO-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
cc: Rusty Russell <rusty@rustcorp.com.au>, <linux-kernel@vger.kernel.org>,
        <frankeh@watson.ibm.com>, <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Futex Asynchronous Interface
In-Reply-To: <3D006FDE.8050100@loewe-komp.de>
Message-ID: <Pine.LNX.4.44.0206081523410.11630-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-MIME-Autoconverted: from 8bit to quoted-printable by deepthought.transmeta.com id g58MRhj10127
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 7 Jun 2002, Peter Wächtler wrote:
>
> What about /proc/futex then?

Why?

Tell me _one_ advantage from having the thing exposed as a filename?

The whole point with "everything is a file" is not that you have some
random filename (indeed, sockets and pipes show that "file" and "filename"
have nothing to do with each other), but the fact that you can use common
tools to operate on different things.

But there's absolutely no point in opening /dev/futex from a shell script
or similar, because you don't get anything from it. You still have to bind
the fd to it's real object.

In short, the name "/dev/futex" (or "/proc/futex") is _meaningless_.
There's no point to it. It has no life outside the FUTEX system call, and
the only thing that you can do by exposing it as a name is to cause
problems for people who don't want to mount /proc, or who do not happen to
have that device node in their /dev.

> Give it an entry in the namespace, why not with sockets (unix and ip) also?

Perhaps because you cannot enumerate sockets and pipes? They don't _have_
names before they are created. Same as futexes, btw.

		Linus

