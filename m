Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269761AbUJALrw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269761AbUJALrw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 07:47:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269764AbUJALrw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 07:47:52 -0400
Received: from dhcp-7-96.dsl.telerama.com ([205.201.7.96]:30080 "EHLO
	catabasis.no-ip.com") by vger.kernel.org with ESMTP id S269761AbUJALrn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 07:47:43 -0400
Date: Fri, 1 Oct 2004 07:47:40 -0400
From: wknop@catabasis.no-ip.com
To: linux-kernel@vger.kernel.org
Subject: [BUG] md/raid5 kernel panics
Message-ID: <20041001114740.GA2418@catabasis.no-ip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
I've been getting lots of kernel panics when rebuilding my software raid-5 array (all are SATA drives). The process in the dump was usually md0_resync, but sometimes it was md0_raid5.

I currently have three drives in the array, but the third isn't built yet (it's listed as a spare), so the third drive begins rebuilding immediately when I run the array. About ten seconds after running the array, I get a panic.

I've tried several kernels (2.6.7, 2.6.8.1, 2.6.9-rc3, and 2.6.9-rc3 w/ Jeff Garzik's SATA patches), and all of them panic at the same point-- rebuilding a drive in the array. Note that I can bring up two of the drives and not the third, and there are no panics; I can mount the array and use it without trouble.

I've captured one dump that didn't cause the kernel to panic (although it happened when I tried removing the drive from the array before it usually panics), which is posted below. I can try to capture some of the other panics if it'd help.

I hope to be able to use my array this weekend, so I'll probably hack away at it some... I'm not very familiar with raid or sata, though. Any info would be greatly appreciated.

Thanks,
Will

---------- SNIP ----------
raid5: automatically using best checksumming function: pIII_sse
   pIII_sse  :  1928.000 MB/sec
raid5: using function: pIII_sse (1928.000 MB/sec)
md: raid5 personality registered as nr 4
md: md0 stopped.
md: bind<sdc>
md: bind<sdb>
raid5: device sdb operational as raid disk 0
raid5: device sdc operational as raid disk 1
raid5: allocated 3161kB for md0
raid5: raid level 5 set md0 active with 2 out of 3 devices, algorithm 2
RAID5 conf printout:
 --- rd:3 wd:2 fd:1
 disk 0, o:1, dev:sdb
 disk 1, o:1, dev:sdc
md: bind<sdd>
RAID5 conf printout:
 --- rd:3 wd:2 fd:1
 disk 0, o:1, dev:sdb
 disk 1, o:1, dev:sdc
 disk 2, o:1, dev:sdd
md: cannot remove active disk sdd from md0 ...
md: syncing RAID array md0
md: minimum _guaranteed_ reconstruction speed: 1000 KB/sec/disc.
md: using maximum available idle IO bandwith (but not more than 200000 KB/sec) for reconstruction.
md: using 128k window, over a total of 245117312 blocks.
md: could not bd_claim sdd.
md: error, md_import_device() returned -16
md: cannot remove active disk sdd from md0 ...
Unable to handle kernel NULL pointer dereference at virtual address 00000007
 printing eip:
c02433a2
*pde = 1db7a067
Oops: 0000 [#1]
PREEMPT SMP
Modules linked in: raid5 xor sata_promise libata nfsd exportfs lockd autofs4 sunrpc sg md dm_mod joydev ehci_hcd uhci_hcd
CPU:    0
EIP:    0060:[<c02433a2>]    Not tainted VLI
EFLAGS: 00010086   (2.6.9-rc3)
EIP is at blk_rq_map_sg+0x72/0x140
eax: 00000080   ebx: da473880   ecx: da473800   edx: 00000000
esi: 00000003   edi: da0e02e8   ebp: 00001000   esp: daa0fed8
ds: 007b   es: 007b   ss: 0068
Process md0_raid5 (pid: 2613, threadinfo=daa0e000 task=daa03550)
Stack: 00000040 deed32cc 00000000 00000008 db06af94 deed32cc dfc66720 dfc66720
       deed32cc c028a5f0 dfc6b788 deed32cc da473800 deed32cc dfc66720 de40c000
       c028a75a dfc66720 00000020 dfc6b788 da9a3f50 deed32cc dfc6b788 dfc6b788
Call Trace:
 [<c028a5f0>] scsi_init_io+0xc0/0x150
 [<c028a75a>] scsi_prep_fn+0x8a/0x1e0
 [<c0241d2e>] elv_next_request+0x4e/0x110
 [<c0243a81>] __generic_unplug_device+0x31/0x40
 [<c0243aae>] generic_unplug_device+0x1e/0x30
 [<e0951977>] unplug_slaves+0x97/0xa0 [raid5]
 [<e08c5719>] md_thread+0x159/0x1b0 [md]
 [<c011f2a0>] autoremove_wake_function+0x0/0x60
 [<c0105152>] ret_from_fork+0x6/0x14
 [<c011f2a0>] autoremove_wake_function+0x0/0x60
 [<e08c55c0>] md_thread+0x0/0x1b0 [md]
 [<c01032d1>] kernel_thread_helper+0x5/0x14
Code: 89 c2 8d 34 8b 8b 4c 24 10 0f b7 41 18 39 c2 0f 8d 99 00 00 00 8b 44 24 0c 8b 4c 24 30 c1 e0 04 8d 1c 01 8d b6 00 00 00 00 85 ff <8b> 6e 04 74 49 8b 44 24 08 85 c0 74 41 8b 43 fc 8b 4c 24 28 01
 <6>note: md0_raid5[2613] exited with preempt_count 1
---------- SNIP ----------

