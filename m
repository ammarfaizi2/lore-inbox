Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316589AbSFZOPw>; Wed, 26 Jun 2002 10:15:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316592AbSFZOPw>; Wed, 26 Jun 2002 10:15:52 -0400
Received: from chaos.analogic.com ([204.178.40.224]:904 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S316589AbSFZOPv>; Wed, 26 Jun 2002 10:15:51 -0400
Date: Wed, 26 Jun 2002 10:17:45 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Nicolas Bougues <nbougues-listes@axialys.net>
cc: Andries Brouwer <aebr@win.tue.nl>, linux-kernel@vger.kernel.org
Subject: Re: Problems with wait queues
In-Reply-To: <20020626140029.GA6310@kiwi>
Message-ID: <Pine.LNX.3.95.1020626100928.25416A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jun 2002, Nicolas Bougues wrote:

> On Wed, Jun 26, 2002 at 12:52:41PM +0200, Andries Brouwer wrote:
> > On Wed, Jun 26, 2002 at 12:32:43PM +0200, Nicolas Bougues wrote:
> > 
> > > Does anybody have any idea on what I may have done wrong, and why
> > > would loadavg increase when vmstat show no activity ?
> > 
> > loadavg does not report what you think it reports
> > 
> 
> As far as I understand, loadavg reports the average number of
> processes in the TASK_RUNNING state.
> 
> What happens in my driver, I believe, is that :
> - on timer interrupt, I do some stuff, and wake_up the waiting process
> - then the loadavg is computed (seeing my waiting task as TASK_RUNNING)
> - then the scheduler runs the task
> - then the task goes immediatly back to sleep
> 
> >From this point of view, then my problem is just "cosmetic". Isn't
> there a way to do things in a different order, so that I could still
> get a meaningful(*) loadavg ?
> 
> (*): by meaningful, I mean representing the number of busy processes
> at a random point in time.
> --
> Nicolas Bougues
> 

I am sure that you can have things look correct as well as run
properly. However, you didn't show us the code. You need to
do something like:

            interruptible_sleep_on(&semaphore);

while your wake-up occurs with:

            wake_up_interruptible(&semaphore);

Or, you can do (the hard way) :

             while(!something)
             {
                 current->policy |= SCHED_YIELD;
                 schedule();
             }

Both ways (and others) will look fine with `top` and will sleep
properly.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

