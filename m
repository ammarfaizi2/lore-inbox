Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263118AbSJGU2Y>; Mon, 7 Oct 2002 16:28:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262764AbSJGU1J>; Mon, 7 Oct 2002 16:27:09 -0400
Received: from packet.digeo.com ([12.110.80.53]:14007 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262774AbSJGU0Y>;
	Mon, 7 Oct 2002 16:26:24 -0400
Message-ID: <3DA1EF3C.65C0073F@digeo.com>
Date: Mon, 07 Oct 2002 13:31:56 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linus Torvalds <torvalds@transmeta.com>,
       Daniel Phillips <phillips@arcor.de>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Oliver Neukum <oliver@neukum.name>, Rob Landley <landley@trommello.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: The reason to call it 3.0 is the desktop (was Re: [OT] 2.6 not3.0 -  
 (NUMA))
References: <Pine.LNX.4.33.0210071145120.1356-100000@penguin.transmeta.com> <1034021669.26502.19.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Oct 2002 20:31:56.0184 (UTC) FILETIME=[941F5980:01C26E40]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> On Mon, 2002-10-07 at 19:51, Linus Torvalds wrote:
> > In the meantime, it might just be possible to take a look at the uid, and
> > if the uid matches use find_group_other, but for non-matching uids use
> > find_group_dir. That gives a "compact for same users, distribute for
> > different users" heuristic, which might be acceptable for normal use (and
> > the theoretical cleanup tool could fix it up).
> 
> Factoring the uid/gid/pid in actually may help in other ways. If we are
> doing it by pid or by uid we will reduce the interleave of multiple
> files thing you sometimes get

Yes, that would help on multiuser setups.  Delayed allocation is
a great fix for that problem though.

The other obvious heuristic is "if the parent directory was
created in the last five seconds, use find_group_other()".  But
that made Linus go "ewwww".
