Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750837AbWBJAWv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750837AbWBJAWv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 19:22:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750873AbWBJAWv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 19:22:51 -0500
Received: from omta05ps.mx.bigpond.com ([144.140.83.195]:28894 "EHLO
	omta05ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1750870AbWBJAWu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 19:22:50 -0500
Message-ID: <43EBDCD7.7020005@bigpond.net.au>
Date: Fri, 10 Feb 2006 11:22:47 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Chris Han <xiphux@gmail.com>, Con Kolivas <kernel@kolivas.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Jake Moilanen <moilanen@austin.ibm.com>,
       Paolo Ornati <ornati@fastwebnet.it>, Ingo Molnar <mingo@elte.hu>
Subject: [ANNOUNCE][RFC] PlugSched-6.3 for  2.6.16-rc2 and 2.6.16-rc2-mm1
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta05ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Fri, 10 Feb 2006 00:22:47 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This version introduces a new scheduler, ingo_ll, which is a 
modification of ingosched that uses average latencies to determine the 
interactive bonuses awarded to tasks.  In effect, tasks only receive 
bonuses if they are necessary for the task to achieve satisfactory 
latencies.  For tasks waking from "interactive" sleeps their average 
interactive latency is compared to a fixed limit and if it exceeds this 
amount then their bonus is increased (if not it is compared to the same 
limit divided by 2^8 and if it is smaller than this the bonus is 
reduced).  The limit may be set via the sysfs file 
/sys/cpusched/ingo_ll/unacceptable_ia_latency.  A similar process is 
conducted for tasks waking from "non interactive" sleep except that the 
limit is adjusted to take account of the number of tasks running on the 
same CPU.

This version also continues the major gutting of the SPA based 
schedulers to reduce overhead.

A patch for 2.6.16-rc2 is available at:

<http://prdownloads.sourceforge.net/cpuse/plugsched-6.3-for-2.6.16-rc2.patch?download>

and a patch for 2.6.16-rc2-mm1 is available at:

<http://prdownloads.sourceforge.net/cpuse/plugsched-6.3-for-2.6.16-rc2-mm1.patch?download>

Very Brief Documentation:

You can select a default scheduler at kernel build time.  If you wish to
boot with a scheduler other than the default it can be selected at boot
time by adding:

cpusched=<scheduler>

to the boot command line where <scheduler> is one of: ingosched, 
ingo_ll, nicksched, staircase, spa_no_frills, spa_ws, spa_svr, spa_ebs 
or zaphod.  If you don't change the default when you build the kernel 
the default scheduler will be ingosched (which is the normal scheduler).

The scheduler in force on a running system can be determined by the
contents of:

/proc/scheduler

Control parameters for the scheduler can be read/set via files in:

/sys/cpusched/<scheduler>/

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
