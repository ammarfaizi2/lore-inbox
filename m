Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266816AbUHCXPx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266816AbUHCXPx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 19:15:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266902AbUHCXPq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 19:15:46 -0400
Received: from serv1.aus1.texas.net ([216.166.60.40]:46749 "EHLO
	serv1.aus1.texas.net") by vger.kernel.org with ESMTP
	id S266816AbUHCXPk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 19:15:40 -0400
Message-ID: <41101C9B.9090209@corp.texas.net>
Date: Tue, 03 Aug 2004 18:15:39 -0500
From: Philip Molter <philip@corp.texas.net>
User-Agent: Mozilla Thunderbird 0.7.2 (Windows/20040707)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: kernel BUG at fs/ext3/balloc.c:942!
Content-Type: multipart/mixed;
 boundary="------------060509020209080107080203"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060509020209080107080203
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This is a FC2 stock errata kernel 2.6.6-1.435.2.3, roughly equivalent to 
2.6.7-rc2.  This kernel does contain the bugfix in fs/ext3/file.c 
(http://marc.theaimsgroup.com/?l=linux-kernel&m=108395053322261&w=2). 
This only occurs under heavy load, but I can't pinpoint where or how. 
It must be a race because we cannot reproduce the problem reliably.

Log output attached

If anyone has any insight, please let me know,

Philip Molter
Giganews

--------------060509020209080107080203
Content-Type: text/plain;
 name="balloc-oops.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="balloc-oops.txt"

Aug  3 17:01:54 h01 kernel: kernel BUG at fs/ext3/balloc.c:942!
Aug  3 17:01:54 h01 kernel: invalid operand: 0000 [#1]
Aug  3 17:01:54 h01 kernel: SMP
Aug  3 17:01:54 h01 kernel: Modules linked in: e1000 bonding ipv6 mii 8021q floppy sg microcode dm_mod uhci_hcd ext3 jbd raid5 xor raid1 3w_xxxx sd_mod scsi_mod
Aug  3 17:01:54 h01 kernel: CPU:    1
Aug  3 17:01:54 h01 kernel: EIP:    0060:[<82897d5b>]    Not tainted
Aug  3 17:01:54 h01 kernel: EFLAGS: 00010287   (2.6.6-1.435.2.3smp)
Aug  3 17:01:54 h01 kernel: EIP is at ext3_try_to_allocate_with_rsv+0x119/0x1bc [ext3]
Aug  3 17:01:54 h01 kernel: eax: 00520000   ebx: 00518000   ecx: 00518000   edx: 6ec144dc
Aug  3 17:01:54 h01 kernel: esi: 00000000   edi: ffffffff   ebp: 81f42200   esp: 0415ebf8
Aug  3 17:01:54 h01 kernel: ds: 007b   es: 007b   ss: 0068
Aug  3 17:01:54 h01 kernel: Process pdflush (pid: 68, threadinfo=0415e000 task=81d5cc70)
Aug  3 17:01:54 h01 kernel: Stack: 7b24c100 000000a3 3cdc72cc 00000000 000000a3 000000a3 00002000 81f42200
Aug  3 17:01:54 h01 kernel:        82898049 6f98a14c 00002000 6ec144dc 0415ec58 00000220 6ec144dc 7b248000
Aug  3 17:01:54 h01 kernel:        7b284400 7b26c460 00000000 00000001 6f98a14c 0051a000 6ec14534 3cdc72cc
Aug  3 17:01:54 h01 kernel: Call Trace:
Aug  3 17:01:54 h01 kernel:  [<82898049>] ext3_new_block+0x1ba/0x4aa [ext3]
Aug  3 17:01:54 h01 kernel:  [<8289a1ab>] ext3_alloc_block+0x9/0xb [ext3]
Aug  3 17:01:54 h01 kernel:  [<8289a4e1>] ext3_alloc_branch+0x4a/0x232 [ext3]
Aug  3 17:01:54 h01 kernel:  [<021fdd17>] as_add_request+0xbd/0x179
Aug  3 17:01:54 h01 kernel:  [<8289a9fe>] ext3_get_block_handle+0x1c7/0x28e [ext3]
Aug  3 17:01:54 h01 kernel:  [<8289ab29>] ext3_get_block+0x64/0x6c [ext3]
Aug  3 17:01:54 h01 kernel:  [<021544c0>] __block_write_full_page+0x107/0x2d0
Aug  3 17:01:54 h01 kernel:  [<8289aac5>] ext3_get_block+0x0/0x6c [ext3]
Aug  3 17:01:54 h01 kernel:  [<0215585f>] block_write_full_page+0xc7/0xd0
Aug  3 17:01:54 h01 kernel:  [<8289aac5>] ext3_get_block+0x0/0x6c [ext3]
Aug  3 17:01:54 h01 kernel:  [<8289b3b3>] ext3_ordered_writepage+0xca/0x136 [ext3]
Aug  3 17:01:54 h01 kernel:  [<8289b2c9>] bget_one+0x0/0x7 [ext3]
Aug  3 17:01:54 h01 kernel:  [<0216dda0>] mpage_writepages+0x143/0x273
Aug  3 17:01:54 h01 kernel:  [<8289b2e9>] ext3_ordered_writepage+0x0/0x136 [ext3]
Aug  3 17:01:54 h01 kernel:  [<0216c747>] __sync_single_inode+0x5d/0x19a
Aug  3 17:01:54 h01 kernel:  [<0216ca9c>] sync_sb_inodes+0x18e/0x242
Aug  3 17:01:54 h01 kernel:  [<0213ca16>] pdflush+0x0/0x1e
Aug  3 17:01:54 h01 kernel:  [<0216cbc9>] writeback_inodes+0x79/0xcd
Aug  3 17:01:54 h01 kernel:  [<0213c00a>] background_writeout+0x73/0xb5
Aug  3 17:01:54 h01 kernel:  [<0213c97a>] __pdflush+0xf6/0x192
Aug  3 17:01:54 h01 kernel:  [<0213ca30>] pdflush+0x1a/0x1e
Aug  3 17:01:54 h01 kernel:  [<0213bf97>] background_writeout+0x0/0xb5
Aug  3 17:01:54 h01 kernel:  [<0213ca16>] pdflush+0x0/0x1e
Aug  3 17:01:54 h01 kernel:  [<0212ff79>] kthread+0x73/0x9b
Aug  3 17:01:54 h01 kernel:  [<0212ff06>] kthread+0x0/0x9b
Aug  3 17:01:54 h01 kernel:  [<021051f1>] kernel_thread_helper+0x5/0xb
Aug  3 17:01:54 h01 kernel:
Aug  3 17:01:54 h01 kernel: Code: 0f 0b ae 03 31 89 8a 82 ff 74 24 2c 89 e8 57 ff 74 24 2c 8b
--------------060509020209080107080203--
