Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751180AbVIRLpR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751180AbVIRLpR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 07:45:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751181AbVIRLpP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 07:45:15 -0400
Received: from mail18.syd.optusnet.com.au ([211.29.132.199]:9926 "EHLO
	mail18.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751180AbVIRLpN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 07:45:13 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Bernardo Innocenti <bernie@develer.com>
Subject: Re: RFA: Changing scheduler quantum (Was: REQUEST: OpenLDAP 2.3.7)
Date: Sun, 18 Sep 2005 21:44:50 +1000
User-Agent: KMail/1.8.2
Cc: Arjan van de Ven <arjanv@redhat.com>,
       Development discussions related to Fedora Core 
	<fedora-devel-list@redhat.com>,
       Nalin Dahyabhai <nalin@redhat.com>, lkml <linux-kernel@vger.kernel.org>
References: <432B9F4A.6070805@develer.com> <20050918110524.GA23910@devserv.devel.redhat.com> <432D517F.2000604@develer.com>
In-Reply-To: <432D517F.2000604@develer.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509182144.50571.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Sep 2005 21:37, Bernardo Innocenti wrote:
> Arjan van de Ven wrote:
> > On Sun, Sep 18, 2005 at 04:27:38AM +0200, Bernardo Innocenti wrote:
> >>It's more meaningful to interpret sched_yield() as "give up the
> >> processor, as if the scheduler quantum had expired".
> >
> > afaik this is *exactly* what the new sched_yield() does ;)
>
> Oops :-)
>
> >>The scheduler wouldn't normally allow a lower priority process to
> >>preempt a high-priority ready process for 30+ ms.  Unless I'm
> >>mistaken about Linux's scheduling policy...
> >
> > if your quantum is up... all other tasks get theirs of course
>
> I assumed dynamic priorities affected the length of the
> quantum, but maybe it just changes the number of times
> the process is scheduled wrt other processes, with the
> quantum being fixed at 20-30ms.
>
> (...a few seconds later...)
>
> Skimming through sched.c, it seems my first guess was
> right: the quantum varies with the priority from 5ms
> to 800ms.
>
> The DEF_TIMESLICE of 400ms looks a bit too gross for
> most applications and the maximum 800ms is just
> ridicolously high.
>
> IIRC, the 7.14MHz 68000 in the Amiga 500 did task-switching
> at 20ms intervals, with a negligible performance hit.
> Couldn't do much better on today's CPUs?

Not quite.

The default timeslice of nice 0 tasks is 100ms. The timeslice is not altered 
the way you have read sched.c. It is altered thus:
1. For 'nice' levels it varies from 5ms at nice 19 to 800ms at nice -20.
2. For interactive tasks, it is cut up into smaller pieces down to 10ms and 
round robins with other tasks at the same dynamic priority, but still is 
based on the nice levels for the full length of cpu time before expiration 
overall.

Cheers,
Con
