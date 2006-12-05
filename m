Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967423AbWLEIem@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967423AbWLEIem (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 03:34:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967493AbWLEIem
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 03:34:42 -0500
Received: from ausmtp05.au.ibm.com ([202.81.18.154]:47079 "EHLO
	ausmtp05.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967423AbWLEIel (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 03:34:41 -0500
Date: Tue, 5 Dec 2006 14:06:58 +0530
From: Gautham R Shenoy <ego@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, vatsa@in.ibm.com, dipankar@in.ibm.com,
       davej@redhat.com, torvalds@osdl.org
Subject: Re: -mm merge plans for 2.6.20
Message-ID: <20061205083658.GA18025@in.ibm.com>
Reply-To: ego@in.ibm.com
References: <20061204204024.2401148d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061204204024.2401148d.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

> remove-hotplug-cpu-crap-from-cpufreq.patch
> 
> Sent to cpufreq maintainer

I suspect that Davej posted this patch because he was getting lockdep
warnings-reports from people complaining of ondemand-governor 
performing spurious unlock_cpu_hotplug. 
That problem has been fixed in the mainline by the commit
http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=4b96b1a10cb00c867103b21f0f2a6c91b705db11

If there are any other issues with cpufreq-cpuhotplug in the mainline,
I'm more than willing to help out fix them. As of now, I cannot seem 
to spot anything serious in the mainline as such.
Hence, merging this isn't an immediate need IMHO.

> hotplug-cpu-clean-up-hotcpu_notifier-use.patch
> hotplug-cpu-clean-up-hotcpu_notifier-use-vs-gregkh-driver-cpu-topology-consider-sysfs_create_group-return-value.patch

> 
> extend-notifier_call_chain-to-count-nr_calls-made.patch
> extend-notifier_call_chain-to-count-nr_calls-made-fixes.patch
> extend-notifier_call_chain-to-count-nr_calls-made-fixes-2.patch
> define-and-use-new-eventscpu_lock_acquire-and-cpu_lock_release.patch
> define-and-use-new-eventscpu_lock_acquire-and-cpu_lock_release-fix.patch
> eliminate-lock_cpu_hotplug-in-kernel-schedc.patch
> eliminate-lock_cpu_hotplug-in-kernel-schedc-fix.patch
> handle-cpu_lock_acquire-and-cpu_lock_release-in-workqueue_cpu_callback.patch
> 
>  Shall merge.
>

Merging this would still give the circular-locking dependency warnings
which I posted the other day. Unless we have a clean way to get
cpu-hotplug-protection for cpufreq, I don't see a point in merging this
stuff.

Cpufreq hotplug-interactions can be sorted out.
I have a few patches which I need to test out before posting them.

Other than that, there are issues regarding the 
workqueue-hotplug-"locking" which needs to be addressed,
probably in a seperate thread.

So could you please reconsider this decision to merge the
hotplug-locking rework, and let it stabilize in -mm for sometime ?

Thanks and Regards
gautham.
-- 
Gautham R Shenoy
Linux Technology Center
IBM India.
"Freedom comes with a price tag of responsibility, which is still a bargain,
because Freedom is priceless!"
