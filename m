Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751182AbWDMXFQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751182AbWDMXFQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 19:05:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751185AbWDMXFQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 19:05:16 -0400
Received: from mailgw.aecom.yu.edu ([129.98.1.16]:56295 "EHLO
	mailgw.aecom.yu.edu") by vger.kernel.org with ESMTP
	id S1751182AbWDMXFO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 19:05:14 -0400
Mime-Version: 1.0
Message-Id: <a06230907c06487c9cfdf@[129.98.90.227]>
Date: Thu, 13 Apr 2006 19:05:16 -0400
To: linux-kernel@vger.kernel.org
From: Maurice Volaski <mvolaski@aecom.yu.edu>
Subject: Bonding driver appears to call a sleeping function from an
 invalid context in 2.6.17-rc1
Cc: bonding-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At startup, the bonding driver appears to call a sleeping function 
from an invalid context in 2.6.17-rc1.

Computer is 64-bit (AMD64).


[  141.736492] BUG: sleeping function called from invalid context at 
include/linux/rwsem.h:43
[  141.736494] in_atomic():1, irqs_disabled():0
[  141.736497]
[  141.736498] Call Trace: <IRQ> <ffffffff80225312>{__might_sleep+190}
[  141.736513]        <ffffffff8023abcb>{blocking_notifier_call_chain+36}
[  141.736519]        <ffffffff803f13a3>{dev_set_mac_address+85} 
<ffffffff8809d915>{:bonding:alb_set_slave_mac_addr+71}
[  141.736540] 
<ffffffff8809d9d6>{:bonding:alb_swap_mac_addr+149} 
<ffffffff8809e886>{:bonding:bond_alb_handle_active_change+182}
[  141.736561]        <ffffffff88096fd6>{:bonding:bond_change_active_slave+522}
[  141.736571]        <ffffffff88097852>{:bonding:bond_select_active_slave+177}
[  141.736580] 
<ffffffff88097c90>{:bonding:bond_mii_monitor+1039} 
<ffffffff88097881>{:bonding:bond_mii_monitor+0}
[  141.736598]        <ffffffff80236bb7>{run_timer_softirq+382} 
<ffffffff80232f35>{__do_softirq+85}
[  141.736607]        <ffffffff8020ac2a>{call_softirq+30} 
<ffffffff8020bfb1>{do_softirq+53}
[  141.736615]        <ffffffff8023307a>{irq_exit+72} 
<ffffffff80217180>{smp_apic_timer_interrupt+75}
[  141.736623]        <ffffffff80207c8d>{default_idle+0} 
<ffffffff8020a584>{apic_timer_interrupt+132} <EOI>
[  141.736630]        <ffffffff80207c8d>{default_idle+0} 
<ffffffff80207cbc>{default_idle+47}
[  141.736637]        <ffffffff80207e92>{cpu_idle+156} 
<ffffffff80216031>{start_secondary+1134}
[  141.751070] BUG: warning at kernel/mutex.c:281/__mutex_trylock_slowpath()
[  141.751229]
[  141.751230] Call Trace: <IRQ> <ffffffff80243494>{mutex_trylock+134}
[  141.751581]        <ffffffff803f877f>{rtnl_trylock+16} 
<ffffffff80429f3e>{inetdev_event+35}
[  141.751966]        <ffffffff80403035>{rt_cache_flush+168} 
<ffffffff80450b7f>{notifier_call_chain+37}
[  141.752356]        <ffffffff8023abe3>{blocking_notifier_call_chain+60}
[  141.752587]        <ffffffff803f13a3>{dev_set_mac_address+85} 
<ffffffff8809d915>{:bonding:alb_set_slave_mac_addr+71}
[  141.752988] 
<ffffffff8809d9d6>{:bonding:alb_swap_mac_addr+149} 
<ffffffff8809e886>{:bonding:bond_alb_handle_active_change+182}
[  141.753399]        <ffffffff88096fd6>{:bonding:bond_change_active_slave+522}
[  141.753635]        <ffffffff88097852>{:bonding:bond_select_active_slave+177}
[  141.753872] 
<ffffffff88097c90>{:bonding:bond_mii_monitor+1039} 
<ffffffff88097881>{:bonding:bond_mii_monitor+0}
[  141.754275]        <ffffffff80236bb7>{run_timer_softirq+382} 
<ffffffff80232f35>{__do_softirq+85}
[  141.754661]        <ffffffff8020ac2a>{call_softirq+30} 
<ffffffff8020bfb1>{do_softirq+53}
[  141.761298]        <ffffffff8023307a>{irq_exit+72} 
<ffffffff80217180>{smp_apic_timer_interrupt+75}
[  141.761683]        <ffffffff80207c8d>{default_idle+0} 
<ffffffff8020a584>{apic_timer_interrupt+132} <EOI>
[  141.762127]        <ffffffff80207c8d>{default_idle+0} 
<ffffffff80207cbc>{default_idle+47}
[  141.762508]        <ffffffff80207e92>{cpu_idle+156} 
<ffffffff80216031>{start_secondary+1134}
[  141.762985] RTNL: assertion failed at net/ipv4/devinet.c (987)
[  141.763104]
[  141.763104] Call Trace: <IRQ> <ffffffff80429f66>{inetdev_event+75}
[  141.763451]        <ffffffff80403035>{rt_cache_flush+168} 
<ffffffff80450b7f>{notifier_call_chain+37}
[  141.763838]        <ffffffff8023abe3>{blocking_notifier_call_chain+60}
[  141.764067]        <ffffffff803f13a3>{dev_set_mac_address+85} 
<ffffffff8809d915>{:bonding:alb_set_slave_mac_addr+71}
[  141.764466] 
<ffffffff8809d9d6>{:bonding:alb_swap_mac_addr+149} 
<ffffffff8809e886>{:bonding:bond_alb_handle_active_change+182}
[  141.764876]        <ffffffff88096fd6>{:bonding:bond_change_active_slave+522}
[  141.765112]        <ffffffff88097852>{:bonding:bond_select_active_slave+177}
[  141.765349] 
<ffffffff88097c90>{:bonding:bond_mii_monitor+1039} 
<ffffffff88097881>{:bonding:bond_mii_monitor+0}
[  141.765751]        <ffffffff80236bb7>{run_timer_softirq+382} 
<ffffffff80232f35>{__do_softirq+85}
[  141.766136]        <ffffffff8020ac2a>{call_softirq+30} 
<ffffffff8020bfb1>{do_softirq+53}
[  141.766516]        <ffffffff8023307a>{irq_exit+72} 
<ffffffff80217180>{smp_apic_timer_interrupt+75}
[  141.766901]        <ffffffff80207c8d>{default_idle+0} 
<ffffffff8020a584>{apic_timer_interrupt+132} <EOI>
[  141.767348]        <ffffffff80207c8d>{default_idle+0} 
<ffffffff80207cbc>{default_idle+47}
[  141.767730]        <ffffffff80207e92>{cpu_idle+156} 
<ffffffff80216031>{start_secondary+1134}
[  141.782517] RTNL: assertion failed at net/ipv4/devinet.c (987)
[  141.782632]
[  141.782632] Call Trace: <IRQ> <ffffffff80429f66>{inetdev_event+75}
[  141.782984]        <ffffffff80403035>{rt_cache_flush+168} 
<ffffffff80450b7f>{notifier_call_chain+37}
[  141.783380]        <ffffffff8023abe3>{blocking_notifier_call_chain+60}
[  141.783610]        <ffffffff803f13a3>{dev_set_mac_address+85} 
<ffffffff8809d915>{:bonding:alb_set_slave_mac_addr+71}
[  141.784011] 
<ffffffff8809d9e9>{:bonding:alb_swap_mac_addr+168} 
<ffffffff8809e886>{:bonding:bond_alb_handle_active_change+182}
[  141.784422]        <ffffffff88096fd6>{:bonding:bond_change_active_slave+522}
[  141.784659]        <ffffffff88097852>{:bonding:bond_select_active_slave+177}
[  141.784896] 
<ffffffff88097c90>{:bonding:bond_mii_monitor+1039} 
<ffffffff88097881>{:bonding:bond_mii_monitor+0}
[  141.785298]        <ffffffff80236bb7>{run_timer_softirq+382} 
<ffffffff80232f35>{__do_softirq+85}
[  141.785685]        <ffffffff8020ac2a>{call_softirq+30} 
<ffffffff8020bfb1>{do_softirq+53}
[  141.786067]        <ffffffff8023307a>{irq_exit+72} 
<ffffffff80217180>{smp_apic_timer_interrupt+75}
[  141.786453]        <ffffffff80207c8d>{default_idle+0} 
<ffffffff8020a584>{apic_timer_interrupt+132} <EOI>
[  141.786898]        <ffffffff80207c8d>{default_idle+0} 
<ffffffff80207cbc>{default_idle+47}
[  141.787286]        <ffffffff80207e92>{cpu_idle+156} 
<ffffffff80216031>{start_secondary+1134}
[  141.787808] bonding: bond0: first active interface up!

-- 

Maurice Volaski, mvolaski@aecom.yu.edu
Computing Support, Rose F. Kennedy Center
Albert Einstein College of Medicine of Yeshiva University
