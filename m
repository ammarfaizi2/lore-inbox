Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266543AbUIPVk3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266543AbUIPVk3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 17:40:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266561AbUIPVk3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 17:40:29 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:50316 "EHLO
	fmmailgate03.web.de") by vger.kernel.org with ESMTP id S266543AbUIPVkM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 17:40:12 -0400
Date: Thu, 16 Sep 2004 23:40:10 +0200
Message-Id: <1285012519@web.de>
MIME-Version: 1.0
From: "Joachim Bremer" <joachim.bremer@web.de>
To: linux-kernel@vger.kernel.org
Subject: 2.6.9-rc2-mm1: kernel oops on usb unplug
Organization: http://freemail.web.de/
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is on a dual opteron 244 (Tyan Tiger K8W). This oops happened after unplugging
a mass storage device - actually a dvd-writer. It was connected to the onboard usb1
device (AMD Chipset). Exactly the same happens on an Tyan Thunder K8W with
2 Opteron 248 connected to an PCI card with NEC chipset. Temporary workaround:
before physical disconnect issue an "remove-single-device" to the scsi-layer.

OOPS follows

Bye

Joachim

First:

Sep 16 15:30:47 v200 kernel: usb 1-2: USB disconnect, address 3
Sep 16 15:30:52 v200 kernel: scsi: Device offlined - not ready after error recovery: host 4 channel 0 id 0 lun 0
Sep 16 15:30:52 v200 kernel: sr 4:0:0:0: Illegal state transition cancel->offline
Sep 16 15:30:52 v200 kernel: Badness in scsi_device_set_state at drivers/scsi/scsi_lib.c:1701

and then:

Sep 16 15:30:52 v200 kernel: Call Trace:<ffffffff802cc7d8>{scsi_device_set_state+248} <ffffffff802ca840>{scsi_error_handler+1808}
Sep 16 15:30:52 v200 kernel:        <ffffffff80110067>{child_rip+8} <ffffffff802ca130>{scsi_error_handler+0}
Sep 16 15:30:52 v200 kernel:        <ffffffff8011005f>{child_rip+0}
Sep 16 15:30:52 v200 kernel: Call Trace:<ffffffff8024517e>{kref_get+46} <ffffffff802445b2>{kobject_get+18}
Sep 16 15:30:52 v200 kernel:        <ffffffff8029b4e4>{get_device+20} <ffffffff802cbd8b>{scsi_request_fn+43}
Sep 16 15:30:52 v200 kernel:        <ffffffff802a246b>{blk_insert_request+187} <ffffffff802cb102>{scsi_queue_insert+146}
Sep 16 15:30:52 v200 kernel:        <ffffffff802ca8c1>{scsi_error_handler+1937} <ffffffff80110067>{child_rip+8}
Sep 16 15:30:52 v200 kernel:        <ffffffff802ca130>{scsi_error_handler+0} <ffffffff8011005f>{child_rip+0}
Sep 16 15:30:52 v200 kernel: Unable to handle kernel paging request at 0000000000200200 RIP:
Sep 16 15:30:52 v200 kernel: <ffffffff802ce025>{scsi_device_dev_release+69}
Sep 16 15:30:52 v200 kernel: PML4 1d8e8067 PGD 1d211067 PMD 0
Sep 16 15:30:52 v200 kernel: Oops: 0000 [1] SMP
Sep 16 15:30:52 v200 kernel: CPU 0
Sep 16 15:30:52 v200 kernel: Pid: 3904, comm: scsi_eh_4 Not tainted 2.6.9-rc2-mm1
Sep 16 15:30:52 v200 kernel: RIP: 0010:[<ffffffff802ce025>] <ffffffff802ce025>{scsi_device_dev_release+69}
Using defaults from ksymoops -t elf64-x86-64 -a i386:x86-64
Sep 16 15:30:52 v200 kernel: RSP: 0018:000001003894fdc8  EFLAGS: 00010083
Sep 16 15:30:52 v200 kernel: RAX: 0000000000000216 RBX: 00000100393c61e8 RCX: 00000100393c6010
Sep 16 15:30:52 v200 kernel: RDX: 0000000000200200 RSI: 0000000000000216 RDI: 00000100393c6020
Sep 16 15:30:52 v200 kernel: RBP: 00000100393c6000 R08: 0000000000000003 R09: 0000000000000000
Sep 16 15:30:52 v200 kernel: R10: 00000000ffffffff R11: ffffffff802cdfe0 R12: 000001003ff55208
Sep 16 15:30:52 v200 kernel: R13: 0000000000000000 R14: 00000100393c6050 R15: 00000100393c61e8
Sep 16 15:30:52 v200 kernel: FS:  0000002a9588d6e0(0000) GS:ffffffff804a20c0(0000) knlGS:0000000000000000
Sep 16 15:30:52 v200 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
Sep 16 15:30:52 v200 kernel: CR2: 0000000000200200 CR3: 0000000000101000 CR4: 00000000000006e0
Sep 16 15:30:52 v200 kernel: Stack: 0000000000000009 00000100393c6230 ffffffff80422650 ffffffff804225a0
Sep 16 15:30:52 v200 kernel:        000001003ff55250 ffffffff80244684 00000100393c6000 000001003ff344d8
Sep 16 15:30:52 v200 kernel:        00000100393c6000 0000010002190800
Sep 16 15:30:52 v200 kernel: Call Trace:<ffffffff80244684>{kobject_cleanup+100} <ffffffff802cc174>{scsi_request_fn+1044}
Sep 16 15:30:52 v200 kernel:        <ffffffff802a246b>{blk_insert_request+187} <ffffffff802cb102>{scsi_queue_insert+146}
Sep 16 15:30:52 v200 kernel:        <ffffffff802ca8c1>{scsi_error_handler+1937} <ffffffff80110067>{child_rip+8}
Sep 16 15:30:52 v200 kernel:        <ffffffff802ca130>{scsi_error_handler+0} <ffffffff8011005f>{child_rip+0}
Sep 16 15:30:52 v200 kernel: Code: 48 39 0a 74 0c 0f 0b 44 1c 38 80 ff ff ff ff a4 00 48 8b 83


