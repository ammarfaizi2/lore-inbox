Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264915AbUFRBrG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264915AbUFRBrG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 21:47:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264948AbUFRBm5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 21:42:57 -0400
Received: from gizmo08ps.bigpond.com ([144.140.71.18]:18641 "HELO
	gizmo08ps.bigpond.com") by vger.kernel.org with SMTP
	id S264924AbUFRBlx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 21:41:53 -0400
Message-ID: <40D2485E.7030502@bigpond.net.au>
Date: Fri, 18 Jun 2004 11:41:50 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Michal Kaczmarski <fallow@op.pl>
Subject: [PATCH] Single Priority Array (SPA) CPU scheduler patches for 2.6.7
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Are available as a single gzipped patch at:

<http://users.bigpond.net.au/Peter-Williams/patch-2_6_7-combined-v1.0.gz>

or as a series of patches to be applied in sequence (for easier 
understanding) at:

<http://users.bigpond.net.au/Peter-Williams/patch-2_6_7-SPA-v1.0.gz> 
replaces the active and expired array with a single array and adds a 
promotion mechanism to avoid starvation,
<http://users.bigpond.net.au/Peter-Williams/patch-2_6_7-SPA_IAB-v1.0.gz> 
replaces the interactive priority bonus mechanism with a simpler one,
<http://users.bigpond.net.au/Peter-Williams/patch-2_6_7-SPA_TPB-v1.0.gz> 
adds a throughput bonus mechanism,
<http://users.bigpond.net.au/Peter-Williams/patch-2_6_7-SPA_TSTATS-v1.0.gz> 
adds reporting of scheduling statistics including time spent on the run 
queue waiting for CPU access (to enable analysis of scheduling 
behaviour), and
<http://users.bigpond.net.au/Peter-Williams/patch-2_6_7-SPA_CNTL-v1.0.gz> 
adds a directory /proc/sys/kernel/cpusched to /proc/sys and a number of 
attributes that can be used to control the scheduler as follows:

base_promotion_interval -- (milliseconds) controls the interval between 
successive promotions (is multiplied by the number of active tasks on 
the CPU in question) NB no promotion occurs if there are less than 2 
active tasks

time_slice -- (milliseconds) the size of the time slice (i.e. how long 
it will be allowed to hold the CPU before it is kicked off to allow 
other tasks a chance to run) that is allocated to a task when it becomes 
active or finishes a time slice.  (min is 1 millisec and max is 1 second).

max_ia_bonus -- (a value between 0 and 10) that determines the maximum 
interactive bonus that a task can acquire

ia_threshold  -- (parts per thousand) is the sleep to (sleep + on_cpu) 
ratio above which a task will have its interactive bonus increased 
asymptotically towards the maximum

cpu_hog_threshold  -- (parts per thousand) is the usage rate above which 
a task will be considered a CPU hog and start to lose interactive bonus 
points if it has any

max_tpt_bonus -- (a value between 0 and 9) that determines the maximum 
throughput bonus that tasks may be awarded

log_at_exit - (0 or 1) turns off/on the logging of tasks' scheduling 
statistics at exit.  This feature is useful for determining the 
scheduling characteristics of relatively short lived tasks that run as 
part of some larger job such as a kernel build where trying to get time 
series data is impractical.

A primitive Python/Glade/GTK GUI for manipulating these parameters is 
available at:

<http://users.bigpond.net.au/Peter-Williams/gcpuctl.tar.gz>

In addition, a version of Con Kolivas's staircase scheduler with 
promotion and scheduler statistics added is available as a single patch at:

<http://users.bigpond.net.au/Peter-Williams/patch-2_6_7-sc-combined-v1.0.gz>

and as multiple patches at:

<http://users.bigpond.net.au/Peter-Williams/patch-2_6_7-SPA-v1.0.gz>
<http://users.bigpond.net.au/Peter-Williams/patch-2_6_7-SPA_STAIRCASE-v1.0.gz>
<http://users.bigpond.net.au/Peter-Williams/patch-2_6_7-SPA_SC_TSTATS-v1.0.gz>

and a primitive GUI for manipulating its control parameters is at:

<http://users.bigpond.net.au/Peter-Williams/gcpuctl_sc.tar.gz>

Comments and feedback welcome,
Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce

