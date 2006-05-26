Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750765AbWEZOMt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750765AbWEZOMt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 10:12:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750767AbWEZOMt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 10:12:49 -0400
Received: from mail18.syd.optusnet.com.au ([211.29.132.199]:50612 "EHLO
	mail18.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1750765AbWEZOMs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 10:12:48 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Peter Williams <pwil3058@bigpond.net.au>
Subject: Re: [RFC 3/5] sched: Add CPU rate hard caps
Date: Sat, 27 May 2006 00:12:28 +1000
User-Agent: KMail/1.9.1
Cc: Mike Galbraith <efault@gmx.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Kingsley Cheung <kingsley@aurema.com>, Ingo Molnar <mingo@elte.hu>,
       Rene Herman <rene.herman@keyaccess.nl>
References: <20060526042021.2886.4957.sendpatchset@heathwren.pw.nest> <200605262100.22071.kernel@kolivas.org> <447709B3.80309@bigpond.net.au>
In-Reply-To: <447709B3.80309@bigpond.net.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605270012.28743.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 26 May 2006 23:59, Peter Williams wrote:
> Con Kolivas wrote:
> > On Friday 26 May 2006 14:20, Peter Williams wrote:
> >> This patch implements hard CPU rate caps per task as a proportion of a
> >> single CPU's capacity expressed in parts per thousand.
> >
> > A hard cap of 1/1000 could lead to interesting starvation scenarios where
> > a mutex or semaphore was held by a task that hardly ever got cpu. Same
> > goes to a lesser extent to a 0 soft cap.
> >
> > Here is how I handle idleprio tasks in current -ck:
> >
> > http://ck.kolivas.org/patches/2.6/pre-releases/2.6.17-rc5/2.6.17-rc5-ck1/
> >patches/track_mutexes-1.patch tags tasks that are holding a mutex
> >
> > http://ck.kolivas.org/patches/2.6/pre-releases/2.6.17-rc5/2.6.17-rc5-ck1/
> >patches/sched-idleprio-1.7.patch is the idleprio policy for staircase.
> >
> > What it does is runs idleprio tasks as normal tasks when they hold a
> > mutex or are waking up after calling down() (ie holding a semaphore).
>
> I wasn't aware that you could detect those conditions.  They could be
> very useful.

Ingo's mutex infrastructure made it possible to accurately track mutexes held, 
and basically anything entering uninterruptible sleep has called down(). 
Mainline, as you know, already flags the latter for interactivity purposes.

-- 
-ck
