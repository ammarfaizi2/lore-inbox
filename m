Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751146AbWAPSQT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751146AbWAPSQT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 13:16:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751147AbWAPSQS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 13:16:18 -0500
Received: from uproxy.gmail.com ([66.249.92.203]:8649 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751146AbWAPSQS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 13:16:18 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=CRS8bYTo+W86zbKSQIQH6WpdYE4Va7SpYsvDozKPPCF0Esr2OAv5t5uAc8tytRIl2jw089YaZ9KjUeTXRJNlpxwH3H2DM6jhzxDgTEkwmmGyF4LscZvuIDtXPz5d+H3R3Tdc0ZR3kjnpSl2LeGaFi/Ve6vcxJFGtVI2S8+1TnsU=
Date: Mon, 16 Jan 2006 19:15:56 +0100
From: Diego Calleja <diegocg@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Oops with current linus' git tree
Message-Id: <20060116191556.bd3f551c.diegocg@gmail.com>
X-Mailer: Sylpheed version 2.1.6 (GTK+ 2.8.9; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm having two noticeable problems with the current linus' tree

1) Oops while watching a DVD with kaffeine (kde based video player),
   oops pasted below.

2) This is a dual p3 machine, but only one CPU is being used to
   run processes on it. CPU #1 is detected etc, but processes will
   be scheduled only in CPU #0. /proc/interrupts shows that CPU #1 is
   still used to service interrupts. I'm able to force processes to run
   on that CPU with taskset but it won't happen automatically like it
   usually does. dmesg here: http://terra.es/personal/diegocg/dmesg


Jan 16 18:04:07 estel kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000040
Jan 16 18:04:07 estel kernel:  printing eip:
Jan 16 18:04:07 estel kernel: c0147a2e
Jan 16 18:04:07 estel kernel: *pde = 00000000
Jan 16 18:04:07 estel kernel: Oops: 0000 [#1]
Jan 16 18:04:07 estel kernel: PREEMPT SMP
Jan 16 18:04:07 estel kernel: Modules linked in: radeon ipt_REJECT xt_tcpudp lp ipt_MASQUERADE iptable_nat ip_nat ip_conntrack iptable_filter
 ip_tables x_tables usbhid ohci_hcd usbcore parport_pc parport floppy pcspkr ide_cd cdrom unix
Jan 16 18:04:07 estel kernel: CPU:    0
Jan 16 18:04:07 estel kernel: EIP:    0060:[find_get_page+46/96]    Not tainted VLI
Jan 16 18:04:07 estel kernel: EFLAGS: 00010002   (2.6.15)
Jan 16 18:04:07 estel kernel: EIP is at find_get_page+0x2e/0x60
Jan 16 18:04:07 estel kernel: eax: 00000040   ebx: 00000040   ecx: 00000000   edx: 00000003
Jan 16 18:04:07 estel kernel: esi: 0003352c   edi: c1a2b178   ebp: c1a2b168   esp: c2b09e20
Jan 16 18:04:07 estel kernel: ds: 007b   es: 007b   ss: 0068
Jan 16 18:04:07 estel kernel: Process kaffeine (pid: 2164, threadinfo=c2b09000 task=e3ffc050)
Jan 16 18:04:07 estel kernel: Stack: <0>00001000 0003352c 0003352c c01491b9 00001000 0000002c f40a3cc0 f40a3d0c
Jan 16 18:04:07 estel kernel:        c1a2b0b4 0003352c 000be343 00000000 0003354a 0003353e 0003352b be344000
Jan 16 18:04:07 estel kernel:        00000000 00000000 00001000 00033521 00000020 00000000 00000000 0003353d
Jan 16 18:04:07 estel kernel: Call Trace:
Jan 16 18:04:07 estel kernel:  [do_generic_mapping_read+409/1200] do_generic_mapping_read+0x199/0x4b0
Jan 16 18:04:07 estel kernel:  [file_read_actor+0/240] file_read_actor+0x0/0xf0
Jan 16 18:04:07 estel kernel:  [__generic_file_aio_read+367/576] __generic_file_aio_read+0x16f/0x240
Jan 16 18:04:07 estel kernel:  [file_read_actor+0/240] file_read_actor+0x0/0xf0
Jan 16 18:04:07 estel kernel:  [unqueue_me+106/176] unqueue_me+0x6a/0xb0
Jan 16 18:04:07 estel kernel:  [generic_file_read+152/192] generic_file_read+0x98/0xc0
Jan 16 18:04:07 estel kernel:  [autoremove_wake_function+0/80] autoremove_wake_function+0x0/0x50
Jan 16 18:04:07 estel kernel:  [default_wake_function+0/16] default_wake_function+0x0/0x10
Jan 16 18:04:07 estel kernel:  [vfs_read+161/352] vfs_read+0xa1/0x160
Jan 16 18:04:07 estel kernel:  [generic_file_read+0/192] generic_file_read+0x0/0xc0
Jan 16 18:04:07 estel kernel:  [sys_read+65/112] sys_read+0x41/0x70
Jan 16 18:04:07 estel kernel:  [sysenter_past_esp+84/117] sysenter_past_esp+0x54/0x75
Jan 16 18:04:07 estel kernel: Code: 89 7c 24 08 8d 78 10 89 1c 24 89 c3 89 f8 89 74 24 04 89 d6 83 c3 04 e8 81 a1 1d 00 89 d8 89 f2 e8 68 83
08 00 85 c0 89 c3 74 0d <8b> 00 89 da f6 c4 40 75 1c f0 ff 42 04 89 f8 e8 be a5 1d 00 89
Jan 16 18:04:07 estel kernel:  <6>note: kaffeine[2164] exited with preempt_count 1