Trace; ffffffff802cc7d8 <scsi_device_set_state+f8/120>
Trace; ffffffff80110067 <child_rip+8/11>
Trace; ffffffff8011005f <child_rip+0/11>
Trace; ffffffff8024517e <kref_get+2e/40>
Trace; ffffffff8029b4e4 <get_device+14/20>
Trace; ffffffff802a246b <blk_insert_request+bb/f0>
Trace; ffffffff802ca8c1 <scsi_error_handler+791/910>
Trace; ffffffff802ca130 <scsi_error_handler+0/910>

>>RIP; ffffffff802ce025 <scsi_device_dev_release+45/1c0>   <=====

>>R11; ffffffff802cdfe0 <scsi_device_dev_release+0/1c0>

Trace; ffffffff80244684 <kobject_cleanup+64/c0>
Trace; ffffffff802a246b <blk_insert_request+bb/f0>
Trace; ffffffff802ca8c1 <scsi_error_handler+791/910>
Trace; ffffffff802ca130 <scsi_error_handler+0/910>

Code;  ffffffff802ce025 <scsi_device_dev_release+45/1c0>
0000000000000000 <_RIP>:
Code;  ffffffff802ce025 <scsi_device_dev_release+45/1c0>   <=====
   0:   48 39 0a                  cmp    %rcx,(%rdx)   <=====
Code;  ffffffff802ce028 <scsi_device_dev_release+48/1c0>
   3:   74 0c                     je     11 <_RIP+0x11>
Code;  ffffffff802ce02a <scsi_device_dev_release+4a/1c0>
   5:   0f 0b                     ud2a
Code;  ffffffff802ce02c <scsi_device_dev_release+4c/1c0>
   7:   44 1c 38                  rexX sbb    $0x38,%al
Code;  ffffffff802ce02f <scsi_device_dev_release+4f/1c0>
   a:   80 ff ff                  cmp    $0xff,%bh
Code;  ffffffff802ce032 <scsi_device_dev_release+52/1c0>
   d:   ff                        (bad)
Code;  ffffffff802ce033 <scsi_device_dev_release+53/1c0>
   e:   ff a4 00 48 8b 83 00      jmpq   *0x838b48(%rax,%rax,1)

