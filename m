Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751358AbVHNIde@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751358AbVHNIde (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Aug 2005 04:33:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932153AbVHNIde
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Aug 2005 04:33:34 -0400
Received: from xizor.is.scarlet.be ([193.74.71.21]:45966 "EHLO
	xizor.is.scarlet.be") by vger.kernel.org with ESMTP
	id S1751358AbVHNIdd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Aug 2005 04:33:33 -0400
From: "Leopold Gouverneur" <gvlp@scarlet.be>
Date: Sun, 14 Aug 2005 10:37:15 +0200
To: linux-kernel@vger.kernel.org
Subject: oops in 2.6.13-rc6
Message-ID: <20050814083715.GA23313@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yesterday, I tried to record a TV program using mencoder as a "at" job.
When I came back the machine was dead (screen blank, keyboard not
responding). Needed hard reset to reboot. I found this in the log ( the
system was not completly dead since cron continued to write ):

Aug 13 21:15:10 localhost Unable to handle kernel paging request at virtual address 622d2b3b
Aug 13 21:15:10 localhost printing eip:
Aug 13 21:15:10 localhost c013e8a6
Aug 13 21:15:10 localhost *pde = 00000000
Aug 13 21:15:10 localhost Oops: 0002 [#1]
Aug 13 21:15:10 localhost PREEMPT 
Aug 13 21:15:10 localhost Modules linked in: snd_intel8x0 snd_ac97_codec snd_bt87x w83627hf i2c_sensor i2c_isa tuner tvaudio bttv video_buf btcx_risc tveeprom
Aug 13 21:15:10 localhost CPU:    0
Aug 13 21:15:10 localhost EIP:    0060:[<c013e8a6>]    Not tainted VLI
Aug 13 21:15:10 localhost EFLAGS: 00010016   (2.6.13-rc6) 
Aug 13 21:15:10 localhost EIP is at free_block+0x76/0xe0
Aug 13 21:15:10 localhost eax: 622d2b37   ebx: c2066000   ecx: c2066cbc   edx: c2e8f000
Aug 13 21:15:10 localhost esi: dffe7c60   edi: 00000010   ebp: dffe7c6c   esp: c15bfdb0
Aug 13 21:15:10 localhost ds: 007b   es: 007b   ss: 0068
Aug 13 21:15:10 localhost Process kswapd0 (pid: 193, threadinfo=c15be000 task=c1574570)
Aug 13 21:15:10 localhost Stack: dffe7c7c 0000003c dffe9210 dffeeb00 dffe7c60 d4156ecc dffe9210 c013e95c 
Aug 13 21:15:10 localhost 0000003c dffe9200 dffe9200 00000292 d4156ecc c15bff48 c013eb2a c15be000 
Aug 13 21:15:10 localhost c1358520 00000001 c01585bc d4156ecc c0158410 d4156ecc c1358520 dffe0484 
Aug 13 21:15:10 localhost Call Trace:
Aug 13 21:15:10 localhost [<c013e95c>] cache_flusharray+0x4c/0xf0
Aug 13 21:15:10 localhost [<c013eb2a>] kmem_cache_free+0x3a/0x50
Aug 13 21:15:10 localhost [<c01585bc>] free_buffer_head+0x1c/0x50
Aug 13 21:15:10 localhost [<c0158410>] try_to_free_buffers+0x60/0xb0
Aug 13 21:15:10 localhost [<c0140e65>] shrink_list+0x3b5/0x470
Aug 13 21:15:10 localhost [<c01410ce>] shrink_cache+0xfe/0x2f0
Aug 13 21:15:10 localhost [<c01417ae>] shrink_zone+0x9e/0xc0
Aug 13 21:15:10 localhost [<c0141c37>] balance_pgdat+0x247/0x3c0
Aug 13 21:15:10 localhost [<c0141e7d>] kswapd+0xcd/0x110
Aug 13 21:15:10 localhost [<c012c1c0>] autoremove_wake_function+0x0/0x50
Aug 13 21:15:10 localhost [<c0102bd2>] ret_from_fork+0x6/0x14
Aug 13 21:15:10 localhost [<c012c1c0>] autoremove_wake_function+0x0/0x50
Aug 13 21:15:10 localhost [<c0141db0>] kswapd+0x0/0x110
Aug 13 21:15:10 localhost [<c0100eed>] kernel_thread_helper+0x5/0x18
Aug 13 21:15:10 localhost Code: 43 04 47 3b 7c 24 04 7d 6c 8b 44 24 08 8b 15 30 91 49 c0 8b 0c b8 8d 81 00 00 00 40 c1 e8 0c c1 e0 05 8b 5c 10 1c 8b 53 04 8b 03 <89> 50 04 89 02 31 d2 2b 4b 0c c7 03 00 01 10 00 c7 43 04 00 02 
Aug 13 21:15:10 localhost <6>note: kswapd0[193] exited with preempt_count 1
Aug 13 21:20:01 localhost cron[23650]: (root) CMD (test -x /usr/sbin/run-crons && /usr/sbin/run-crons )
Aug 13 21:30:01 localhost cron[23662]: (root) CMD (test -x /usr/sbin/run-crons && /usr/sbin/run-crons )
Aug 13 21:34:51 localhost Unable to handle kernel paging request at virtual address a2dbfac5
Aug 13 21:34:51 localhost printing eip:
Aug 13 21:34:51 localhost c013e8a6
Aug 13 21:34:51 localhost *pde = 00000000
Aug 13 21:34:51 localhost Oops: 0002 [#2]
Aug 13 21:34:51 localhost PREEMPT 
Aug 13 21:34:51 localhost Modules linked in: snd_intel8x0 snd_ac97_codec snd_bt87x w83627hf i2c_sensor i2c_isa tuner tvaudio bttv video_buf btcx_risc tveeprom
Aug 13 21:34:51 localhost CPU:    0
Aug 13 21:34:51 localhost EIP:    0060:[<c013e8a6>]    Not tainted VLI
Aug 13 21:34:51 localhost EFLAGS: 00010012   (2.6.13-rc6) 
Aug 13 21:34:51 localhost EIP is at free_block+0x76/0xe0
Aug 13 21:34:51 localhost eax: a2dbfac1   ebx: d5f82000   ecx: d5f821f0   edx: d60bb020
Aug 13 21:34:51 localhost esi: c153d6e0   edi: 00000008   ebp: c153d6ec   esp: dffa3ee8
Aug 13 21:34:51 localhost ds: 007b   es: 007b   ss: 0068
Aug 13 21:34:51 localhost Process events/0 (pid: 3, threadinfo=dffa2000 task=dffc6020)
Aug 13 21:34:51 localhost Stack: c153d6fc 0000000b dff15470 dff15470 dff15460 0000000b c153d6e0 c013ee61 
Aug 13 21:34:51 localhost c153d4fc c153d6e0 00000001 c153d750 c013ef15 dffa2000 c153d4fc dffa2000 
Aug 13 21:34:51 localhost dffa2000 dffc6148 c0499020 00000297 c0499024 c14db8e0 c0127c0e 00000000 
Aug 13 21:34:51 localhost Call Trace:
Aug 13 21:34:51 localhost [<c013ee61>] drain_array_locked+0x61/0xb0
Aug 13 21:34:51 localhost [<c013ef15>] cache_reap+0x65/0x1b0
Aug 13 21:34:51 localhost [<c0127c0e>] worker_thread+0x1ae/0x280
Aug 13 21:34:51 localhost [<c013eeb0>] cache_reap+0x0/0x1b0
Aug 13 21:34:51 localhost [<c0114f00>] default_wake_function+0x0/0x10
Aug 13 21:34:51 localhost [<c0114f00>] default_wake_function+0x0/0x10
Aug 13 21:34:51 localhost [<c0127a60>] worker_thread+0x0/0x280
Aug 13 21:34:51 localhost [<c012bcc5>] kthread+0x95/0xd0
Aug 13 21:34:51 localhost [<c012bc30>] kthread+0x0/0xd0
Aug 13 21:34:51 localhost [<c0100eed>] kernel_thread_helper+0x5/0x18
Aug 13 21:34:51 localhost Code: 43 04 47 3b 7c 24 04 7d 6c 8b 44 24 08 8b 15 30 91 49 c0 8b 0c b8 8d 81 00 00 00 40 c1 e8 0c c1 e0 05 8b 5c 10 1c 8b 53 04 8b 03 <89> 50 04 89 02 31 d2 2b 4b 0c c7 03 00 01 10 00 c7 43 04 00 02 
Aug 13 21:34:51 localhost <6>note: events/0[3] exited with preempt_count 1
Aug 13 21:35:16 localhost Unable to handle kernel paging request at virtual address 00200204
Aug 13 21:35:16 localhost printing eip:
Aug 13 21:35:16 localhost c013e8a1
Aug 13 21:35:16 localhost *pde = 00000000
Aug 13 21:35:16 localhost Oops: 0000 [#3]
Aug 13 21:35:16 localhost PREEMPT 
Aug 13 21:35:16 localhost Modules linked in: snd_intel8x0 snd_ac97_codec snd_bt87x w83627hf i2c_sensor i2c_isa tuner tvaudio bttv video_buf btcx_risc tveeprom
Aug 13 21:35:16 localhost CPU:    0
Aug 13 21:35:16 localhost EIP:    0060:[<c013e8a1>]    Not tainted VLI
Aug 13 21:35:16 localhost EFLAGS: 00010012   (2.6.13-rc6) 
Aug 13 21:35:16 localhost EIP is at free_block+0x71/0xe0
Aug 13 21:35:16 localhost eax: 002bf280   ebx: 00200200   ecx: d5f949d0   edx: c1000000
Aug 13 21:35:16 localhost esi: c153d6e0   edi: 00000004   ebp: c153d6ec   esp: c167fd1c
Aug 13 21:35:16 localhost ds: 007b   es: 007b   ss: 0068
Aug 13 21:35:16 localhost Process mencoder (pid: 23606, threadinfo=c167e000 task=c6e7aa80)
Aug 13 21:35:16 localhost Stack: c153d6fc 0000001b dff15470 c1567f80 c153d6e0 d5b62af8 dff15470 c013e95c 
Aug 13 21:35:16 localhost 0000001b dff15460 dff15460 00000292 d5b62af8 c167fd94 c013eb2a d5b62b84 
Aug 13 21:35:16 localhost d5b62b84 c167e000 c016d0f5 d5b62b8c c016d3aa 00000028 c167e000 d5bf6b84 
Aug 13 21:35:16 localhost Call Trace:
Aug 13 21:35:16 localhost [<c013e95c>] cache_flusharray+0x4c/0xf0
Aug 13 21:35:16 localhost [<c013eb2a>] kmem_cache_free+0x3a/0x50
Aug 13 21:35:16 localhost [<c016d0f5>] destroy_inode+0x35/0x40
Aug 13 21:35:16 localhost [<c016d3aa>] dispose_list+0x7a/0x100
Aug 13 21:35:16 localhost [<c016d747>] prune_icache+0x167/0x1d0
Aug 13 21:35:16 localhost [<c016d7c4>] shrink_icache_memory+0x14/0x40
Aug 13 21:35:16 localhost [<c0140827>] shrink_slab+0x117/0x190
Aug 13 21:35:16 localhost [<c0141930>] try_to_free_pages+0xe0/0x1a0
Aug 13 21:35:16 localhost [<c013ab0d>] __alloc_pages+0x13d/0x3e0
Aug 13 21:35:16 localhost [<c014534b>] do_anonymous_page+0x6b/0x160
Aug 13 21:35:16 localhost [<c01454a5>] do_no_page+0x65/0x370
Aug 13 21:35:16 localhost [<c0145a60>] __handle_mm_fault+0x1a0/0x200
Aug 13 21:35:16 localhost [<c0113418>] do_page_fault+0x1a8/0x589
Aug 13 21:35:16 localhost [<c0147191>] vma_merge+0x141/0x1e0
Aug 13 21:35:16 localhost [<c01477b9>] do_mmap_pgoff+0x449/0x730
Aug 13 21:35:16 localhost [<c0108b3a>] sys_mmap2+0x7a/0xc0
Aug 13 21:35:16 localhost [<c0113270>] do_page_fault+0x0/0x589
Aug 13 21:35:16 localhost [<c010377b>] error_code+0x4f/0x54
Aug 13 21:35:16 localhost Code: 24 89 5e 1c 89 43 04 47 3b 7c 24 04 7d 6c 8b 44 24 08 8b 15 30 91 49 c0 8b 0c b8 8d 81 00 00 00 40 c1 e8 0c c1 e0 05 8b 5c 10 1c <8b> 53 04 8b 03 89 50 04 89 02 31 d2 2b 4b 0c c7 03 00 01 10 00 
Aug 13 21:35:16 localhost <6>note: mencoder[23606] exited with preempt_count 1
Aug 13 21:39:46 localhost Unable to handle kernel paging request at virtual address a2dbfac5
Aug 13 21:39:46 localhost printing eip:
Aug 13 21:39:46 localhost c013e8a6
Aug 13 21:39:46 localhost *pde = 00000000
Aug 13 21:39:46 localhost Oops: 0002 [#4]
Aug 13 21:39:46 localhost PREEMPT 
Aug 13 21:39:46 localhost Modules linked in: snd_intel8x0 snd_ac97_codec snd_bt87x w83627hf i2c_sensor i2c_isa tuner tvaudio bttv video_buf btcx_risc tveeprom
Aug 13 21:39:46 localhost CPU:    0
Aug 13 21:39:46 localhost EIP:    0060:[<c013e8a6>]    Not tainted VLI
Aug 13 21:39:46 localhost EFLAGS: 00010012   (2.6.13-rc6) 
Aug 13 21:39:46 localhost EIP is at free_block+0x76/0xe0
Aug 13 21:39:46 localhost eax: a2dbfac1   ebx: d5f82000   ecx: d5f821f0   edx: d60bb020
Aug 13 21:39:46 localhost esi: c153d6e0   edi: 00000008   ebp: c153d6ec   esp: df1e3f0c
Aug 13 21:39:46 localhost ds: 007b   es: 007b   ss: 0068
Aug 13 21:39:46 localhost Process cupsd (pid: 5574, threadinfo=df1e2000 task=c1659020)
Aug 13 21:39:46 localhost Stack: c153d6fc 0000001b dff15470 c1567f80 c153d6e0 da2ff088 dff15470 c013e95c 
Aug 13 21:39:46 localhost 0000001b dff15460 dff15460 00000296 da2ff088 cd876b7c c013eb2a da2ff114 
Aug 13 21:39:46 localhost c7132000 da2ff114 c016d0f5 da2ff114 c016e563 00000000 c0163eef df3a5b14 
Aug 13 21:39:46 localhost Call Trace:
Aug 13 21:39:46 localhost [<c013e95c>] cache_flusharray+0x4c/0xf0
Aug 13 21:39:46 localhost [<c013eb2a>] kmem_cache_free+0x3a/0x50
Aug 13 21:39:46 localhost [<c016d0f5>] destroy_inode+0x35/0x40
Aug 13 21:39:46 localhost [<c016e563>] iput+0x53/0x70
Aug 13 21:39:46 localhost [<c0163eef>] sys_unlink+0xbf/0x110
Aug 13 21:39:46 localhost [<c01072fa>] do_gettimeofday+0x1a/0xb0
Aug 13 21:39:46 localhost [<c0102c9b>] sysenter_past_esp+0x54/0x75
Aug 13 21:39:46 localhost Code: 43 04 47 3b 7c 24 04 7d 6c 8b 44 24 08 8b 15 30 91 49 c0 8b 0c b8 8d 81 00 00 00 40 c1 e8 0c c1 e0 05 8b 5c 10 1c 8b 53 04 8b 03 <89> 50 04 89 02 31 d2 2b 4b 0c c7 03 00 01 10 00 c7 43 04 00 02 
Aug 13 21:39:46 localhost <6>note: cupsd[5574] exited with preempt_count 1
