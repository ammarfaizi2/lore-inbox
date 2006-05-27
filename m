Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751752AbWE0BnH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751752AbWE0BnH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 21:43:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751754AbWE0BnH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 21:43:07 -0400
Received: from mail05.syd.optusnet.com.au ([211.29.132.186]:15000 "EHLO
	mail05.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751752AbWE0BnF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 21:43:05 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Peter Williams <pwil3058@bigpond.net.au>
Subject: Re: [RFC 0/5] sched: Add CPU rate caps
Date: Sat, 27 May 2006 11:42:43 +1000
User-Agent: KMail/1.9.1
Cc: Mike Galbraith <efault@gmx.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Kingsley Cheung <kingsley@aurema.com>, Ingo Molnar <mingo@elte.hu>,
       Rene Herman <rene.herman@keyaccess.nl>
References: <20060526042021.2886.4957.sendpatchset@heathwren.pw.nest> <200605262041.09221.kernel@kolivas.org> <4477AB24.1050109@bigpond.net.au>
In-Reply-To: <4477AB24.1050109@bigpond.net.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605271142.43611.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 27 May 2006 11:28, Peter Williams wrote:
> Con Kolivas wrote:
> > On Friday 26 May 2006 14:20, Peter Williams wrote:
> >> Although the rlimit mechanism already has a CPU usage limit (RLIMIT_CPU)
> >> it is a total usage limit and therefore (to my mind) not very useful.
> >> These patches provide an alternative whereby the (recent) average CPU
> >> usage rate of a task can be limited to a (per task) specified proportion
> >> of a single CPU's capacity.  The limits are specified in parts per
> >> thousand and come in two varieties -- hard and soft.
> >
> > Why 1000?
>
> Probably a hang over from a version where the units were proportion of a
> whole machine.  Percentage doesn't work very well if there are more than
> 1 CPU in that case (especially if there are more than 100 CPUs :-)).
> But it's also useful to have the extra range if your trying to cap
> processes (or users) from outside the scheduler using these primitives.
>
> > I doubt that degree of accuracy is possible in cpu accounting and
> > accuracy or even required. To me it would seem to make more sense to just
> > be a percentage.
>
> It's not meant to imply accuracy :-).  The main issue is avoiding
> overflow when doing the multiplications during the comparisons.

Well you could always expose a smaller more meaningful value than what is 
stored internally. However you've already implied that there are requirements 
in userspace for more granularity in the proportioning than percentage can 
give.

-- 
-ck
