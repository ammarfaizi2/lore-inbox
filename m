Return-Path: <linux-kernel-owner+w=401wt.eu-S1750782AbXACODm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750782AbXACODm (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 09:03:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750785AbXACODm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 09:03:42 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:58549 "EHLO
	e34.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750782AbXACODl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 09:03:41 -0500
Date: Wed, 3 Jan 2007 19:34:59 +0530
From: Gautham R Shenoy <ego@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Oleg Nesterov <oleg@tv-sign.ru>, Ingo Molnar <mingo@elte.hu>,
       David Howells <dhowells@redhat.com>,
       Christoph Hellwig <hch@infradead.org>,
       Gautham R Shenoy <ego@in.ibm.com>, linux-kernel@vger.kernel.org,
       dipankar@in.ibm.com, vatsa@in.ibm.com
Subject: Re: [PATCH 3/2] fix flush_workqueue() vs CPU_DEAD race
Message-ID: <20070103140459.GA12620@in.ibm.com>
Reply-To: ego@in.ibm.com
References: <20061230161031.GA101@tv-sign.ru> <20070102162727.9ce2ae2b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070102162727.9ce2ae2b.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Sorry, I am yet to check out Venki's and Oleg's patches as I
just returned from Vacation.

On Tue, Jan 02, 2007 at 04:27:27PM -0800, Andrew Morton wrote:
> 
> I have a mental note that these:
> 
> extend-notifier_call_chain-to-count-nr_calls-made.patch
> extend-notifier_call_chain-to-count-nr_calls-made-fixes.patch
> extend-notifier_call_chain-to-count-nr_calls-made-fixes-2.patch

These patches are needed because they allow us to send out the "failed"
notifications to only those subsystems that received the "prepare"
notifications earlier.

> define-and-use-new-eventscpu_lock_acquire-and-cpu_lock_release.patch
> define-and-use-new-eventscpu_lock_acquire-and-cpu_lock_release-fix.patch

These were posted inorder to have a common place where the subsystems
could lock their per-subsystem hotplug mutexes/semaphore from within the
cpu-hotplug-callback function. Hence they are needed IMO.

> eliminate-lock_cpu_hotplug-in-kernel-schedc.patch
> eliminate-lock_cpu_hotplug-in-kernel-schedc-fix.patch

These patches define and use a mutex to handle cpu-hotplug and eliminate
the use of lock_cpu_hotplug in sched.c. Hence they are still needed.

> handle-cpu_lock_acquire-and-cpu_lock_release-in-workqueue_cpu_callback.patch

Again, this one ensures that workqueue_mutex is taken/released on
CPU_LOCK_ACQUIRE/CPU_LOCK_RELEASE events in the cpuhotplug callback
function. So this one is required, unless it conflicts with what Oleg
has posted. Will check that out tonite.

> 
> should be scrapped.  But really I forget what their status is.  Gautham,
> can you please remind us where we're at?
> 

If all goes fine (w.r.t cpufreq and workqueue), eliminating
lock_cpu_hotplug from kernel/*.c should be relatively easy.<fingers crossed>

Thanks and Regards
gautham.
-- 
Gautham R Shenoy
Linux Technology Center
IBM India.
"Freedom comes with a price tag of responsibility, which is still a bargain,
because Freedom is priceless!"
