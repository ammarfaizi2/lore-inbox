Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750776AbWEZIC5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750776AbWEZIC5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 04:02:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750821AbWEZIC4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 04:02:56 -0400
Received: from mail.gmx.net ([213.165.64.20]:14036 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750776AbWEZICz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 04:02:55 -0400
X-Authenticated: #14349625
Subject: Re: [RFC 0/5] sched: Add CPU rate caps
From: Mike Galbraith <efault@gmx.de>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: Con Kolivas <kernel@kolivas.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Kingsley Cheung <kingsley@aurema.com>, Ingo Molnar <mingo@elte.hu>,
       Rene Herman <rene.herman@keyaccess.nl>
In-Reply-To: <20060526042021.2886.4957.sendpatchset@heathwren.pw.nest>
References: <20060526042021.2886.4957.sendpatchset@heathwren.pw.nest>
Content-Type: text/plain
Date: Fri, 26 May 2006 10:04:20 +0200
Message-Id: <1148630661.7589.65.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-05-26 at 14:20 +1000, Peter Williams wrote:
> These patches implement CPU usage rate limits for tasks.
> 
> Although the rlimit mechanism already has a CPU usage limit (RLIMIT_CPU)
> it is a total usage limit and therefore (to my mind) not very useful.
> These patches provide an alternative whereby the (recent) average CPU
> usage rate of a task can be limited to a (per task) specified proportion
> of a single CPU's capacity.

The killer problem I see with this approach is that it doesn't address
the divide and conquer problem.  If a task is capped, and forks off
workers, each worker inherits the total cap, effectively extending same.

IMHO, per task resource management is too severely limited in it's
usefulness, because jobs are what need managing, and they're seldom
single threaded.  In order to use per task limits to manage any given
job, you have to both know the number of components, and manually
distribute resources to each component of the job.  If a job has a
dynamic number of components, it becomes impossible to manage.

	-Mike

