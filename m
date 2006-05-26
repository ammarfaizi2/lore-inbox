Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750998AbWEZQL7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750998AbWEZQL7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 12:11:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750989AbWEZQL7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 12:11:59 -0400
Received: from mail.gmx.de ([213.165.64.21]:3479 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750990AbWEZQLx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 12:11:53 -0400
X-Authenticated: #5039886
Date: Fri, 26 May 2006 18:11:49 +0200
From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
To: Mike Galbraith <efault@gmx.de>
Cc: Peter Williams <pwil3058@bigpond.net.au>, Con Kolivas <kernel@kolivas.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Kingsley Cheung <kingsley@aurema.com>, Ingo Molnar <mingo@elte.hu>,
       Rene Herman <rene.herman@keyaccess.nl>,
       Herbert Poetzl <herbert@13thfloor.at>, Sam Vilain <sam@vilain.net>
Subject: Re: [RFC 0/5] sched: Add CPU rate caps
Message-ID: <20060526161148.GA23680@atjola.homenet>
Mail-Followup-To: Mike Galbraith <efault@gmx.de>,
	Peter Williams <pwil3058@bigpond.net.au>,
	Con Kolivas <kernel@kolivas.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Kingsley Cheung <kingsley@aurema.com>, Ingo Molnar <mingo@elte.hu>,
	Rene Herman <rene.herman@keyaccess.nl>,
	Herbert Poetzl <herbert@13thfloor.at>, Sam Vilain <sam@vilain.net>
References: <20060526042021.2886.4957.sendpatchset@heathwren.pw.nest> <1148630661.7589.65.camel@homer>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1148630661.7589.65.camel@homer>
User-Agent: Mutt/1.5.11+cvs20060403
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2006.05.26 10:04:20 +0200, Mike Galbraith wrote:
> On Fri, 2006-05-26 at 14:20 +1000, Peter Williams wrote:
> > These patches implement CPU usage rate limits for tasks.
> > 
> > Although the rlimit mechanism already has a CPU usage limit (RLIMIT_CPU)
> > it is a total usage limit and therefore (to my mind) not very useful.
> > These patches provide an alternative whereby the (recent) average CPU
> > usage rate of a task can be limited to a (per task) specified proportion
> > of a single CPU's capacity.
> 
> The killer problem I see with this approach is that it doesn't address
> the divide and conquer problem.  If a task is capped, and forks off
> workers, each worker inherits the total cap, effectively extending same.
> 
> IMHO, per task resource management is too severely limited in it's
> usefulness, because jobs are what need managing, and they're seldom
> single threaded.  In order to use per task limits to manage any given
> job, you have to both know the number of components, and manually
> distribute resources to each component of the job.  If a job has a
> dynamic number of components, it becomes impossible to manage.

Linux-VServer uses a token bucket scheduler (TBS) to limit cpu ressources
for processes in a "context". All processes in a context share one token
bucket, which has a set of parameters to tune scheduling behaviour.
As the token bucket is shared by a group of processes, and inherited by
child processes/threads, management is quite easy. And the parameters
can be tuned to allow different scheduling behaviours, like allowing a
process group to burst, ie. use as much cpu time as is available, after
being idle for some time, but being limited to X % cpu time on average.

I'm CC'ing Herbert and Sam on this as they can explain the whole thing a
lot better and I'm not familiar with implementation details.

Regards
Björn
