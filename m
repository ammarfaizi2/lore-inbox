Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261325AbVGCLtU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261325AbVGCLtU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Jul 2005 07:49:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261391AbVGCLtT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Jul 2005 07:49:19 -0400
Received: from mailhub3.nextra.sk ([195.168.1.146]:7428 "EHLO
	mailhub3.nextra.sk") by vger.kernel.org with ESMTP id S261325AbVGCLrK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Jul 2005 07:47:10 -0400
Message-ID: <42C7D039.4070006@rainbow-software.org>
Date: Sun, 03 Jul 2005 13:47:05 +0200
From: Ondrej Zary <linux@rainbow-software.org>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-parport@lists.infradead.org
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: pf: Oops with Imation SuperDisk
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've tried to use my external Imation SuperDisk parallel port drive in 
Linux 2.6.12 but failed. The drive is detected properly but when I try 
to mount a floppy, I get errors (they look like timeouts), the system is 
unresponsive (even framebuffer cursor stops blinking) and then it oopses 
  (see below). Also when I configure the port to ECP/EPP in BIOS, the 
driver is unable to use any EPP mode (uses 8-bit and the oops is the same).

sh-3.00# /sbin/modprobe paride
sh-3.00# /sbin/modprobe epat
paride: epat registered as protocol 0
sh-3.00# /sbin/modprobe pf verbose=1 drive0=0x378
pf: pf version 1.04, major 47, cluster 64, nice 0
pf0: 0x378 is parport0
pf0: epat: port 0x378, mode 0, ccr 0, test=(0,256,0)
pf0: epat: port 0x378, mode 1, ccr 40, test=(224,256,448)
pf0: epat: port 0x378, mode 2, ccr 0, test=(0,256,0)
pf0: epat: port 0x378, mode 3, ccr 0, test=(0,256,0)
pf0: epat: port 0x378, mode 4, ccr 0, test=(0,256,0)
pf0: epat: port 0x378, mode 5, ccr 0, test=(0,256,0)
pf0: Sharing parport0 at 0x378
pf0: epat 1.02, Shuttle EPAT chip c6 at 0x378, mode 5 (EPP-32), delay 1
pf0: Reset (1) signature =   1  1  1 14 eb
pf0: MATSHITA LS-120 COSM 04, master LUN 0, type 0, removable, 2880 blocks
sh-3.00# /sbin/mount /dev/pf0 /mnt/floppy/ -t vfat
pf0: MATSHITA LS-120 COSM 04, master LUN 0, type 0, removable, 2880 blocks
pf0: read block completion: alt=0x50 stat=0x50 err=0x100 loop=160001 phase=3
pf0: read block completion: alt=0x50 stat=0x50 err=0x100 loop=160001 phase=3
pf0: read block completion: alt=0x50 stat=0x50 err=0x100 loop=160001 phase=3
pf0: read block completion: alt=0x50 stat=0x50 err=0x100 loop=160001 phase=3
pf0: read block completion: alt=0x50 stat=0x50 err=0x100 loop=160001 phase=3
pf0: read block completion: alt=0x50 stat=0x50 err=0x100 loop=160001 phase=3
pf0: read block completion: alt=0x50 stat=0x50 err=0x100 loop=160001 phase=3
pf0: read block completion: alt=0x50 stat=0x50 err=0x100 loop=160001 phase=3
sh-3.00# ------------[ cut here ]------------
kernel BUG at <bad filename>:54507!
invalid operand: 0000 [#1]
PREEMPT
Modules linked in: pf epat paride
CPU:    0
EIP:    0060:[<c0236967>]    Not tainted VLI
EFLAGS: 00010046   (2.6.12-pentium)
EIP is at end_request+0x47/0x50
eax: 00000000   ebx: c7e43a24   ecx: 00000000   edx: c7e43a24
esi: 00000246   edi: c8822c24   ebp: 00000246   esp: c7f93f34
ds: 007b   es: 007b   ss: 0068
Process events/0 (pid: 3, threadinfo=c7f92000 task=c7fc3020)
Stack: c7f92000 c8821232 00000247 c88211b0 c88200e8 00000000 c8822c20 
c7f92000
        c012016a c113c818 00000000 c8820090 c7f92000 c113c808 c113c800 
ffffffff
        ffffffff 00000001 00000000 c010eb50 00010000 00000000 c0305e0a 
c7f93fc4
Call Trace:
  [<c8821232>] do_pf_read_drq+0x82/0x130 [pf]
  [<c88211b0>] do_pf_read_drq+0x0/0x130 [pf]
  [<c88200e8>] ps_tq_int+0x58/0xd0 [pf]
  [<c012016a>] worker_thread+0x1ba/0x290
  [<c8820090>] ps_tq_int+0x0/0xd0 [pf]
  [<c010eb50>] default_wake_function+0x0/0x10
  [<c0305e0a>] schedule+0x31a/0x5f0
  [<c010eb50>] default_wake_function+0x0/0x10
  [<c011ffb0>] worker_thread+0x0/0x290
  [<c0123e74>] kthread+0x94/0xa0
  [<c0123de0>] kthread+0x0/0xa0
  [<c0100c1d>] kernel_thread_helper+0x5/0x18
Code: da 74 28 8b 43 04 89 42 04 89 5b 04 89 10 89 1b 8b 43 54 85 c0 75 
08 89 d8 5b e9 05 ff ff ff 8b 43 50 89 da e8 eb c0 ff ff eb ec <0f> 0b 
eb d4 90 8d 74 26 00 57
  <6>note: events/0[3] exited with preempt_count 1

-- 
Ondrej Zary
