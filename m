Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264569AbUFTGTw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264569AbUFTGTw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 02:19:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264734AbUFTGTw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 02:19:52 -0400
Received: from gizmo08ps.bigpond.com ([144.140.71.18]:61059 "HELO
	gizmo08ps.bigpond.com") by vger.kernel.org with SMTP
	id S264569AbUFTGTr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 02:19:47 -0400
Message-ID: <40D52C7F.80403@bigpond.net.au>
Date: Sun, 20 Jun 2004 16:19:43 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Michal Kaczmarski <fallow@op.pl>, Shane Shrybman <shrybman@aei.ca>
Subject: Re: [PATCH] Single Priority Array (SPA) CPU scheduler patches for
 2.6.7
References: <40D2485E.7030502@bigpond.net.au>
In-Reply-To: <40D2485E.7030502@bigpond.net.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams wrote:
> Are available as a single gzipped patch at:
> 
> <http://users.bigpond.net.au/Peter-Williams/patch-2_6_7-combined-v1.0.gz>
> 
> or as a series of patches to be applied in sequence (for easier 
> understanding) at:
> 
> <http://users.bigpond.net.au/Peter-Williams/patch-2_6_7-SPA-v1.0.gz> 
> replaces the active and expired array with a single array and adds a 
> promotion mechanism to avoid starvation,
> <http://users.bigpond.net.au/Peter-Williams/patch-2_6_7-SPA_IAB-v1.0.gz> 
> replaces the interactive priority bonus mechanism with a simpler one,
> <http://users.bigpond.net.au/Peter-Williams/patch-2_6_7-SPA_TPB-v1.0.gz> 
> adds a throughput bonus mechanism,
> <http://users.bigpond.net.au/Peter-Williams/patch-2_6_7-SPA_TSTATS-v1.0.gz> 
> adds reporting of scheduling statistics including time spent on the run 
> queue waiting for CPU access (to enable analysis of scheduling 
> behaviour), and
> <http://users.bigpond.net.au/Peter-Williams/patch-2_6_7-SPA_CNTL-v1.0.gz> 
> adds a directory /proc/sys/kernel/cpusched to /proc/sys and a number of 
> attributes that can be used to control the scheduler as follows:
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
> A primitive Python/Glade/GTK GUI for manipulating these parameters is 
> available at:
> 
> <http://users.bigpond.net.au/Peter-Williams/gcpuctl.tar.gz>
> 
> In addition, a version of Con Kolivas's staircase scheduler with 
> promotion and scheduler statistics added is available as a single patch at:
> 
> <http://users.bigpond.net.au/Peter-Williams/patch-2_6_7-sc-combined-v1.0.gz> 
> 
> 
> and as multiple patches at:
> 
> <http://users.bigpond.net.au/Peter-Williams/patch-2_6_7-SPA-v1.0.gz>
> <http://users.bigpond.net.au/Peter-Williams/patch-2_6_7-SPA_STAIRCASE-v1.0.gz> 
> 
> <http://users.bigpond.net.au/Peter-Williams/patch-2_6_7-SPA_SC_TSTATS-v1.0.gz> 
> 
> 
> and a primitive GUI for manipulating its control parameters is at:
> 
> <http://users.bigpond.net.au/Peter-Williams/gcpuctl_sc.tar.gz>

To facilitate the comparative evaluation of the two CPU schedulers 
described above they have been combined into a single patch with the 
capability to switch between the to schedulers at run time.  This patch 
is available for download at:

<http://users.bigpond.net.au/Peter-Williams/patch-2.6.7-HYDRA_SC-v1.0.gz>

The file /proc/sys/kernel/cpusched/mode has been added to those 
described above to control which of the schedulers is in control.  The 
string "sc" is used to select the staircase scheduler and "pb" to select 
the priority based scheduler described above.  The staircase scheduler 
control parameters "compute" and "interactive" have been moved into 
/proc/sys/kernel/cpusched along with the other scheduler control 
parameters.  A primitive Glade/PyGTK GUI that provides the ability to 
switch between schedulers and to control scheduler parameters is 
available at:

<http://users.bigpond.net.au/Peter-Williams/gcpuctl_hydra.tar.gz>

NB
1. None of the priority based scheduler control parameters will have any 
effect when the staircase scheduler is in charge but the staircase 
"compute" parameter will effect preemption for the priority based scheduler.
2. The staircase scheduler is based on Con's version 6.E and does not 
contain his latest fixes but will be updated when he releases his next 
patch.
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce

