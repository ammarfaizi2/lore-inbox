Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751074AbVHaUDm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751074AbVHaUDm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 16:03:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751078AbVHaUDm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 16:03:42 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:19709 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S1751074AbVHaUDl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 16:03:41 -0400
Subject: PREEMPT_RT with e1000
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: mingo@elte.hu
Cc: rostedt@goodmis.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: MontaVista
Date: Wed, 31 Aug 2005 13:03:22 -0700
Message-Id: <1125518602.15034.3.camel@dhcp153.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It looks like Gigabit Ethernet is still having some problems. This is
with the e1000 driver. If I remove all the qdisc_restart changes it
starts to work the warning below goes away, but it has smp_processor_id
warnings.

Daniel


BUG: softirq-net-tx/:5, possible softlockup detected on CPU#0!

Call Trace: <IRQ> <ffffffff8015b92a>{softlockup_detected+56} <ffffffff8015b9d7>{softlockup_tick+164}
       <ffffffff80119a4b>{smp_apic_timer_interrupt+55} <ffffffff8010e6a4>{apic_timer_interrupt+132}
        <EOI> <ffffffff80516f9b>{__down_mutex+694} <ffffffff80482e4d>{qdisc_restart+369}
       <ffffffff80476198>{net_tx_action+200} <ffffffff8013a802>{ksoftirqd+231}
       <ffffffff8013a71b>{ksoftirqd+0} <ffffffff8014a769>{kthread+218}
       <ffffffff8010e9f6>{child_rip+8} <ffffffff8014a68f>{kthread+0}
       <ffffffff8010e9ee>{child_rip+0}
---------------------------
| preempt count: 00010000 ]
| 0-level deep critical section nesting:
----------------------------------------


