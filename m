Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266365AbUHWSN4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266365AbUHWSN4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 14:13:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266296AbUHWSN4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 14:13:56 -0400
Received: from nika.frontier.iarc.uaf.edu ([137.229.94.16]:19328 "EHLO
	nika.frontier.iarc.uaf.edu") by vger.kernel.org with ESMTP
	id S266273AbUHWSMF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 14:12:05 -0400
Date: Mon, 23 Aug 2004 10:12:05 -0800
From: Christopher Swingley <cswingle@iarc.uaf.edu>
To: linux-kernel@vger.kernel.org
Subject: Oops during mkfs, SMP Opteron, 2.6.8.1 / -mm4
Message-ID: <20040823181204.GB2519@iarc.uaf.edu>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-gpg-fingerprint: B96C 58DC 0643 F8FE C9D0  8F55 1542 1A4F 0698 252E
X-gpg-key: [http://www.frontier.iarc.uaf.edu/~cswingle/gnupgkey.asc]
X-URL: [http://www.frontier.iarc.uaf.edu/~cswingle/]
X-Editor: VIM [http://www.vim.org]
X-message-flag: Consider Linux: fast, reliable, secure & free!
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings!

I'm getting a kernel oops (manually typed in at the bottom) when I try 
to make an ext3 (or ext2) filesystem on a large (999 GB) RAID array.  I 
get the same oops whether the disks are set up as a hardware RAID (3Ware 
7000 series) or software RAID-5.  The oops is 100% repeatable, and 
always happens at the same place during mkfs.

The system is a dual Opteron system with an MSI mainboard.  The drives 
are SATA drives plugged into a 3Ware 7000 series RAID controller.

I get the oops with both 2.6.8.1 and 2.6.8.1-mm4.

If more information would be helpful, just let me know!

Here's the manually typed in oops:

Unable to handle kernel paging request at 0000000000200e6f RIP:
<ffffffff80157081>{kmem_getpages+129}
PML4 1fdcd9067 PGD 1fe351067 PMD 0
Oops: 0000 [1] SMP
CPU 1
Modules linked in: 8139too mii crc32 tg3
Pid: 1719, comm: mkfs.ext3 Not tainted 2.6.8.1
RIP: 0010:[<ffffffff80157081>] <ffffffff80157081>{kmem_getpages+129}
RSP: 0018:00000101fe38bb88  EFLAGS: 00010213
RAX: ffffffff7fffffff RXB: 00000101fffc9680 RCX: 00000000001fffff
RDX: 0000010000011400 RSI: 0000010000011740 RDI: 0000010000011c00
RBP: 00000101fffc9680 R08: 000001016bc1e000 R09: 000001016c331310
R10: 00000101fffc96a8 R11: 00000101fffc96b8 R12: 0000000000000050
R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000000010
FS:  0000002a95bcf380(0000) GS:ffffffff8050f100(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000000200e6f CR3: 00000000dfeca000 CR4: 00000000000006e0
Process mkfs.ext3 (pid: 1719, threadinfo 00000101fe38a000, task 00000100099229f0)
Stack: 000001016c3f4000 0000000000000000 0000000000000050 ffffffff80157eb0
       00000050fe38bda1 00000101fffc9680 00000101fffc9698 0000000000000050
       0000010005f92658 0000000000000001
Call Trace:<ffffffff80157eb0>{cache_grow+176} <ffffffff801580cf>{cache_alloc_refill+383}
       <ffffffff80158396>{kmem_cache_alloc+54} <ffffffff80175161>{alloc_buffer_head+17}
       <ffffffff8017290a>{create_buffers+42} <ffffffff801732a6>{create_empty_buffers+22}
       <ffffffff8017370f>{__block_prepare_write+175} <ffffffff80177b10>{blkdev_get_block+0}
       <ffffffff801538e2>{__alloc_pages+818} <ffffffff8017419a>{block_prepare_write+26}
       <ffffffff80151593>{generic_file_aio_write_nolock+1315}
       <ffffffff80263617>{write_chan+311} <ffffffff8026370c>{write_chan+556}
       <ffffffff80151a37>{generic_file_write_nolock+103} <ffffffff8012f860>{default_wake_function+0}
       <ffffffff802634e0>{write_chan+0} <ffffffff80178b5a>{blkdev_file_write+26}
       <ffffffff80170497>{vfs_write+199} <ffffffff801705c3>{sys_write+83}
       <ffffffff8010ed4a>{system_call+126}

Code: 48 8b 91 70 0e 00 00 76 07 b8 00 00 00 80 eb 0a 48 b8 00 00
RIP <ffffffff80157081>{kmem_getpages+129} RSP <00000101fe38bb88>
CR2: 0000000000200e6f

Thanks!

Chris
-- 
Christopher S. Swingley          email: cswingle@iarc.uaf.edu (work)
Intl. Arctic Research Center            cswingle@gmail.com (personal)
University of Alaska Fairbanks   www.frontier.iarc.uaf.edu/~cswingle/

