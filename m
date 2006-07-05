Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932360AbWGEAPQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932360AbWGEAPQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 20:15:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932361AbWGEAPQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 20:15:16 -0400
Received: from mail22.syd.optusnet.com.au ([211.29.133.160]:64186 "EHLO
	mail22.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932360AbWGEAPO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 20:15:14 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Peter Williams <pwil3058@bigpond.net.au>
Subject: Re: [PATCH] sched: Add SCHED_BGND (background) scheduling policy
Date: Wed, 5 Jul 2006 10:14:47 +1000
User-Agent: KMail/1.9.3
Cc: Andrew Morton <akpm@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
References: <20060704233521.8744.45368.sendpatchset@heathwren.pw.nest>
In-Reply-To: <20060704233521.8744.45368.sendpatchset@heathwren.pw.nest>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607051014.48089.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 05 July 2006 09:35, Peter Williams wrote:
> Problem:
>
> There is a genuine need for the ability to put tasks in the background
> (a la the SCHED_IDLEPRIO policy in Con Kolivas's -sc kernels) as is
> evidenced by comments in LKML re a desire for SCHED_BATCH tasks
> to run completely in the background.
>
> Solution:
>
> Of course, one option would have been to just modify SCHED_BATCH so
> that tasks with that policy run completely in the background but there is a
> genuine need for a non background batch policy so the solution adopted
> is to implementa a new policy SCHED_BGND.
>
> SCHED_BATCH means that it's a normal process and should get a fair
> share of the CPU in accordance with its "nice" setting but it is NOT an
> interactive task and should NOT receive any of the special treatment
> that a task that is adjudged to be interactive receives.  In particular,
> it should always be moved to the expired array at the end of its time
> slice as to do otherwise might result in CPU starvation for other tasks.
>
> SCHED_BGND means it's totally unimportant and should only be given the
> CPU if no one else wants it OR if not giving it the CPU could lead to
> priority inversion or starvation of other tasks due to this tasks holding
> system resources.

Could we just call it SCHED_IDLEPRIO since it's the same thing and there are 
tools out there that already use this name?

-- 
-ck
