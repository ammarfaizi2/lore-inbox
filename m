Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275973AbRKNR7j>; Wed, 14 Nov 2001 12:59:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276424AbRKNR7a>; Wed, 14 Nov 2001 12:59:30 -0500
Received: from [208.129.208.52] ([208.129.208.52]:48135 "EHLO xmailserver.org")
	by vger.kernel.org with ESMTP id <S275973AbRKNR7O>;
	Wed, 14 Nov 2001 12:59:14 -0500
Date: Wed, 14 Nov 2001 10:08:04 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Mike Kravetz <kravetz@us.ibm.com>
cc: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@transmeta.com>,
        <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [patch] scheduler cache affinity improvement for 2.4 kernels
In-Reply-To: <20011113205613.A1070@w-mikek2.sequent.com>
Message-ID: <Pine.LNX.4.40.0111141006010.1582-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Nov 2001, Mike Kravetz wrote:

> On Thu, Nov 08, 2001 at 03:30:11PM +0100, Ingo Molnar wrote:
> >
> > i've attached a patch that fixes a long-time performance problem in the
> > Linux scheduler.
>
> Just got back from holiday and saw this patch.  I like the idea
> slowing down task dynamic priority modifications (the counter
> field).  My only thought/concern would be in the case where a
> task with maximum dynamic priority (counter value) decides to
> use 'all' of its timeslice.  In such a case, the task can not
> be preempted by another task (with the same static priority)
> until its entire timeslice is expired.  In the current scheduler,
> I believe the task can be preempted after 1 timer tick.  In
> practice, this shouldn't be an issue.  However, it is something
> we may want to think about.  One simple solution would be to
> update a tasks dynamic priority (counter value) more frequently
> it it is above its NICE_TO_TICKS value.

Mike, take a look at my next post in this thread.
I'm using a watermark value of 10 :


        if (p->counter > TICKS_WMARK)
            --p->counter;
        else if (++p->timer_ticks >= p->counter) {
            p->counter = 0;
            p->timer_ticks = 0;
            p->need_resched = 1;
        }





- Davide


