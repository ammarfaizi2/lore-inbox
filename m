Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270576AbTHJRpZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 13:45:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270605AbTHJRpZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 13:45:25 -0400
Received: from pop.gmx.net ([213.165.64.20]:2944 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S270576AbTHJRpV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 13:45:21 -0400
Message-Id: <5.2.1.1.2.20030810182157.019c66c0@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.1
Date: Sun, 10 Aug 2003 19:49:31 +0200
To: Daniel Phillips <phillips@arcor.de>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: [patch] SCHED_SOFTRR starve-free linux scheduling policy  
  ...
Cc: Davide Libenzi <davidel@xmailserver.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200308101646.34830.phillips@arcor.de>
References: <5.2.1.1.2.20030810080748.019cb090@pop.gmx.net>
 <5.2.1.1.2.20030809183021.0197ae00@pop.gmx.net>
 <5.2.1.1.2.20030810080748.019cb090@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 04:46 PM 8/10/2003 +0100, Daniel Phillips wrote:
>On Sunday 10 August 2003 07:41, Mike Galbraith wrote:
>So lets go back and look at your two concerns:
>
> > 1.  SCHED_SOFTRR tasks can disturb (root) SCHED_RR/SCHED_FIFO tasks as is.
> > SCHED_SOFTRR should probably be a separate band, above SCHED_OTHER, but
> > below realtime queues.
>
>Nobody promises that root's SCHED_RR/FIFO tasks can get any particular share
>of the cpu, only that they will get some CPU provided that all higher-priority
>tasks play nicely.  Normal users can take advantage of this hospitality by
>taking up to a certain, administer-configured share of the CPU for their own
>dark purposes.  Everything is roses and cherries, we haven't broken any rules,
>and there's no DoS here.  (Assuming we change the realtime CPU bound to be
>global instead of task-local.)

(Davide already did the global cpu limit)

No, there is no DoS possibility, but it feels a little... unclean.  It 
doesn't appear to accomplish anything other than bypassing 'you must be 
this tall (godly stature) to use this API'.  No matter what limit you put 
on the cpu usage, that amount can (xlat: probably will) be abused.

> > 2.   It's not useful for video (I see no difference between realtime
> > component of video vs audio), and if the cpu restriction were opened up
> > enough to become useful, you'd end up with ~pure SCHED_RR, which you can no
> > way allow Joe User access to.  As a SCHED_LOWLATENCY, it seems like it
> > might be useful, but I wonder how useful.
>
>It's perfectly usable for video, though the administrator may have to
>configure a considerably larger share of the cpu for SOFTRR in that case,
>especially if a software codec is being used.  I don't see any reason why
>the administrator of a single-user system could not make 95% of it available
>for realtime media.  The remaining 5% will still be more than a 486 (probably)
>which is enough to take care of all the things that the system absolutely
>needs to take care of.

On my little box, I'd have to relinquish control of over 50% of my cpu at 
_minimum_ to some random application developer.  (not)

>That said, I'm only interested in audio at the moment.  If everything works
>out, it will be a non-change to use it for video as well.

Oh, I'm sure it'll work.  What I tested briefly worked fine.  However, I'm 
not sure that it's a good (or bad) idea.

         -Mike 

