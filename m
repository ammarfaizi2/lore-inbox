Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266322AbSLJFVl>; Tue, 10 Dec 2002 00:21:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266386AbSLJFVl>; Tue, 10 Dec 2002 00:21:41 -0500
Received: from holomorphy.com ([66.224.33.161]:8091 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S266322AbSLJFVk>;
	Tue, 10 Dec 2002 00:21:40 -0500
Date: Mon, 9 Dec 2002 21:28:51 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@digeo.com>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: dbench on tmpfs OOM's
Message-ID: <20021210052851.GE9882@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@digeo.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <3D86BE4F.75C9B6CC@digeo.com> <Pine.LNX.4.44.0209170726050.19523-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0209170726050.19523-100000@localhost.localdomain>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 17, 2002 at 08:01:20AM +0100, Hugh Dickins wrote:
> What I never did was try GFP_HIGHUSER and kmap on the index pages:
> I think I decided back then that it wasn't likely to be needed
> (sparsely filled file indexes are a rarer case than sparsely filled
> pagetables, once the stupidity is fixed; and small files don't use
> index pages at all).  But Bill's testing may well prove me wrong.

The included fix works flawlessly under the conditions of the original
reported problem on 2.5.50-bk6-wli-1.

Sorry for not getting back to you sooner.


Thanks,
Bill

Results:
-------

instance 1:
----------
Throughput 86.2057 MB/sec (NB=107.757 MB/sec  862.057 MBit/sec)  512 procs
dbench 512  360.36s user 12645.64s system 1648% cpu 13:08.91 total

instance 2:
----------
Throughput 85.8913 MB/sec (NB=107.364 MB/sec  858.913 MBit/sec)  512 procs
dbench 512  361.96s user 11780.65s system 1539% cpu 13:08.97 total


Peak memory consumption during the run:

/proc/meminfo:
-------------
MemTotal:     32125300 kB
MemFree:       7841472 kB
MemShared:           0 kB
Buffers:          1236 kB
Cached:       23397036 kB
SwapCached:          0 kB
Active:         149512 kB
Inactive:     23386864 kB
HighTotal:    31588352 kB
HighFree:      7681344 kB
LowTotal:       536948 kB
LowFree:        160128 kB
SwapTotal:           0 kB
SwapFree:            0 kB
Dirty:               0 kB
Writeback:           0 kB
Mapped:         142508 kB
Slab:           133020 kB
Committed_AS: 23757472 kB
PageTables:      18820 kB
ReverseMaps:    168934
HugePages_Total:     0
HugePages_Free:      0
Hugepagesize:     2048 kB

/proc/slabinfo (reported by bloatmost):
---------------------------------------
 shmem_inode_cache:    39321KB    39682KB   99.9 
   radix_tree_node:    33870KB    34335KB   98.64
           pae_pmd:    18732KB    18732KB  100.0 
      dentry_cache:    11612KB    14156KB   82.2 
       task_struct:     2691KB     2710KB   99.32
        signal_act:     2207KB     2216KB   99.58
              filp:     1976KB     2032KB   97.23
         size-1024:     1824KB     1824KB  100.0 
       names_cache:     1740KB     1740KB  100.0 
    vm_area_struct:     1598KB     1650KB   96.88
         pte_chain:     1271KB     1305KB   97.39
         size-2048:      982KB     1032KB   95.15
biovec-BIO_MAX_PAGES:      768KB      780KB   98.46
       files_cache:      704KB      704KB  100.0 
         mm_struct:      656KB      665KB   98.65
          size-512:      421KB      436KB   96.55
   blkdev_requests:      400KB      405KB   98.76
        biovec-128:      384KB      390KB   98.46
  ext2_inode_cache:      309KB      315KB   98.33
       inode_cache:      253KB      253KB  100.0 
 skbuff_head_cache:      221KB      251KB   88.24
           size-32:      183KB      211KB   86.68
