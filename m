Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265237AbUASQCW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 11:02:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265263AbUASQCW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 11:02:22 -0500
Received: from mailhub1.shef.ac.uk ([143.167.1.9]:48818 "EHLO
	mailhub1.shef.ac.uk") by vger.kernel.org with ESMTP id S265237AbUASQCP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 11:02:15 -0500
Subject: 
From: Andrew Beresford <a.j.beresford@sheffield.ac.uk>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Corporate Information and Computer Systems - University of
	Sheffield
Message-Id: <1074528129.3299.9.camel@turtle>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 19 Jan 2004 16:02:10 +0000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm seeing a problem with multicast using mrouted 3.9-beta3 on a 2.6.0
kernel.

When I set mrouted going, it segfaults after a few moments and the
following gets output to messages. If I restart mrouted the machine hard
locks and I have to reset.

The kernel is being tainted by the tsdev touchscreen driver which seems
to load each time I turn my machine on. Nothing else is tainting it, I
promise!

The problem goes away if I use a 2.4 kernel.

Jan 13 09:02:35 turtle kernel: kernel BUG at net/core/dev.c:1021!
Jan 13 09:02:35 turtle kernel: invalid operand: 0000 [#1]
Jan 13 09:02:35 turtle kernel: CPU:    0
Jan 13 09:02:35 turtle kernel: EIP:    0060:[<c0203ba1>]    Tainted: P
Using defaults from ksymoops -t elf32-i386 -a i386
Jan 13 09:02:35 turtle kernel: EFLAGS: 00010206
Jan 13 09:02:35 turtle kernel: eax: 0000127c   ebx: d498ea80   ecx:
f76a1b0f   edx: 00000138
Jan 13 09:02:35 turtle kernel: esi: 0000127a   edi: ca9dc030   ebp:
fffffff4   esp: c0dbbac8
Jan 13 09:02:35 turtle kernel: ds: 007b   es: 007b   ss: 0068
Jan 13 09:02:35 turtle kernel: Stack: 00000000 defd9800 d498ea80
c0203f13 d498ea80 d498ea80 dd6a11a4 ca9dc01c
Jan 13 09:02:35 turtle kernel: dd6a1180 c021bff1 d498ea80 c033d748
c0b10b00 d498ea80 00000024 c024aecb
Jan 13 09:02:35 turtle kernel: d498ea80 defd9800 ca9dc030 c08a3080
00000000 c1fa4cc0 c0997018 c0138fa0
Jan 13 09:02:35 turtle kernel: Call Trace:
Jan 13 09:02:35 turtle kernel: [<c0203f13>] dev_queue_xmit+0x22b/0x274
Jan 13 09:02:35 turtle kernel: [<c021bff1>] ip_finish_output+0xc5/0x1c8
Jan 13 09:02:35 turtle kernel: [<c024aecb>] ipmr_queue_xmit+0x1f7/0x350
Jan 13 09:02:35 turtle kernel: [<c0138fa0>] cache_init_objs+0x54/0x60
Jan 13 09:02:35 turtle kernel: [<c02001fb>] kfree_skbmem+0x17/0x1c
Jan 13 09:02:35 turtle kernel: [<c024b180>] ip_mr_forward+0x134/0x13c
Jan 13 09:02:35 turtle kernel: [<c0249ca0>]
ipmr_cache_resolve+0x10c/0x11c
Jan 13 09:02:35 turtle kernel: [<c024a3ae>] ipmr_mfc_add+0x10a/0x1b4
Jan 13 09:02:35 turtle kernel: [<c024a814>]
ip_mroute_setsockopt+0x240/0x304
Jan 13 09:02:35 turtle kernel: [<c01192d6>] recalc_task_prio+0xa6/0x1f0
Jan 13 09:02:35 turtle kernel: [<c021f8c1>] ip_setsockopt+0xdf1/0xe58
Jan 13 09:02:35 turtle kernel: [<c020183f>] memcpy_toiovec+0x53/0x84
Jan 13 09:02:35 turtle kernel: [<c0201fb6>]
skb_copy_datagram_iovec+0x3e/0x1e4
Jan 13 09:02:35 turtle kernel: [<c02001fb>] kfree_skbmem+0x17/0x1c
Jan 13 09:02:35 turtle kernel: [<c020029c>] __kfree_skb+0x9c/0x11c
Jan 13 09:02:35 turtle kernel: [<c0237f9f>] raw_recvmsg+0xeb/0x134
Jan 13 09:02:35 turtle kernel: [<c0240821>] inet_recvmsg+0x39/0x50
Jan 13 09:02:35 turtle kernel: [<c01fcf90>] sock_recvmsg+0x8c/0xb0
Jan 13 09:02:35 turtle kernel: [<c013625d>] rmqueue_bulk+0x4d/0x70
Jan 13 09:02:35 turtle kernel: [<c01c5a41>] pty_write+0x19d/0x1a4
Jan 13 09:02:35 turtle kernel: [<c0136697>] __alloc_pages+0x97/0x2dc
Jan 13 09:02:35 turtle kernel: [<c0119f88>] schedule+0x2dc/0x574
Jan 13 09:02:35 turtle kernel: [<c01fe179>] sys_recvfrom+0x9d/0xf4
Jan 13 09:02:35 turtle kernel: [<c01fe1b9>] sys_recvfrom+0xdd/0xf4
Jan 13 09:02:35 turtle kernel: [<c015ae10>] poll_freewait+0x3c/0x44
Jan 13 09:02:35 turtle kernel: [<c015b140>] do_select+0x1a8/0x2b4
Jan 13 09:02:35 turtle kernel: [<c023fa35>] inet_setsockopt+0x21/0x28
Jan 13 09:02:35 turtle kernel: [<c01fe238>] sys_setsockopt+0x48/0x70
Jan 13 09:02:35 turtle kernel: [<c01fe8e4>] sys_socketcall+0x16c/0x1c4
Jan 13 09:02:35 turtle kernel: [<c0120115>] sys_time+0x39/0x50
Jan 13 09:02:35 turtle kernel: [<c010b525>] sysenter_past_esp+0x52/0x71
Jan 13 09:02:35 turtle kernel: Code: 0f 0b fd 03 27 94 27 c0 89 c8 c1 e0
10 81 e1 00 00 ff ff 01
 
 
>>EIP; c0203ba1 <i8042_command+b1/d0>   <=====
 
>>ebx; d498ea80 <__crc___release_region+3e8ac/2ff41e>
>>ecx; f76a1b0f <__crc_compute_creds+2c5b85/4dc4f6>
>>edi; ca9dc030 <__crc_kunmap+fa386/538e07>
>>ebp; fffffff4 <__kernel_rt_sigreturn+1bb4/????>
>>esp; c0dbbac8 <__crc_tcp_create_openreq_child+35a4d2/3f36c7>
 
Trace; c0203f13 <i8042_interrupt+e3/190>
Trace; c021bff1 <nf_reinject+61/290>
Trace; c024aecb <tcp_create_openreq_child+35b/490>
Trace; c0138fa0 <kallsyms_release+20/40>
Trace; c02001fb <fb_copy_cmap+15b/490>
Trace; c024b180 <tcp_check_req+180/4d0>
Trace; c0249ca0 <tcp_v4_lookup+1c0/210>
Trace; c024a3ae <tcp_time_wait+1ae/340>
Trace; c024a814 <tcp_tw_deschedule+54/a0>
Trace; c01192d6 <mca_configure_adapter_status+36/80>
Trace; c021f8c1 <hippi_header+81/140>
Trace; c020183f <input_register_device+8f/130>
Trace; c0201fb6 <input_devices_read+1f6/5f0>
Trace; c02001fb <fb_copy_cmap+15b/490>
Trace; c020029c <fb_copy_cmap+1fc/490>
Trace; c0237f9f <tcp_disconnect+22f/400>
Trace; c0240821 <tcp_fragment+121/320>
Trace; c01fcf90 <fb_cursor+190/270>
Trace; c013625d <module_unload_free+ad/e0>
Trace; c01c5a41 <acpi_power_add+125/142>
Trace; c0136697 <symbol_put_addr+17/90>
Trace; c0119f88 <setup_p4_watchdog+68/140>
Trace; c01fe179 <parse_display_block+1a9/2b0>
Trace; c01fe1b9 <parse_display_block+1e9/2b0>
Trace; c015ae10 <generic_cont_expand+20/160>
Trace; c015b140 <cont_prepare_write+1f0/370>
Trace; c023fa35 <tcp_rcv_state_process+895/940>
Trace; c01fe238 <parse_display_block+268/2b0>
Trace; c01fe8e4 <parse_detailed_timing_block+f4/130>
Trace; c0120115 <copy_files+1a5/310>
Trace; c010b525 <irq_entries_start+c5/880>
 
Code;  c0203ba1 <i8042_command+b1/d0>
00000000 <_EIP>:
Code;  c0203ba1 <i8042_command+b1/d0>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0203ba3 <i8042_command+b3/d0>
   2:   fd                        std
Code;  c0203ba4 <i8042_command+b4/d0>
   3:   03 27                     add    (%edi),%esp
Code;  c0203ba6 <i8042_command+b6/d0>
   5:   94                        xchg   %eax,%esp
Code;  c0203ba7 <i8042_command+b7/d0>
   6:   27                        daa
Code;  c0203ba8 <i8042_command+b8/d0>
   7:   c0 89 c8 c1 e0 10 81      rorb   $0x81,0x10e0c1c8(%ecx)
Code;  c0203baf <i8042_command+bf/d0>
   e:   e1 00                     loope  10 <_EIP+0x10>
Code;  c0203bb1 <i8042_command+c1/d0>
  10:   00 ff                     add    %bh,%bh
Code;  c0203bb3 <i8042_command+c3/d0>
  12:   ff 01                     incl   (%ecx)
 
 
1 warning and 1 error issued.  Results may not be reliable.

-- 
Andrew Beresford <a.j.beresford@sheffield.ac.uk>
Network Administrator - Corporate Information and Computer Systems
Tel: 0114 222 3022

