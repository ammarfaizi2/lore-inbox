Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281313AbRKLIWP>; Mon, 12 Nov 2001 03:22:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281317AbRKLIWF>; Mon, 12 Nov 2001 03:22:05 -0500
Received: from smtp-rt-11.wanadoo.fr ([193.252.19.62]:48375 "EHLO
	magnolia.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S281313AbRKLIVw>; Mon, 12 Nov 2001 03:21:52 -0500
Content-Type: text/plain; charset=US-ASCII
From: Duncan Sands <duncan.sands@math.u-psud.fr>
To: Mathijs Mohlmann <mathijs@knoware.nl>
Subject: Re: tasklets and finalization
Date: Mon, 12 Nov 2001 09:21:18 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <XFMail.20011112085704.mathijs@knoware.nl>
In-Reply-To: <XFMail.20011112085704.mathijs@knoware.nl>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E163CLH-0000J4-00@baldrick>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 12 November 2001 8:57 am, you wrote:
> On 11-Nov-2001 Duncan Sands wrote:
> > PS: My first thought was to use tasklet_kill, but according
> > to "Linux device drivers" (2nd ed) that may hang if the
> > tasklet isn't pending.
>
> true.
>
> > PPS: Another thought was to call schedule(), hoping that
> > all pending asklets will get run then, but is that reliable?
>
> if you are sure, the tasklet isn't rescheduled within the tasklet
> i THINK this will do it:
>
>         current->policy |= SCHED_YIELD;
>         schedule();
>
>         me

Thanks for thinking about this.  Here's a thought:

...
tasklet_schedule(&my_tasklet);
tasklet_kill(&my_tasklet);
...

Since (as far as I can see) there is no way the
tasklet will run before calling tasklet_kill, this
should just kill any pending tasklets.

Duncan.
