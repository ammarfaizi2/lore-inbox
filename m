Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263366AbSKDEx0>; Sun, 3 Nov 2002 23:53:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264764AbSKDExV>; Sun, 3 Nov 2002 23:53:21 -0500
Received: from mail.michigannet.com ([208.49.116.30]:3853 "EHLO
	member.michigannet.com") by vger.kernel.org with ESMTP
	id <S263366AbSKDExT>; Sun, 3 Nov 2002 23:53:19 -0500
Date: Sun, 3 Nov 2002 23:59:49 -0500
From: Paul <set@pobox.com>
To: linux-kernel@vger.kernel.org
Subject: [Oops] 2.5.45-mcp2 BUG at mm/highmem.c
Message-ID: <20021104045949.GG20069@squish.home.loc>
Mail-Followup-To: Paul <set@pobox.com>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi;

	Testing on a system that was LVM1 based. One oops from a
gcc3.2 compiled kernel, the other from a gcc2.95.3 compiled
kernel. (I wish it was vanilla, but it doesnt compile with device
mapper, needed -mcp2) [compilation failure posted by others]
[using latest device mapper and LVM2 tools from sistina]
	hda and hdc, who both work with DMA under 2.4.19,
yield eg. on detection:
hda: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
hda: task_no_data_intr: error=0x04 { DriveStatusError }
	And DMA seems to be disabled after that. (as reported by
hdparm)
	Light stressing, by tar copying an fs from one logical volume
to another, or rm -rf a full fs triggered both oops quickly.

	This is the gcc-2.95.3 compiled kernels oops [they look
very similar]. If anyone is interested, and wants more detail
like .config, boot mesg, or wants me to test anything, just ask.

Paul
set@pobox.com

ksymoops 2.4.5 on i586 2.5.45-mcp2.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.45-mcp2/ (default)
     -m /boot/System.map-2.5.45-mcp2 (specified)

kernel BUG at mm/highmem.c:455!
invalid operand: 0000
CPU:    0
EIP:    0060:[<c0132522>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: c7fb86a0   ebx: c0350c28   ecx: c11cfc88   edx: 00000001
esi: 00000002   edi: 00000400   ebp: c0350c28   esp: c11cfc48
ds: 0068   es: 0068   ss: 0068
Stack: c7ec4800 c01c0d6e c0350c28 c11cfc88 c7ec4800 00000002 c0350c28 c7fb86a0 
       00254ad5 c11cd860 00000004 00000001 00000000 c013b451 c01c1289 c0350c28 
       c7fb86a0 c7dffd30 c7fb86a0 c7fb86a0 c882204c c0203495 c7fb86a0 00000002 
Call Trace: [<c01c0d6e>]  [<c013b451>]  [<c01c1289>]  [<c0203495>]  [<c020365a>]  [<c0203709>]  [<c020381f>]  [<c01c1289>]  [<c01c1326>]  [<c01511f2>]  [<c0151a97>]  [<c01c1326>]  [<c0139890>]  [<c013994e>]  [<c0139970>]  [<c0151d6d>]  [<c01772a8>]  [<c017811f>]  [<c0178408>]  [<c0177706>]  [<c01772a8>]  [<c0133df4>]  [<c015098c>]  [<c0150afe>]  [<c0150c93>]  [<c0150d68>]  [<c0133baa>]  [<c01337b0>]  [<c0133858>]  [<c0133863>]  [<c0133b54>]  [<c01054ad>] 
Code: 0f 0b c7 01 4e 7c 26 c0 8d b6 00 00 00 00 f6 83 9c 00 00 00


>>EIP; c0132522 <blk_queue_bounce+12/70>   <=====

>>eax; c7fb86a0 <_end+7c59ce0/84b66a0>
>>ebx; c0350c28 <ide_hwifs+848/4b78>
>>ecx; c11cfc88 <_end+e712c8/84b66a0>
>>ebp; c0350c28 <ide_hwifs+848/4b78>
>>esp; c11cfc48 <_end+e71288/84b66a0>

Trace; c01c0d6e <__make_request+4a/408>
Trace; c013b451 <bio_alloc+31/1cc>
Trace; c01c1289 <generic_make_request+15d/170>
Trace; c0203495 <__map_bio+3d/dc>
Trace; c020365a <__clone_and_map+72/b4>
Trace; c0203709 <__split_bio+6d/100>
Trace; c020381f <dm_request+83/9c>
Trace; c01c1289 <generic_make_request+15d/170>
Trace; c01c1326 <submit_bio+8a/94>
Trace; c01511f2 <mpage_bio_submit+22/28>
Trace; c0151a97 <mpage_writepage+42f/4c4>
Trace; c01c1326 <submit_bio+8a/94>
Trace; c0139890 <bh_lru_install+104/110>
Trace; c013994e <__find_get_block+b2/bc>
Trace; c0139970 <__getblk+18/3c>
Trace; c0151d6d <mpage_writepages+241/374>
Trace; c01772a8 <ext2_get_block+0/360>
Trace; c017811f <ext2_update_inode+3b/334>
Trace; c0178408 <ext2_update_inode+324/334>
Trace; c0177706 <ext2_writepages+12/18>
Trace; c01772a8 <ext2_get_block+0/360>
Trace; c0133df4 <do_writepages+18/2c>
Trace; c015098c <__sync_single_inode+68/168>
Trace; c0150afe <__writeback_single_inode+72/78>
Trace; c0150c93 <sync_sb_inodes+18f/218>
Trace; c0150d68 <writeback_inodes+4c/90>
Trace; c0133baa <background_writeout+56/a8>
Trace; c01337b0 <__pdflush+150/1f8>
Trace; c0133858 <pdflush+0/14>
Trace; c0133863 <pdflush+b/14>
Trace; c0133b54 <background_writeout+0/a8>
Trace; c01054ad <kernel_thread_helper+5/c>

Code;  c0132522 <blk_queue_bounce+12/70>
00000000 <_EIP>:
Code;  c0132522 <blk_queue_bounce+12/70>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0132524 <blk_queue_bounce+14/70>
   2:   c7 01 4e 7c 26 c0         movl   $0xc0267c4e,(%ecx)
Code;  c013252a <blk_queue_bounce+1a/70>
   8:   8d b6 00 00 00 00         lea    0x0(%esi),%esi
Code;  c0132530 <blk_queue_bounce+20/70>
   e:   f6 83 9c 00 00 00 00      testb  $0x0,0x9c(%ebx)

