Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262362AbTFKPLn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 11:11:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262385AbTFKPLn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 11:11:43 -0400
Received: from franka.aracnet.com ([216.99.193.44]:10671 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S262362AbTFKPLf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 11:11:35 -0400
Date: Wed, 11 Jun 2003 07:52:09 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: LKML <linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 799] New: bug in module parameters causes an oops
Message-ID: <44790000.1055343129@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

           Summary: bug in module parameters causes an oops
    Kernel Version: 2.5.70+bk
            Status: NEW
          Severity: normal
             Owner: bugme-janitors@lists.osdl.org
         Submitter: alexander.riesen@synopsys.com


Distribution: Gentoo, module-init-tools-0.9.11

As mozilla(flashplugin) tried to initialize sound, I got
the following oops, and the all subsequent calls to modprobe
have hanged.

modprobe: FATAL: Module snd_card_0 not found. 
snd: Unknown parameter `device_mode'
Unable to handle kernel paging request at virtual address dc949a3c
 printing eip:
c014911e
*pde = 014fa067
*pte = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c014911e>]    Not tainted
EFLAGS: 00010286
EIP is at load_module+0x71e/0x8b0
eax: 00000009   ebx: dc8b0000   ecx: dc949960   edx: db53eb20
esi: fffffffe   edi: dc949960   ebp: d4777f8c   esp: d4777f0c
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 4652, threadinfo=d4776000 task=d5d4dba0)
Stack: dc93e000 dc93e000 dc949a60 00000002 dc8b9090 0000001f dc947a94 00000000 
       00000528 00000500 dc867000 dc949960 00000000 00000000 00000000 00000000 
       0000000c 0000001b 00000019 00000013 00000015 00000000 00000020 0000001f 
Call Trace:
 [<c014934b>] sys_init_module+0x9b/0x3e0
 [<c010a4bb>] syscall_call+0x7/0xb

Code: 8b b9 dc 00 00 00 85 ff 0f 84 04 fc ff ff 0f 0b 61 01 fd 0a 
modprobe: FATAL: Module snd_card_0 not found. 
[<dc903ed8>] rpciod_idle+0x18/0x20 [sunrpc]
[<dc8e8bb0>] rpciod+0x0/0x3c0 [sunrpc]
[<c01075fd>] kernel_thread_helper+0x5/0x18
[<dc903ee0>] rpciod_killer+0x0/0x20 [sunrpc]



modprobe      D DBFDAD20 4272061968  4656   4655                     (NOTLB)
Call Trace:
 [<c018a0ac>] real_lookup+0xdc/0x110
 [<c0196470>] dput+0x30/0x650
 [<c01084b3>] __down+0x143/0x350
 [<c018b1bd>] link_path_walk+0x86d/0xda0
 [<c0121c50>] default_wake_function+0x0/0x30
 [<c0108bb7>] __down_failed+0xb/0x14
 [<c0149e15>] .text.lock.module+0xcd/0xe8
 [<c01629eb>] vma_link+0xcb/0x1c0
 [<c01a4e61>] seq_read+0x2f1/0x300
 [<c01a4c5b>] seq_read+0xeb/0x300
 [<c0163532>] do_mmap_pgoff+0x3e2/0x6c0
 [<c017559f>] vfs_read+0xaf/0x120
 [<c017582f>] sys_read+0x3f/0x60
 [<c010a4bb>] syscall_call+0x7/0xb

mozilla-bin   D D7603D10 4262142560  4577      1  4586    4609  4573 (NOTLB)
Call Trace:
 [<c0121c7a>] default_wake_function+0x2a/0x30
 [<c0122455>] wait_for_completion+0x155/0x330
 [<c0121c50>] default_wake_function+0x0/0x30
 [<c013d7db>] queue_work+0x12b/0x1c0
 [<c0121c50>] default_wake_function+0x0/0x30
 [<c013d6a1>] call_usermodehelper+0x161/0x170
 [<c013d4d0>] __call_usermodehelper+0x0/0x70
 [<c01cc7f1>] ext3_lookup+0x1a1/0x340
 [<c013d1b6>] request_module+0xd6/0x130
 [<dc894baf>] soundcore_open+0x36f/0x610 [soundcore]
 [<dc895210>] +0x90/0xf6 [soundcore]
 [<c01842a0>] exact_match+0x0/0x10
 [<c0183aad>] chrdev_open+0x21d/0x610
 [<c0176617>] get_empty_filp+0x77/0x100
 [<c0173fb1>] dentry_open+0x151/0x220
 [<c0173e56>] filp_open+0x66/0x70
 [<c01898f3>] getname+0x93/0xd0
 [<c0174675>] sys_open+0x55/0x90
 [<c010a4bb>] syscall_call+0x7/0xb


