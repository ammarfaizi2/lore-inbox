Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314981AbSECSNA>; Fri, 3 May 2002 14:13:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314984AbSECSM6>; Fri, 3 May 2002 14:12:58 -0400
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:52742 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S314981AbSECSMx>; Fri, 3 May 2002 14:12:53 -0400
Date: Fri, 3 May 2002 20:12:42 +0200 (CEST)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Martin Dalecki <dalecki@evision-ventures.com>
cc: Andreas Dilger <adilger@turbolabs.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.13 IDE 50
In-Reply-To: <3CD289CE.2070900@evision-ventures.com>
Message-ID: <Pine.LNX.4.33.0205031949010.5617-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> - Fix wrong usage of time_after in ide.c. This should cure the drive 
> seek
>    timeout problems some people where expierencing. This was clarified 
> to me by
>    Bartek, who apparently checked whatever the actual code is consistent 
> with the comments in front of it. Thank you Bartlomiej Zolnierkiewicz.
> 
>    I think now that we should have time_past(xxx) in <linux/timer.h>.

What would you suppose time_past(xxx) to do?

I agree this calls for some action to prevent confusion in the future.
However, I'm not sure how a new macro could help here.

Andreas Dilger once did a patch to clarify the documentation of
time_[before,after] a bit.
(http://www.lib.uaa.alaska.edu/linux-kernel/archive/2001-Week-45/0075.html)

> @@ -1258,7 +1172,7 @@
>  
>                         /* This device still wants to remain idle.
>                          */
> -                       if (drive->sleep && time_after(jiffies, drive->sleep))
> +                       if (drive->sleep && time_after(drive->sleep, jiffies))
>                                 continue;
>  
>                         /* Take this device, if there is no device choosen thus
> 

I think there is an implicit notational convention to have the volatile 
argument, i.e. jiffies, first. This would express that the condition 
evaluates as true *before* some fixed point in time:

   if (drive->sleep && time_before(jiffies, drive->sleep))

Maybe sticking to this convention would suffice to keep the 
semantics of the condition obvious.

Tim





