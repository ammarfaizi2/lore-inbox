Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318130AbSIORUo>; Sun, 15 Sep 2002 13:20:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318132AbSIORUn>; Sun, 15 Sep 2002 13:20:43 -0400
Received: from packet.digeo.com ([12.110.80.53]:9360 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S318130AbSIORUg>;
	Sun, 15 Sep 2002 13:20:36 -0400
Message-ID: <3D84C63E.76526EDE@digeo.com>
Date: Sun, 15 Sep 2002 10:41:18 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Axel Siebenwirth <axel@hh59.org>, Con Kolivas <conman@kolivas.net>
CC: lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>,
       "lse-tech@lists.sourceforge.net" <lse-tech@lists.sourceforge.net>
Subject: Re: 2.5.34-mm4
References: <3D82B5C3.229C6B1A@digeo.com> <20020915105021.GA444@prester.freenet.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Sep 2002 17:25:25.0870 (UTC) FILETIME=[E11670E0:01C25CDC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Axel Siebenwirth wrote:
> 
> Hi Andrew!
> 
> On Fri, 13 Sep 2002, Andrew Morton wrote:
> 
> > url: http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.34/2.5.34-mm4/
> 
> With changing from 2.5.34-mm2 to -mm4 I have experienced some moments of
> quite unresponsive behaviour. For example I am building X which at that
> special moment causes pretty heavy disk load and the system doesn't respond
> at all. I was using X and was not able to switch consoles or move mouse only
> extremely sluggish.

There are large IDE updates in -mm4, and this is consistent with
a disk which isn't doing DMA any more.  Could you (and Con) please
double-check with `hdparm -i' and `hdparm -t' that the disk subsystem
is behaving properly?

Yes, it could well be a VM bug, but I wouldn't want to run round in
confused circles all day ;)  Thanks.


> I have seen that it used more swap that usual.

2.5 is much more swaphappy than 2.4.  I believe that this is actually
correct behaviour for optimum throughput.  But it just happens that
people (me included) hate it.  We don't notice the improved runtimes
for the pagecache-intensive operations but we do notice the time it
takes to get the xterms working again.

We have not yet sat down and worked out what to do about this.
 
>              total       used       free     shared    buffers     cached
> Mem:        191096     159340      31756          0      10568      94100
> -/+ buffers/cache:      54672     136424
> Swap:       289160          0     289160
> 
> This is how it looks like under normal circumstances and when building X I
> had 20M in swap usage which seemed quite a lot to me. Maybe I'm just wrong.
> Unfortunately I was not able to start vmstat, first because I can't start
> vmstat when system is not responding and second it doesn't work anyway
> because of your changes.
> 

Yeah, sorry.  The burden of back-compatibility weighed too heavy and
Rik decided that we just have to fix userspace to follow kernel
changes.  There will be breakage for a while;  updates are at
http://surriel.com/procps/.

Unfortunately, those updates cause odd-but-not-serious things to
happen to Red Hat initscripts.  This happens when you install standard
util-linux as well.  It is due to the initscripts passing in arguments
which the standard tools do not understand.
