Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261714AbTHWINo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 04:13:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261560AbTHWINo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 04:13:44 -0400
Received: from wall.ttu.ee ([193.40.254.238]:18701 "EHLO wall.ttu.ee")
	by vger.kernel.org with ESMTP id S261963AbTHWINm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 04:13:42 -0400
Date: Sat, 23 Aug 2003 11:13:39 +0300 (EET DST)
From: Siim Vahtre <siim@pld.ttu.ee>
To: linux-kernel@vger.kernel.org
Subject: cryptoloop bug with 2.6.0-test3
Message-ID: <Pine.GSO.4.53.0308231109170.20934@pitsa.pld.ttu.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

siim@void:/boot$ lsmod
Module                  Size  Used by
crypto_null             1792  0
twofish                38272  0
ext2                   46372  0
des                    11296  0
serpent                13248  0
aes                    32192  0
cryptoloop              2336  0
loop                   13704  1 cryptoloop
fbcon                  27040  0
font                    5600  1 fbcon
i810fb                 27296  1
cfbcopyarea             3584  1 i810fb
vgastate                9280  1 i810fb
cfbimgblt               2784  1 i810fb
cfbfillrect             3456  1 i810fb

siim@void:/boot$ sudo rmmod twofish crypto_null des serpent aes cryptoloop loop

Unable to handle kernel paging request at virtual address 19000040
 printing eip:
c01d4f24
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c01d4f24>]    Not tainted
EFLAGS: 00010206
EIP is at kobject_del+0x34/0x80
eax: 19000000   ebx: cdced650   ecx: cdced650   edx: 19000000
esi: cfd845a0   edi: cfd84660   ebp: cd4ee000   esp: cd4efef4
ds: 007b   es: 007b   ss: 0068
Process rmmod (pid: 22179, threadinfo=cd4ee000 task=c9a28760)
Stack: cfdab780 00000000 cd4ee000 cdced650 c01d4f83 cdced650 cdced600
c020ddda
       cdced650 cdced600 c021167e cdced600 cfd845a0 c0332538 c02125f3
cfd845a0
       cfd845a0 cfd845a0 c0183466 cfd845a0 00000000 00000000 c0332538
00000000
Call Trace:
 [<c01d4f83>] kobject_unregister+0x13/0x30
 [<c020ddda>] elv_unregister_queue+0x1a/0x40
 [<c021167e>] blk_unregister_queue+0x1e/0x50
 [<c02125f3>] unlink_gendisk+0x13/0x40
 [<c0183466>] del_gendisk+0x66/0xe0
 [<d4a120e0>] cleanup_module+0x70/0x8b [loop]
 [<c01317eb>] sys_delete_module+0x11b/0x140
 [<c0146c00>] do_munmap+0x90/0x190
 [<c0146d44>] sys_munmap+0x44/0x70
 [<c01092ab>] syscall_call+0x7/0xb

Code: 8b 52 40 85 d2 74 25 89 5c 24 08 8b 41 24 c7 04 24 1e 62 30
Segmentation fault

After that, 'lsmod' hangs and is unkillable.
