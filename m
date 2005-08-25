Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965023AbVHYXaB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965023AbVHYXaB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 19:30:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965024AbVHYXaB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 19:30:01 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:47349 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S965023AbVHYXaA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 19:30:00 -0400
Subject: Re: 2.6.13-rc7-rt1
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050825062651.GA26781@elte.hu>
References: <20050825062651.GA26781@elte.hu>
Content-Type: text/plain
Organization: MontaVista
Date: Thu, 25 Aug 2005 16:29:56 -0700
Message-Id: <1125012596.14592.12.camel@dhcp153.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Devastating latency on a 3Ghz xeon .. Maybe the raw_spinlock in the
timer base is creating a unbounded latency?

Daniel

( softirq-timer/1-13   |#1): new 66088 us maximum-latency critical section.
 => started at timestamp 1857957769: <__down_mutex+0x5f/0x295>
 =>   ended at timestamp 1858023857: <_raw_spin_unlock_irq+0x16/0x39>

Call Trace:<ffffffff80144816>{check_critical_timing+491} <ffffffff8047732a>{rt_secret_rebuild+0}
       <ffffffff80144adb>{trace_irqs_on+100} <ffffffff80508da5>{_raw_spin_unlock_irq+22}
       <ffffffff8013303b>{run_timer_softirq+1916} <ffffffff8012f0d6>{ksoftirqd+241}
       <ffffffff8012efe5>{ksoftirqd+0} <ffffffff8013f961>{kthread+218}
       <ffffffff8010e9c2>{child_rip+8} <ffffffff8013f887>{kthread+0}
       <ffffffff8010e9ba>{child_rip+0}
---------------------------
| preempt count: 00000000 ]
| 0-level deep critical section nesting:
----------------------------------------

 =>   dump-end timestamp 1858101914



