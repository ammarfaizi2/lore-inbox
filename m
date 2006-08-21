Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932602AbWHUFXd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932602AbWHUFXd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 01:23:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932601AbWHUFXd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 01:23:33 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:34702 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S932602AbWHUFXc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 01:23:32 -0400
Message-ID: <44E942ED.9010502@cn.ibm.com>
Date: Mon, 21 Aug 2006 13:21:49 +0800
From: Yao Fei Zhu <walkinair@cn.ibm.com>
Reply-To: walkinair@cn.ibm.com
Organization: IBM
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: BUG: sleeping function called from invalid context at arch/powerpc/kernel/rtas.c:463
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, all

Online and offline cpus in 2.6.18-rc4/PPC64 will trigger Call Trace
like this,

[root@blade11 ~]# echo 0 > /sys/devices/system/cpu/cpu0/online
[root@blade11 ~]# dmesg -c
BUG: sleeping function called from invalid context at 
arch/powerpc/kernel/rtas.c:463
in_atomic():0, irqs_disabled():1
Call Trace:
[C0000000725EB9C0] [C00000000000FB70] .show_stack+0x68/0x1b0 (unreliable)
[C0000000725EBA60] [C000000000053EB4] .__might_sleep+0xd8/0xf4
[C0000000725EBAE0] [C00000000001D5D8] .rtas_busy_delay+0x20/0x5c
[C0000000725EBB70] [C00000000001DC00] .rtas_set_indicator+0x6c/0xcc
[C0000000725EBC10] [C000000000049130] .xics_migrate_irqs_away+0x6c/0x20c
[C0000000725EBCD0] [C000000000048EEC] .pSeries_cpu_disable+0x98/0xb4
[C0000000725EBD50] [C000000000029A24] .__cpu_disable+0x44/0x58
[C0000000725EBDC0] [C000000000082030] .take_cpu_down+0x10/0x38
[C0000000725EBE40] [C000000000090000] .do_stop+0x16c/0x20c
[C0000000725EBEE0] [C000000000078EBC] .kthread+0x128/0x178
[C0000000725EBF90] [C0000000000271DC] .kernel_thread+0x4c/0x68
cpu 0 (hwid 0) Ready to die...
[root@blade11 ~]# echo 1 > /sys/devices/system/cpu/cpu0/online
[root@blade11 ~]# dmesg -c
BUG: sleeping function called from invalid context at 
arch/powerpc/kernel/rtas.c:463
in_atomic():0, irqs_disabled():1
Call Trace:
[C000000000573BC0] [C00000000000FB70] .show_stack+0x68/0x1b0 (unreliable)
[C000000000573C60] [C000000000053EB4] .__might_sleep+0xd8/0xf4
[C000000000573CE0] [C00000000001D5D8] .rtas_busy_delay+0x20/0x5c
[C000000000573D70] [C00000000001DC00] .rtas_set_indicator+0x6c/0xcc
[C000000000573E10] [C000000000049320] .xics_setup_cpu+0x50/0x64
[C000000000573E80] [C0000000000486A8] .smp_xics_setup_cpu+0x2c/0x9c
[C000000000573F00] [C00000000002A4D4] .start_secondary+0x9c/0x168
[C000000000573F90] [C0000000000083BC] .start_secondary_prolog+0xc/0x10
Processor 0 found.


