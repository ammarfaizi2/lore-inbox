Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265960AbUHIEiV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265960AbUHIEiV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 00:38:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265971AbUHIEiV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 00:38:21 -0400
Received: from gizmo08bw.bigpond.com ([144.140.70.18]:44478 "HELO
	gizmo08bw.bigpond.com") by vger.kernel.org with SMTP
	id S265960AbUHIEiS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 00:38:18 -0400
Message-ID: <4116FFB3.8090902@bigpond.net.au>
Date: Mon, 09 Aug 2004 14:38:11 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Michal Kaczmarski <fallow@op.pl>
Subject: [PATCH] V-4.0 Single Priority Array O(1) CPU Scheduler Evaluation
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Version 4.0 of the various single priority array scheduler patches for 
2.6.7 and 2.6.8-rc3 kernels are now available for evaluation.

This version is a fairly major rationalization and simplification of the 
code with a view to reducing overhead and addressing wli's reservations 
with respect to the promotion mechanism.

1. [ZAPHOD] My proposed replacement scheduler which offers runtime 
selectable choice between a priority based or entitlement based O(1) 
scheduler with active/expired arrays replaced by  a single array and an 
O(1) promotion mechanism plus scheduling statistics with new simplified 
interactive bonus mechanism and throughput bonus mechanism:

2.6.7
<http://prdownloads.sourceforge.net/cpuse/patch-2.6.7-spa_zaphod_FULL-v4.0?download>
2.6.8-rc3
<http://prdownloads.sourceforge.net/cpuse/patch-2.6.8-rc3-spa_zaphod_FULL-v4.0?download>

The following table of hackbench results for various configurations (IAB 
  column is the maximum allowed interactive bonus and TPB is the maximum 
allowed throughput bonus) illustrates this scheduler's performance 
compared to the normal O(1) scheduler.

Kernel Mode IAB TPB  10 groups           100 groups
------------------------------------------------------------
vanilla              1.583(100.0%, 2.2%) 16.740(100.0%, 1.5%)
zaphod  "eb" 10   5  1.612(101.8%, 1.0%) 16.422( 98.1%, 1.4%)
zaphod  "pb" 10   5  1.570( 99.1%, 0.8%) 16.100( 96.1%, 0.7%)
zaphod  "eb"  0   0  1.575( 99.5%, 0.1%) 15.992( 95.5%, 1.0%)
zaphod  "pb"  0   0  1.602(101.2%, 5.0%) 15.983( 95.4%, 0.1%)
zaphod  "eb" 10   0  1.612(101.8%, 0.1%) 16.142( 96.4%, 0.3%)
zaphod  "pb" 10   0  1.584(100.0%, 0.1%) 16.014( 95.6%, 0.01%)
zaphod  "eb"  0   5  1.609(101.6%, 0.4%) 16.487( 98.4%, 0.9%)
zaphod  "pb"  0   5  1.606(101.4%, 0.5%) 16.367( 97.7%, 1.3%)

The numbers are the results of averaging over 10 runs with the numbers 
in brackets being the size of the value compared to that for the vanilla 
kernel and the standard deviation of the value as a percentage.  The 
results for 10 groups show there's no significant difference between the 
schedulers with the differences being mostly less than half a standard 
deviation.  However, for 100 groups several of the results have 
differences greater than 1 standard deviation.

Other scheduling parameters were left with their default values but 
further experimentation will be done to determine their efficacy.

2. Slightly modified version of Con Kolivas's staircase O(1) scheduler
with active/expired arrays replaced by a single array and an O(1)
promotion mechanism:

2.6.7
<http://prdownloads.sourceforge.net/cpuse/patch-2.6.7-spa_sc_FULL-v4.0?download>
2.6.8-rc3
<http://prdownloads.sourceforge.net/cpuse/patch-2.6.8-rc3-spa_sc_FULL-v4.0?download>

3. [HYDRA] Runtime selection between staircase, priority based and
entitlement based O(1) schedulers:

2.6.7
<http://prdownloads.sourceforge.net/cpuse/patch-2.6.7-spa_hydra_FULL-v4.0?download>
2.6.8-rc3
<http://prdownloads.sourceforge.net/cpuse/patch-2.6.8-rc3-spa_hydra_FULL-v4.0?download>

Other schedulers are also available from
<https://sourceforge.net/projects/cpuse/>

So as not to interfere with the staircase scheduler's evaluation I do
not propose to release patches for rc3-mm kernels unless requested.

-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce


