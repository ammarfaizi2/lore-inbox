Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283694AbRLYLCU>; Tue, 25 Dec 2001 06:02:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285460AbRLYLCL>; Tue, 25 Dec 2001 06:02:11 -0500
Received: from white.pocketinet.com ([12.17.167.5]:19357 "EHLO
	white.pocketinet.com") by vger.kernel.org with ESMTP
	id <S283694AbRLYLCC>; Tue, 25 Dec 2001 06:02:02 -0500
Content-Type: text/plain; charset=US-ASCII
From: Nicholas Knight <nknight@pocketinet.com>
Reply-To: nknight@pocketinet.com
To: "M. Edward (Ed) Borasky" <znmeb@aracnet.com>, christian e <cej@ti.com>
Subject: Re: minimizing swap usage
Date: Tue, 25 Dec 2001 03:02:05 -0800
X-Mailer: KMail [version 1.3.1]
Cc: linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0112200559350.8883-100000@shell1.aracnet.com>
In-Reply-To: <Pine.LNX.4.33.0112200559350.8883-100000@shell1.aracnet.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <WHITEp4nbukgQu0216A000005b2@white.pocketinet.com>
X-OriginalArrivalTime: 25 Dec 2001 11:00:24.0471 (UTC) FILETIME=[5A86B270:01C18D33]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 20 December 2001 06:05 am, M. Edward (Ed) Borasky wrote:
> On Thu, 20 Dec 2001, christian e wrote:
> > Hi,all
> >
> > Can someone give me a pointer to how I can avoid somethign like
> > this:
> >
> > foo@bar]$ free -m
> > 	    total       used       free     shared    buffers     cached
> > Mem:           249        245          4          0          6     
> >  136 -/+ buffers/cache:        102        147
> > Swap:          243         89        153
> >
> > What's with all the caching when my apps crawl because it's
> > swapping so much ? I've tried to adjust /proc/vm/kswapd parameters
> > but that doesn't seem to help..I'd like to postpone the swapping
> > until its almost out of physical memory..
>
> This may seem counterintuitive, but postponing swapping / cache
> flushing to disk till the last possible moment is counterproductive.
> It's a little like procrastination in the time management world --

Why not add a config option to choose between code for two behaviors:
(1 being the default, of course)
1. Current behavior, usualy a Good Thing, sometimes a Bad Thing, I've 
had apps that had to call up in their entirety from swap space, while I 
still had plenty of "avalible" RAM left ("avalible" meaning free, and 
cache/buffers.) It seems the kernel puts a higher priority on caching 
and buffers than on memory that hasn't been accessed in a while, which, 
as I said, is usualy good, but not always.

2. Don't swap ANYTHING to disk until avalible RAM drops below, say, 
15%. And put cache on a sanity check; if the system is going to swap to 
disk because avalible RAM drops below 15%, and  cache makes up more 
than, say, 45%, start dropping the oldest stuff in the cache to free up 
RAM instead of swapping. (I'm assuming 128-256MB+ of RAM here, for 
anything smaller, default is probably best.)

At the very least, I'd like to see #2 tried, if someone that knows the 
VM system has time to spare on it.
Cache/swap practices in the kernel have been bugging me for a long time.
