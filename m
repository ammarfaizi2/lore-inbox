Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316221AbSFJU5v>; Mon, 10 Jun 2002 16:57:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316217AbSFJU5u>; Mon, 10 Jun 2002 16:57:50 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:61454 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S315424AbSFJU5s>; Mon, 10 Jun 2002 16:57:48 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] Futex Asynchronous Interface
Date: 10 Jun 2002 13:57:22 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <ae33ri$b8b$1@cesium.transmeta.com>
In-Reply-To: <8QXHSZTXw-B@khms.westfalen.de> <Pine.LNX.4.44.0206091056550.13459-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.44.0206091056550.13459-100000@home.transmeta.com>
By author:    Linus Torvalds <torvalds@transmeta.com>
In newsgroup: linux.dev.kernel
> 
> But what would you _do_ with them? What would be the advantage as compared
> to the current situation?
> 
> Now, to configure a device, you get a fd to the device the same way you
> get a fd _anyway_ - with "socket()".
> 
> And anybody who says that "socket()" is utterly unnatural to the UNIX way
> is quite far out to lunch. It may be unnatural to the Plan-9 way of
> "everything is a namespace", but that was never the UNIX way. The UNIX way
> is "everything is a file descriptor or a process", but that was never
> about namespaces.
> 
> Yes, some old-timers could argue that original UNIX didn't have sockets,
> and that the BSD interface is ugly and an abomination and that it _should_
> have been a namespace thing, but that argument falls flat on its face when
> you realize that the "pipe()" system call _was_ in original UNIX, and has
> all the same issues.
> 

The biggest problem with the socket API is that it makes it impossible
to use in a shell script context or other context where it isn't
practical to operate on binary data.  The second-biggest problem with
the API is that it at least historically makes it basically impossible
to write address-family-independent code... something like "telnet"
shouldn't need to know if it's operating over TCP on IPv4, TCP on
IPv6, SPX on IPX...; it should be able to resolve a string to a name and
then create a connection, and the address family stuff should be
encasulated in the library.

The first problem a namespace-like solution would deal with... then
one could open /dev/sock/stream/ipv4/206.189.222.9/23 using a normal
open() call.  The second is to resolve "poetry.vogon.net","telnet" to
the above string, but that's a user-space issue.

At least it would be nice if open() on a Unix domain socket would
connect to that socket.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
