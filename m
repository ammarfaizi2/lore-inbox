Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264367AbRFGGmt>; Thu, 7 Jun 2001 02:42:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264350AbRFGGmj>; Thu, 7 Jun 2001 02:42:39 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:46124 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S264352AbRFGGmZ>; Thu, 7 Jun 2001 02:42:25 -0400
To: Mike Galbraith <mikeg@wen-online.de>
Cc: Derek Glidden <dglidden@illusionary.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
Subject: Re: Break 2.4 VM in five easy steps
In-Reply-To: <Pine.LNX.4.33.0106070631150.285-100000@mikeg.weiden.de>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 07 Jun 2001 00:38:41 -0600
In-Reply-To: <Pine.LNX.4.33.0106070631150.285-100000@mikeg.weiden.de>
Message-ID: <m1bso06bgu.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Galbraith <mikeg@wen-online.de> writes:

> On 6 Jun 2001, Eric W. Biederman wrote:
> 
> > Mike Galbraith <mikeg@wen-online.de> writes:
> >
> > > > If you could confirm this by calling swapoff sometime other than at
> > > > reboot time.  That might help.  Say by running top on the console.
> > >
> > > The thing goes comatose here too. SCHED_RR vmstat doesn't run, console
> > > switch is nogo...
> > >
> > > After running his memory hog, swapoff took 18 seconds.  I hacked a
> > > bleeder valve for dead swap pages, and it dropped to 4 seconds.. still
> > > utterly comatose for those 4 seconds though.
> >
> > At the top of the while(1) loop in try_to_unuse what happens if you put in.
> > if (need_resched) schedule();
> > It should be outside all of the locks.  It might just be a matter of
> everything
> 
> > serializing on the SMP locks, and the kernel refusing to preempt itself.
> 
> That did it.

Does this improve the swapoff speed or just allow other programs to
run at the same time?  If it is still slow under that kind of load it
would be interesting to know what is taking up all time.

If it is no longer slow a patch should be made and sent to Linus.

Eric
