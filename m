Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266283AbUBQP6I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 10:58:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266286AbUBQP44
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 10:56:56 -0500
Received: from obsidian.spiritone.com ([216.99.193.137]:2966 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S266281AbUBQP4r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 10:56:47 -0500
Date: Tue, 17 Feb 2004 07:56:39 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: wh+bugme@nospam.blub.net
Subject: [Bug 2121] New: kernel Oops while loading parport_pc	module
Message-ID: <18720000.1077033399@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=2121

           Summary: kernel Oops while loading parport_pc module
    Kernel Version: 2.6.2
            Status: NEW
          Severity: normal
             Owner: drivers_parallel@kernel-bugs.osdl.org
         Submitter: wh+bugme@nospam.blub.net


Distribution: Debian woody/testing
Hardware Environment: duron 1300
Software Environment: Vanilla 2.6.2 kernel built with gcc 2.95.4
Problem Description: Upon loading the parport_pc module, the kernel gives an Oops

Steps to reproduce:

Boot the 2.6.2 kernel and load the parport_pc module

Relevant syslog extract: 

Feb 17 11:02:13 wielklem kernel: Unable to handle kernel paging request at
virtual address e081060c
Feb 17 11:02:13 wielklem kernel:  printing eip:
Feb 17 11:02:13 wielklem kernel: c0224a95
Feb 17 11:02:13 wielklem kernel: *pde = 1fe3e067
Feb 17 11:02:13 wielklem kernel: *pte = 00000000
Feb 17 11:02:13 wielklem kernel: Oops: 0002 [#1]
Feb 17 11:02:13 wielklem kernel: CPU:    0
Feb 17 11:02:13 wielklem kernel: EIP:    0060:[kobject_add+133/240]    Not tainted
Feb 17 11:02:13 wielklem kernel: EFLAGS: 00010296
Feb 17 11:02:13 wielklem kernel: EIP is at kobject_add+0x85/0xf0
Feb 17 11:02:13 wielklem kernel: eax: c039d844   ebx: e0a5f3b0   ecx: e081060c 
 edx: e0a5f3cc
Feb 17 11:02:13 wielklem kernel: esi: c039d84c   edi: c039d7e4   ebp: e0a5f394 
 esp: ddd15f1c
Feb 17 11:02:13 wielklem kernel: ds: 007b   es: 007b   ss: 0068
Feb 17 11:02:13 wielklem kernel: Process modprobe (pid: 542, threadinfo=ddd14000
task=ddd3ace0)
Feb 17 11:02:13 wielklem kernel: Stack: e0a5f3b0 e0a5f3b0 00000000 c0224b16
e0a5f3b0 e0a5f3b0 e0a5f3b0 c039d7e0 
Feb 17 11:02:13 wielklem kernel:        c0270dc5 e0a5f3b0 e0a5f3b0 e0a5b21d
e0a5f380 e0a5f460 e0a5f4c0 e0a5f500 
Feb 17 11:02:13 wielklem kernel:        c02711d4 e0a5f394 c024f218 e0a5f394
e0a5f400 e09b3151 e0a5f380 00000000 
Feb 17 11:02:13 wielklem kernel: Call Trace:
Feb 17 11:02:13 wielklem kernel:  [kobject_register+22/80]
kobject_register+0x16/0x50
Feb 17 11:02:13 wielklem kernel:  [bus_add_driver+53/144] bus_add_driver+0x35/0x90
Feb 17 11:02:13 wielklem kernel:  [driver_register+52/64] driver_register+0x34/0x40
Feb 17 11:02:13 wielklem kernel:  [pnp_register_driver+40/96]
pnp_register_driver+0x28/0x60
Feb 17 11:02:13 wielklem kernel:  [__crc_mb_cache_entry_takeout+457575/3586750]
parport_pc_init+0x31/0xc3 [parport_pc]
Feb 17 11:02:13 wielklem kernel:  [__crc_mb_cache_entry_takeout+1141452/3586750]
init_module+0x106/0x130 [parport_pc]
Feb 17 11:02:13 wielklem kernel:  [sys_init_module+244/512]
sys_init_module+0xf4/0x200
Feb 17 11:02:13 wielklem kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Feb 17 11:02:13 wielklem kernel: 
Feb 17 11:02:13 wielklem kernel: Code: 89 11 8b 43 28 8b 38 8d 4f 48 89 c8 ba ff
ff 00 00 0f c1 10 
Feb 17 11:02:13 wielklem kernel:  <7>request_module: failed /sbin/modprobe --
parport_lowlevel. error = 11
Feb 17 11:02:13 wielklem kernel: lp: driver loaded but no devices found

