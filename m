Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264716AbSKJDxK>; Sat, 9 Nov 2002 22:53:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264708AbSKJDxJ>; Sat, 9 Nov 2002 22:53:09 -0500
Received: from packet.digeo.com ([12.110.80.53]:27063 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S264720AbSKJDxD>;
	Sat, 9 Nov 2002 22:53:03 -0500
Message-ID: <3DCDD9AC.C3FB30D9@digeo.com>
Date: Sat, 09 Nov 2002 19:59:40 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: 2.5.46-mm2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Nov 2002 03:59:41.0162 (UTC) FILETIME=[98876CA0:01C2886D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


url: http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.46/2.5.46-mm2/

There's some work here to address some of the whacky corner cases
which have traditionally knocked the VM over.  Some are fixed, some
still need work.  My latest party trick is to run a 4G highmem machine
with 800 megabytes of ZONE_NORMAL under mlock.  Can't say that it
completely works yet...

Of note in -mm2 is a patch from Chris Mason which teaches reiserfs to
use the mpage code for reads - it should show a nice reduction in CPU
load under reiserfs reads.

And Jens's rbtree-based insertion code for the request queue.  Which
means that the queues can be grown a *lot* if people want to play with
that.  The VM should be able to cope with it fine.

And a new set of block a_ops which never, ever, ever attach buffer_heads
to file pagecache.  Implemented for ext2 - use `mount -o nobh'.

And several VM tuning and stability tweaks.


Changes since 2.5.46-mm1:

-net-timer-init.patch

 Merged

+rcu-stats.patch

 Stats in /proc/rcu

-mbcache-atomicity-fix.patch
-htree-fix.patch

 Merged

+nuke-disk-stats.patch

 Remove the disk stats from /proc/stat: they're in /sys now.

-akpm-deadline.patch

 The IO scheduler can now be tuned via /sys/block/hda/iosched

+aio-direct-io-infrastructure.patch
+aio-direct-io.patch

 AIO support for direct-io

+reiserfs-readpages.patch

 Use mpage in reiserfs3

+remove-inode-buffers.patch

 Drop clean metadata buffers from inodes when we're trying to reclaim them.

+unfreeable-zones.patch

 Handle weird situations where all of a zone's pages are pinned by something.

+mpage-kmap.patch

 s/kmap/kmap_atomic/ in the mpage code

+nobh.patch

 Don't attached buffer_heads to pagecache for writes.

+inode-reclaim-balancing.patch

 Fix some overeager reclaim of dentries and hence inodes.

+rbtree-iosched.patch

 Tree-based IO scheduler insertion, and /sys/block/XXX/iosched tunables




All patches:

linus.patch
  cset-1.786.157.7-to-1.801.txt.gz

kgdb.patch

genksyms-hurts.patch
  fix exporting of per-cpu symbols for modversions

misc.patch
  misc fixes

writev-bad-seg-fix.patch
  Fix readv/writev return value

wli-01-iowait.patch
  SMP iowait stats

wli-02-zap_hugetlb_resources.patch
  hugetlb: fix zap_hugetlb_resources()

wli-03-remove-unlink_vma.patch
  hugetlb: remove unlink_vma()

wli-04-internalize-hugetlb-init.patch
  hugetlb: internalize hugetlb init

wli-05-sysctl-cleanup.patch
  hugetlb: remove sysctl.c intrusion

wli-06-cleanup-proc.patch
  hugetlb: remove /proc/ intrusion

wli-07-hugetlb-static.patch
  hugetlb: make private functions static

rcu-stats.patch
  RCU statistics reporting

msec-fix.patch
  Fix math underflow in disk accounting

touch_buffer-fix.patch
  buffer_head refcounting fixes and cleanup

pgalloc-accounting-fix.patch
  fix page alloc/free accounting

nuke-disk-stats.patch
  duplicate statistics being gathered

irq-save-vm-locks.patch
  make mapping->page_lock irq-safe

irq-safe-private-lock.patch
  make mapping->private_lock irq-safe

aio-direct-io-infrastructure.patch
  AIO support for raw/O_DIRECT

aio-direct-io.patch
  AIO support for raw/O_DIRECT

reiserfs-readpages.patch
  reiserfs v3 readpages support

remove-inode-buffers.patch
  try to remove buffer_heads from to-be-reaped inodes

resurrect-incremental-min.patch
  strengthen the `incremental min' logic in the page allocator

unfreeable-zones.patch
  VM: handle zones which are ful of unreclaimable pages

mpage-kmap.patch
  kmap->kmap_atomic in mpage.c

nobh.patch
  no-buffer-head ext2 option

inode-reclaim-balancing.patch
  better inode reclaim balancing

rbtree-iosched.patch
  Subject: Re: 2.5.46: ide-cd cdrecord success report

page-reservation.patch
  Page reservation API

wli-show_free_areas.patch
  show_free_areas extensions

dcache_rcu.patch
  Use RCU for dcache

shpte-ng.patch
  pagetable sharing for ia32
