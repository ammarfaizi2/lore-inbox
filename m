Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264010AbUD0Lw2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264010AbUD0Lw2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 07:52:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264022AbUD0Lw2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 07:52:28 -0400
Received: from [62.221.213.104] ([62.221.213.104]:31117 "EHLO
	mx01.websystems.nl") by vger.kernel.org with ESMTP id S264010AbUD0LwZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 07:52:25 -0400
Message-ID: <33610.80.56.84.145.1083066742.squirrel@wmail.websystems.nl>
Date: Tue, 27 Apr 2004 13:52:22 +0200 (CEST)
Subject: 2.6.5: Unable to handle kernel paging request at virtual address
From: "Justin Albstmeijer" <justin@VLAMea.nl>
To: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.2-1
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Because I experienced the following problem:
(Default Fedora Core 1 SMP Kernel Hang on Dual Xeon System )
http://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=109497

on a DELL Poweredge 2650 (2x 2.8Ghz Xeon processors)

I started testing the 2.6 kernel by compiling a custom kernel.
Started with 2.6.4 and moved to 2.6.5 after the problem still occurred.
2.6.5 also crashed after a couple of days.
Then I tried the kernel boot options "noapic acpi=off" and the server work
fine for 10 days.
Then it started giving segmentation faults and showed this in de messages
file:
---------------------------------------------------------------------------
kernel: Unable to handle kernel paging request at virtual address 00100104
kernel:  printing eip:
kernel: c0120525
kernel: *pde = 00000000
kernel: Oops: 0002 [#1]
kernel: SMP
kernel: CPU:    1
kernel: EIP:    0060:[<c0120525>]    Not tainted
kernel: EFLAGS: 00010202   (2.6.5VL01)
kernel: EIP is at __mmdrop+0x58/0x84
kernel: eax: 00100100   ebx: f71be400   ecx: 00000000   edx: 00200200
kernel: esi: f7234580   edi: 00000000   ebp: dfedbf48   esp: dfedbedc
kernel: ds: 007b   es: 007b   ss: 0068
kernel: Process bash (pid: 27353, threadinfo=dfeda000 task=f72fed00)
kernel: Stack: dfbf91c0 0000000c c011e2be c01a5baf 00000004 dfedbefc
00000000 00000000
kernel:        00000004 00000004 00000000 dfbf91e0 6a3d49b2 0002c4dd
dfbf91c0 00000000
kernel:        c24235f0 c2422ca0 fffffc18 00002e8b 6a3d8871 0002c4dd
f72fed00 f72feec8
kernel: Call Trace:
kernel:  [<c011e2be>] schedule+0x495/0x7d8
kernel:  [<c01a5baf>] avc_has_perm+0x62/0x78
kernel:  [<c0124b26>] sys_wait4+0x189/0x231
kernel:  [<c011e601>] default_wake_function+0x0/0xc
kernel:  [<c01231a0>] session_of_pgrp+0x25/0x81
kernel:  [<c011e601>] default_wake_function+0x0/0xc
kernel:  [<c0124bf5>] sys_waitpid+0x27/0x2b
kernel:  [<c010905b>] syscall_call+0x7/0xb
kernel:
kernel: Code: 89 50 04 89 02 c7 43 04 00 02 20 00 c7 03 00 01 10 00 c6 05
----------------------------------------------------------------------------

c01204cd T __mmdrop
c0120551 T mmput
c01205b2 T mmgrab
c01205da T mm_release

I can still ping the server.. but nothing else.

Any suggestion.




