Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264012AbTE0SJM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 14:09:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264060AbTE0SIV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 14:08:21 -0400
Received: from 214.156-136-217.adsl.skynet.be ([217.136.156.214]:43533 "EHLO
	gw.ici") by vger.kernel.org with ESMTP id S264037AbTE0SHf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 14:07:35 -0400
Message-ID: <3ED3AC36.5050503@trollprod.org>
Date: Tue, 27 May 2003 20:19:34 +0200
From: Olivier NICOLAS <olivn@trollprod.org>
Organization: TrollPod
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021204
X-Accept-Language: fr, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: ALSA problems: sound lockup, modules, 2.5.70
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel: 2.5.70

Soundcard uses  snd-intel8x0


On module load

intel8x0: clocking to 48000
Slab corruption: start=deda495c, expend=deda4ad3, problemat=deda4a9c
Last user: [<c018e47d>](proc_destroy_inode+0x1d/0x20)
Data:
********************************************************************************************************************************************************************************************************************************************************************************************************************************AC 

36 96 DE ***************************************************A5
Next: 71 F0 2C .7D E4 18 C0 A5 C2 0F 17 B0 E6 AD DF 0C 00 00 00 A0 34
19
C0 00 00 00 00 00 00 00 00
slab error in check_poison_obj(): cache `proc_inode_cache': object was
modified after freeing
Call Trace:
   [<c0142237>] check_poison_obj+0x147/0x1b0
   [<c0143f2c>] kmem_cache_alloc+0x14c/0x180
   [<c018e40c>] proc_alloc_inode+0x1c/0x70
   [<c018e40c>] proc_alloc_inode+0x1c/0x70
   [<c0178cbe>] alloc_inode+0x1e/0x160
   [<c0178cbe>] alloc_inode+0x1e/0x160
   [<c01798bb>] new_inode+0x1b/0xd0
   [<c019054c>] proc_pid_make_inode+0x9c/0xe0
   [<c01904d0>] proc_pid_make_inode+0x20/0xe0
   [<c0143f2c>] kmem_cache_alloc+0x14c/0x180
   [<c0190a17>] proc_lookupfd+0x57/0x270
   [<c016bc5c>] real_lookup+0xdc/0x110
   [<c016c10b>] do_lookup+0x8b/0xa0
   [<c016c589>] link_path_walk+0x469/0x6a0
   [<c016ccde>] __user_walk+0x3e/0x60
   [<c01678fa>] sys_readlink+0x2a/0x90
   [<c015b1f6>] sys_open+0x76/0x90
   [<c01097f3>] syscall_call+0x7/0xb




On module unload

Unable to handle kernel paging request at virtual address 6b6b6b6b
   printing eip:
c0166e55
*pde = 00000000
Oops: 0002 [#1]
CPU:    0
EIP:    0060:[<c0166e55>]    Not tainted
EFLAGS: 00210202
EIP is at cdev_purge+0x35/0xb0
eax: 6b6b6b6b   ebx: c17cdc84   ecx: cb1f2ad8   edx: 6b6b6b6b
esi: c17cdc4c   edi: 00000000   ebp: d65c3f14   esp: d65c3efc
ds: 007b   es: 007b   ss: 0068
Process rmmod (pid: 1828, threadinfo=d65c2000 task=d71572d0)
Stack: c0349060 00200286 c17cdc4c 00000000 c17cdc4c c0341298 d65c3f24
c0167162
         c17cdc4c c0342fe0 d65c3f34 c01f3425 c17cdc4c def25bd4 d65c3f4c
c0166a4f
         c17cdc4c 00000000 00000100 e0a10880 d65c3f5c e0a0ba99 00000074
e0a0be6a
Call Trace:
   [<c0167162>] cdev_dynamic_release+0x12/0x20
   [<c01f3425>] kobject_cleanup+0x45/0x50
   [<c0166a4f>] unregister_chrdev+0x5f/0x70
   [<e0a10880>] +0x0/0x180 [snd]
   [<e0a0ba99>] alsa_sound_exit+0x39/0x60 [snd]
   [<e0a0be6a>] +0x8b/0x41d [snd]
   [<c01388bf>] sys_delete_module+0x14f/0x180
   [<e0a10880>] +0x0/0x180 [snd]
   [<c014eb44>] sys_munmap+0x54/0x70



