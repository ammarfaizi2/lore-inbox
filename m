Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262321AbTFBNdo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 09:33:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262323AbTFBNdn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 09:33:43 -0400
Received: from pop.gmx.net ([213.165.64.20]:34176 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262321AbTFBNdh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 09:33:37 -0400
Message-Id: <5.2.0.9.2.20030602154624.019f2f98@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.0.9
Date: Mon, 02 Jun 2003 15:51:29 +0200
To: Ingo Molnar <mingo@elte.hu>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: [Linux-ia64] Re: web page on O(1) scheduler
Cc: Bill Davidsen <davidsen@tmr.com>, Olivier Galibert <galibert@pobox.com>,
       <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0306020949520.3375-100000@localhost.localdom
 ain>
References: <5.2.0.9.2.20030529062657.01fcaa50@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 10:05 AM 6/2/2003 +0200, Ingo Molnar wrote:

>On Thu, 29 May 2003, Mike Galbraith wrote:
>
> > [...] What makes more sense to me than the current implementation is to
> > rotate the entire peer queue when a thread expires... ie pull in the
> > head of the expired queue into the tail of the active queue at the same
> > time so you always have a player if one exists.  (you'd have to select
> > queues based on used cpu time to make that work right though)
>
>we have tried all sorts of more complex yield() schemes before - they
>sucked for one or another workload. So in 2.5 i took the following path:
>make yield() _simple_ and effective, ie. expire the yielding task (push it
>down the runqueue roughly halfway, statistically) and dont try to be too
>smart doing it. All the real yield() users (mostly in the kernel) want it
>to be an efficient way to avoid livelocks. The old 2.4 yield
>implementation had the problem of enabling a ping-pong between two
>higher-prio yielding processes, until they use up their full timeslice.

(yeah, i looked at that in ktracer logs.  cpu hot-potato sucks;)

>(we could do one more thing that still keeps the thing simple: we could
>re-set the yielding task's timeslice instead of the current 'keep the
>previous timeslice' logic.)

(more consistent) 

