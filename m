Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263607AbUAYDRM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 22:17:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263618AbUAYDRM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 22:17:12 -0500
Received: from citrine.spiritone.com ([216.99.193.133]:14251 "EHLO
	citrine.spiritone.com") by vger.kernel.org with ESMTP
	id S263607AbUAYDRE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 22:17:04 -0500
Date: Sat, 24 Jan 2004 19:17:01 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: henning@skalatan.de
Subject: [Bug 1950] New: kernel BUG at mm/mmap.c:1443,	with compile load 
Message-ID: <274030000.1075000621@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=1950

           Summary: kernel BUG at mm/mmap.c:1443, with compile load
    Kernel Version: 2.6.1
            Status: NEW
          Severity: normal
             Owner: rml@tech9.net
         Submitter: henning@skalatan.de


Distribution: Gentoo Linux 1.4 
Hardware Environment: AMD Athlon(tm) XP 1900+, X86 
Software Environment: gcc-3.2.3, sh, Python (ebuild-environment) 
Problem Description:  
The compiling of a new glibc Version (3.2.3) abort with a Segmentation fault, 
or hang forever. 
 
Steps to reproduce: 
Restart the compiling process. 
 
---- 
Bug 1: 
------------[ cut here ]------------ 
kernel BUG at mm/mmap.c:1443! 
invalid operand: 0000 [#1] 
CPU:    0 
EIP:    0060:[<c014e1c2>]    Not tainted 
EFLAGS: 00010202 
EIP is at exit_mmap+0x182/0x190 
eax: 00000001   ebx: ec7aed40   ecx: 000de000   edx: 00000000 
esi: ec7aed40   edi: f3722000   ebp: ec7aed60   esp: f3723e78 
ds: 007b   es: 007b   ss: 0068 
Process mkinstalldirs (pid: 19847, threadinfo=f3722000 task=f26a8100) 
Stack: f3723e90 ec7aed40 f475df80 00000000 ffffffff f3723e94 c046c548 0000004c 
       ec7aed40 ec7aed60 f26a8100 c011f745 ec7aed40 c03b4938 ec7aed40 c012379d 
       ec7aed40 ec7aed40 f26a86c4 f26a8100 f3722000 0000000b 0000000b f3722000 
Call Trace: 
 [<c011f745>] mmput+0x65/0xc0 
 [<c012379d>] do_exit+0x15d/0x3f0 
 [<c0123b1b>] do_group_exit+0x7b/0xc0 
 [<c012ccc1>] get_signal_to_deliver+0x1f1/0x380 
 [<c0109272>] do_signal+0xe2/0x120 
 [<c016756b>] do_pipe+0x17b/0x1f0 
 [<c010f07e>] destroy_context+0x6e/0xd0 
 [<c0120ef4>] __mmdrop+0x34/0x46 
 [<c011dafc>] schedule+0x3bc/0x590 
 [<c012cec0>] sigprocmask+0x40/0xc0 
 [<c012d03a>] sys_rt_sigprocmask+0xfa/0x160 
 [<c011bbf0>] do_page_fault+0x0/0x4e2 
 [<c0109309>] do_notify_resume+0x59/0x5c 
 [<c01094e6>] work_notifysig+0x13/0x15 
 
Code: 0f 0b a3 05 7f 9f 36 c0 e9 06 ff ff ff 90 83 ec 28 89 5c 24 
 <6>note: mkinstalldirs[19847] exited with preempt_count 1 
------ 
 
Bug 2: 
------------[ cut here ]------------ 
kernel BUG at mm/mmap.c:1443! 
invalid operand: 0000 [#2] 
CPU:    0 
EIP:    0060:[<c014e1c2>]    Not tainted 
EFLAGS: 00010202 
EIP is at exit_mmap+0x182/0x190 
eax: 00000001   ebx: eb0fab80   ecx: 0007f000   edx: 00000000 
esi: eb0fab80   edi: dbaf8000   ebp: eb0faba0   esp: dbaf9e78 
ds: 007b   es: 007b   ss: 0068 
Process sh (pid: 30682, threadinfo=dbaf8000 task=ed045320) 
Stack: dbaf9e90 eb0fab80 f2b50340 00000000 ffffffff dbaf9e94 c046c548 0000003d 
       eb0fab80 eb0faba0 ed045320 c011f745 eb0fab80 c03b4938 eb0fab80 c012379d 
       eb0fab80 eb0fab80 ed0458e4 ed045320 dbaf8000 0000000b 0000000b dbaf8000 
Call Trace: 
 [<c011f745>] mmput+0x65/0xc0 
 [<c012379d>] do_exit+0x15d/0x3f0 
 [<c0123b1b>] do_group_exit+0x7b/0xc0 
 [<c012ccc1>] get_signal_to_deliver+0x1f1/0x380 
 [<c0109272>] do_signal+0xe2/0x120 
 [<c0124217>] sys_wait4+0x1f7/0x290 
 [<c012e04b>] sys_rt_sigaction+0xfb/0x120 
 [<c011bbf0>] do_page_fault+0x0/0x4e2 
 [<c0109309>] do_notify_resume+0x59/0x5c 
 [<c01094e6>] work_notifysig+0x13/0x15 
 
Code: 0f 0b a3 05 7f 9f 36 c0 e9 06 ff ff ff 90 83 ec 28 89 5c 24 
 <6>note: sh[30682] exited with preempt_count 1


