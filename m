Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266005AbUHTCYT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266005AbUHTCYT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 22:24:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266006AbUHTCYT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 22:24:19 -0400
Received: from gizmo08bw.bigpond.com ([144.140.70.18]:45991 "HELO
	gizmo08bw.bigpond.com") by vger.kernel.org with SMTP
	id S266005AbUHTCXn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 22:23:43 -0400
Message-ID: <412560AB.3070304@bigpond.net.au>
Date: Fri, 20 Aug 2004 12:23:39 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Michal Kaczmarski <fallow@op.pl>, spaminos-ker <spaminos-ker@yahoo.com>
Subject: [PATCH] V-5.0 Single Priority Array O(1) CPU Scheduler Evaluation
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Version 5.0 of the various single priority array scheduler patches for
the 2.6.8.1 kernel are now available for evaluation.

This version adds NEW FEATURES to ZAPHOD and HYDRA schedulers.

1. [ZAPHOD] My proposed replacement scheduler which offers runtime
selectable choice between a priority based or entitlement based O(1)
scheduler with active/expired arrays replaced by  a single array and an
O(1) promotion mechanism plus scheduling statistics with new simplified
interactive bonus mechanism and throughput bonus mechanism.  This 
version adds hard (/proc/<TGIG>/task/<PID>/cpu_rate_hard_cap) and soft 
(/proc/<TGIG>/task/<PID>/cpu_rate_cap) CPU rate caps (in parts per 
thousand of a CPU) and an unprivileged RT mechanism (which was inspired 
by Con's SCHED_ISO patchs and will treat tasks that try to change policy 
to real time but fail due to lack of privilege as pseudo real time tasks 
and run them at MAX_RT_PRIO provided that their CPU usage rate is less 
than the threshold specified in 
/proc/sys/kernel/cpusched/unpriv_rt_threshold (in parts per thousand -- 
default 10 i.e. 1% of a CPU). Obviously setting this value to zero will 
disable the mechanism completely.). Tasks that have a soft cap of zero 
are treated much the same as Con's SCHED_BATCH tasks and will have their 
time slices multiplied by the value in 
/proc/sys/kernel/cpusched/bgnd_time_slice_multiplier (default 1):

<http://prdownloads.sourceforge.net/cpuse/patch-2.6.8.1-spa_zaphod_FULL-v5.0?download>

2. [SC] Slightly modified version of Con Kolivas's staircase O(1)
(version 7.I) scheduler (includes SCHED_ISO and SCHED_BATCH 
modifications) with active/expired arrays replaced by a single
array and an O(1) promotion mechanism:

<http://prdownloads.sourceforge.net/cpuse/patch-2.6.8.1-spa_hydra_FULL-v5.0?download>

3. [HYDRA] Runtime selection between staircase, priority based and
entitlement based O(1) schedulers:

<http://prdownloads.sourceforge.net/cpuse/patch-2.6.8.1-spa_sc_FULL-v5.0?download>

Other schedulers are also available from
<https://sourceforge.net/projects/cpuse/>

Your comments and feedback are requested.

Thanks
Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce

