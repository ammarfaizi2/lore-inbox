Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932282AbWCXXqf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932282AbWCXXqf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 18:46:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932284AbWCXXqf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 18:46:35 -0500
Received: from fmr18.intel.com ([134.134.136.17]:54984 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S932282AbWCXXqe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 18:46:34 -0500
Date: Fri, 24 Mar 2006 15:45:59 -0800
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Con Kolivas <kernel@kolivas.org>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Mike Galbraith <efault@gmx.de>, linux-kernel@vger.kernel.org
Subject: more smpnice patch issues
Message-ID: <20060324154558.A20018@unix-os.sc.intel.com>
References: <20060322155122.2745649f.akpm@osdl.org> <4421F702.5040609@bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <4421F702.5040609@bigpond.net.au>; from pwil3058@bigpond.net.au on Wed, Mar 22, 2006 at 05:16:50PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

more issues with smpnice patch...

a) consider a 4-way system (simple SMP system with no HT and cores) scenario
where a high priority task (nice -20) is running on P0 and two normal
priority tasks running on P1. load balance with smp nice code
will never be able to detect an imbalance and hence will never move one of 
the normal priority tasks on P1 to idle cpus P2 or P3.

b) smpnice seems to break this patch..

[PATCH] sched: allow the load to grow upto its cpu_power
http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=0c117f1b4d14380baeed9c883f765ee023da8761

example scenario for this case: consider a numa system with two nodes, each
node containing four processors. if there are two processes in node-0 and with
node-1 being completely idle, your patch will move one of those processes to
node-1 whereas the previous behavior will retain those two processes in node-0..
(in this case, in your code max_load will be less than busiest_load_per_task)

smpnice patch has complicated the load balance code... Very difficult
to comprehend the side effects of this patch in the presence of different 
priority tasks...

thanks,
suresh
