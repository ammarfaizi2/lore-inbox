Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266322AbUFURAE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266322AbUFURAE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 13:00:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266323AbUFURAE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 13:00:04 -0400
Received: from havoc.gtf.org ([216.162.42.101]:23715 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S266330AbUFUQ7w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 12:59:52 -0400
Date: Mon, 21 Jun 2004 12:59:46 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@osdl.org>
Subject: oops in 2.6.7-bk-latest
Message-ID: <20040621165946.GA14025@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This oops snuck into the tree _very_ recently, as it did not happen
to me last night when I was testing "kernel too fast" fixes.  I was
about to try Linus's latest fix, when this hit.

Linus, as soon as I reboot into a stable kernel, I'll install BK-latest
plus your fix, reboot into that kernel, and give it a test.


We see that mke2fs is stuck in disk wait, as expected from this sort of oops:
15690 pts/8    S      0:00  |       \_ /bin/sh /sbin/installkernel 2.6.7 arch/i3
15700 pts/8    S      0:00  |           \_ /bin/bash /sbin/new-kernel-pkg --mkin
15707 pts/8    S      0:00  |               \_ /bin/bash /sbin/mkinitrd -f /boot
15939 pts/8    D      0:00  |                   \_ mke2fs /dev/loop0 8000


Command being executed at the time:
$ sudo installkernel 2.6.7 arch/i386/boot/bzImage System.map 


loop: loaded (max 8 devices)
Unable to handle kernel NULL pointer dereference at virtual address 00000001
 printing eip:
f88e9611
*pde = 00000000
Oops: 0000 [#1]
SMP 
Modules linked in: loop i810_audio ac97_codec tg3 battery ata_piix libata
CPU:    1
EIP:    0060:[<f88e9611>]    Not tainted
EFLAGS: 00010282   (2.6.7) 
EIP is at do_lo_receive+0x23/0x78 [loop]
eax: 00000000   ebx: cae71000   ecx: 00000001   edx: 00000000
esi: 00000000   edi: 00000001   ebp: 00000000   esp: e2203f58
ds: 007b   es: 007b   ss: 0068
Process loop0 (pid: 15937, threadinfo=e2202000 task=dea5d6b0)
Stack: c1713d60 00000001 cae71130 e2202000 cae71124 00000000 00000000 cae71000 
       cae7112c 00000003 00000001 00000000 f88e96c8 cae71000 00000001 00001000 
       00000000 00000000 00000000 f7fdd800 cae71000 cae71124 00000000 f88e973b 
Call Trace:
 [<f88e96c8>] lo_receive+0x62/0x88 [loop]
 [<f88e973b>] do_bio_filebacked+0x4d/0x79 [loop]
 [<f88e99cb>] loop_thread+0xa4/0x10b [loop]
 [<f88e9927>] loop_thread+0x0/0x10b [loop]
 [<c0104271>] kernel_thread_helper+0x5/0xb
Code: 8b 01 89 44 24 20 8b 41 08 89 44 24 24 8b 44 24 3c 89 44 24 

