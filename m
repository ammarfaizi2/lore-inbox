Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262289AbTCRMxv>; Tue, 18 Mar 2003 07:53:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262367AbTCRMxv>; Tue, 18 Mar 2003 07:53:51 -0500
Received: from chaos.analogic.com ([204.178.40.224]:902 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S262289AbTCRMxu> convert rfc822-to-8bit; Tue, 18 Mar 2003 07:53:50 -0500
Date: Tue, 18 Mar 2003 08:06:22 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: DervishD <raul@pleyades.net>
cc: "Sparks, Jamie" <JAMIE.SPARKS@cubic.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: select() stress
In-Reply-To: <20030318102837.GH42@DervishD>
Message-ID: <Pine.LNX.4.53.0303180758380.26753@chaos>
References: <Pine.WNT.4.44.0303171010580.1544-100000@GOLDENEAGLE.gameday2000>
 <Pine.LNX.4.53.0303171112090.22652@chaos> <20030318102837.GH42@DervishD>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Mar 2003, DervishD wrote:

>     Hi all :)
>
>  Richard B. Johnson dixit:
> > >       /*  ****************************** */
> > >       if (select(getdtablesize(), &socklist, NULL, NULL, NULL) < 0)
> > >       {
> > >         if (errno != EINTR) perror("WeapTerrain");
> > > 	continue;
> > >       }
> > select() takes a file-descriptor as its first argument, not the
> > return-value of some function that returns the number of file-
> > descriptors. You cannot assume that this number is the same
> > as the currently open socket. Just use the socket-value. That's
> > the file-descriptor.
>
>     Not at all. 'select()' takes a *number of file descriptors* as
> its first argument, meaning the maximum number of file descriptors to
> check (it checks only the first N file descriptors, being 'N' the
> first argument). Usually that first argument is FD_SETSIZE, but the
> result of any function returning a number is right if you know that
> the return value is what you want.
>
>     If, for example, FD_SETSIZE is set to UINT_MAX but
> getdtablesize() returns 100 ('ulimit' came to mind), it's a good idea
> to use the return value of that function. Anyway, IMHO is better to
> use FD_SETSIZE.
>
>     See the glibc info for more references.
>
>     Bye and happy coding :)
>     Raúl Núñez de Arenas Coronado
>

What I said has been misinterpreted. Select takes the highest
number fd in the set you want to examine plus 1. It therefore
requires some relationship to the fd that you are using if
you are using a socket whos value was N you must select on
(at least) N+1, not the return value of a function that gives
the maximum number of fds that you can open. They are not the
same and are not guaranteed to be related although on some
target, they might. It's the same problem as:

	write(1, "Hello\n", 6);

Such code is broken. At the very least, one needs to use
STDOUT_FILENO as the fd, and really should not count characters
by hand.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

