Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263361AbTCNPat>; Fri, 14 Mar 2003 10:30:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263367AbTCNPat>; Fri, 14 Mar 2003 10:30:49 -0500
Received: from pop.gmx.net ([213.165.65.60]:23712 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S263361AbTCNPas>;
	Fri, 14 Mar 2003 10:30:48 -0500
Message-Id: <5.2.0.9.2.20030314161055.00cf33d8@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.0.9
Date: Fri, 14 Mar 2003 16:46:10 +0100
To: Charles Baylis <cb-lkml@fish.zetnet.co.uk>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: 2.5.64-mm6, a new test case for scheduler interactivity
  problems
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <5.2.0.9.2.20030314152115.00ce76b0@pop.gmx.net>
References: <200303132201.02278.cb-lkml@fish.zetnet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 03:34 PM 3/14/2003 +0100, Mike Galbraith wrote:
>At 10:01 PM 3/13/2003 +0000, Charles Baylis wrote:
>>My test case tries to reproduce this by creating a number of tasks which
>>alternate between being 'interactive' and CPU hogs. On my Celery 333 laptop
>>it can sometimes cause skips with only 1 child, and is pretty much
>>guaranteed to cause skips with more child tasks.
>
>Greetings,
>
>Nice test case.  I don't have sound capability on my linux box, but your 
>test case makes it fail the window wiggle test horribly.  I fiddled with 
>it a bit, and convinced it to "stop doing that please".  Does the attached 
>(experimental butchery) help your box's sp-sp-speach im-p-p-pediment?

P.S.  If you try this, change STARVATION_LIMIT from 1*HZ to 
2*MAX_TIMESLICE.  With that, I can run a make -j5 bzImage, irman with fixed 
mem_load, thud 3 and kasteroids with no trouble at ALL on my 128mb 
p3/500.  The only time things get ugly is when memload fires up.  It 
allocates 72mb and scribbles to it... a bit much for a 128mb box with 
_this_ load ;-)  Even then, swapping like heck, kasteroids is playable most 
of the time.

Without the patch, irman's process load starves everyone to death, and thud 
3 utterly destroys interactivity.  YMMV of course (it _is_ an experiment... 
might even explode;)

         -Mke 

