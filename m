Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261818AbULGOif@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261818AbULGOif (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 09:38:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261819AbULGOif
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 09:38:35 -0500
Received: from apollo.nbase.co.il ([194.90.137.2]:46343 "EHLO
	apollo.nbase.co.il") by vger.kernel.org with ESMTP id S261818AbULGOib
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 09:38:31 -0500
Message-ID: <41B5C038.1090501@mrv.com>
Date: Tue, 07 Dec 2004 16:37:44 +0200
From: emann@mrv.com (Eran Mann)
User-Agent: Mozilla Thunderbird 1.0RC1 (X11/20041201)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm2-V0.7.32-2
References: <OFD07DEEA4.7C243C76-ON86256F5F.007976EC@raytheon.com> <20041204175636.GA3115@elte.hu>
In-Reply-To: <20041204175636.GA3115@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
...

> i've implemented the 'tracing follows the task' logic in the -32-2
> patch, available from the usual place:
> 
>     http://redhat.com/~mingo/realtime-preempt/
> 
> i've also added a CPU# field and i've reworked latency_trace format, to
> make it more readable. Whenever preempt_wakeup_timing is enabled,
> user-tracing will follow the traced task, if it's disabled then tracing
> will stay on the CPU. No other changes.
...
> 	Ingo

On my machine, disabling CONFIG_LATENCY_TRACE causes the kernel to stop 
reporting preempt latencies. After
# echo 1 > /proc/sys/kernel/preempt_max_latency

/proc/sys/kernel/preempt_max_latency always shows 1 no matter what load 
is on the machine. I´ve seen this behavior since the first time I tried 
to disable CONFIG_LATENCY_TRACE, around V0.7.31.something.

Below is the exact diff between the 2 configs (the one that shows 
latencies and the one that doesn´t). Note that the only intentional 
change is turning off CONFIG_LATENCY_TRACE.
=======================================================
--- /tmp/config-2.6.10-rc2-mm3-V0.7.32-2.lat    2004-12-07 
16:25:03.000000000 +0200
+++ /tmp/config-2.6.10-rc2-mm3-V0.7.32-2.no_lat 2004-12-07 
11:06:19.000000000 +0200
@@ -1,7 +1,7 @@
  #
  # Automatically generated make config: don't edit
  # Linux kernel version: 2.6.10-rc2-mm3-V0.7.32-2
-# Tue Dec  7 11:07:07 2004
+# Mon Dec  6 20:24:09 2004
  #
  CONFIG_X86=y
  CONFIG_MMU=y
@@ -137,6 +137,7 @@
  CONFIG_MTRR=y
  # CONFIG_EFI is not set
  CONFIG_HAVE_DEC_LOCK=y
+# CONFIG_REGPARM is not set

  #
  # Performance-monitoring counters support
@@ -1711,12 +1712,12 @@
  CONFIG_CRITICAL_IRQSOFF_TIMING=y
  CONFIG_CRITICAL_TIMING=y
  CONFIG_LATENCY_TIMING=y
-CONFIG_LATENCY_TRACE=y
-CONFIG_MCOUNT=y
+# CONFIG_LATENCY_TRACE is not set
  # CONFIG_RT_DEADLOCK_DETECT is not set
  # CONFIG_DEBUG_KOBJECT is not set
  CONFIG_DEBUG_BUGVERBOSE=y
  # CONFIG_DEBUG_INFO is not set
+CONFIG_USE_FRAME_POINTER=y
  CONFIG_FRAME_POINTER=y
  CONFIG_EARLY_PRINTK=y
  # CONFIG_DEBUG_STACKOVERFLOW is not set
=======================================================
-- 
Eran Mann

