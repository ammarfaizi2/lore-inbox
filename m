Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311475AbSDIUjh>; Tue, 9 Apr 2002 16:39:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311483AbSDIUjg>; Tue, 9 Apr 2002 16:39:36 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:46342 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S311475AbSDIUjd>; Tue, 9 Apr 2002 16:39:33 -0400
Date: Tue, 9 Apr 2002 17:39:23 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@duckman.distro.conectiva
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] rmap 12i
Message-ID: <Pine.LNX.4.44L.0204091738070.31387-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NOTE: this version is based on marcelo's bitkeeper tree, old version
info has mostly been lost. This is ok because merging with Linus and
Marcelo is done in functional chunks anyway and not in historical
chunks.

The ninth maintenance release of the 12th version of the reverse
mapping based VM is now available.
This is an attempt at making a more robust and flexible VM
subsystem, while cleaning up a lot of code at the same time.
The patch is available from:

           http://surriel.com/patches/2.4/2.4.19p6-rmap-12i
and        http://linuxvm.bkbits.net/


My big TODO items for a next release are:
  - O(1) page launder - currently functional but slow, needs to be tuned
  - pte-highmem
  - fine grained locking for SMP and NUMA (William Lee Irwin)

rmap 12i:
  - slab cleanup                                          (Christoph Hellwig)
  - remove references to compiler.h from mm/*             (me)
  - move rmap to marcelo's bk tree                        (me)
  - minor cleanups                                        (me)
rmap 12h:
  - hopefully fix OOM detection algorithm                 (me)
  - drop pte quicklist in anticipation of pte-highmem     (me)
  - replace andrea's highmem emulation by ingo's one      (me)
  - improve rss limit checking                            (Nick Piggin)
rmap 12g:
  - port to armv architecture                             (David Woodhouse)
  - NUMA fix to zone_table initialisation                 (Samuel Ortiz)
  - remove init_page_count                                (David Miller)
rmap 12f:
  - for_each_pgdat macro                                  (William Lee Irwin)
  - put back EXPORT(__find_get_page) for modular rd       (me)
  - make bdflush and kswapd actually start queued disk IO (me)
rmap 12e
  - RSS limit fix, the limit can be 0 for some reason     (me)
  - clean up for_each_zone define to not need pgdata_t    (William Lee Irwin)
  - fix i810_dma bug introduced with page->wait removal   (William Lee Irwin)
rmap 12d:
  - fix compiler warning in rmap.c                        (Roger Larsson)
  - read latency improvement   (read-latency2)            (Andrew Morton)
rmap 12c:
  - fix small balancing bug in page_launder_zone          (Nick Piggin)
  - wakeup_kswapd / wakeup_memwaiters code fix            (Arjan van de Ven)
  - improve RSS limit enforcement                         (me)
rmap 12b:
  - highmem emulation (for debugging purposes)            (Andrea Arcangeli)
  - ulimit RSS enforcement when memory gets tight         (me)
  - sparc64 page->virtual quickfix                        (Greg Procunier)
rmap 12a:
  - fix the compile warning in buffer.c                   (me)
  - fix divide-by-zero on highmem initialisation  DOH!    (me)
  - remove the pgd quicklist (suspicious ...)             (DaveM, me)
rmap 12:
  - keep some extra free memory on large machines         (Arjan van de Ven, me)
  - higher-order allocation bugfix                        (Adrian Drzewiecki)
  - nr_free_buffer_pages() returns inactive + free mem    (me)
  - pages from unused objects directly to inactive_clean  (me)
  - use fast pte quicklists on non-pae machines           (Andrea Arcangeli)
  - remove sleep_on from wakeup_kswapd                    (Arjan van de Ven)
  - page waitqueue cleanup                                (Christoph Hellwig)
rmap 11c:
  - oom_kill race locking fix                             (Andres Salomon)
  - elevator improvement                                  (Andrew Morton)
  - dirty buffer writeout speedup (hopefully ;))          (me)
  - small documentation updates                           (me)
  - page_launder() never does synchronous IO, kswapd
    and the processes calling it sleep on higher level    (me)
  - deadlock fix in touch_page()                          (me)
rmap 11b:
  - added low latency reschedule points in vmscan.c       (me)
  - make i810_dma.c include mm_inline.h too               (William Lee Irwin)
  - wake up kswapd sleeper tasks on OOM kill so the
    killed task can continue on its way out               (me)
  - tune page allocation sleep point a little             (me)
rmap 11a:
  - don't let refill_inactive() progress count for OOM    (me)
  - after an OOM kill, wait 5 seconds for the next kill   (me)
  - agpgart_be fix for hashed waitqueues                  (William Lee Irwin)
rmap 11:
  - fix stupid logic inversion bug in wakeup_kswapd()     (Andrew Morton)
  - fix it again in the morning                           (me)
  - add #ifdef BROKEN_PPC_PTE_ALLOC_ONE to rmap.h, it
    seems PPC calls pte_alloc() before mem_map[] init     (me)
  - disable the debugging code in rmap.c ... the code
    is working and people are running benchmarks          (me)
  - let the slab cache shrink functions return a value
    to help prevent early OOM killing                     (Ed Tomlinson)
  - also, don't call the OOM code if we have enough
    free pages                                            (me)
  - move the call to lru_cache_del into __free_pages_ok   (Ben LaHaise)
  - replace the per-page waitqueue with a hashed
    waitqueue, reduces size of struct page from 64
    bytes to 52 bytes (48 bytes on non-highmem machines)  (William Lee Irwin)
rmap 10:
  - fix the livelock for real (yeah right), turned out
    to be a stupid bug in page_launder_zone()             (me)
  - to make sure the VM subsystem doesn't monopolise
    the CPU, let kswapd and some apps sleep a bit under
    heavy stress situations                               (me)
  - let __GFP_HIGH allocations dig a little bit deeper
    into the free page pool, the SCSI layer seems fragile (me)
rmap 9:
  - improve comments all over the place                   (Michael Cohen)
  - don't panic if page_remove_rmap() cannot find the
    rmap in question, it's possible that the memory was
    PG_reserved and belonging to a driver, but the driver
    exited and cleared the PG_reserved bit                (me)
  - fix the VM livelock by replacing > by >= in a few
    critical places in the pageout code                   (me)
  - treat the reclaiming of an inactive_clean page like
    allocating a new page, calling try_to_free_pages()
    and/or fixup_freespace() if required                  (me)
  - when low on memory, don't make things worse by
    doing swapin_readahead                                (me)
rmap 8:
  - add ANY_ZONE to the balancing functions to improve
    kswapd's balancing a bit                              (me)
  - regularize some of the maximum loop bounds in
    vmscan.c for cosmetic purposes                        (William Lee Irwin)
  - move page_address() to architecture-independent
    code, now the removal of page->virtual is portable    (William Lee Irwin)
  - speed up free_area_init_core() by doing a single
    pass over the pages and not using atomic ops          (William Lee Irwin)
  - documented the buddy allocator in page_alloc.c        (William Lee Irwin)
rmap 7:
  - clean up and document vmscan.c                        (me)
  - reduce size of page struct, part one                  (William Lee Irwin)
  - add rmap.h for other archs (untested, not for ARM)    (me)
rmap 6:
  - make the active and inactive_dirty list per zone,
    this is finally possible because we can free pages
    based on their physical address                       (William Lee Irwin)
  - cleaned up William's code a bit                       (me)
  - turn some defines into inlines and move those to
    mm_inline.h (the includes are a mess ...)             (me)
  - improve the VM balancing a bit                        (me)
  - add back inactive_target to /proc/meminfo             (me)
rmap 5:
  - fixed recursive buglet, introduced by directly
    editing the patch for making rmap 4 ;)))              (me)
rmap 4:
  - look at the referenced bits in page tables            (me)
rmap 3:
  - forgot one FASTCALL definition                        (me)
rmap 2:
  - teach try_to_unmap_one() about mremap()               (me)
  - don't assign swap space to pages with buffers         (me)
  - make the rmap.c functions FASTCALL / inline           (me)
rmap 1:
  - fix the swap leak in rmap 0                           (Dave McCracken)
rmap 0:
  - port of reverse mapping VM to 2.4.16                  (me)

Rik
-- 
Will hack the VM for food.

http://www.surriel.com/		http://distro.conectiva.com/

