Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284195AbRLFU1n>; Thu, 6 Dec 2001 15:27:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284217AbRLFU12>; Thu, 6 Dec 2001 15:27:28 -0500
Received: from mail.xmailserver.org ([208.129.208.52]:6663 "EHLO
	mail.xmailserver.org") by vger.kernel.org with ESMTP
	id <S284195AbRLFUZl>; Thu, 6 Dec 2001 15:25:41 -0500
Date: Thu, 6 Dec 2001 12:36:45 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Ingo Molnar <mingo@elte.hu>
cc: Mike Kravetz <kravetz@us.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Scheduler Cleanup
In-Reply-To: <Pine.LNX.4.33.0112062301070.24309-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.40.0112061232310.1603-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Dec 2001, Ingo Molnar wrote:

>
> On Thu, 6 Dec 2001, Davide Libenzi wrote:
>
> > What about decreasing counter by 1 for each sched_yield() call ?
>
> we did that in earlier kernels - it's not really the right thing to do, as
> calling yield() does not mean we are willing to give up a *timeslice*. It
> only means that right now we are not able to proceed.

The old code was giving up the whole timeslice, that is a bit excessive.
Having the counter decay patch + descreasing by 1 the counter you've the
proper execution of non yielding tasks, while if you've only yielding
tasks, who cares if they repidly give up the whole timeslice sequentially.
The other, but more expensive solution is to have a side-counter
accumulation where time slice subtracted to counter accumulates and are
remerged at the proper time ( recalc loop ).




- Davide


