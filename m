Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262092AbTIZAJX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 20:09:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262094AbTIZAJX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 20:09:23 -0400
Received: from devil.servak.biz ([209.124.81.2]:40167 "EHLO devil.servak.biz")
	by vger.kernel.org with ESMTP id S262092AbTIZAJK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 20:09:10 -0400
Subject: Oops, panic with RAID5, 2.6.0-test5-mm4
From: Torrey Hoffman <thoffman@arnor.net>
To: Linux RAID <linux-raid@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1064534941.18499.59.camel@torrey.et.myrio.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Thu, 25 Sep 2003 17:09:02 -0700
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - devil.servak.biz
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - arnor.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is almost identical to my earlier report, but it happened under
slightly different circumstances.  I've trimmed the dmesg log this
time.  I'm happy to provide more information if required, or test
different kernels or patches...  (I'm about to try the latest bk
snapshot, in fact...)

My /dev/md0 is a RAID5 with 5 devices: 4 drives on a Promise controller
plus a partition on /dev/hda.

I booted test5-mm4 with the Promise controller temporarily removed from
the machine.  I expected the RAID startup to fail of course, but I
didn't expect a kernel oops & panic.

The built-in RAID code autodetected the one remaining RAID partition on
hda, and attempted to start reconstruction... kaboom!

- - - - - - - -

md: raid0 personality registered as nr 2
md: raid1 personality registered as nr 3
md: raid5 personality registered as nr 4
raid5: measuring checksumming speed
   8regs     :  1172.000 MB/sec
   8regs_prefetch:   952.000 MB/sec
   32regs    :   532.000 MB/sec
   32regs_prefetch:   524.000 MB/sec
   pIII_sse  :  1240.000 MB/sec
   pII_mmx   :  1632.000 MB/sec
   p5_mmx    :  1736.000 MB/sec
raid5: using function: pIII_sse (1240.000 MB/sec)
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
NET: Registered protocol family 1
NET: Registered protocol family 17
md: Autodetecting RAID arrays.
md: autorun ...
md: considering hda3 ...
md:  adding hda3 ...
md: created md0
md: bind<hda3>
md: running: <hda3>
md: md0: raid array is not clean -- starting background reconstruction
Unable to handle kernel NULL pointer dereference at virtual address
00000000
 printing eip:
c0283f02
*pde = 00000000
Oops: 0000 [#1]
SMP
CPU:    0
EIP:    0060:[<c0283f02>]    Not tainted VLI
EFLAGS: 00010286
EIP is at md_probe+0x12/0xf0
eax: 00000000   ebx: dfd7b9a0   ecx: dfd68960   edx: 00000000
esi: dfd6896c   edi: dfd6896c   ebp: c152fd8c   esp: c152fd74
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 1, threadinfo=c152e000 task=c152d900)
Stack: dfd6896c c152fd8c c0149661 dfd7b9a0 dfd6896c dfd6896c c152fddc
c0284192
       00000000 00000000 00000000 c152fdb8 00000282 00000400 00000004
c03e0fe1
       00000246 c152fddc c0124d93 0000000a 00000400 c0300fe1 c152fde8
dfd7b9a0
Call Trace:
 [<c0149661>] invalidate_inode_pages+0x21/0x30
 [<c0284192>] do_md_run+0x192/0x470
 [<c0124d93>] printk+0x143/0x1c0
 [<c02847af>] autorun_array+0x9f/0xd0
 [<c0124d93>] printk+0x143/0x1c0
 [<c0284a0a>] autorun_devices+0x22a/0x270
 [<c0124d93>] printk+0x143/0x1c0
 [<c028791a>] autostart_arrays+0x2a/0xc6
 [<c0164384>] do_open+0x114/0x3f0
 [<c0163cf0>] bdev_test+0x0/0x20
 [<c0163d10>] bdev_set+0x0/0x20
 [<c0285dfc>] md_ioctl+0x74c/0x790
 [<c015afbc>] dentry_open+0x13c/0x1f0
 [<c015ae76>] filp_open+0x66/0x70
 [<c011fe40>] schedule+0x60/0x690
 [<c023a127>] blkdev_ioctl+0xa7/0x447
 [<c016e295>] sys_ioctl+0xf5/0x271
 [<c03ae9d1>] md_run_setup+0x71/0xa0
 [<c03ad1d1>] prepare_namespace+0x11/0x110
 [<c01349d2>] init_workqueues+0x12/0x29
 [<c01070f1>] init+0x51/0x150
 [<c01070a0>] init+0x0/0x150
 [<c010b27d>] kernel_thread_helper+0x5/0x18
                                                                                                                                        
Code: 0d ea ff 89 34 24 e8 7e f5 ff ff e9 34 ff ff ff 89 75 cc e9 c4 fe
ff ff 90 55 89 e5 83 ec 18 89 75 f8 8b 45 0c 89 5d f4 89 7d fc
 <0>Kernel panic: Attempted to kill init!


-- 
Torrey Hoffman <thoffman@arnor.net>

