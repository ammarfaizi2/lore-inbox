Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261966AbVDDBYz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261966AbVDDBYz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 21:24:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261963AbVDDBYZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 21:24:25 -0400
Received: from Giotto.spidernet.net ([194.154.128.30]:37572 "EHLO
	mail0q.spidernet.net") by vger.kernel.org with ESMTP
	id S261962AbVDDBYQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 21:24:16 -0400
Subject: out of vmalloc space - but vmalloc parameter does not allow boot
From: Ranko Zivojnovic <ranko@spidernet.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Mon, 04 Apr 2005 04:24:01 +0300
Message-Id: <1112577841.6035.40.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

(Please CC responses as I am not subscribed to the list. Thanks!)

I've recently started experiencing the following problem on one of my
Linux servers:

allocation failed: out of vmalloc space - use vmalloc=<size> to increase
size.
allocation failed: out of vmalloc space - use vmalloc=<size> to increase
size.
XFS: possible memory allocation deadlock in kmem_alloc (mode:0x2d0)
XFS: possible memory allocation deadlock in kmem_alloc (mode:0x2d0)

...and so on until it completely locks up and needs reboot.

>From what I can tell from fs/xfs/linux-2.6/kmem.c, the XFS message is
just another confirmation that the machine has run out of vmalloc space.

The machine has 4GB of RAM and is running 2.6.11.5 kernel.

I have tried to specify vmalloc=256m to start with, but no luck - the
machine does not even want to boot. It panics with:
EXT2-fs: unable to read superblock
isofs_fill_super: bread failed, dev=md0, iso_blknum=16, block=32
XFS: SB read failed
VFS: Cannot open root device "md0" or unknown-block(9,0)
Please append a correct "root=" boot option
Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-
block(9,0)

If I remove the "vmalloc" parameter, it boots just fine but then after
some hours, when the load on the server goes up, I get the above
"request" to increase vmalloc. Being desperate to find the way out, I
have also tried increasing the hardcoded value in arch/i386/mm/init.c,
but ended up with the same effect as with the parameter - panic on boot.

/proc/meminfo says (while the system is up and running):
MemTotal:      4073244 kB
MemFree:        144356 kB
Buffers:          1184 kB
Cached:        2735576 kB
SwapCached:          0 kB
Active:         921804 kB
Inactive:      2408800 kB
HighTotal:     3193792 kB
HighFree:          896 kB
LowTotal:       879452 kB
LowFree:        143460 kB
SwapTotal:     7341600 kB
SwapFree:      7341600 kB
Dirty:           50940 kB
Writeback:           0 kB
Mapped:         613172 kB
Slab:           498936 kB
CommitLimit:   9378220 kB
Committed_AS:   736392 kB
PageTables:       1760 kB
VmallocTotal:   114680 kB
VmallocUsed:     88996 kB
VmallocChunk:    20988 kB
HugePages_Total:     0
HugePages_Free:      0
Hugepagesize:     4096 kB

I have also tried changing the following parameters - but no luck
either:
vm.lower_zone_protection = 900
vm.min_free_kbytes = 30000
vm.vfs_cache_pressure = 150

Please help! What am I doing wrong?

Also, if this question does not belong here - please point to the right
direction :).

Best regards,

Ranko

