Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261530AbSKGQxD>; Thu, 7 Nov 2002 11:53:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261531AbSKGQxD>; Thu, 7 Nov 2002 11:53:03 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:24076 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S261530AbSKGQxB>; Thu, 7 Nov 2002 11:53:01 -0500
Date: Thu, 7 Nov 2002 11:58:35 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: reiser <reiser@namesys.com>
cc: Peter Chubb <peter@chubb.wattle.id.au>,
       Andreas Dilger <adilger@clusterfs.com>,
       Nikita Danilov <Nikita@namesys.com>,
       Tomas Szepe <szepe@pinerecords.com>,
       Alexander Zarochentcev <zam@namesys.com>,
       lkml <linux-kernel@vger.kernel.org>, Oleg Drokin <green@namesys.com>,
       umka <umka@namesys.com>
Subject: Re: [BK][PATCH] Reiser4, will double Linux FS performance, pleaseapply
In-Reply-To: <3DC87154.1030601@namesys.com>
Message-ID: <Pine.LNX.3.96.1021107114229.30525D-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Nov 2002, reiser wrote:

> There is also a longer PhD thesis by her.  10 minutes is about as much 
> work as I personally am willing to lose and try to remember.  Avoiding 
> 75% of writes instead of 20% is a substantial performance gain worth 
> paying a cost for.  Unfortunately it is not easy to say if it is worth 
> that much cost, but I suspect it is.  An approach we are exploring is 
> for blocks to reach disk earlier than that if the device is not 
> congested, on the grounds that if not much IO is occuring, then 
> performance is not important.

  I would certainly like to see that, lost data in case of problems is
more of a problem than performance for many people. 

  Particularly if (a) there is an idle CPU, (b) there are no blocks queued
for write to the device, and (c) there are dirty blocks to go to the
device, it would be good to ignore the age of the block or use a firly low
minimum age. If we dropped a few blocks onto the drive each time the
conditions were met, I suspect that with many systems that would result in
a lot more free write space in memory. The total blocks written to the
drive would go up, but it shouldn't hurt performance. 

  My first thought is that the check would be done after finding no
runable normal processes and before running batch priority processes. If
only a few blocks were written each time oldest first it shouldn't even
hurt the batch processes. 

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

