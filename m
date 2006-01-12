Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030461AbWALQd7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030461AbWALQd7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 11:33:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030470AbWALQd7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 11:33:59 -0500
Received: from main.gmane.org ([80.91.229.2]:28393 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1030461AbWALQd6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 11:33:58 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Orion Poplawski <orion@cora.nwra.com>
Subject: Help with machine check exception
Date: Thu, 12 Jan 2006 09:30:17 -0700
Message-ID: <dq606p$776$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: inferno.cora.nwra.com
User-Agent: Mail/News 1.5 (X11/20060103)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can someone help determine the problem here?  Does it definitely point 
to a bad CPU, or possibly a bad motherboard?

Thanks!

CPU 0: Machine Check Exception:                4 Bank 4: b200000000070f0f
TSC 184fcd0553e4
Kernel panic - not syncing: Machine check

Call Trace: <#MC> <ffffffff80134831>{panic+133} 
<ffffffff8034329c>{_spin_trylock+9}
        <ffffffff8010f4d3>{oops_begin+90} <ffffffff801149f8>{print_mce+136}
        <ffffffff80114abf>{mcheck_timer+0} 
<ffffffff801150cd>{do_machine_check+752}
        <ffffffff8010ee6f>{machine_check+127}  <EOE>
  NMI Watchdog detected LOCKUP on CPU 0
CPU 0
Modules linked in: nfs lockd nfs_acl ipv6 parport_pc lp parport autofs4 
sunrpc xfs export
fs dm_mod video button battery ac ohci_hcd i2c_amd8111 i2c_amd756 
i2c_core shpchp eepro10
0 e100 mii tg3 floppy ext3 jbd
Pid: 14041, comm: srt Tainted: G   M  2.6.14-1.1656_FC4smp #1
RIP: 0010:[<ffffffff80118242>] <ffffffff80118242>{__smp_call_function+107}
RSP: 0000:ffffffff804a8358  EFLAGS: 00000002
RAX: 0000000000000002 RBX: 0000000000000003 RCX: 0000ffff0000ffff
RDX: 0000000000000004 RSI: 0000000000000020 RDI: ffffffff80523be0
RBP: 0000000000000000 R08: ffff8100826b71e0 R09: 0000000000000000
R10: 0000000000000000 R11: ffffffff8011abcb R12: ffffffff80117f0b
R13: 0000000000000000 R14: ffffffff80360d29 R15: 0000000000000001
FS:  00002aaaaae8ad00(0000) GS:ffffffff80518000(0000) knlGS:00000000f7fab6c0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fffffc07000 CR3: 00000000c2f42000 CR4: 00000000000006e0
Process srt (pid: 14041, threadinfo ffff8100bd0ba000, task ffff8100822000c0)
Stack: ffffffff80117f0b 0000000000000000 0000000000000002 0000000000000000
        0000000000014f00 0000000000000001 0000000000000000 0000000000000000
        0000184fcd054eab ffffffff801182a0
Call Trace: <#MC> <ffffffff80117f0b>{smp_really_stop_cpu+0} 
<ffffffff801182a0>{smp_send_s
top+43}
        <ffffffff8013483d>{panic+145} <ffffffff8034329c>{_spin_trylock+9}
        <ffffffff8010f4d3>{oops_begin+90} <ffffffff801149f8>{print_mce+136}
        <ffffffff80114abf>{mcheck_timer+0} 
<ffffffff801150cd>{do_machine_check+752}
        <ffffffff8010ee6f>{machine_check+127}  <EOE>

Code: 8b 44 24 10 39 c3 75 f6 85 ed 75 14 66 90 eb 18 f3 90 8b 44
console shuts up ...
  <3>Debug: sleeping function called from invalid context at 
include/linux/rwsem.h:43
in_atomic():1, irqs_disabled():1

Call Trace: <NMI> <ffffffff8013603a>{profile_task_exit+21} 
<ffffffff801371f8>{do_exit+34}
        <ffffffff8025456d>{do_unblank_screen+40} 
<ffffffff8010f593>{bad_intr+0}
        <ffffffff80118ed0>{nmi_watchdog_tick+242} 
<ffffffff8010f835>{default_do_nmi+137}
        <ffffffff80117f0b>{smp_really_stop_cpu+0} 
<ffffffff80118ff9>{do_nmi+69}
        <ffffffff8010eb97>{nmi+127} 
<ffffffff80117f0b>{smp_really_stop_cpu+0}
        <ffffffff8011abcb>{flat_send_IPI_mask+0} 
<ffffffff80118242>{__smp_call_function+10
7}
         <EOE>  <#MC> <ffffffff80117f0b>{smp_really_stop_cpu+0}
        <ffffffff801182a0>{smp_send_stop+43} <ffffffff8013483d>{panic+145}
        <ffffffff8034329c>{_spin_trylock+9} 
<ffffffff8010f4d3>{oops_begin+90}
        <ffffffff801149f8>{print_mce+136} <ffffffff80114abf>{mcheck_timer+0}
        <ffffffff801150cd>{do_machine_check+752} 
<ffffffff8010ee6f>{machine_check+127}
         <EOE>
APIC error on CPU0: 00(08)
Kernel panic - not syncing: Aiee, killing interrupt handler!
APIC error on CPU0: 08(08)
APIC error on CPU0: 08(08)

Call Trace:<7>APIC error on CPU0: 08(08)
APIC error on CPU0: 08(08)
  <NMI> <7>APIC error on CPU0: 08(08)
<ffffffff80134831>{panic+133}<7>APIC error on CPU0: 08(08)
APIC error on CPU0: 08(08)
APIC error on CPU0: 08(08)
  <ffffffff8034334a>{_spin_unlock_irq+14}<7>APIC error on CPU0: 08(08)
APIC error on CPU0: 08(08)
APIC error on CPU0: 08(08)
APIC error on CPU0: 08(08)

        <7>APIC error on CPU0: 08(08)
<ffffffff80342cd1>{__down_read+50}<7>APIC error on CPU0: 08(08)
APIC error on CPU0: 08(08)
APIC error on CPU0: 08(08)
  <7>APIC error on CPU0: 08(08)
<ffffffff803432e8>{_spin_lock_irqsave+9}<7>APIC error on CPU0: 08(08)
APIC error on CPU0: 08(08)
APIC error on CPU0: 08(08)
APIC error on CPU0: 08(08)

        <7>APIC error on CPU0: 08(08)
<ffffffff801fde91>{__up_read+19}<7>APIC error on CPU0: 08(08)
APIC error on CPU0: 08(08)
APIC error on CPU0: 08(08)
  <ffffffff80137255>{do_exit+127}<7>APIC error on CPU0: 08(08)
APIC error on CPU0: 08(08)
APIC error on CPU0: 08(08)
APIC error on CPU0: 08(08)

        <ffffffff8025456d>{do_unblank_screen+40}<7>APIC error on CPU0: 
08(08)
APIC error on CPU0: 08(08)
APIC error on CPU0: 08(08)
APIC error on CPU0: 08(08)
  <ffffffff8010f593>{bad_intr+0}<7>APIC error on CPU0: 08(08)
APIC error on CPU0: 08(08)
APIC error on CPU0: 08(08)
APIC error on CPU0: 08(08)

        <ffffffff80118ed0>{nmi_watchdog_tick+242}<7>APIC error on CPU0: 
08(08)
  <ffffffff8010f835>{default_do_nmi+137}<7>APIC error on CPU0: 08(08)
APIC error on CPU0: 08(08)
APIC error on CPU0: 08(08)
APIC error on CPU0: 08(08)

        <7>APIC error on CPU0: 08(08)
<ffffffff80117f0b>{smp_really_stop_cpu+0}<7>APIC error on CPU0: 08(08)
APIC error on CPU0: 08(08)
APIC error on CPU0: 08(08)
APIC error on CPU0: 08(08)
  <ffffffff80118ff9>{do_nmi+69}<7>APIC error on CPU0: 08(08)
APIC error on CPU0: 08(08)
APIC error on CPU0: 08(08)

        <7>APIC error on CPU0: 08(08)
<ffffffff8010eb97>{nmi+127}<7>APIC error on CPU0: 08(08)
APIC error on CPU0: 08(08)
APIC error on CPU0: 08(08)
  <ffffffff80117f0b>{smp_really_stop_cpu+0}<7>APIC error on CPU0: 08(08)
APIC error on CPU0: 08(08)
APIC error on CPU0: 08(08)
APIC error on CPU0: 08(08)

        <7>APIC error on CPU0: 08(08)
APIC error on CPU0: 08(08)
<ffffffff8011abcb>{flat_send_IPI_mask+0}<7>APIC error on CPU0: 08(08)
APIC error on CPU0: 08(08)
APIC error on CPU0: 08(08)
APIC error on CPU0: 08(08)
  <ffffffff80118242>{__smp_call_function+107}<7>APIC error on CPU0: 08(08)
APIC error on CPU0: 08(08)
APIC error on CPU0: 08(08)
APIC error on CPU0: 08(08)

        <7>APIC error on CPU0: 08(08)
  <EOE> <7>APIC error on CPU0: 08(08)
  <#MC> <7>APIC error on CPU0: 08(08)
<ffffffff80117f0b>{smp_really_stop_cpu+0}<7>APIC error on CPU0: 08(08)
APIC error on CPU0: 08(08)
APIC error on CPU0: 08(08)
APIC error on CPU0: 08(08)

        <7>APIC error on CPU0: 08(08)
<ffffffff801182a0>{smp_send_stop+43}<7>APIC error on CPU0: 08(08)
APIC error on CPU0: 08(08)
APIC error on CPU0: 08(08)
APIC error on CPU0: 08(08)
  <ffffffff8013483d>{panic+145}<7>APIC error on CPU0: 08(08)
APIC error on CPU0: 08(08)
APIC error on CPU0: 08(08)

        <7>APIC error on CPU0: 08(08)
<ffffffff8034329c>{_spin_trylock+9}<7>APIC error on CPU0: 08(08)
APIC error on CPU0: 08(08)
APIC error on CPU0: 08(08)
APIC error on CPU0: 08(08)
  <ffffffff8010f4d3>{oops_begin+90}<7>APIC error on CPU0: 08(08)
APIC error on CPU0: 08(08)
APIC error on CPU0: 08(08)

        <7>APIC error on CPU0: 08(08)
<ffffffff801149f8>{print_mce+136}<7>APIC error on CPU0: 08(08)
APIC error on CPU0: 08(08)
APIC error on CPU0: 08(08)
APIC error on CPU0: 08(08)
  <ffffffff80114abf>{mcheck_timer+0}<7>APIC error on CPU0: 08(08)
APIC error on CPU0: 08(08)
APIC error on CPU0: 08(08)

        <7>APIC error on CPU0: 08(08)
<ffffffff801150cd>{do_machine_check+752}<7>APIC error on CPU0: 08(08)
  <ffffffff8010ee6f>{machine_check+127}<7>APIC error on CPU0: 08(08)
APIC error on CPU0: 08(08)
APIC error on CPU0: 08(08)
APIC error on CPU0: 08(08)

         <EOE> <7>APIC error on CPU0: 08(08)
APIC error on CPU0: 08(08)

  <7>APIC error on CPU0: 08(08)
APIC error on CPU0: 08(08)

