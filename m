Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262258AbTCRKYD>; Tue, 18 Mar 2003 05:24:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262260AbTCRKYD>; Tue, 18 Mar 2003 05:24:03 -0500
Received: from [66.70.28.20] ([66.70.28.20]:24078 "EHLO
	maggie.piensasolutions.com") by vger.kernel.org with ESMTP
	id <S262258AbTCRKYC>; Tue, 18 Mar 2003 05:24:02 -0500
Date: Tue, 18 Mar 2003 11:28:37 +0100
From: DervishD <raul@pleyades.net>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: "Sparks, Jamie" <JAMIE.SPARKS@cubic.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: select() stress
Message-ID: <20030318102837.GH42@DervishD>
References: <Pine.WNT.4.44.0303171010580.1544-100000@GOLDENEAGLE.gameday2000> <Pine.LNX.4.53.0303171112090.22652@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.53.0303171112090.22652@chaos>
User-Agent: Mutt/1.4i
Organization: Pleyades
User-Agent: Mutt/1.4i <http://www.mutt.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi all :)

 Richard B. Johnson dixit:
> >       /*  ****************************** */
> >       if (select(getdtablesize(), &socklist, NULL, NULL, NULL) < 0)
> >       {
> >         if (errno != EINTR) perror("WeapTerrain");
> > 	continue;
> >       }
> select() takes a file-descriptor as its first argument, not the
> return-value of some function that returns the number of file-
> descriptors. You cannot assume that this number is the same
> as the currently open socket. Just use the socket-value. That's
> the file-descriptor.

    Not at all. 'select()' takes a *number of file descriptors* as
its first argument, meaning the maximum number of file descriptors to
check (it checks only the first N file descriptors, being 'N' the
first argument). Usually that first argument is FD_SETSIZE, but the
result of any function returning a number is right if you know that
the return value is what you want.

    If, for example, FD_SETSIZE is set to UINT_MAX but
getdtablesize() returns 100 ('ulimit' came to mind), it's a good idea
to use the return value of that function. Anyway, IMHO is better to
use FD_SETSIZE.

    See the glibc info for more references.

    Bye and happy coding :)
    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736
http://www.pleyades.net & http://www.pleyades.net/~raulnac
