Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261408AbULEWcx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261408AbULEWcx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 17:32:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261410AbULEWcx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 17:32:53 -0500
Received: from main.gmane.org ([80.91.229.2]:2273 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261408AbULEWco (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 17:32:44 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?ISO-8859-15?Q?Sven_K=F6hler?= <skoehler@upb.de>
Subject: [BUG] null-pointer deref (perhaps reiserfs3)
Date: Sun, 05 Dec 2004 23:31:38 +0100
Message-ID: <cp02a6$57j$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: p5484ae5f.dip.t-dialin.net
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4.2) Gecko/20040426
X-Accept-Language: de, en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

on a machine that i can only reach via SSH at the moment, i got a 
null-pointer dereference (see below). The machine runs kernel 2.6.9 
without any additional patches.

It happened, while i was doing a "make install". A command within the 
"installkernel"-script segfaulted. It seems that only the filesystem 
mounted to /boot is affected. Any access to that FS blocks.

Is there any way to recover the situation remotely? I'm thinking about 
unmounting /boot, and running fsck.reiserfs, but i cannot umount the FS, 
since the device is still in use.



Unable to handle kernel NULL pointer dereference at virtual address 00000000
  printing eip:
c018d632
*pde = 00000000
Oops: 0000 [#1]
SMP
Modules linked in: nfsd exportfs lockd sunrpc ipt_state ip_conntrack 
ipt_REJECT ipt_ULOG iptable_filter ip_tables ohci_hcd ehci_hcd uhci_hcd 
rtc usbcore 8250_acpi 8250 serial_core e100 mii ide_cd sr_mod cdrom
CPU:    1
EIP:    0060:[<c018d632>]    Not tainted VLI
EFLAGS: 00010282   (2.6.9)
EIP is at scan_bitmap_block+0x32/0x280
eax: f894f000   ebx: 00000001   ecx: 00000000   edx: 00000000
esi: f894f008   edi: db319c5c   ebp: f7fd9600   esp: db319bf8
ds: 007b   es: 007b   ss: 0068
Process cat (pid: 15917, threadinfo=db318000 task=f47b26d0)
Stack: f3c90000 00008000 00002618 00000001 db319c10 00000000 00000000 
00000000
        00000001 db319c5c 00000000 f7fd9600 c018db60 db319ebc 00000001 
db319c5c
        00000801 00000020 00000020 00000001 00008000 00000800 00000001 
00008000
Call Trace:
  [<c018db60>] scan_bitmap+0x200/0x230
  [<c018ed06>] reiserfs_allocate_blocknrs+0x176/0x4f0
  [<c019bef0>] reiserfs_allocate_blocks_for_region+0x270/0x1660
  [<c01ad843>] search_for_position_by_key+0x1d3/0x400
  [<c01ac0a3>] pathrelse+0x23/0x40
  [<c019dfbc>] reiserfs_prepare_file_region_for_write+0x3bc/0x9d0
  [<c019eb3b>] reiserfs_file_write+0x56b/0x7c0
  [<c01546f8>] vfs_write+0xb8/0x130
  [<c0154841>] sys_write+0x51/0x80
  [<c01041ef>] syscall_call+0x7/0xb
Code: 8b 44 24 34 8b 7c 24 3c 8b 54 24 38 8b 28 8b 0f 8b 85 64 01 00 00 
8b 40 08 89 4c 24 14 8d 34 d0 85 f6 0f 84 2f 02 00 00 8b 56 04 <8b> 02 
a8 04 0f 85 15 02 00 00 0f b7 46 02 31 d2 3b 44 24 44 0f


