Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262365AbSJKJWe>; Fri, 11 Oct 2002 05:22:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262366AbSJKJWe>; Fri, 11 Oct 2002 05:22:34 -0400
Received: from packet.digeo.com ([12.110.80.53]:46285 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262365AbSJKJWa>;
	Fri, 11 Oct 2002 05:22:30 -0400
Message-ID: <3DA699AA.BBA05716@digeo.com>
Date: Fri, 11 Oct 2002 02:28:10 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.41 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: 2.5.41-mm3
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Oct 2002 09:28:10.0978 (UTC) FILETIME=[841A2C20:01C27108]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


url: http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.41/2.5.41-mm3/

. Merged up John's latest 2.5 oprofile, so folks will have to wean
  themselves off the crufty old one.

  You'll have to grab the userspace tools from
  http://oprofile.sourceforge.net/oprofile-2.5.html

  Use:

	mkdir /dev/oprofile	# John forgot this
	./configure --with-kernel-support
	make install

  Or just do what I didn't do and read the web page.

  Quite a few things seem to have changed with oprofile.  A typical
  profiling cycle would now be:

	rm -rf /var/lib/oprofile
	op_start --ctr0-count=50000 --ctr0-event=CPU_CLK_UNHALTED \
		--vmlinux=/path/to/vmlinux 
	<run test>
	op_stop
	sleep 3
	oprofpp -l -i /boot/vmlinux
	kill $(cat /var/lib/oprofile/lock)

  You must kill the daemon by hand before you can run op_start
  again.

. I've dropped the 512-byte O_DIRECT alignment patch for now. It's
  over in the experimental directory.  I'd like to get a decent round
  of testing with the bio_add_page fix so we can get that into Linus
  and get direct-io generally stabilised again before moving on.

. We've had some encouraging performance test results on the
  shared pagetable code, but also a couple of crashes.  The people
  who are monitoring performance may want to try that out.  It is
  selectable in config.

. Turns out that the idea of unmapped mapped pagecache a little earlier
  than swapping out anon memory was a poor one.  Changed the VM so that
  we treat these types of pages the same.

  It would be really appreciated if people who are interested in "the
  desktop experience" could give this patchset a try.  It's working
  well for me; but that's not a large sample...


-guruhugh.patch
-pte-highmem-warning.patch
-raw-use-o_direct.patch
-remove-radix_tree_reserve.patch
-ext3-yield.patch
-readv-writev-check-fix.patch

 Merged

+kgdb.patch

 Make things simpler for myself

+oprofile-25.patch

 Latest version

+hugetlb-meminfo.patch

 Change the layout of the hugetlbpage info in /proc/meminfo

+dio-bio-add-fix-1.patch

 Direct-io fixes

+net-loopback.patch

 Davem's patch to make the loopback device save a copy.  Doesn't seem
 to affect anything really.

-dio-fine-alignment.patch

 Moved to ../experimental for now

+blkdev-o_direct-short-read.patch

 Fix O_DIRECT-read-past-EOF for blockdevs

+msync-correctness.patch

 msync() standards fix

+page_reserved-accounting.patch

 Global accounting for PageReserved pages

+use-page_reserved_accounting.patch

 Use the above in a couple of VM decision-making places

+shpte-ifdef.patch

 Reduce shpte ifdeffery a little

+shpte-mprotect-fix.patch

 Shared pagetable mprotect fix.




linus.patch
  cset-1.573.100.12-to-1.738.txt.gz

kgdb.patch

oprofile-25.patch

misc.patch
  misc

swsusp-feature.patch
  add shrink_all_memory() for swsusp

hugetlb-meminfo.patch
  change hugetlbpage info in /proc/meminfo

dio-bio-add-fix-1.patch
  Fix direct-io for bio_add_page()

net-loopback.patch
  Disable second copy in the network loopback driver

large-queue-throttle.patch
  Improve writer throttling for small machines

exit-page-referenced.patch
  Propagate pte referenced bit into pagecache during unmap

swappiness.patch
  swappiness control

mapped-start-active.patch
  start anonymous pages on the active list

rename-dirty_async_ratio.patch
  rename dirty_async_ratio to dirty_ratio

auto-dirty-memory.patch
  adaptive dirty-memory thresholding

batched-slab-asap.patch
  batched slab shrinking and shrinker callback API

blkdev-o_direct-short-read.patch
  Fix O_DIRECT blockdev reads at end-of-device

orlov-allocator.patch

lseek-ext2_readdir.patch
  remove lock_kernel() from ext2_readdir()

msync-correctness.patch
  msync correctness fix

write-deadlock.patch
  Fix the generic_file_write-from-same-mmapped-page deadlock

rd-cleanup.patch
  Cleanup and fix the ramdisk driver (doesn't work right yet)

spin-lock-check.patch
  spinlock/rwlock checking infrastructure

hugetlb-prefault.patch
  hugetlbpages: factor out some code for hugetlbfs

ramfs-aops.patch
  Move ramfs address_space ops into libfs

hugetlb-header-split.patch
  Move hugetlb declarations into their own header

hugetlbfs.patch
  hugetlbfs file system

hugetlb-shm.patch
  hugetlbfs backing for SYSV shared memory

page_reserved-accounting.patch
  Global PageReserved accounting

use-page_reserved_accounting.patch
  Use PG_reserved accounting in the VM

ramfs-prepare-write-speedup.patch
  correctness fixes in libfs address_space ops

akpm-deadline.patch
  deadline scheduler tweaks

intel-user-copy.patch
  Faster copt_*_user for Intel ia32 CPUs

raid0-fix.patch
  RAID0 fix

rmqueue_bulk.patch
  bulk page allocator

free_pages_bulk.patch
  Bulk page freeing function

hot_cold_pages.patch
  Hot/Cold pages and zone->lock amortisation

readahead-cold-pages.patch
  Use cache-cold pages for pagecache reads.

pagevec-hot-cold-hint.patch
  hot/cold hints for truncate and page reclaim

page-reservation.patch
  Page reservation API

slab-split-01-rename.patch
  slab cleanup: rename static functions

slab-split-02-SMP.patch
  slab: enable the cpu arrays on uniprocessor

slab-split-03-tail.patch
  slab: reduced internal fragmentation

slab-split-04-drain.patch
  slab: take the spinlock in the drain function.

slab-split-05-name.patch
  slab: remove spaces from /proc identifiers

slab-split-06-mand-cpuarray.patch
  slab: cleanups and speedups

slab-split-07-inline.patch
  slab: uninline poisoning checks

slab-split-08-reap.patch
  slab: reap timers

cpucache_init-fix.patch
  cpucache_init fix

slab-split-10-list_for_each_fix.patch
  slab: for a list walking bug

shpte.patch

shpte-ifdef.patch
  reduced ifdeffery in the shared pagetable code

shpte-mprotect-fix.patch
  fix shared pagetable handling of mprotect

read_barrier_depends.patch
  extended barrier primitives

rcu_ltimer.patch
  RCU core

dcache_rcu.patch
  Use RCU for dcache
