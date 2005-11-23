Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030468AbVKWW4Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030468AbVKWW4Y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 17:56:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030459AbVKWW4Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 17:56:24 -0500
Received: from fmr21.intel.com ([143.183.121.13]:31458 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S1030469AbVKWW4X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 17:56:23 -0500
Message-Id: <200511232256.jANMuGg20547@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Kernel BUG at mm/rmap.c:491
Date: Wed, 23 Nov 2005 14:56:16 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcXwgRvjYRkRFEmsQxyHdUrmWNBDTg==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Has people seen this BUG_ON before?  On 2.6.15-rc2, x86-64.

- Ken


Bad page state at free_hot_cold_page (in process 'sh', page ffff81000482dde8)
flags:0x8000000000000000 mapping:0000000000000000 mapcount:1 count:0
Backtrace:

Call Trace:<ffffffff8014ef8c>{bad_page+115} <ffffffff8014f71f>{free_hot_cold_page+120}
       <ffffffff8014f7d3>{__pagevec_free+33} <ffffffff80154ecc>{release_pages+369}
       <ffffffff80154fc4>{__pagevec_lru_add_active+230} <ffffffff8015b14f>{__handle_mm_fault+680}
       <ffffffff801b0f03>{journal_stop+487} <ffffffff80396970>{do_page_fault+992}
       <ffffffff8013a3bf>{do_sigaction+110} <ffffffff8013a849>{sys_rt_sigaction+132}
       <ffffffff8010e249>{error_exit+0} 
Trying to fix it up, but a reboot is needed
Bad page state at free_hot_cold_page (in process 'sh', page ffff8100049d0f78)
flags:0x8000000000000000 mapping:0000000000000000 mapcount:1 count:0
Backtrace:

Call Trace:<ffffffff8014ef8c>{bad_page+115} <ffffffff8014f71f>{free_hot_cold_page+120}
       <ffffffff8014f7d3>{__pagevec_free+33} <ffffffff80154ecc>{release_pages+369}
       <ffffffff80154fc4>{__pagevec_lru_add_active+230} <ffffffff8015b14f>{__handle_mm_fault+680}
       <ffffffff801b0f03>{journal_stop+487} <ffffffff80396970>{do_page_fault+992}
       <ffffffff8013a3bf>{do_sigaction+110} <ffffffff8013a849>{sys_rt_sigaction+132}
       <ffffffff8010e249>{error_exit+0} 
Trying to fix it up, but a reboot is needed
Bad page state at free_hot_cold_page (in process 'sh', page ffff8100049d0f40)
flags:0x8000000000000004 mapping:0000000000000000 mapcount:1 count:0
Backtrace:

Call Trace:<ffffffff8014ef8c>{bad_page+115} <ffffffff8014f71f>{free_hot_cold_page+120}
       <ffffffff8014f7d3>{__pagevec_free+33} <ffffffff80154ecc>{release_pages+369}
       <ffffffff80154fc4>{__pagevec_lru_add_active+230} <ffffffff8015b14f>{__handle_mm_fault+680}
       <ffffffff801b0f03>{journal_stop+487} <ffffffff80396970>{do_page_fault+992}
       <ffffffff8013a3bf>{do_sigaction+110} <ffffffff8013a849>{sys_rt_sigaction+132}
       <ffffffff8010e249>{error_exit+0} 
Trying to fix it up, but a reboot is needed
sh[16651]: segfault at 0000000000000028 rip 000000000042c830 rsp 00007fffffa8bad8 error 4
Kernel BUG at mm/swap.c:218
invalid operand: 0000 [1] SMP 
CPU 1 
Modules linked in:
Pid: 16500, comm: cc1 Tainted: G    B 2.6.15-rc2 #3
RIP: 0010:[<ffffffff80154db0>] <ffffffff80154db0>{release_pages+85}
RSP: 0018:ffff81011569dca8  EFLAGS: 00010257
RAX: 0000000000000000 RBX: ffff8100049d0fb0 RCX: 0000000000000000
RDX: ffff8100049d0fb0 RSI: 0000000000000010 RDI: ffff810004f38298
RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000000
R13: 0000000000000010 R14: ffff810004f38298 R15: ffff81011569dca8
FS:  00002aaaaaac7b00(0000) GS:ffffffff804e1880(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 000000390128f070 CR3: 00000001034a4000 CR4: 00000000000006e0
Process cc1 (pid: 16500, threadinfo ffff81011569c000, task ffff810116cd03c0)
Stack: 0000000000000000 0000000000000000 ffff810004bdc960 ffff810004ceea70 
       ffff810004aae9d8 ffff810004b2dc70 ffff810004b8f1f0 ffff810004a46730 
       ffff810004d5f090 ffff8100048c5298 
Call Trace:<ffffffff80162597>{free_pages_and_swap_cache+116} <ffffffff80159aa6>{unmap_vma
s+1484}
       <ffffffff8015e98a>{exit_mmap+121} <ffffffff8012c7b0>{mmput+38}
       <ffffffff80130c10>{do_exit+462} <ffffffff8020cbf3>{__up_write+34}
       <ffffffff8013169f>{sys_exit_group+0} <ffffffff8010d50e>{system_call+126}
       

Code: 0f 0b 68 ca c9 3b 80 c2 da 00 f0 83 43 08 ff 0f 98 c0 84 c0 
RIP <ffffffff80154db0>{release_pages+85} RSP <ffff81011569dca8>
 ----------- [cut here ] --------- [please bite here ] ---------
Fixing recursive fault but reboot is needed!
Kernel BUG at mm/rmap.c:491
invalid operand: 0000 [2] SMP 
CPU 3 
Modules linked in:
Pid: 16651, comm: sh Tainted: G    B 2.6.15-rc2 #3
RIP: 0010:[<ffffffff80160b33>] <ffffffff80160b33>{page_remove_rmap+21}
RSP: 0000:ffff810104a89bf0  EFLAGS: 00010286
RAX: 00000000ffffffff RBX: ffff81010466d648 RCX: 000000010466d000
RDX: ffff810001000000 RSI: 0000000000000001 RDI: ffff8100049d0f40
RBP: 00000000006c9000 R08: ffff810104a89d00 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000030001 R12: 80000001084d8067
R13: ffff8100049d0f40 R14: ffff810004f38280 R15: ffff810104a89cb8
FS:  0000000000000000(0000) GS:ffffffff804e1980(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000000000028 CR3: 0000000113261000 CR4: 00000000000006e0
Process sh (pid: 16651, threadinfo ffff810104a88000, task ffff810119681890)
Stack: ffffffff80159a52 ffff810004f38280 00000000006dcfff 00000000006dcfff 
       00000000006dcfff ffff8100048f67e8 00000000fffffff2 ffff81010e1a9c40 
       00000000006dd000 ffff81010a638018 
Call Trace:<ffffffff80159a52>{unmap_vmas+1400} <ffffffff8015e98a>{exit_mmap+121}
       <ffffffff8012c7b0>{mmput+38} <ffffffff80130c10>{do_exit+462}
       <ffffffff80137ff7>{__dequeue_signal+435} <ffffffff8013169f>{sys_exit_group+0}
       <ffffffff801399fd>{get_signal_to_deliver+1163} <ffffffff80138406>{specific_send_sig_info+168}
       <ffffffff8010c9ed>{do_signal+109} <ffffffff80182dc9>{mntput_no_expire+28}
       <ffffffff80182dc9>{mntput_no_expire+28} <ffffffff8016896e>{sys_access+247}
       <ffffffff80172263>{sys_newstat+33} <ffffffff8010db78>{retint_signal+61}
       

Code: 0f 0b 68 b1 ca 3b 80 c2 eb 01 48 c7 c6 ff ff ff ff bf 20 00 
RIP <ffffffff80160b33>{page_remove_rmap+21} RSP <ffff810104a89bf0>
 <1>Fixing recursive fault but reboot is needed!


