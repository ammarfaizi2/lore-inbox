Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262129AbTIMLSm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 07:18:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262131AbTIMLSm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 07:18:42 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:3339 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S262129AbTIMLSj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 07:18:39 -0400
Subject: Re: New reiser4 snapshot (2003.09.12) is out
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Oleg Drokin <green@namesys.com>
Cc: reiserfs-dev@namesys.com, reiserfs-list@namesys.com,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20030912161534.GA8439@namesys.com>
References: <20030912161534.GA8439@namesys.com>
Content-Type: text/plain
Message-Id: <1063451900.1285.3.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Sat, 13 Sep 2003 13:18:21 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-09-12 at 18:15, Oleg Drokin wrote:
> Hello!
> 
>    Another reiser4 snapshot was released today. This time it is against
>    2.6.0-test5.
>    Please take note that DISK DORMAT IS CHANGED, so you need to recreate
>    your reiser4 filesystems (if you have any). This involves getting new
>    reiser4progs, too.
> 
>    The snapshot is available from http://www.namesys.com/snapshots/2003.09.12

I've downloaded libaal and reiser4progs as noted above. I applied the
whole reiser4.diff to 2.6.0-test5-bk3, but, when I run:

# mkfs.reiser4 /dev/hda4
# mount -t reiser4 /dev/hda4 /mnt

I get the following oops:

reiser4[mount(306)]: parse_node40
(fs/reiser4/plugin/node/node40.c:745)[nikita-494]:
WARNING: Wrong level found in node: 2 != 0
 reiser4[mount(306)]: key_warning
(fs/reiser4/plugin/object.c:86)[nikita-717]:
WARNING: Error for inode 42 (-5)
Unable to handle kernel NULL pointer dereference at virtual address
00000000
 printing eip:
c01ae82d
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c01ae82d>]    Not tainted
EFLAGS: 00010286
EIP is at inode_detach_jnode+0x1d/0xa0
eax: 00000000   ebx: cc627d80   ecx: cc627d80   edx: c80b8054
esi: c16d0000   edi: 00000000   ebp: c10dd4c8   esp: c16d1c1c
ds: 007b   es: 007b   ss: 0068
Process mount (pid: 306, threadinfo=c16d0000 task=ce87b900)
Stack: c10dd4c8 ffffe000 cc627d80 c16d0000 00000000 c01ae988 cc627d80
c16d0000 
       c01ae9cd cc627d80 cc627d80 c01cf8b8 cc627d80 cc627d80 cee30680
c16d0000 
       c01c2f51 00000000 00000000 00000000 00000000 00000000 00000000
00000000 
Call Trace:
 [<c01ae988>] unhash_unformatted_node_nolock+0x58/0x80
 [<c01ae9cd>] unhash_unformatted_jnode+0x1d/0x40
 [<c01cf8b8>] reiser4_invalidatepage+0xd8/0x160
 [<c01c2f51>] dealloc_wmap+0x31/0x40
 [<c013fef7>] do_invalidatepage+0x27/0x30
 [<c013ff7f>] truncate_complete_page+0x7f/0x90
 [<c0140170>] truncate_inode_pages+0x100/0x2a0
 [<c016c99f>] wake_up_inode+0xf/0x30
 [<c0172d1b>] write_inode_now+0x4b/0x90
 [<c016c4ae>] generic_forget_inode+0x14e/0x170
 [<c016c552>] iput+0x62/0x90
 [<c01c670d>] done_formatted_fake+0x4d/0x60
 [<c01cddba>] reiser4_fill_super+0x44a/0x630
 [<c0159754>] get_sb_bdev+0x124/0x160
 [<c01ce19f>] reiser4_get_sb+0x2f/0x40
 [<c01cd970>] reiser4_fill_super+0x0/0x630
 [<c01599bf>] do_kern_mount+0x5f/0xe0
 [<c016f2c8>] do_add_mount+0x78/0x160
 [<c016f5d4>] do_mount+0x134/0x180
 [<c016f490>] copy_mount_options+0xe0/0xf0
 [<c016f99f>] sys_mount+0xbf/0x140
 [<c010941b>] syscall_call+0x7/0xb

Code: 8b 38 ff 46 14 8d 9f 24 ff ff ff 8b 51 14 89 0c 24 a1 5c 0d 
 <6>note: mount[306] exited with preempt_count 2

Reiser4 was built into the kernel.

