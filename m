Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264338AbRFGH3x>; Thu, 7 Jun 2001 03:29:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264349AbRFGH3n>; Thu, 7 Jun 2001 03:29:43 -0400
Received: from www.wen-online.de ([212.223.88.39]:64776 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S264338AbRFGH3c>;
	Thu, 7 Jun 2001 03:29:32 -0400
Date: Thu, 7 Jun 2001 09:28:58 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: Derek Glidden <dglidden@illusionary.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
Subject: Re: Break 2.4 VM in five easy steps
In-Reply-To: <m1bso06bgu.fsf@frodo.biederman.org>
Message-ID: <Pine.LNX.4.33.0106070926400.6078-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7 Jun 2001, Eric W. Biederman wrote:

> Mike Galbraith <mikeg@wen-online.de> writes:
>
> > On 6 Jun 2001, Eric W. Biederman wrote:
> >
> > > Mike Galbraith <mikeg@wen-online.de> writes:
> > >
> > > > > If you could confirm this by calling swapoff sometime other than at
> > > > > reboot time.  That might help.  Say by running top on the console.
> > > >
> > > > The thing goes comatose here too. SCHED_RR vmstat doesn't run, console
> > > > switch is nogo...
> > > >
> > > > After running his memory hog, swapoff took 18 seconds.  I hacked a
> > > > bleeder valve for dead swap pages, and it dropped to 4 seconds.. still
> > > > utterly comatose for those 4 seconds though.
> > >
> > > At the top of the while(1) loop in try_to_unuse what happens if you put in.
> > > if (need_resched) schedule();
> > > It should be outside all of the locks.  It might just be a matter of
> > everything
> >
> > > serializing on the SMP locks, and the kernel refusing to preempt itself.
> >
> > That did it.
>
> Does this improve the swapoff speed or just allow other programs to
> run at the same time?  If it is still slow under that kind of load it
> would be interesting to know what is taking up all time.
>
> If it is no longer slow a patch should be made and sent to Linus.

No, it only cures the freeze.  The other appears to be the slow code
pointed out by Andrew Morton being tickled by dead swap pages.

	-Mike

