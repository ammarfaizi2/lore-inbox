Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317374AbSFCLcW>; Mon, 3 Jun 2002 07:32:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317375AbSFCLcV>; Mon, 3 Jun 2002 07:32:21 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:26377 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S317374AbSFCLcV>; Mon, 3 Jun 2002 07:32:21 -0400
Date: Mon, 3 Jun 2002 13:32:21 +0200
From: Pavel Machek <pavel@suse.cz>
To: Jens Axboe <axboe@suse.de>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: suspend.c: This is broken, fixme
Message-ID: <20020603113221.GA17228@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20020603095507.GA3030@elf.ucw.cz> <20020603110816.GI820@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > @@ -300,7 +301,8 @@
> >  static void do_suspend_sync(void)
> >  {
> >         while (1) {
> > -               run_task_queue(&tq_disk);
> > +               blk_run_queues();
> > +#error this is broken, FIXME
> >                 if (!TQ_ACTIVE(tq_disk))
> >                         break;
> > 
> > . Why is it broken?
> 
> Hey, I even cc'ed you on the patch when it went to Linus... Lets
> look at

Okay; I thought I corrected it in the meantime, that's why I got confused.

> what happened before: run tq_disk, then check if it is active. What
> prevents tq_disk from being active right after you issue the TQ_ACTIVE
> check? Nothing. And I'm not sure exactly what semantics you think
> running tq_disk has. I suspect you are looking for a 'start any pending
> i/o and return when it has completed', which is far from what happens.
> Running tq_disk will _try_ to start _some_ I/O, and eventually, in time,
> the currently pending requests will have completed. In the mean time,
> more I/O could have been added though.

I'm alone at the system at that point. All user tasks are stopped and
I'm only thread running. There's noone that could submit requests at
that point.

In such case, killing #error is right solution, right?
								Pavel



-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
