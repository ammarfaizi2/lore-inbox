Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263547AbTHXO0x (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Aug 2003 10:26:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263551AbTHXO0x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Aug 2003 10:26:53 -0400
Received: from defout.telus.net ([199.185.220.240]:31382 "EHLO
	priv-edtnes56.telusplanet.net") by vger.kernel.org with ESMTP
	id S263547AbTHXO03 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Aug 2003 10:26:29 -0400
Subject: semaphore.c:84: spin_is_locked on uninitialized spinlock f75f38f8
From: Bob Gill <gillb4@telusplanet.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1061622120.3403.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 23 Aug 2003 01:02:01 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There still seems to be a problem in 'test4 as the following message
does not seem to be as cheerful as the rest of the boot sequence.

Cheers!


ieee1394: sbp2: Logged into SBP-2 device
arch/i386/kernel/semaphore.c:84: spin_is_locked on uninitialized
spinlock f75f38f8.
Unable to handle kernel paging request at virtual address 6b6b6b6b
 printing eip:
c01bfa9a
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c01bfa9a>]    Not tainted
EFLAGS: 00010097
EIP is at vsnprintf+0x2de/0x44d
eax: 6b6b6b6b   ebx: 0000000a   ecx: 6b6b6b6b   edx: fffffffe
esi: c03aac6b   edi: 00000000   ebp: f7571d78   esp: f7571d40
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 762, threadinfo=f7570000 task=f792af00)
Stack: c03aac5d c03ab03f 00000054 00000000 0000000a ffffffff 00000001
00000002
       ffffffff ffffffff c03ab03f c03aac40 00000046 f75f38f8 f7571dc8
c011f8da
       c03aac40 00000400 c02d0252 f7571de0 00000086 f75f38c8 f75aab3c
f75aab70
Call Trace:
 [<c011f8da>] printk+0x16f/0x3b7
 [<c0119774>] __wake_up_locked+0x22/0x26
 [<c01080c2>] __down+0x1b1/0x2e2
 [<c0119594>] default_wake_function+0x0/0x2e
 [<f89fd0dd>] sbp2util_allocate_write_packet+0x68/0x74 [sbp2]
 [<c0108677>] __down_failed+0xb/0x14
 [<f8a00b43>] .text.lock.sbp2+0xf/0x2c [sbp2]
 [<f89fe546>] sbp2_start_device+0x205/0x3e6 [sbp2]
 [<f89fe303>] sbp2_start_ud+0x106/0x144 [sbp2]
 [<c01a7575>] sysfs_create_dir+0x34/0x6a
 [<f89fde34>] sbp2_probe+0x4b/0x4f [sbp2]
 [<c01efbdb>] bus_match+0x3d/0x65
 [<c01efcf4>] driver_attach+0x59/0x83
 [<c01eff70>] bus_add_driver+0x91/0xa3
 [<c01f03b6>] driver_register+0x88/0x8c
 [<f8918a39>] hpsb_register_protocol+0x17/0x28 [ieee1394]
 [<f8a00b0d>] sbp2_module_init+0x7d/0xa4 [sbp2]
 [<c013d91f>] sys_init_module+0x1bb/0x318
 [<c0109db1>] sysenter_past_esp+0x52/0x71
 
Code: 80 38 00 74 07 40 4a 83 fa ff 75 f4 29 c8 83 e7 10 89 c3 75
 <6>kudzu: numerical sysctl 1 23 is obsolete.
Slab corruption: start=f75f38c0, expend=f75f3937, problemat=f75f3900
Last user: [<f891118f>](free_hpsb_packet+0x2c/0x33 [ieee1394])
Data: ****************************************************************6A
******************************************************A5
Next: 71 F0 2C .8F 11 91 F8 71 F0 2C .....................
slab error in check_poison_obj(): cache `hpsb_packet': object was
modified after freeing
Call Trace:
 [<c01470a4>] check_poison_obj+0x16c/0x1ac
 [<c0147270>] slab_destroy+0x18c/0x194
 [<c014ae50>] cache_reap+0x293/0x408
 [<c020d5b6>] ide_do_request+0x53/0x481
 [<c0128c47>] update_process_times+0x46/0x50
 [<c0149f9e>] reap_timer_fnc+0x0/0x29
 [<c0149fa9>] reap_timer_fnc+0xb/0x29
 [<c0120495>] profile_hook+0x21/0x25
 [<c0128dc8>] run_timer_softirq+0x15d/0x3d0
 [<c01112f5>] timer_interrupt+0x8b/0x23e
 [<c01241a1>] do_softirq+0xa1/0xa3
 [<c010be4b>] do_IRQ+0x20e/0x348
 [<c0107039>] default_idle+0x0/0x2c
 [<c0105000>] rest_init+0x0/0x2a
 [<c0109f70>] common_interrupt+0x18/0x20
 [<c0107039>] default_idle+0x0/0x2c
 [<c0105000>] rest_init+0x0/0x2a
 [<c0107060>] default_idle+0x27/0x2c
 [<c01070d1>] cpu_idle+0x31/0x3a
 [<c0370663>] start_kernel+0x13d/0x13f
 [<c0370401>] unknown_bootoption+0x0/0xfa
-- 
Bob Gill <gillb4@telusplanet.net>

