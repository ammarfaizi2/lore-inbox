Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261670AbTJ1UA5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 15:00:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261685AbTJ1UA5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 15:00:57 -0500
Received: from fw.osdl.org ([65.172.181.6]:35032 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261670AbTJ1UAw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 15:00:52 -0500
Message-Id: <200310282000.h9SK0ko25805@mail.osdl.org>
Date: Tue, 28 Oct 2003 12:00:43 -0800 (PST)
From: markw@osdl.org
Subject: linux-2.6.0-test9 oops with lvm2
To: linux-lvm@sistina.com
cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've got the following oops with pdflush on 2.6.0-test9.  I have a
52 disk LVM2 (v2.00.07) volume attached through a pair of Adaptec raid
controllers. It appears to oops after I've created an ext2 filesystem on
the volume and attempt to mount it.  I wonder if it might be device
manager related since I see dm_request in the call trace. If there's any
more information I can provide, let me know.

Thanks!

Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:                                                                
c0146797      
*pde = 37c83001
*pte = 00000000
Oops: 0000 [#1]
CPU:    0      
EIP:    0060:[<c0146797>]    Not tainted
EFLAGS: 00010082                        
EIP is at page_address+0x17/0xb0
eax: 00000000   ebx: 00000000   ecx: 00000004   edx: f7f68160
esi: f6a38c00   edi: 00000000   ebp: 00000001   esp: f7d91b54
ds: 007b   es: 007b   ss: 0068                               
Process pdflush (pid: 35, threadinfo=f7d90000 task=f7d95310)
Stack: 00000001 f6df3f00 f6a38c00 00000000 00000001 c0219dbc 00000000 cab3cc20 
       00000020 00000000 00002f30 00000000 00000000 00000008 00000010 f6df3f00 
       f6a38c00 00000010 cab3caa0 00000010 c021a2cf f6a38c00 cab3cc20 f7fc7260 
Call Trace:                                                                    
 [<c0219dbc>] __make_request+0x1fc/0x5a0
 [<c021a2cf>] generic_make_request+0x16f/0x1f0
 [<c02920ad>] __map_bio+0x3d/0x100            
 [<c0292459>] __clone_and_map+0x1d9/0x310
 [<c011e1a0>] autoremove_wake_function+0x0/0x50
 [<c0292618>] __split_bio+0x88/0x100           
 [<c0292753>] dm_request+0xc3/0xe0  
 [<c021a2cf>] generic_make_request+0x16f/0x1f0
 [<c011e1a0>] autoremove_wake_function+0x0/0x50
 [<c021a3a4>] submit_bio+0x54/0xa0             
 [<c017a0de>] mpage_bio_submit+0x2e/0x40
 [<c017ab26>] mpage_writepage+0x246/0x790
 [<c015af83>] __find_get_block+0x73/0x100
 [<c015b107>] __bread+0x27/0x50          
 [<c01947d8>] ext2_get_inode+0xe8/0x140
 [<c017b30c>] mpage_writepages+0x29c/0x2db
 [<c0193920>] ext2_get_block+0x0/0x410    
 [<c0193f3f>] ext2_writepages+0x1f/0x30
 [<c0193920>] ext2_get_block+0x0/0x410 
 [<c013f7ee>] do_writepages+0x1e/0x40 
 [<c0179574>] __sync_single_inode+0xc4/0x220
 [<c017992c>] sync_sb_inodes+0x1ac/0x270    
 [<c0179a59>] writeback_inodes+0x69/0xa0
 [<c013f5f8>] wb_kupdate+0xe8/0x160     
 [<c013fc00>] __pdflush+0xd0/0x1c0 
 [<c013fcf0>] pdflush+0x0/0x20    
 [<c013fcff>] pdflush+0xf/0x20
 [<c013f510>] wb_kupdate+0x0/0x160
 [<c01072a4>] kernel_thread_helper+0x0/0xc
 [<c01072a9>] kernel_thread_helper+0x5/0xc
                                          
Code: 8b 03 a9 00 01 00 00 75 30 8b 0d 6c b3 42 c0 29 cb c1 fb 03 

-- 
Mark Wong - - markw@osdl.org
Open Source Development Lab Inc - A non-profit corporation
12725 SW Millikan Way - Suite 400 - Beaverton, OR 97005
(503) 626-2455 x 32 (office)
(503) 626-2436      (fax)
