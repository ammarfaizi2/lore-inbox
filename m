Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264508AbTE1FF6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 01:05:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264509AbTE1FF6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 01:05:58 -0400
Received: from rwcrmhc53.attbi.com ([204.127.198.39]:54999 "EHLO
	rwcrmhc53.attbi.com") by vger.kernel.org with ESMTP id S264508AbTE1FF4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 01:05:56 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
Organization: ( )
To: LKML <linux-kernel@vger.kernel.org>
Subject: kernel BUG at include/linux/blkdev (2.5.70)
Date: Tue, 27 May 2003 23:23:29 -0400
User-Agent: KMail/1.5.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305272323.29063.ivg2@cornell.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Out of nowhere on mozilla open (after it worked fine all afternoon):

------------[ cut here ]------------
kernel BUG at include/linux/blkdev.h:408!
invalid operand: 0000 [#1]
CPU:    0
EIP:    0060:[<c02322be>]    Tainted: P  
EFLAGS: 00010046
EIP is at blk_queue_start_tag+0x8e/0x100
eax: dfdfaf40   ebx: 00000000   ecx: c040176c   edx: dfdfc1a8
esi: dfdfc1a8   edi: dff52240   ebp: dff52260   esp: cf275aa8
ds: 007b   es: 007b   ss: 0068
Process mozilla-bin (pid: 3073, threadinfo=cf274000 task=d7296cc0)
Stack: da5a3880 000003e8 c04016c0 c040176c 00000286 00000001 dfdf0080 c040176c 
       c0245baa c040177c dfdfc1a8 00e916ff c04016c0 c0246832 c040176c dfdfc1a8 
       c01142d4 00000060 00000283 00000000 c01e92f2 000003e8 0023e546 000001f7 
Call Trace:
 [<c0245baa>] idedisk_start_tag+0x7a/0x90
 [<c0246832>] __ide_do_rw_disk+0x722/0x770
 [<c01142d4>] delay_tsc+0x14/0x40
 [<c01e92f2>] __delay+0x12/0x20
 [<c023afb4>] start_request+0x104/0x160
 [<c023b28b>] ide_do_request+0x24b/0x430
 [<c023b48d>] do_ide_request+0x1d/0x30
 [<c0233c5b>] __make_request+0x2bb/0x4f0
 [<c0233fb1>] generic_make_request+0x121/0x1b0
 [<c011e1d0>] autoremove_wake_function+0x0/0x50
 [<c023407d>] submit_bio+0x3d/0x70
 [<c0173a5e>] mpage_bio_submit+0x2e/0x40
 [<c0173d22>] do_mpage_readpage+0x182/0x320
 [<c0155347>] __find_get_block+0x67/0xe0
 [<c01391e0>] add_to_page_cache+0x70/0x110
 [<c0173feb>] mpage_readpages+0x12b/0x160
 [<c01bd790>] reiserfs_get_block+0x0/0x15a0
 [<c013cb3f>] __rmqueue+0xbf/0x110
 [<c013eca5>] read_pages+0x115/0x120
 [<c01bd790>] reiserfs_get_block+0x0/0x15a0
 [<c013d072>] __alloc_pages+0x92/0x320
 [<c013eded>] do_page_cache_readahead+0x13d/0x1c0
 [<c013efb5>] page_cache_readahead+0x145/0x190
 [<c0139a42>] do_generic_mapping_read+0xb2/0x3b0
 [<c0139d40>] file_read_actor+0x0/0x110
 [<c013a009>] __generic_file_aio_read+0x1b9/0x200
 [<c0139d40>] file_read_actor+0x0/0x110
 [<c013a15e>] generic_file_read+0x8e/0xb0
 [<c01609a0>] link_path_walk+0x610/0x8e0
 [<c015fd50>] vfs_permission+0x80/0x110
 [<c015fe34>] permission+0x54/0x70
 [<c016139f>] may_open+0x5f/0x230
 [<c0153600>] get_empty_filp+0x90/0x100
 [<c016160d>] open_namei+0x9d/0x440
 [<c0151a0a>] dentry_open+0xea/0x210
 [<c01c18c0>] reiserfs_file_release+0x0/0x490
 [<c0169962>] dput+0x22/0x1e0
 [<c01c18c0>] reiserfs_file_release+0x0/0x490
 [<c0152702>] vfs_read+0xe2/0x150
 [<c01522e0>] default_llseek+0x0/0xd0
 [<c01529c2>] sys_read+0x42/0x70
 [<c01092a5>] sysenter_past_esp+0x52/0x71

Code: 0f 0b 98 01 6e 51 32 c0 eb b6 8b 4f 14 90 8d 74 26 00 83 c3 
 <6>note: mozilla-bin[3073] exited with preempt_count 1


