Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261680AbTCQBHR>; Sun, 16 Mar 2003 20:07:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261682AbTCQBHR>; Sun, 16 Mar 2003 20:07:17 -0500
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:25611 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S261680AbTCQBHQ>; Sun, 16 Mar 2003 20:07:16 -0500
Date: Mon, 17 Mar 2003 02:18:03 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Andrea Arcangeli <andrea@suse.de>
cc: Nicolas Pitre <nico@cam.org>, Ben Collins <bcollins@debian.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] BK->CVS (real time mirror)
In-Reply-To: <20030316215219.GX1252@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0303170104080.5042-100000@serv>
References: <Pine.LNX.4.44.0303161341520.5348-100000@xanadu.home>
 <Pine.LNX.4.44.0303162014090.12110-100000@serv> <20030316215219.GX1252@dualathlon.random>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 16 Mar 2003, Andrea Arcangeli wrote:

> > Not really, it's actually more simple to what Larry is currently offering. 
> > A simply SCCS to RCS converter would be enough. Merging information is
> > easy to add as well. If you now also add a sequence number is quite simple 
> > to modify a CVS server which can export the data reliably.
> 
> CVS basically exports RCS through the network, your argument makes no
> sense to me, what's the difference, I don't see what you mean.

RCS is not that limited. It's very simple to take all deltas from a SCCS 
file and put it into a RCS file:

	for delta in (all sorted deltas)
		get -rdelta foo.c
		ci -rdelta foo.c

Now one needs a little knowledge about the SCCS format. New deltas are 
added at the top and deltas have their own sequence numbers, it's no 
problem to add this sequence number to a RCS delta. This sequence number 
can be used by CVS to export the data reliable, the client would simply 
see 1.sequencenr as the version number.
If one looks now at the bk SCCS files, it's pretty easy to guess, which 
deltas are merges, so it should be really no problem to add this info to 
the RCS file as well.

> > If you want to test an alternative system to see whether it's usable for 
> > kernel development, what better data is there? How could you compare it 
> > against bk?
> 
> Larry has all the rights to not to help providing a testcase, it makes
> no sense for you to complain he's not providing a testcase for a
> competitive system. It make no sense just like complaining that if Larry
> changes the bk format to something encrypted compressed or .doc. he has
> the rights to do it, so please stop raising pointless arguments.

Well, this wasn't the deal. Larry doesn't own the data, he can't say that 
you only get all the data, if you use bk. One of the arguments for the 
move to bk was that the format was open and the data wasn't locked in.
Technically it makes a lot of sense to move to a different format, but if 
he needs help to convert the data into proper RCS format, he only needs to 
ask, I'd be happy to help.

bye, Roman

