Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272563AbTHPCZh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 22:25:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272578AbTHPCZg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 22:25:36 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:19402
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S272563AbTHPCZf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 22:25:35 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Timothy Miller <miller@techsource.com>
Subject: Re: [PATCH] O16int for interactivity
Date: Sat, 16 Aug 2003 12:31:50 +1000
User-Agent: KMail/1.5.3
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       gaxt <gaxt@rogers.com>, Mike Galbraith <efault@gmx.de>
References: <200308160149.29834.kernel@kolivas.org> <3F3D25D0.7010701@techsource.com>
In-Reply-To: <3F3D25D0.7010701@techsource.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308161231.50661.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Aug 2003 04:26, Timothy Miller wrote:
> Con Kolivas wrote:
> > Preemption of tasks at the same level with twice as much timeslice has
> > been dropped as this is not necessary with timeslice granularity (may
> > improve performance of cpu intensive tasks).
>
> Does this situation happen where two tasks at different nice levels have
> dynamic priority adjustments which make them effectively have the same
> priority?

Yes it does. Preemption and order of scheduling is determined entirely by the 
dynamic priority.

> > Preemption of user tasks is limited to those in the interactive range;
> > cpu intensive non interactive tasks can run out their full timeslice (may
> > also improve cpu intensive performance)
>
> What can cause preemption of a task that has not used up its timeslice?

Any task of better (dynamic) priority will preempt it.

>   I assume a device interrupt could do this, but... there's a question I
> asked earlier which I haven't read the answer to yet, so I'm going to
> guess:
>
> A hardware timer interrupt happens at timeslice granularity.  If the
> interrupt occurs, but the timeslice is not expired, then NORMALLY, the
> ISR would just return right back to the running task, but sometimes, it
> might decided to end the timeslice early and run some other task.
>
> Right?

No, the timeslice granularity is a hard cut off where a task gets rescheduled 
and put at the back of the queue again. If there is no other task of equal or 
better priority it will just start again.

> So, what might cause the scheduler to decide to preempt a task which has
> not used up its timeslice?

Better dynamic priority.

Con

