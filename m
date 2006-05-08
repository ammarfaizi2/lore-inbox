Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751107AbWEHVgM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751107AbWEHVgM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 17:36:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751119AbWEHVgM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 17:36:12 -0400
Received: from EXCHG2003.microtech-ks.com ([24.124.14.122]:30184 "EHLO
	EXCHG2003.microtech-ks.com") by vger.kernel.org with ESMTP
	id S1751107AbWEHVgL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 17:36:11 -0400
Message-ID: <445FB9C7.8060507@atipa.com>
Date: Mon, 08 May 2006 16:36:07 -0500
From: Roger Heflin <rheflin@atipa.com>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: openib-general@openib.org, Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Openmpi/xhpl kernel crash 2.6.17-rc3 with Pathscale htx
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 May 2006 21:27:49.0920 (UTC) FILETIME=[41D59A00:01C672E6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Running hpl with openmpi over Infiniband gets me a crash.

Using hpl, openmpi 1.0.2, openib, and the 2.6.17-rc3 kernel.

I don't see the crash under ip over ib (ran for over an hour),
the crash occurs immediately upon attempting to start xhpl.

Here is the crash captured via the serial port:

[  144.713555] ----------- [cut here ] --------- [please bite here ] 
---------
[  144.720550] Kernel BUG at drivers/infiniband/hw/ipath/ipath_layer.c:757
[  144.727205] invalid opcode: 0000 [1] SMP
[  144.731334] CPU 0
[  144.733419] Modules linked in: ipv6 autofs4 adm1026 hwmon_vid 
i2c_piix4 nfs lockd nfs_acl sunrpc dm_mirror dm_multipath dm_mod button 
battery ac ohci_hcd ehci_hcd i2c_nforce2 i2c_core shpchp snd_intel8x0 
snd_ac97_codec snd_ac97_bus snd_pcm_oss snd_mixer_oss snd_pcm snd_timer 
snd soundcore snd_page_alloc ib_ipoib ib_ipath ipath_core ib_uverbs 
ib_umad ib_ucm ib_sa ib_cm ib_mad ib_core tg3 floppy sata_svw ext3 jbd 
sata_nv libata sd_mod scsi_mod
[  144.774643] Pid: 4771, comm: xhpl Not tainted 2.6.17-rc3 #1
[  144.780244] RIP: 0010:[<ffffffff880f6984>] 
<ffffffff880f6984>{:ipath_core:ipath_verbs_send+362}
[  144.788858] RSP: 0018:ffffffff8051be38  EFLAGS: 00010246
[  144.794409] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 
ffff8100df4a0150
[  144.801574] RDX: ffffc200003b1078 RSI: 0000000000000000 RDI: 
ffff8100df4a0150
[  144.808742] RBP: 0000000000000000 R08: ffff8100df4a0158 R09: 
0000000000000018
[  144.815910] R10: 0000000000000018 R11: 0000000000000246 R12: 
ffffc2000026f020
[  144.823071] R13: 0000000000000000 R14: 0000000000000018 R15: 
0000000000000000
[  144.830230] FS:  00002b750d6fcca0(0000) GS:ffffffff805ad000(0000) 
knlGS:0000000000000000
[  144.838398] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[  144.844190] CR2: 000000000047f050 CR3: 000000000cdb1000 CR4: 
00000000000006e0
[  144.851370] Process xhpl (pid: 4771, threadinfo ffff81000ceba000, 
task ffff81000cc9e880)
[  144.859504] Stack: ffffffff8059d900 ffff8100df4a0150 00000018dfef1000 
ffff8100df4a0120
[  144.867549]        ffff8100df4a0000 ffffffff805f7d88 ffff8100df4a0098 
0000000000000038
[  144.875829]        0000000000000400 ffffffff8811869e
[  144.881079] Call Trace: <IRQ> 
<ffffffff8811869e>{:ib_ipath:ipath_do_rc_send+348}
[  144.888727]        <ffffffff80232548>{do_timer+58} 
<ffffffff8020d0bb>{main_timer_handler+493}
[  144.897498]        <ffffffff8022efc6>{tasklet_hi_action+105} 
<ffffffff8022ebc4>{__do_softirq+80}
[  144.906525]        <ffffffff8020aa5a>{call_softirq+30} 
<ffffffff8020bc0a>{do_softirq+47}
[  144.914854]        <ffffffff8020bbd1>{do_IRQ+62} 
<ffffffff80209b96>{ret_from_intr+0} <EOI>
[  144.923395]        <ffffffff8026aafe>{kfree+417} 
<ffffffff880e14ff>{:ib_uverbs:ib_uverbs_poll_cq+409}
[  144.932867]        <ffffffff880dfa27>{:ib_uverbs:ib_uverbs_write+196} 
<ffffffff8026f746>{vfs_write+212}
[  144.942509]        <ffffffff8026f897>{sys_write+69} 
<ffffffff80209612>{system_call+126}
[  144.950997]
[  144.950998] Code: 0f 0b 68 84 21 10 88 c2 f5 02 eb 07 44 39 f3 41 0f 
47 de 48
[  144.960709] RIP <ffffffff880f6984>{:ipath_core:ipath_verbs_send+362} 
RSP <ffffffff8051be38>
[  144.969212]  <3>BUG: sleeping function called from invalid context at 
include/linux/rwsem.h:43
[  144.977952] in_atomic():1, irqs_disabled():0
[  144.982261]
[  144.982262] Call Trace: <IRQ> <ffffffff80221daa>{__might_sleep+190}
[  144.990056]        <ffffffff80216103>{flat_send_IPI_mask+0} 
<ffffffff80236073>{blocking_notifier_call_chain+31}
[  145.000411]        <ffffffff8022c2ee>{do_exit+34} 
<ffffffff80423c6f>{_spin_unlock_irqrestore+11}
[  145.009454]        <ffffffff8020b027>{do_divide_error+0} 
<ffffffff8020b22e>{do_invalid_op+145}
[  145.018334]        <ffffffff880f6984>{:ipath_core:ipath_verbs_send+362}
[  145.025102]        <ffffffff803f7d02>{tcp_v4_do_rcv+43} 
<ffffffff88092128>{:tg3:tg3_interrupt_tagged+51}
[  145.034840]        <ffffffff8020a551>{error_exit+0} 
<ffffffff880f6984>{:ipath_core:ipath_verbs_send+362}
[  145.044606]        <ffffffff880f6b40>{:ipath_core:ipath_verbs_send+806}
[  145.051390]        <ffffffff8811869e>{:ib_ipath:ipath_do_rc_send+348} 
<ffffffff80232548>{do_timer+58}
[  145.060897]        <ffffffff8020d0bb>{main_timer_handler+493} 
<ffffffff8022efc6>{tasklet_hi_action+105}
[  145.070569]        <ffffffff8022ebc4>{__do_softirq+80} 
<ffffffff8020aa5a>{call_softirq+30}
[  145.079121]        <ffffffff8020bc0a>{do_softirq+47} 
<ffffffff8020bbd1>{do_IRQ+62}
[  145.086947]        <ffffffff80209b96>{ret_from_intr+0} <EOI> 
<ffffffff8026aafe>{kfree+417}
[  145.095523]        <ffffffff880e14ff>{:ib_uverbs:ib_uverbs_poll_cq+409}
[  145.102291]        <ffffffff880dfa27>{:ib_uverbs:ib_uverbs_write+196} 
<ffffffff8026f746>{vfs_write+212}
[  145.111972]        <ffffffff8026f897>{sys_write+69} 
<ffffffff80209612>{system_call+126}
[  145.120482] Kernel panic - not syncing: Aiee, killing interrupt handler!
[  145.127265]

/proc/interrupts looks like this:
           CPU0       CPU1       CPU2       CPU3
   0:     107714     110040     109206     113504    IO-APIC-edge  timer
   1:        417       1287        405       1627    IO-APIC-edge  i8042
   8:          0          0          0          0    IO-APIC-edge  rtc
   9:          0          0          0          0   IO-APIC-level  acpi
  15:         50          0          0         23    IO-APIC-edge  ide1
  50:          0          0          0          0   IO-APIC-level 
libata, ohci_hcd:usb2
  58:          0          0          0          0   IO-APIC-level  libata
  66:          0          0          0          0   IO-APIC-level  libata
  74:      15625          0          0         11   IO-APIC-level  eth0
  90:        551          0          0          0   IO-APIC-level 
ipath_core
  98:          0          0          0          0   IO-APIC-level 
NVidia CK804
233:        249        904       1161       4180   IO-APIC-level 
libata, ehci_hcd:usb1
NMI:        107        124        406        483
LOC:     440388     440365     440341     440317
ERR:          0
MIS:          0


Any ideas?

                                  Roger

