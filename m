Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265069AbTFCQHH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 12:07:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265071AbTFCQHH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 12:07:07 -0400
Received: from dm4-167.slc.aros.net ([66.219.220.167]:20099 "EHLO cyprus")
	by vger.kernel.org with ESMTP id S265069AbTFCQHE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 12:07:04 -0400
Message-ID: <3EDCCACD.5040209@aros.net>
Date: Tue, 03 Jun 2003 10:20:29 -0600
From: Lou Langholtz <ldl@aros.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: warren@togami.com
Subject: Re: 2.5.70 kernel BUG include/linux/dcache.h:271!
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maybe related? I've also run into this BUG output but from a very 
different path... the following 2.5.70 kernel output was the result of 
running rmmod (from the new rusty init tools package) for the nbd module 
that I've been hacking on (with additional printk output as seen). It 
may well be the hacks I've done to nbd are wrong (hopefully that's the 
case), but note the ref counts marked "q.e.ref#" which is from 
disk->queue->elevator.kobj.refcount for each "disk". Negative values 
seem really wrong in this case and don't seem likely the fault of my 
hacks but rather a bug in the elevator and/or block handling code.

Please CC me in reply, I am not subscribed to lkml either.
ldl@aros.net

Thanks!!

------------[ cut here ]------------
Jun  2 23:09:36 cyprus kernel: nbd: nbd_exit called.
Jun  2 23:09:36 cyprus kernel: nb0: calling del_gendisk(d56f1dc0): 43 
0-0 ref#=4 q=e3268560 q.e.ref#=2
Jun  2 23:09:36 cyprus kernel: nb1: calling del_gendisk(d56f1cc0): 43 
1-1 ref#=4 q=e3268560 q.e.ref#=0
Jun  2 23:09:36 cyprus kernel: nb2: calling del_gendisk(d56f3c80): 43 
2-2 ref#=4 q=e3268560 q.e.ref#=-2
Jun  2 23:09:36 cyprus kernel: nb3: calling del_gendisk(d56f1ac0): 43 
3-3 ref#=4 q=e3268560 q.e.ref#=-4
Jun  2 23:09:36 cyprus kernel: nb4: calling del_gendisk(d56f15c0): 43 
4-4 ref#=4 q=e3268560 q.e.ref#=-6
Jun  2 23:09:36 cyprus kernel: nb5: calling del_gendisk(d56f16c0): 43 
5-5 ref#=4 q=e3268560 q.e.ref#=-8
Jun  2 23:09:36 cyprus kernel: nb6: calling del_gendisk(d56f3980): 43 
6-6 ref#=4 q=e3268560 q.e.ref#=-10
Jun  2 23:09:36 cyprus kernel: ------------[ cut here ]------------
Jun  2 23:09:36 cyprus kernel: kernel BUG at include/linux/dcache.h:271!
Jun  2 23:09:36 cyprus kernel: invalid operand: 0000 [#1]
Jun  2 23:09:36 cyprus kernel: CPU:    0
Jun  2 23:09:36 cyprus kernel: EIP:    0060:[<c0176b1d>]    Tainted: GF
Jun  2 23:09:36 cyprus kernel: EFLAGS: 00210246
Jun  2 23:09:36 cyprus kernel: EIP is at sysfs_remove_dir+0x1d/0x13f
Jun  2 23:09:36 cyprus kernel: eax: 00000000   ebx: e32685a4   ecx: 
c027a0a0   edx: 00000000
Jun  2 23:09:36 cyprus kernel: esi: 00000006   edi: d5cad5c0   ebp: 
d8eadec0   esp: d8eadea8
Jun  2 23:09:36 cyprus kernel: ds: 007b   es: 007b   ss: 0068
Jun  2 23:09:36 cyprus kernel: Process rmmod (pid: 1732, 
threadinfo=d8eac000 task=d6224d80)
Jun  2 23:09:36 cyprus kernel: Stack: d5cb9340 dfd6fbc0 dfd6fbe8 
e32685a4 00000006 d56f3a48 d8eaded8 c0204e53
Jun  2 23:09:36 cyprus kernel:        e32685a4 c047e740 e32685a4 
e32685a4 d8eadee8 c0204e94 e32685a4 d56f3980
Jun  2 23:09:36 cyprus kernel:        d8eadef8 c0275eae e32685a4 
d56f3980 d8eadf0c c0279bd4 d56f3980 d56f3980
Jun  2 23:09:36 cyprus kernel: Call Trace:
Jun  2 23:09:36 cyprus kernel:  [<e32685a4>] nbd_queue+0x44/0x14c [nbd]
Jun  2 23:09:36 cyprus kernel:  [<c0204e53>] kobject_del+0x43/0x70
Jun  2 23:09:36 cyprus kernel:  [<e32685a4>] nbd_queue+0x44/0x14c [nbd]
Jun  2 23:09:36 cyprus last message repeated 2 times
Jun  2 23:09:36 cyprus kernel:  [<c0204e94>] kobject_unregister+0x14/0x20
Jun  2 23:09:36 cyprus kernel:  [<e32685a4>] nbd_queue+0x44/0x14c [nbd]
Jun  2 23:09:36 cyprus kernel:  [<c0275eae>] elv_unregister_queue+0x1e/0x40
Jun  2 23:09:36 cyprus kernel:  [<e32685a4>] nbd_queue+0x44/0x14c [nbd]
Jun  2 23:09:36 cyprus kernel:  [<c0279bd4>] unlink_gendisk+0x14/0x40
Jun  2 23:09:36 cyprus kernel:  [<c0175951>] del_gendisk+0x61/0x110
Jun  2 23:09:36 cyprus kernel:  [<e32617a4>] +0x644/0x7400 [nbd]
Jun  2 23:09:36 cyprus kernel:  [<e325efec>] nbd_exit+0x7c/0x157 [nbd]
Jun  2 23:09:36 cyprus kernel:  [<e3268560>] nbd_queue+0x0/0x14c [nbd]
Jun  2 23:09:36 cyprus kernel:  [<e3268800>] +0x0/0x140 [nbd]
Jun  2 23:09:36 cyprus kernel:  [<c012c30e>] sys_delete_module+0x12e/0x170
Jun  2 23:09:36 cyprus kernel:  [<e3268800>] +0x0/0x140 [nbd]
Jun  2 23:09:36 cyprus kernel:  [<c010c73c>] do_IRQ+0xcc/0xe0
Jun  2 23:09:36 cyprus kernel:  [<c010ac4d>] sysenter_past_esp+0x52/0x71
Jun  2 23:09:36 cyprus kernel:
Jun  2 23:09:36 cyprus kernel: Code: 0f 0b 0f 01 db 9a 3c c0 ff 07 85 ff 
0f 84 08 01 00 00 8b 47


