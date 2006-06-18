Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932067AbWFRLnR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932067AbWFRLnR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 07:43:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932105AbWFRLnR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 07:43:17 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:13970 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932067AbWFRLnQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 07:43:16 -0400
Date: Sun, 18 Jun 2006 17:12:46 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: Andrew Morton <akpm@osdl.org>, kernel@kolivas.org, sam@vilain.net,
       bsingharora@gmail.com, dev@openvz.org, linux-kernel@vger.kernel.org,
       efault@gmx.de, kingsley@aurema.com, ckrm-tech@lists.sourceforge.net,
       mingo@elte.hu, rene.herman@keyaccess.nl
Subject: Re: [PATCH 0/4] sched: Add CPU rate caps
Message-ID: <20060618114246.GA17386@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20060618082638.6061.20172.sendpatchset@heathwren.pw.nest> <20060618025046.77b0cecf.akpm@osdl.org> <449529FE.1040008@bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <449529FE.1040008@bigpond.net.au>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 18, 2006 at 08:25:02PM +1000, Peter Williams wrote:
> >People are going to want to extend this to capping a *group* of tasks, with
> >some yet-to-be-determined means of tying those tasks together.  How well
> >suited is this code to that extension?
> 
> Quite good.  It can be used from outside the scheduler to impose caps on 
> arbitrary groups of tasks.  Were the PAGG interface available I could 
> knock up a module to demonstrate this.  When/if the "task watchers" 

For demonstration purpose, maybe you could use tsk->uid to group tasks and 
and see how capping at group level works out? Basically cap the per-user cpu
usage.

> patch is included I will try and implement a higher level mechanism 
> using that.  The general technique is to get an estimate of the 
> "effective number" of tasks in the group (similar to load) and give each 
> task in the group a cap which is the group's cap divided by the 
> effective number of tasks (or the group cap whichever is smaller -- i.e. 
> the effective number of tasks could be less than one).

For "effective number" do you include only runnable tasks? As and when
this number changes, you would need to go and change the per-task cap of
all tasks in the group. Any idea what the cost of that operation would
be? Or do you intend to do it lazily to amortize some of that cost?

> Doing it inside the scheduler is also doable but would have some locking 
> issues.  The run queue lock could no longer be used to protect the data 
> as there's no guarantee that all the tasks in the group are associated 
> with the same queue.

-- 
Regards,
vatsa