Sep 16 15:30:52 v200 kernel: CR2: 0000000000200200
Sep 16 15:30:52 v200 kernel: CPU 0
Sep 16 15:30:52 v200 kernel: Pid: 45, comm: kblockd/0 Not tainted 2.6.9-rc2-mm1
Sep 16 15:30:52 v200 kernel: RIP: 0010:[<ffffffff802a789b>] <ffffffff802a789b>{as_next_request+43}
Sep 16 15:30:52 v200 kernel: RSP: 0018:000001003fcebde8  EFLAGS: 00010046
Sep 16 15:30:52 v200 kernel: RAX: 656e6e6168632034 RBX: 000001003ff55400 RCX: 000001003fcebed0
Sep 16 15:30:52 v200 kernel: RDX: 0000000000000001 RSI: 0000000000000212 RDI: 00000100022e8040
Sep 16 15:30:52 v200 kernel: RBP: 00000100022e8228 R08: 000001003fcea000 R09: 0000000000000002
Sep 16 15:30:52 v200 kernel: R10: ffffffff80472aa0 R11: ffffffff802a1860 R12: 00000100022e8040
Sep 16 15:30:52 v200 kernel: R13: 0000000000000000 R14: 00000100022e8040 R15: ffffffff802a18b0
Sep 16 15:30:52 v200 kernel: FS:  0000002a9588d6e0(0000) GS:ffffffff804a20c0(0000) knlGS:0000000000000000
Sep 16 15:30:52 v200 kernel: CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
Sep 16 15:30:52 v200 kernel: CR2: 0000000000200200 CR3: 0000000000101000 CR4: 00000000000006e0
Sep 16 15:30:52 v200 kernel: Stack: 000001003fc84030 ffffffff803b1c00 00000100022e8040 00000100022e8228
Sep 16 15:30:52 v200 kernel:        00000100022e8040 0000000000000212 00000100022e8040 ffffffff8029fd6f
Sep 16 15:30:52 v200 kernel:        00000100022e8040 00000100022e8228
Sep 16 15:30:52 v200 kernel: Call Trace:<ffffffff8029fd6f>{elv_next_request+271} <ffffffff802a183f>{__generic_unplug_device+31}
Sep 16 15:30:52 v200 kernel:        <ffffffff802a1878>{generic_unplug_device+24} <ffffffff80145520>{worker_thread+496}
Sep 16 15:30:52 v200 kernel:        <ffffffff80130d50>{default_wake_function+0} <ffffffff80130d50>{default_wake_function+0}
Sep 16 15:30:52 v200 kernel:        <ffffffff80149ce0>{keventd_create_kthread+0} <ffffffff80145330>{worker_thread+0}
Sep 16 15:30:52 v200 kernel:        <ffffffff80149ce0>{keventd_create_kthread+0} <ffffffff80149c99>{kthread+217}
Sep 16 15:30:52 v200 kernel:        <ffffffff80110067>{child_rip+8} <ffffffff80149ce0>{keventd_create_kthread+0}
Sep 16 15:30:52 v200 kernel:        <ffffffff80149bc0>{kthread+0} <ffffffff8011005f>{child_rip+0}
Sep 16 15:30:52 v200 kernel: Code: 48 39 00 0f 85 73 03 00 00 48 8d 43 28 31 ed 48 39 43 28 8b


>>RIP; ffffffff802a789b <as_next_request+2b/3d0>   <=====

>>R10; ffffffff80472aa0 <sched_group_phys+0/40>
>>R11; ffffffff802a1860 <generic_unplug_device+0/30>
>>R15; ffffffff802a18b0 <blk_unplug_work+0/10>

Trace; ffffffff8029fd6f <elv_next_request+10f/130>
Trace; ffffffff802a1878 <generic_unplug_device+18/30>
Trace; ffffffff80130d50 <default_wake_function+0/10>
Trace; ffffffff80149ce0 <keventd_create_kthread+0/60>
Trace; ffffffff80149ce0 <keventd_create_kthread+0/60>
Trace; ffffffff80110067 <child_rip+8/11>
Trace; ffffffff80149bc0 <kthread+0/120>

Code;  ffffffff802a789b <as_next_request+2b/3d0>
0000000000000000 <_RIP>:
Code;  ffffffff802a789b <as_next_request+2b/3d0>   <=====
   0:   48 39 00                  cmp    %rax,(%rax)   <=====
Code;  ffffffff802a789e <as_next_request+2e/3d0>
   3:   0f 85 73 03 00 00         jne    37c <_RIP+0x37c>
Code;  ffffffff802a78a4 <as_next_request+34/3d0>
   9:   48 8d 43 28               lea    0x28(%rbx),%rax
Code;  ffffffff802a78a8 <as_next_request+38/3d0>
   d:   31 ed                     xor    %ebp,%ebp
Code;  ffffffff802a78aa <as_next_request+3a/3d0>
   f:   48 39 43 28               cmp    %rax,0x28(%rbx)
Code;  ffffffff802a78ae <as_next_request+3e/3d0>
  13:   8b 00                     mov    (%rax),%eax



_________________________________________________________
Mit WEB.DE FreePhone? mit hochster Qualitat ab 0 Ct./Min.
weltweit telefonieren! http://freephone.web.de/?mc=021201

