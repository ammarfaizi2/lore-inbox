Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261793AbSI2UX0>; Sun, 29 Sep 2002 16:23:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261771AbSI2UWU>; Sun, 29 Sep 2002 16:22:20 -0400
Received: from packet.digeo.com ([12.110.80.53]:61097 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261779AbSI2UVc>;
	Sun, 29 Sep 2002 16:21:32 -0400
Message-ID: <3D976206.B2C6A5B8@digeo.com>
Date: Sun, 29 Sep 2002 13:26:46 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.38 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>
CC: Anton Blanchard <anton@samba.org>,
       "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Subject: 2.5.39-mm1
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 Sep 2002 20:26:48.0338 (UTC) FILETIME=[8953C720:01C267F6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


url: http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.39/2.5.39-mm1/

This patchset includes the per-cpu-pages stuff which Martin and I
have been working on.  This is designed to:

- increase the probability of the page allocator returning a page
  which is cache-warm on the calling CPU

- amortise zone->lock contention via work batching.

- provide the basis for a page reservation API, so we can guarantee
  that some troublesome inside-spinlock allocations will succeed.
  Mainly pte_chains and radix_tree_nodes (haven't implemented this yet).

I must say that based on a small amount of performance testing the
benefits of the cache warmness thing are disappointing. Maybe 1% if
you squint.  Martin, could you please do a before-and-after on the
NUMAQ's, double check that it is actually doing the right thing?

And Anton, could you please test this, make sure that it fixes the
rmqueue() and __free_pages_ok() lock contention as effectively as
the old per-cpu-pages patch did?  Thanks.

There is a reiserfs compilation problem at present.

Rick has a modified version of iostat.  Please use that for extracting the
SARD info.  Also the version at http://linux.inet.hr/ is reasonably uptodate.

New versions of procps are at http://surriel.com/procps/ - the version
from cygnus CVS works for me.



+module-fix.patch

 Compile fix for current Linus BK diff (Ingo)

+might_sleep-2.patch

 Additional might_sleep checks

+slab-fix.patch

 Fix a kmem_cache_destroy problem

+hugetlb-doc.patch

 hugetlbpage docco

+get_user_pages-PG_reserved.patch

 Don't bump the refcount on PageReserved pages in get_user_pages()

+move_one_page_fix.patch

 kmap_atomic atomicity fix

+zab-list_heads.patch

 Initialise some uninitialised VMA list_heads

+batched-slab-asap.patch

 Batch up the slab shrinking work.

+rmqueue_bulk.patch
+free_pages_bulk.patch

 Multipage page allocation and freeing

+hot_cold_pages.patch

 Per-cpu hot-n-cold page lists.

+readahead-cold-pages.patch

 Select cold pages for reading into pagecache

+pagevec-hot-cold-hint.patch

 Pages which are freed by page reclaim and truncate are probably
 cache-cold.  Don't pollute the cache-hot pool with them.



linus.patch
  cset-1.622.1.14-to-1.651.txt.gz

module-fix.patch
  compile fixes from Ingo

ide-high-1.patch

scsi_hack.patch
  Fix block-highmem for scsi

ext3-dxdir.patch
  ext3 htree

spin-lock-check.patch
  spinlock/rwlock checking infrastructure

rd-cleanup.patch
  Cleanup and fix the ramdisk driver (doesn't work right yet)

might_sleep-2.patch
  more sleep-inside-spinlock checks

slab-fix.patch
  slab: put the spare page on cachep->pages_free

hugetlb-doc.patch
  hugetlbpage documentation

get_user_pages-PG_reserved.patch
  Check for PageReserved pages in get_user_pages()

move_one_page_fix.patch
  pte_highmem atomicity fix in move_one_page()

zab-list_heads.patch
  vm_area_struct list_head initialisation

remove-gfp_nfs.patch
  remove GFP_NFS

buddyinfo.patch
  Add /proc/buddyinfo - stats on the free pages pool

free_area.patch
  Remove struct free_area_struct and free_area_t, use `struct free_area'

per-node-kswapd.patch
  Per-node kswapd instance

topology-api.patch
  Simple topology API

topology_fixes.patch
  topology-api cleanups

write-deadlock.patch
  Fix the generic_file_write-from-same-mmapped-page deadlock

radix_tree_gang_lookup.patch
  radix tree gang lookup

truncate_inode_pages.patch
  truncate/invalidate_inode_pages rewrite

proc_vmstat.patch
  Move the vm accounting out of /proc/stat

kswapd-reclaim-stats.patch
  Add kswapd_steal to /proc/vmstat

iowait.patch
  I/O wait statistics

sard.patch
  SARD disk accounting

dio-bio-add-page.patch
  Use bio_add_page() in direct-io.c

tcp-wakeups.patch
  Use fast wakeups in TCP/IPV4

swapoff-deadlock.patch
  Fix a tmpfs swapoff deadlock

dirty-and-uptodate.patch
  page state cleanup

shmem_rename.patch
  shmem_rename() directory link count fix

dirent-size.patch
  tmpfs: show a non-zero size for directories

tmpfs-trivia.patch
  tmpfs: small fixlets

per-zone-vm.patch
  separate the kswapd and direct reclaim code paths

swsusp-feature.patch
  add shrink_all_memory() for swsusp

remove-page-virtual.patch
  remove page->virtual for !WANT_PAGE_VIRTUAL

dirty-memory-clamp.patch
  sterner dirty-memory clamping

mempool-wakeup-fix.patch
  Fix for stuck tasks in mempool_alloc()

remove-write_mapping_buffers.patch
  Remove write_mapping_buffers

buffer_boundary-scheduling.patch
  IO schduling for indirect blocks

ll_rw_block-cleanup.patch
  cleanup ll_rw_block()

lseek-ext2_readdir.patch
  remove lock_kernel() from ext2_readdir()

discontig-no-contig_page_data.patch
  undefine contif_page_data for discontigmem

per-node-zone_normal.patch
  ia32 NUMA: per-node ZONE_NORMAL

alloc_pages_node-cleanup.patch
  alloc_pages_node cleanup

batched-slab-asap.patch
  batched slab shrinking

akpm-deadline.patch
  deadline scheduler tweaks

rmqueue_bulk.patch
  bulk page allocator

free_pages_bulk.patch
  Bulk page freeing function

hot_cold_pages.patch
  Hot/Cold pages and zone->lock amortisation
  EDEC
  
  Hot/Cold pages and zone->lock amortisation
  

readahead-cold-pages.patch
  Use cache-cold pages for pagecache reads.

pagevec-hot-cold-hint.patch
  hot/cold hints for truncate and page reclaim

read_barrier_depends.patch
  extended barrier primitives

rcu_ltimer.patch
  RCU core

dcache_rcu.patch
  Use RCU for dcache
