Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422704AbWCXLyf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422704AbWCXLyf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 06:54:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422708AbWCXLyf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 06:54:35 -0500
Received: from mail04.syd.optusnet.com.au ([211.29.132.185]:38882 "EHLO
	mail04.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1422704AbWCXLye (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 06:54:34 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Mike Galbraith <efault@gmx.de>
Subject: Re: [2.6.16-mm1 patch] throttling tree patches
Date: Fri, 24 Mar 2006 22:54:08 +1100
User-Agent: KMail/1.9.1
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Peter Williams <pwil3058@bigpond.net.au>
References: <1143198208.7741.8.camel@homer> <1143198964.7741.23.camel@homer> <1143199295.7741.29.camel@homer>
In-Reply-To: <1143199295.7741.29.camel@homer>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603242254.09643.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 24 March 2006 22:21, Mike Galbraith wrote:
> patch 4/6
>
> This patch implements the throttling.
>
> Throttling is done via computing a slice_avg, which is the upper limit
> of what a task's sleep_avg may be and be sane.  When a task begins to
> consume more CPU than it's sleep_avg indicates it should, the task will
> be throttled.  A task which conforms to expectations can save credit for
> later use, which allows interactive tasks to do a burst of activity
> without being throttled.  When their reserve is exhausted however,
> that's the end of high ussage at high priority.

Looks ok. The description of credit still sounds cryptic.

> +#define C1 (CREDIT_C1 * MAX_BONUS * HZ)
> +#define C2 (CREDIT_C2 * MAX_BONUS * HZ + C1)
> +#define C3 (MAX_BONUS * C2)

Macro names that short are asking for trouble...

...
else looks good. After we've cleaned out all the sched patches from -mm it 
would be nice to get this work in. The values of C1 and particularly C2 
_sound_ large but may well be appropriate since you've been hard at work on 
this. I'll have to have a play for myself (if I ever find spare cycles on my 
miniscule selection of hardware) with them when they hit -mm.

Cheers,
Con
