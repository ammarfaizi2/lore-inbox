Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266505AbUGBIRJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266505AbUGBIRJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 04:17:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266508AbUGBIRJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 04:17:09 -0400
Received: from gizmo05ps.bigpond.com ([144.140.71.40]:23256 "HELO
	gizmo05ps.bigpond.com") by vger.kernel.org with SMTP
	id S266505AbUGBIQ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 04:16:57 -0400
Message-ID: <40E519F1.1030200@bigpond.net.au>
Date: Fri, 02 Jul 2004 18:16:49 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Michal Kaczmarski <fallow@op.pl>, Shane Shrybman <shrybman@aei.ca>
Subject: Re: [PATCH] CPU scheduler evaluation tool
References: <40DFBCAD.7020403@bigpond.net.au>
In-Reply-To: <40DFBCAD.7020403@bigpond.net.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams wrote:
> To facilitate the comparative evaluation of alternative CPU schedulers a 
> patch that allows the run time selection of CPU scheduler between 
> version 7.7 of Con Kolivas's staircase scheduler ("sc") and the priority 
> based scheduler with interactive and throughput bonuses ("pb") has been 
> created.  This patch is available for download at:
> 
> <http://prdownloads.sourceforge.net/cpuse/patch-2.6.7-spa_hydra_FULL-v1.2?download> 
> 
> 
> The file /proc/sys/kernel/cpusched/mode has been added to those provided 
> by the "pb" to control which of the schedulers is in control.  The 
> string "sc" is used to select the staircase scheduler and "pb" to select 
> the priority based scheduler described above.  The staircase scheduler 
> control parameters "compute" and "interactive" have been moved into 
> /proc/sys/kernel/cpusched along with the "pb" scheduler control 
> parameters.  The scheduler starts in the "sc" mode. A primitive 
> Glade/PyGTK GUI that provides the ability to switch between schedulers 
> and to control scheduler parameters is available at:
> 
> <http://prdownloads.sourceforge.net/cpuse/gcpuctl_hydra-1.0.tar.gz?download> 
> 
> 
> This GUI should also work with a standard version of Con Kolivas's 
> staircase scheduler as well as the version based on my single priority 
> array patch:
> 
> <http://prdownloads.sourceforge.net/cpuse/patch-2.6.7-spa_sc_FULL-v1.2?download> 
> 
> 
> and the basic priority based scheduler:
> 
> <http://prdownloads.sourceforge.net/cpuse/patch-2.6.7-spa_pb_FULL-v1.2?download> 
> 
> 
> and, for those so inclined, these patches broken into smaller parts for 
> easier digestion are available at:
> 
> <https://sourceforge.net/projects/cpuse/>
> 
> An entitlement based "eb" scheduler will be added to the selection 
> available in the near future.
> 
> Controls:
> 
> base_promotion_interval -- (milliseconds) controls the interval between 
> successive promotions (is multiplied by the number of active tasks on 
> the CPU in question) NB no promotion occurs if there are less than 2 
> active tasks
> 
> time_slice -- (milliseconds) the size of the time slice (i.e. how long 
> it will be allowed to hold the CPU before it is kicked off to allow 
> other tasks a chance to run) that is allocated to a task when it becomes 
> active or finishes a time slice.  (min is 1 millisec and max is 1 second).
> 
> max_ia_bonus -- (a value between 0 and 10) that determines the maximum 
> interactive bonus that a task can acquire
> 
> initial_ia_bonus -- (a value between 0 and 10) that determines the 
> initial interactive bonus that a newly forked task will be given.  This 
> value will be capped by the max_ia_bonus.
> 
> ia_threshold  -- (parts per thousand) is the sleep to (sleep + on_cpu) 
> ratio above which a task will have its interactive bonus increased 
> asymptotically towards the maximum
> 
> cpu_hog_threshold  -- (parts per thousand) is the usage rate above which 
> a task will be considered a CPU hog and start to lose interactive bonus 
> points if it has any
> 
> max_tpt_bonus -- (a value between 0 and 9) that determines the maximum 
> throughput bonus that tasks may be awarded
> 
> log_at_exit - (0 or 1) turns off/on the logging of tasks' scheduling 
> statistics at exit.  This feature is useful for determining the 
> scheduling characteristics of relatively short lived tasks that run as 
> part of some larger job such as a kernel build where trying to get time 
> series data is impractical.
> 
> compute -- (0 or 1) turn on/off the staircase schedulers "compute" switch
> 
> interactive -- (0 or 1) turn on/off the staircase schedulers 
> "interactive" mode

Updated versions of this patch that include the staircase 7.8 updates 
and an entitlement based scheduler is available at:

<http://prdownloads.sourceforge.net/cpuse/patch-2.6.7-spa_hydra_FULL-v1.3?download>

Because of a problem with VERY CPU bound tasks it has been necessary to 
change the way the control statistics for these type of tasks are 
calculated.  This has resulted in the introduction of another control 
parameter hog_sub_cycle_threshold which is an integer value and if a 
task uses more than this number of time slices without sleeping its 
average delay and cpu statistics will be calculated over the cpu:->runq 
sub cycle instead of the full scheduling cycle.  A modified version of 
the primitive GUI for manipulating parameters is available at:

<http://prdownloads.sourceforge.net/cpuse/gcpuctl_hydra-1.1.tar.gz?download>

A stand alone version of the entitlement based scheduler will appear in 
due course.

-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce

