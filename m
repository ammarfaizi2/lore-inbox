Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267083AbTAUOKF>; Tue, 21 Jan 2003 09:10:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267084AbTAUOKF>; Tue, 21 Jan 2003 09:10:05 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:7686 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S267083AbTAUOKF>; Tue, 21 Jan 2003 09:10:05 -0500
Date: Tue, 21 Jan 2003 09:16:21 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: DervishD <raul@pleyades.net>
cc: "Richard B. Johnson" <root@chaos.analogic.com>,
       Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Changing argv[0] under Linux.
In-Reply-To: <20030114191420.GA162@DervishD>
Message-ID: <Pine.LNX.3.96.1030121091135.30318C-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Jan 2003, DervishD wrote:

> > > libc, but I think that is more on the kernel side, that's why I ask
> > Last time I checked argv[0] was 512 bytes. Many daemons overwrite
> > it with no problem.
> 
>     Any header where I can see the length for argv[0] or is this some
> kind of unoficial standard? Just doing strcpy seems dangerous to me
> (you can read 'paranoid'...).

The method used in INN is to make arg 1 some space. So
  nnrpd -s'                             ' -D ...
You can check that argv[1] is -s, and what its length is, then happily
write over argv[0]. That's portable in practical terms, since most C
implementations just have the variable length args in sequence, while a
few have a fixed length array for args. You're safe in either case.

Ex:
  if (strncmp(argv[1], "-s", 2) && strlen(argv[1]) > REPLACELEN) {
    sprintf(argv[0], "format", atuff...);
  }

Some systems have setproctitle() but it doesn't appear to be posix.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

