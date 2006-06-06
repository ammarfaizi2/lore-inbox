Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751256AbWFFL1F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751256AbWFFL1F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 07:27:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751257AbWFFL1F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 07:27:05 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:11904 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751256AbWFFL1E
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 07:27:04 -0400
Date: Tue, 6 Jun 2006 16:56:52 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Mike Galbraith <efault@gmx.de>
Cc: Peter Williams <pwil3058@bigpond.net.au>, sekharan@us.ibm.com,
       balbir@in.ibm.com, dev@openvz.org, Andrew Morton <akpm@osdl.org>,
       Sam Vilain <sam@vilain.net>, ckrm-tech@lists.sourceforge.net,
       Balbir Singh <bsingharora@gmail.com>, Con Kolivas <kernel@kolivas.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Kingsley Cheung <kingsley@aurema.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>, Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [ckrm-tech] [RFC 3/5] sched: Add CPU rate hard caps
Message-ID: <20060606112652.GC4394@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <44781167.6060700@bigpond.net.au> <447D95DE.1080903@sw.ru> <447DBD44.5040602@in.ibm.com> <447E9A1D.9040109@openvz.org> <447EA694.8060407@in.ibm.com> <1149187413.13336.24.camel@linuxchandra> <447FD2E1.7060605@bigpond.net.au> <1149237992.9446.133.camel@Homer.TheSimpsons.net> <44803ABA.6050001@bigpond.net.au> <1149259639.8661.22.camel@Homer.TheSimpsons.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1149259639.8661.22.camel@Homer.TheSimpsons.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 02, 2006 at 04:47:19PM +0200, Mike Galbraith wrote:
> > > Consider make.  A cap on make itself isn't meaningful, and _any_ per
> > > task cap you put on it with the intent of managing the aggregate, is
> > > defeated by the argument -j.  Per task caps require omniscience to be
> > > effective in managing processes.  That's a pretty severe limitation.
> > 
> > These caps aren't trying to control aggregates but with suitable 
> > software they can be used to control aggregates.
> 
> How?  How would you deal with the make example with per task caps.

If we add some grouping mechanism for tasks (CKRM or PAGG), then this 
could be handled easily by adjusting the per-task limit based on the
number of tasks in the group? For example, when make is started, it
could be the only task in the group, with a per-task (& group_limit) of 50%. 
As it forks more tasks, the per-task limit of everyone in the group is 
adjusted (lazily perhaps at the next scheduler tick time) based on the 
group_limit/num_of_tasks_in_group. 

This would still require a resource control daemon to adjust the
per-task limit of tasks within a group (if some task in underutilizing
its bandwidth for example).


-- 
Regards,
vatsa
