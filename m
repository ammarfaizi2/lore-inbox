Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932122AbWEQKZy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932122AbWEQKZy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 06:25:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932119AbWEQKZy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 06:25:54 -0400
Received: from mail16.syd.optusnet.com.au ([211.29.132.197]:41607 "EHLO
	mail16.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932071AbWEQKZx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 06:25:53 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Mike Galbraith <efault@gmx.de>
Subject: Re: Regression seen for patch "sched:dont decrease idle sleep avg"
Date: Wed, 17 May 2006 20:25:21 +1000
User-Agent: KMail/1.9.1
Cc: tim.c.chen@linux.intel.com, "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       linux-kernel@vger.kernel.org, mingo@elte.hu,
       Andrew Morton <akpm@osdl.org>
References: <4t16i2$12rqnu@orsmga001.jf.intel.com> <200605171823.24476.kernel@kolivas.org> <1147859363.8813.41.camel@homer>
In-Reply-To: <1147859363.8813.41.camel@homer>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605172025.22626.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 17 May 2006 19:49, Mike Galbraith wrote:
> On Wed, 2006-05-17 at 18:23 +1000, Con Kolivas wrote:
> > There is a ceiling to the priority beyond which tasks that only ever
> > sleep for very long periods cannot surpass.
>
> (Hmm.  The intent is more clear, ie reserve the top for low latency
> tasks,... but that sounds a bit like xmms protection.)
>
> The main problem I see with this ceiling, solely from the interactivity
> viewpoint, is that interactive tasks which have started burning cpu
> and/or freshly forked interactive tasks land in the same spot.  Thud.c
> demonstrates this problem quite well.  You don't want a few copies of
> thud in the same queue with your interactive task, much less above it if
> it's used enough cpu to drop a notch or two.  Much pain ensues.

If there are thud processes that have earned their place they deserve it, just 
as any other task. If something uses only 1% cpu it is unfair just because it 
only ever sleeps for long sleeps to prevent it getting as good priority as 
anything else that uses only 1% cpu. I've noticed that 'top' suffers this 
fate for example. The problem I've had all along with thud as a test case is 
that while it causes a pause on the system for potentially a few seconds, it 
does this by raising the load transiently to a load of 50 (or whatever you 
set it to). I have no problem with a system having a hiccup when the load is 
50, provided the system eventually recovers and isn't starved forever (which 
it isn't). There are other means to prevent one user having that many running 
tasks if so desired.

-- 
-ck
