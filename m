Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261252AbVDDOgj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261252AbVDDOgj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 10:36:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261253AbVDDOgi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 10:36:38 -0400
Received: from Giotto.spidernet.net ([194.154.128.30]:14531 "EHLO
	mail0q.spidernet.net") by vger.kernel.org with ESMTP
	id S261252AbVDDOga (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 10:36:30 -0400
Subject: UPDATE: out of vmalloc space - but vmalloc parameter does not
	allow boot
From: Ranko Zivojnovic <ranko@spidernet.net>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1112577841.6035.40.camel@localhost.localdomain>
References: <1112577841.6035.40.camel@localhost.localdomain>
Content-Type: text/plain
Organization: SpiderNet Services Ltd
Date: Mon, 04 Apr 2005 17:36:15 +0300
Message-Id: <1112625375.5680.45.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(please do CC replies as I am still not on the list)

As I am kind of pressured to resolve this issue, I've set up a test
environment using VMWare in order to reproduce the problem and
(un)fortunately the attempt was successful.

I have noticed a few points that relate to the size of the physical RAM
and the behavior vmalloc. As I am not sure if this is by design or a
bug, so please someone enlighten me:

The strange thing I have seen is that with the increase of the physical
RAM, the VmallocTotal in the /proc/meminfo gets smaller! Is this how it
is supposed to be?

Namely (tests done using VMWare, using the 2.6.11.5 kernel):

/proc/meminfo on a machine with 256M of physical RAM plus 512M swap:
MemTotal:       254580 kB
MemFree:        220504 kB
Buffers:          4928 kB
Cached:          18212 kB
SwapCached:          0 kB
Active:          13360 kB
Inactive:        12604 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       254580 kB
LowFree:        220504 kB
SwapTotal:      530128 kB
SwapFree:       530128 kB
Dirty:              12 kB
Writeback:           0 kB
Mapped:           6440 kB
Slab:             5812 kB
CommitLimit:    657416 kB
Committed_AS:     7272 kB
PageTables:        344 kB
VmallocTotal:   770040 kB  <----------
VmallocUsed:      1348 kB
VmallocChunk:   768504 kB
HugePages_Total:     0
HugePages_Free:      0
Hugepagesize:     4096 kB

/proc/meminfo on a machine with 512M of physical RAM plus 512M swap:
MemTotal:       514260 kB
MemFree:        479068 kB
Buffers:          4880 kB
Cached:          18000 kB
SwapCached:          0 kB
Active:          13264 kB
Inactive:        12556 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       514260 kB
LowFree:        479068 kB
SwapTotal:      530128 kB
SwapFree:       530128 kB
Dirty:               8 kB
Writeback:           0 kB
Mapped:           6452 kB
Slab:             5740 kB
CommitLimit:    787256 kB
Committed_AS:     7280 kB
PageTables:        344 kB
VmallocTotal:   507896 kB  <----------
VmallocUsed:      1348 kB
VmallocChunk:   506360 kB
HugePages_Total:     0
HugePages_Free:      0
Hugepagesize:     4096 kB

/proc/meminfo on a machine with 768M of physical RAM plus 512M swap:
MemTotal:       774348 kB
MemFree:        739132 kB
Buffers:          4888 kB
Cached:          17992 kB
SwapCached:          0 kB
Active:          13260 kB
Inactive:        12568 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       774348 kB
LowFree:        739132 kB
SwapTotal:      530128 kB
SwapFree:       530128 kB
Dirty:             228 kB
Writeback:           0 kB
Mapped:           6448 kB
Slab:             5736 kB
CommitLimit:    917300 kB
Committed_AS:     7272 kB
PageTables:        344 kB
VmallocTotal:   245752 kB  <----------
VmallocUsed:      1348 kB
VmallocChunk:   244216 kB
HugePages_Total:     0
HugePages_Free:      0
Hugepagesize:     4096 kB

/proc/meminfo on a machine with 1024M of physical RAM plus 512M swap:
MemTotal:      1034444 kB
MemFree:        997764 kB
Buffers:          4876 kB
Cached:          18004 kB
SwapCached:          0 kB
Active:          13260 kB
Inactive:        12544 kB
HighTotal:      131008 kB
HighFree:       108448 kB
LowTotal:       903436 kB
LowFree:        889316 kB
SwapTotal:      530128 kB
SwapFree:       530128 kB
Dirty:             612 kB
Writeback:           0 kB
Mapped:           6436 kB
Slab:             5824 kB
CommitLimit:   1047348 kB
Committed_AS:     7272 kB
PageTables:        344 kB
VmallocTotal:   114680 kB  <----------
VmallocUsed:      1348 kB
VmallocChunk:   113144 kB
HugePages_Total:     0
HugePages_Free:      0
Hugepagesize:     4096 kB

Or in summary:
 256M RAM --> VmallocTotal:   770040 kB
 512M RAM --> VmallocTotal:   507896 kB
 768M RAM --> VmallocTotal:   245752 kB
   1G RAM --> VmallocTotal:   114680 kB
   4G RAM --> VmallocTotal:   114680 kB
   6G RAM --> VmallocTotal:   114680 kB

(4G and 6G RAM VmallocTotal values taken off the real machines)

Now the question: Is this behavior normal? Should it not be in reverse -
more RAM equals more space for vmalloc?

With regards to the 'vmalloc' kernel parameter, I was able to boot
normally using kernel parameter vmalloc=192m with RAM sizes 256, 512,
768 but _not_ with 1024M of RAM and above. 

With 1024M of RAM (and apparently everything above), it is unable to
boot if vmalloc parameter is specified to a value lager than default
128m. It panics with the following:

EXT2-fs: unable to read superblock
isofs_fill_super: bread failed, dev=md0, iso_blknum=16, block=32
XFS: SB read failed
VFS: Cannot open root device "md0" or unknown-block(9,0)
Please append a correct "root=" boot option
Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(9,0)

Question: Is this inability to boot related to the fact that the system
is unable to reserve enough space for vmalloc?

Thanks for your valuable time,

Ranko

