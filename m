Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266718AbSKMIiZ>; Wed, 13 Nov 2002 03:38:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267146AbSKMIiZ>; Wed, 13 Nov 2002 03:38:25 -0500
Received: from packet.digeo.com ([12.110.80.53]:25768 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S266718AbSKMIiW>;
	Wed, 13 Nov 2002 03:38:22 -0500
Message-ID: <3DD21113.B4F3857@digeo.com>
Date: Wed, 13 Nov 2002 00:45:07 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: 2.5.47-mm2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Nov 2002 08:45:07.0398 (UTC) FILETIME=[F7CCE660:01C28AF0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


url: http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.47/2.5.47-mm2/

I think I managed to include everyone's patches this time.

. Includes the latest rbtree-based IO scheduler from Jens.  This version
  appears to do all the right things and in brief testing has at least the
  same IO performance as the linear-search insertion, and shows lower CPU
  costs.

  The large queues which this code enables have tickled a bug in the
  writeback code.  With more than 40% of physical memory in a single queue
  something is going for a bit of a spin and is consuming too much CPU.
  It's not a fatal problem but can affect benchmarking.  It will only
  exhibit on smallish machines (<512 megabytes of RAM) and will be less
  likely to happen on IDE systems.   IDE has smaller requests than
  SCSI and the total memory which can be placed under writeback is much less.

. There's a patch here which teaches the request queues to unplug themselves
  if there are four requests queued or if the queue has been idle for three
  milliseconds.  Instrumentation shows that around 5 to 10% of requests are
  getting an earlier start than they would have without this patch, but there
  doesn't seem to be much benefit from brief testing.  It may help AIO, which
  would otherwise have to unplug all the queues in the machine with every
  request.

  It did allow some rather awkward unplugging code in lots of other places
  to be pulled out.


Since 2.5.47-mm1:

+linus.patch

 Latest drop from Linus

+timers-net.patch

 More timer fixes

+rmap-flush-cache-page.patch

 Cache flush fix on the page eviction path

+swap-get_page-page-unlock.patch
+swap-writepages-swizzled.patch

 Stuff from Hugh

+bttv-timer.patch

 A timer fix (I think we're around the 85% mark on these now)

+inlines-01-tcp_input.patch
+inlines-02-tcp_output.patch
+inlines-03-tcp_ipv4.patch
+inlines-04-udp.patch
+inlines-05-tcp.patch
+inlines-06-af_inet.patch
+inlines-07-arp.patch
+inlines-08-fib_hash.patch
+inlines-09-icmp.patch
+inlines-10-ip_fragment.patch
+inlines-11-ip_output.patch
+inlines-12-route.patch
+inlines-13-tcp_minisocks.patch
+inlines-14-xfrm_policy.patch
+inlines-15-af_unix.patch
+inlines-16-garbage.patch
+inlines-17-skbuff.patch

 Uninlining in networking.  10 kbytes.

+auto-unplug.patch

 Self-unplugging queues

+less-unplugging.patch

 Pull out lots of open-coded global unplugs.

+kmap-atomic-nfs.patch

 Use kmap_atomic in NFS



All patches:

linus.patch
  cset-1.823-to-1.845.txt.gz

timers-net.patch

kgdb.patch

rcu-stats.patch
  RCU statistics reporting

genksyms-fix.patch
  modversions fix for exporting per-cpu data

buffer-debug.patch
  buffer.c debugging

mbcache-cleanup.patch
  mbcache: add gfp_mask parameter to free() callback, cleanups

rmap-flush-cache-page.patch
  flush_cache_page while pte valid

swap-get_page-page-unlock.patch
  unlock_page when get_swap_bio fails

swap-writepages-swizzled.patch
  Subject: [PATCH] swap writepages swizzled

bttv-timer.patch

irq-save-vm-locks.patch
  make mapping->page_lock irq-safe

irq-safe-private-lock.patch
  make mapping->private_lock irq-safe

aio-direct-io-infrastructure.patch
  AIO support for raw/O_DIRECT

aio-direct-io.patch
  AIO support for raw/O_DIRECT

inlines-01-tcp_input.patch

inlines-02-tcp_output.patch

inlines-03-tcp_ipv4.patch

inlines-04-udp.patch

inlines-05-tcp.patch

inlines-06-af_inet.patch

inlines-07-arp.patch

inlines-08-fib_hash.patch

inlines-09-icmp.patch

inlines-10-ip_fragment.patch

inlines-11-ip_output.patch

inlines-12-route.patch

inlines-13-tcp_minisocks.patch

inlines-14-xfrm_policy.patch

inlines-15-af_unix.patch

inlines-16-garbage.patch

inlines-17-skbuff.patch

reiserfs-readpages.patch
  reiserfs v3 readpages support

reiserfs-readpages-fix.patch

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

swapcache-throttle.patch

auto-unplug.patch
  self-unplugging request queues

less-unplugging.patch
  Remove most of the blk_run_queues() calls

rbtree-iosched.patch
  Subject: Re: 2.5.46: ide-cd cdrecord success report

page-reservation.patch
  Page reservation API

wli-show_free_areas.patch
  show_free_areas extensions

kmap-atomic-nfs.patch
  Subject: Re: [RFC] use kmap_atomic in the NFS client

dcache_rcu.patch
  Use RCU for dcache

shpte-ng.patch
  pagetable sharing for ia32
