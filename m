Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267675AbSLFHSJ>; Fri, 6 Dec 2002 02:18:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267676AbSLFHSJ>; Fri, 6 Dec 2002 02:18:09 -0500
Received: from packet.digeo.com ([12.110.80.53]:59820 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267675AbSLFHSI>;
	Fri, 6 Dec 2002 02:18:08 -0500
Message-ID: <3DF050EB.108DCF8@digeo.com>
Date: Thu, 05 Dec 2002 23:25:31 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: GrandMasterLee <masterlee@digitalroadkill.net>
CC: Andrea Arcangeli <andrea@suse.de>,
       William Lee Irwin III <wli@holomorphy.com>,
       Norman Gaywood <norm@turing.une.edu.au>, linux-kernel@vger.kernel.org
Subject: Re: Maybe a VM bug in 2.4.18-18 from RH 8.0?
References: <3DF049F9.6F83D13@digeo.com> <1039158861.16565.10.camel@localhost>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Dec 2002 07:25:37.0796 (UTC) FILETIME=[AC65A440:01C29CF8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

GrandMasterLee wrote:
> 
> On Fri, 2002-12-06 at 00:55, Andrew Morton wrote:
> > Andrea Arcangeli wrote:
> [...]
> > > and you're totally wrong saying that mlocking 700m on a 4G box
> > > could kill it.
> >
> > It is possible to mlock 700M of the normal zone on a 4G -aa kernel.
> > I can't immediately think of anything apart from vma's which will
> > make it fall over, but it will run like crap.
> 
> Just curious, but how long would it take a system with 8GB RAM, using 4G
> or 64G kernel to fall over?

A few seconds if you ran the wrong thing.  Never if you ran something
else.

> One thing I've noticed, is that 2.4.19aa2
> runs great on a box with 8GB when I don't allocate all that much, but
> seems to run into issues after a large DB has been running on it for
> several days. (i.e. the system get's generally a little slower, less
> responsive, and in some cases crashes after 7 days).

"crashes"?  kernel, or application?   What additional info is
available?
 
> Yes, I know, sounds like a memory leak in something, but aside from
> patching Oracle from 8.1.7.4(dba's can't find any new patches ATM), I've
> tried everything except changing my kernel.
> 
> Could this be similar behaviour?

No, it's something else.  Possibly a leak, possibly vma structures.

You should wait until the machine is sluggish, then capture
the output of:

	vmstat 1
	cat /proc/meminfo
	cat /proc/slabinfo
	ps aux
