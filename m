Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266824AbUHSRTX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266824AbUHSRTX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 13:19:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266830AbUHSRTX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 13:19:23 -0400
Received: from dsl081-100-231.den1.dsl.speakeasy.net ([64.81.100.231]:40833
	"EHLO hal9000.jaa.iki.fi") by vger.kernel.org with ESMTP
	id S266824AbUHSRTU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 13:19:20 -0400
Date: Thu, 19 Aug 2004 11:19:18 -0600
From: Jani Averbach <jaa@jaa.iki.fi>
To: linux-kernel@vger.kernel.org
Subject: 2.6.x: Kernel Oops with netconsole + serial console
Message-ID: <20040819171918.GC5050@jaa.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-PGP-Key: http://www.cc.jyu.fi/~jaa/averbach_jani_pub_asc.txt
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[please Cc: me]

Hi,

I have tried to setup both netconsole and serial console for
unattended server (I need a serial console for booting and a netconsole for
logging).

However, 2.6.6 and 2.6.8.1 both will oops if both consoles are
configured and in use. Disabling one of them will help, and system
boots up normally.

This is dual amd64, with two BCM5704 NIC.

<1>Unable to handle kernel paging request at ffffffffffffffff RIP:
<ffffffff802f0bd2>{ip_rcv+50}PML4 103027 PGD 2c1c067 PMD 0
Oops: 0000 [1] SMP
CPU 0
Pid: 1, comm: swapper Not tainted 2.6.6
RIP: 0010:[<ffffffff802f0bd2>] <ffffffff802f0bd2>{ip_rcv+50}
RSP: 0000:ffffffff80494cb8  EFLAGS: 00010293
RAX: 0000000000000000 RBX: 000001007fbcf7c0 RCX: ffffffff804147e0
RDX: ffffffffffffffff RSI: 0000010002e80000 RDI: 000001007fbcf7c0
RBP: 000001007fbcf7c0 R08: 000001007fbcf7c0 R09: 000001007fb53212
R10: 0000000000000000 R11: 20005c1110a4e764 R12: 0000010002e80000
R13: 0000000000000008 R14: 000001007fbcf7c0 R15: 0000000000000042
FS:  0000000000000000(0000) GS:ffffffff80490dc0(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: ffffffffffffffff CR3: 0000000000101000 CR4: 00000000000006e0
Process swapper (pid: 1, stackpage=1007ff900c0)
Stack: ffffffff8013b7c1 0000000000000206 0000000000000206 0000000000000296
       ffffffff80485260 000001007fbcf7c0 ffffffff80485280 ffffffff802dd9dd
       ffffffff80113704 0000010002e80380
Call Trace:<IRQ> <ffffffff8013b7c1>{do_timer+49} <ffffffff802dd9dd>{netif_receive_skb+413}
       <ffffffff80113704>{end_8259A_irq+100} <ffffffff80285c79>{tg3_rx+841}
       <ffffffff80285e22>{tg3_poll+162} <ffffffff802ddbc4>{net_rx_action+132}
       <ffffffff801373d3>{__do_softirq+83} <ffffffff80137465>{do_softirq+53}
       <ffffffff801119ad>{do_IRQ+317} <ffffffff8010ef9d>{ret_from_intr+0}
        <EOI> <ffffffff80267807>{serial_in+71} <ffffffff80269ac2>{serial8250_console_write+130}
       <ffffffff8013387c>{__call_console_drivers+76} <ffffffff801339d7>{call_console_drivers+231}
       <ffffffff80133d72>{release_console_sem+82} <ffffffff80133c9c>{printk+508}
       <ffffffff8014ea75>{__alloc_pages+165} <ffffffff804aac91>{get_boot_pages+209}
       <ffffffff804b5e4b>{ip_rt_init+283} <ffffffff804b6105>{ip_init+21}
       <ffffffff804b6b92>{inet_init+402} <ffffffff8049b8fa>{do_initcalls+106}
       <ffffffff8010b0fc>{init+92} <ffffffff8010f547>{child_rip+8}
       <ffffffff8010b0a0>{init+0} <ffffffff8010f53f>{child_rip+0}


Code: 48 8b 04 c2 48 ff 00 8b 87 dc 00 00 00 ff c8 74 2d be 20 00
RIP <ffffffff802f0bd2>{ip_rcv+50} RSP <ffffffff80494cb8>
CR2: ffffffffffffffff
 <0>Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing

BR, Jani

-- 
Jani Averbach

