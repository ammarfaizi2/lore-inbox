Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266625AbUBQXds (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 18:33:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266626AbUBQXds
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 18:33:48 -0500
Received: from delerium.kernelslacker.org ([81.187.208.145]:18843 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S266625AbUBQXdp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 18:33:45 -0500
Date: Tue, 17 Feb 2004 23:31:20 +0000
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.3rc4 floppy oops.
Message-ID: <20040217233120.GA8117@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Another fun one on module unload..

		Dave

kernel: Floppy drive(s): fd0 is 1.44M
kernel: FDC 0 is a post-1991 82077
kernel: Uninitialised timer!
kernel: This is just a warning.  Your computer is OK
kernel: function=0x00000000, data=0x0
kernel: Call Trace:
modprobe: FATAL: Module ide_probe not found.
kernel:  [<c012d2f4>] check_timer_failed+0x3c/0x58
kernel:  [<c012d72c>] del_timer+0x15/0xca
kernel:  [<c7c714d2>] floppy_ready+0x0/0x1f9 [floppy]
kernel:  [<c7c7149a>] start_motor+0x9e/0xd6 [floppy]
kernel:  [<c7c714fb>] floppy_ready+0x29/0x1f9 [floppy]
kernel:  [<c0135496>] worker_thread+0x1b4/0x250
kernel:  [<c7c714d2>] floppy_ready+0x0/0x1f9 [floppy]
kernel:  [<c01217e4>] default_wake_function+0x0/0xc
kernel:  [<c010b586>] ret_from_fork+0x6/0x20
kernel:  [<c01217e4>] default_wake_function+0x0/0xc
kernel:  [<c01352e2>] worker_thread+0x0/0x250
kernel:  [<c01091ed>] kernel_thread_helper+0x5/0xb
kernel:
kernel: ------------[ cut here ]------------
kernel: kernel BUG at kernel/timer.c:154!
kernel: invalid operand: 0000 [#1]
kernel: CPU:    0
kernel: EIP:    0060:[<c012d3b6>]    Not tainted
kernel: EFLAGS: 00010246
kernel: EIP is at __mod_timer+0x1a/0x29d
kernel: eax: c7c7c740   ebx: fff3733f   ecx: 00000005   edx: fffd84a7
kernel: esi: 00000000   edi: c7c7c740   ebp: 000003e8   esp: c6f7df18
kernel: ds: 007b   es: 007b   ss: 0068
kernel: Process events/0 (pid: 4, threadinfo=c6f7c000 task=c1162650)
kernel: Stack: 00000000 fffd84a7 c6d3fe08 c01216e2 c6f7df80 00000046 00000000 fffd7995
kernel:        00000000 fff3733f 00000000 c7c7c740 000003e8 c7c6fb07 00000000 0000044a
kernel:        000000a6 c7c7b4c0 00000206 00000000 c6f7f2b4 c7c73070 c111acc0 c111acc0
kernel: Call Trace:
kernel:  [<c01216e2>] schedule+0x526/0x628
kernel:  [<c7c6fb07>] floppy_off+0xb4/0xbc [floppy]
kernel:  [<c7c73070>] redo_fd_request+0x22/0x350 [floppy]
kernel:  [<c0135496>] worker_thread+0x1b4/0x250
kernel:  [<c7c7304e>] redo_fd_request+0x0/0x350 [floppy]
kernel:  [<c01217e4>] default_wake_function+0x0/0xc
kernel:  [<c010b586>] ret_from_fork+0x6/0x20
kernel:  [<c01217e4>] default_wake_function+0x0/0xc
kernel:  [<c01352e2>] worker_thread+0x0/0x250
kernel:  [<c01091ed>] kernel_thread_helper+0x5/0xb
kernel:
kernel: Code: 0f 0b 9a 00 75 b0 2d c0 81 7f 14 6e ad 87 4b 74 07 89 f8 e8

