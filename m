Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932227AbWEWO4X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932227AbWEWO4X (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 10:56:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932236AbWEWO4X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 10:56:23 -0400
Received: from odin2.bull.net ([129.184.85.11]:14316 "EHLO odin2.bull.net")
	by vger.kernel.org with ESMTP id S932227AbWEWO4W convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 10:56:22 -0400
From: "Serge Noiraud" <serge.noiraud@bull.net>
To: Daniel Walker <dwalker@mvista.com>
Subject: Re: RT patch + LTTng
Date: Tue, 23 May 2006 16:57:44 +0200
User-Agent: KMail/1.7.1
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       linux-kernel@vger.kernel.org
References: <200605221742.29566.Serge.Noiraud@bull.net> <1148393197.3535.85.camel@c-67-180-134-207.hsd1.ca.comcast.net>
In-Reply-To: <1148393197.3535.85.camel@c-67-180-134-207.hsd1.ca.comcast.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200605231657.45363.Serge.Noiraud@bull.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mardi 23 Mai 2006 16:06, Daniel Walker wrote/a écrit :
> On Mon, 2006-05-22 at 17:42 +0200, Serge Noiraud wrote:
> 
> > ltt_stat-7809  0Dnh3    0us : __trace_start_sched_wakeup (try_to_wake_up)
> > ltt_stat-7809  0Dnh3    0us : __trace_start_sched_wakeup <<...>-3> (0 0)
> 
> 
> Do you also have preempt and interrupt latency turned on ? In addition
> to wakeup latency ..
Here is all I configured :
...
CONFIG_PREEMPT_RT=y
CONFIG_PREEMPT=y
CONFIG_PREEMPT_SOFTIRQS=y
CONFIG_PREEMPT_HARDIRQS=y
CONFIG_PREEMPT_BKL=y
# CONFIG_CLASSIC_RCU is not set
CONFIG_PREEMPT_RCU=y
CONFIG_RCU_STATS=y
...
CONFIG_DEBUG_PREEMPT=y
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_PI_LIST=y
CONFIG_RT_MUTEX_TESTER=y
CONFIG_WAKEUP_TIMING=y
CONFIG_WAKEUP_LATENCY_HIST=y
CONFIG_PREEMPT_TRACE=y
CONFIG_CRITICAL_PREEMPT_TIMING=y
CONFIG_PREEMPT_OFF_HIST=y
CONFIG_CRITICAL_IRQSOFF_TIMING=y
CONFIG_INTERRUPT_OFF_HIST=y
CONFIG_CRITICAL_TIMING=y
CONFIG_DEBUG_TRACE_IRQFLAGS=y
CONFIG_LATENCY_TIMING=y
CONFIG_CRITICAL_LATENCY_HIST=y
CONFIG_LATENCY_HIST=y
CONFIG_LATENCY_TRACE=y
...

If you want to known what I have in :
/proc/latency_hist/preempt_off_latency and in /proc/latency_hist/interrupt_off_latency
I suppressed all lines with a zero at the end.
There are no infos in these files.

-sh-2.05b# more /proc/latency_hist/preempt_off_latency/CPU0 | grep -v "     0$"
#Minimum latency: 4294967295 microseconds.
#Average latency: 0 microseconds.
#Maximum latency: 0 microseconds.
#Total samples: 0
#There are 0 samples greater or equal than 10240 microseconds
#usecs           samples
-sh-2.05b# more /proc/latency_hist/preempt_off_latency/CPU1 | grep -v "     0$"
#Minimum latency: 4294967295 microseconds.
#Average latency: 0 microseconds.
#Maximum latency: 0 microseconds.
#Total samples: 0
#There are 0 samples greater or equal than 10240 microseconds
#usecs           samples
-sh-2.05b# more /proc/latency_hist/interrupt_off_latency/CPU0 | grep -v "    0$"
#Minimum latency: 4294967295 microseconds.
#Average latency: 0 microseconds.
#Maximum latency: 0 microseconds.
#Total samples: 0
#There are 0 samples greater or equal than 10240 microseconds
#usecs           samples
-sh-2.05b# more /proc/latency_hist/interrupt_off_latency/CPU1 | grep -v "    0$" 
#Minimum latency: 4294967295 microseconds.
#Average latency: 0 microseconds.
#Maximum latency: 0 microseconds.
#Total samples: 0
#There are 0 samples greater or equal than 10240 microseconds
#usecs           samples
-sh-2.05b#

> 
> Daniel 

-- 
Serge Noiraud
