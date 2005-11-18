Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030210AbVKRR4v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030210AbVKRR4v (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 12:56:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030276AbVKRR4v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 12:56:51 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:60839 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030210AbVKRR4u
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 12:56:50 -0500
Subject: 2.6.15-rc1-mm1 panic in ptrace_check_attach()
From: Badari Pulavarty <pbadari@us.ibm.com>
To: akpm@osdl.org
Cc: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Fri, 18 Nov 2005 09:56:40 -0800
Message-Id: <1132336600.24066.179.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

I am not sure if its already reported. I get panic in
ptrace_check_attach() while trying to run UML on 2.6.15-rc1-mm1.

Going to try 2.6.15-rc1-mm2 now. 

Thanks,
Badari

Unable to handle kernel NULL pointer dereference at 0000000000000020
RIP:
<ffffffff8013d834>{ptrace_check_attach+36}
PGD 1ccc6c067 PUD 1ce816067 PMD 0
Oops: 0000 [2] SMP
CPU 3
Modules linked in: floppy thermal processor fan button battery ac
parport_pc lp parport evdev joydev st sr_mod ipv6 sg qla2300 qlogicfc
qla2200 qla2xxx firmware_class ohci_hcd hw_random usbcore dm_mod
Pid: 21537, comm: linux Not tainted 2.6.15-rc1-mm1 #1
RIP: 0010:[<ffffffff8013d834>] <ffffffff8013d834>{ptrace_check_attach
+36}
RSP: 0018:ffff810195c75ef8  EFLAGS: 00010216
RAX: ffffffff805d2080 RBX: 0000000000000000 RCX: ffff8101cc69d228
RDX: ffff8101cc69d220 RSI: 0000000000000000 RDI: ffffffff805d2080
RBP: 0000000000000000 R08: 0000000055681c58 R09: 00000000ffffbc78
R10: ffff810195c74000 R11: 0000000000000206 R12: 0000000000000000
R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000000
FS:  00002aaaab2890a0(0000) GS:ffffffff805cc180(0063)
knlGS:0000000055685080
CS:  0010 DS: 002b ES: 002b CR0: 000000008005003b
CR2: 0000000000000020 CR3: 00000001ca93e000 CR4: 00000000000006e0
Process linux (pid: 21537, threadinfo ffff810195c74000, task
ffff81019d031110)
Stack: 0000000000000000 0000000000000000 0000000000000015
ffffffff8013d96a
       0000000000000015 0000000000000001 0000000000000000
0000000000000000
       0000000000000000 ffffffff8012a75f
Call Trace:<ffffffff8013d96a>{sys_ptrace+122}
<ffffffff8012a75f>{sys32_ptrace+111}
       <ffffffff8011f453>{cstar_do_call+27}

Code: f6 43 20 01 bd fd ff ff ff 0f 84 81 00 00 00 65 48 8b 04 25
RIP <ffffffff8013d834>{ptrace_check_attach+36} RSP <ffff810195c75ef8>
CR2: 0000000000000020
 NMI Watchdog detected LOCKUP on CPU 3
CPU 3
Modules linked in: floppy thermal processor fan button battery ac
parport_pc lp parport evdev joydev st sr_mod ipv6 sg qla2300 qlogicfc
qla2200 qla2xxx firmware_class ohci_hcd hw_random usbcore dm_mod
Pid: 21537, comm: linux Not tainted 2.6.15-rc1-mm1 #1
RIP: 0010:[<ffffffff802a79c3>] <ffffffff802a79c3>{__write_lock_failed
+15}
RSP: 0018:ffff810195c75cc8  EFLAGS: 00000087
RAX: ffffffff805d2080 RBX: ffff81017fc3cb40 RCX: 0000000000000079
RDX: ffff81019d0312a0 RSI: 0000000000000296 RDI: ffffffff805d2080
RBP: ffff81019d031110 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 00ff00ff00ff00ff R12: ffff81019d031754
R13: ffff81019d031110 R14: ffff810195c75cf8 R15: ffff810195c75e48
FS:  00002aaaab2890a0(0000) GS:ffffffff805cc180(0000)
knlGS:0000000055685080
CS:  0010 DS: 002b ES: 002b CR0: 000000008005003b
CR2: 0000000000000020 CR3: 0000000000101000 CR4: 00000000000006e0
Process linux (pid: 21537, threadinfo ffff810195c74000, task
ffff81019d031110)
Stack: ffffffff803fcc88 ffffffff80137fec ffff81019d0312a0
ffffffff80499ec8
       ffffffff80499ec8 0000000000000246 ffffffff8048faac
ffffffffffffffef
       ffffffff803fcaf8 0000000000000246
Call Trace:<ffffffff803fcc88>{.text.lock.spinlock+79}
<ffffffff80137fec>{do_exit+1212}
       <ffffffff803fcaf8>{_spin_unlock_irqrestore+8}
<ffffffff803fe5f5>{do_page_fault+1925}
       <ffffffff8015b821>{filemap_nopage+385}
<ffffffff8016a1d5>{__handle_mm_fault+1941}
       <ffffffff801379ca>{do_wait+2938} <ffffffff8010ec1d>{error_exit+0}
       <ffffffff8013d834>{ptrace_check_attach+36}
<ffffffff8013d834>{ptrace_check_attach+36}
       <ffffffff8013d96a>{sys_ptrace+122}
<ffffffff8012a75f>{sys32_ptrace+111}
       <ffffffff8011f453>{cstar_do_call+27}

Code: 75 f6 f0 81 28 00 00 00 01 0f 85 e2 ff ff ff c3 90 f0 ff 00
console shuts up ...
 <0>Kernel panic - not syncing: Aiee, killing interrupt handler!


