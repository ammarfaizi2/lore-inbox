Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265250AbTANVEA>; Tue, 14 Jan 2003 16:04:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265255AbTANVEA>; Tue, 14 Jan 2003 16:04:00 -0500
Received: from findaloan-online.cc ([216.209.85.42]:37382 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S265250AbTANVD7>;
	Tue, 14 Jan 2003 16:03:59 -0500
Date: Tue, 14 Jan 2003 16:21:13 -0500
From: Mark Mielke <mark@mark.mielke.cc>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: DervishD <raul@pleyades.net>, Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Changing argv[0] under Linux.
Message-ID: <20030114212113.GF15412@mark.mielke.cc>
References: <20030114202359.GD15412@mark.mielke.cc> <Pine.LNX.3.95.1030114152443.13840C-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.95.1030114152443.13840C-100000@chaos.analogic.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 14, 2003 at 03:28:23PM -0500, Richard B. Johnson wrote:
> On Tue, 14 Jan 2003, Mark Mielke wrote:
> > On Tue, Jan 14, 2003 at 02:56:35PM -0500, Richard B. Johnson wrote:
> > > Well I just grepped through usr/include/bits/posix1_lim.h and it
> > > shows 255 (with this 'C' library) so you are probably right.
> > > In any event, a "whole line of text" isn't going to overrun it. 
> > Looking at the code, it looks to me as if argv[0] can be any size up to
> > _SC_ARG_MAX, with the restraining factor being that the environment
> > variables and the other arguments must fit in the same space.
> > Is this not correct?
> Don't think so. In my headers _SC_ARG_MAX is an enumerated type
> that is numerically equal to 0. It's in confname.h, the first
> element in the enumerated list.

_SC_ARG_MAX is one of the identifiers that are used with sysconf() to
lookup a system-wide configuration value:

    $ perl -MPOSIX -e 'print sysconf(_SC_ARG_MAX), "\n"'
    131072

The environment size for a program invoked using exec() can be up to
131072 bytes long (my configuration). This environment holds the
command arguments as well as the environment.

On my system, _SC_ARG_MAX is telling me that it is possible to have
argv[0] be just under 131072 bytes long.

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

