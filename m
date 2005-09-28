Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030195AbVI1HIw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030195AbVI1HIw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 03:08:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751185AbVI1HIv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 03:08:51 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:21654 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1751167AbVI1HIu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 03:08:50 -0400
Date: Wed, 28 Sep 2005 00:08:39 -0700
From: Paul Jackson <pj@sgi.com>
To: KUROSAWA Takahiro <kurosawa@valinux.co.jp>
Cc: taka@valinux.co.jp, magnus.damm@gmail.com, dino@in.ibm.com,
       linux-kernel@vger.kernel.org, ckrm-tech@lists.sourceforge.net
Subject: Re: [ckrm-tech] Re: [PATCH 1/3] CPUMETER: add cpumeter framework to
 the CPUSETS
Message-Id: <20050928000839.1d659bfb.pj@sgi.com>
In-Reply-To: <20050928062146.6038E70041@sv1.valinux.co.jp>
References: <20050908225539.0bc1acf6.pj@sgi.com>
	<20050909.203849.33293224.taka@valinux.co.jp>
	<20050909063131.64dc8155.pj@sgi.com>
	<20050910.161145.74742186.taka@valinux.co.jp>
	<20050910015209.4f581b8a.pj@sgi.com>
	<20050926093432.9975870043@sv1.valinux.co.jp>
	<20050927013751.47cbac8b.pj@sgi.com>
	<20050927113902.C78A570046@sv1.valinux.co.jp>
	<20050927084905.7d77bdde.pj@sgi.com>
	<20050928062146.6038E70041@sv1.valinux.co.jp>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Takahiro-san, replying to pj:
> >                          |
> >                       CPUSET 1a
> >                       cpus: 2, 3
> >                       cpu_exclusive=0
> >                       meter_cpu=0
> >                       meter_cpu_*
> >                          |
> >             +------------+------------+
> >             |                         |
> >          CPUSET 2a                CPUSET 2b
> >          cpus: 2                  cpus: 3
> >          meter_cpu=0              meter_cpu=0
> >          cpu_exclusive=0          cpu_exclusive=0
> > 
> > Note here that marking C (CPUSET 1) as meter_cpu exposes the meter_cpu_*
> > files in the children of C.
> 
> If we split the cpus {2, 3} into {2} and {3} by creating CPUSET 2a 
> and CPUSET 2b, the guarantee assigned to CPUSET 1a might not be
> satisfied.  For example, the maximum cpu resource usage of tasks 
> in CPUSET 2a should essentially be 50% because tasks in CPUSET 2a
> can only use the half number of cpus. 

Ah, yes, this could be difficult and not worth doing.

It might help if I stated more of what I mean, which I didn't before.

I intended that all tasks in the combination of cpusets 1a, 2a, and 2b
would collectively be allowed what ever percentage of cpu cycles the
meter_cpu_* files in cpuset 1a prescribed.  I did not intend to suggest
any particular balance between these tasks in 1a, 2a and 2b would be
enforced.  In particular, I did not expect for anything like a 50%
split between the tasks in 2a and 2b to be enforced.   For the purposes
of your cpu controller, just treat the entire set of tasks in all
three of these cpusets as one pool, governed by one meter_cpu_*
setting, just as if all these tasks were in cpuset 1a, and as if
cpusets 2a and 2b didn't exist.

This might be easier to do - I don't know.  If this is still hard,
then I guess my dream of allowing metered cpusets to have child
cpusets with a "proper subset" of CPUs (strictly fewer CPUs) is too
hard to do now.  In the abstract, this seems like a serious limitation
to me.  But practically speaking, it might not be a big problem.
I don't know.

If it is still hard, even this way, it may just have to wait, until
someone needs it bad enough to find a way.  If we have layed a good
foundation and allowed for this possibility in our architecture,
then perhaps we will have done all we can do for now.

> Probably allowing nested metered cpusets is too hard both to implement
> and to use.  So far, I woundn't like to implement it.

A wise choice.

> This seems very interesting.  Tasks enclosed by a certain cpuset may
> want to change the behavior of oom_killer.

Yes - I think so too.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
