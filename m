Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264111AbRFFTcP>; Wed, 6 Jun 2001 15:32:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264110AbRFFTcF>; Wed, 6 Jun 2001 15:32:05 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:10540 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S263804AbRFFTb7>; Wed, 6 Jun 2001 15:31:59 -0400
To: Mike Galbraith <mikeg@wen-online.de>
Cc: Derek Glidden <dglidden@illusionary.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
Subject: Re: Break 2.4 VM in five easy steps
In-Reply-To: <Pine.LNX.4.33.0106062102060.404-100000@mikeg.weiden.de>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 06 Jun 2001 13:28:16 -0600
In-Reply-To: <Pine.LNX.4.33.0106062102060.404-100000@mikeg.weiden.de>
Message-ID: <m1k82p5rxr.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Galbraith <mikeg@wen-online.de> writes:

> On 6 Jun 2001, Eric W. Biederman wrote:
> 
> > Derek Glidden <dglidden@illusionary.com> writes:
> >
> >
> > > The problem I reported is not that 2.4 uses huge amounts of swap but
> > > that trying to recover that swap off of disk under 2.4 can leave the
> > > machine in an entirely unresponsive state, while 2.2 handles identical
> > > situations gracefully.
> > >
> >
> > The interesting thing from other reports is that it appears to be kswapd
> > using up CPU resources.  Not the swapout code at all.  So it appears
> > to be a fundamental VM issue.  And calling swapoff is just a good way
> > to trigger it.
> >
> > If you could confirm this by calling swapoff sometime other than at
> > reboot time.  That might help.  Say by running top on the console.
> 
> The thing goes comatose here too. SCHED_RR vmstat doesn't run, console
> switch is nogo...
> 
> After running his memory hog, swapoff took 18 seconds.  I hacked a
> bleeder valve for dead swap pages, and it dropped to 4 seconds.. still
> utterly comatose for those 4 seconds though.

At the top of the while(1) loop in try_to_unuse what happens if you put in.
if (need_resched) schedule(); 
It should be outside all of the locks.  It might just be a matter of everything
serializing on the SMP locks, and the kernel refusing to preempt itself.

Eric

