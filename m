Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263592AbSIQElV>; Tue, 17 Sep 2002 00:41:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263593AbSIQElV>; Tue, 17 Sep 2002 00:41:21 -0400
Received: from holomorphy.com ([66.224.33.161]:46818 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S263592AbSIQElU>;
	Tue, 17 Sep 2002 00:41:20 -0400
Date: Mon, 16 Sep 2002 21:43:17 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-mm@kvack.org
Cc: akpm@zip.com.au, hugh@veritas.com, linux-kernel@vger.kernel.org
Subject: dbench on tmpfs OOM's
Message-ID: <20020917044317.GZ2179@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-mm@kvack.org, akpm@zip.com.au, hugh@veritas.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My machine OOM'd during a run of 2 simultaneous dbench 512's on 2
separate 12GB tmpfs fs's on a 32x NUMA-Q with 32GB of RAM, 2.5.35
plus minimalistic booting fixes, no swap, and my recently posted false
OOM fix (though it is perhaps not the most desirable fix).

Note: gfp_mask == __GFP_FS | __GFP_HIGHIO | __GFP_IO | __GFP__WAIT
... the __GFP_FS checks can't save us here.


Cheers,
Bill

#1  0xc013ce2e in oom_kill () at oom_kill.c:182
#2  0xc013cee8 in out_of_memory () at oom_kill.c:250
#3  0xc0138bec in try_to_free_pages (classzone=0xc0389300, gfp_mask=464, 
    order=0) at vmscan.c:561
#4  0xc013989b in balance_classzone (classzone=0xc0389300, gfp_mask=464, 
    order=0, freed=0xf6169ed0) at page_alloc.c:278
#5  0xc0139b97 in __alloc_pages (gfp_mask=464, order=0, zonelist=0xc02a3e94)
    at page_alloc.c:401
#6  0xc013cb57 in alloc_pages_pgdat (pgdat=0xc0389000, gfp_mask=464, order=0)
    at numa.c:77
#7  0xc013cba3 in _alloc_pages (gfp_mask=464, order=0) at numa.c:105
#8  0xc0139c23 in get_zeroed_page (gfp_mask=45) at page_alloc.c:442
#9  0xc013db12 in shmem_getpage_locked (info=0xd950f900, inode=0xd950f978, 
    idx=16) at shmem.c:205
#10 0xc013e6ea in shmem_file_write (file=0xf45dd6c0, 
    buf=0x804bda1 '\001' <repeats 200 times>..., count=65474, ppos=0xf45dd6e0)
    at shmem.c:957
#11 0xc014553c in vfs_write (file=0xf45dd6c0, 
    buf=0x804bda0 '\001' <repeats 200 times>..., count=65475, pos=0xf45dd6e0)
    at read_write.c:216
#12 0xc014561e in sys_write (fd=6, 
    buf=0x804bda0 '\001' <repeats 200 times>..., count=65475)
    at read_write.c:246
#13 0xc010771f in syscall_call () at process.c:966

MemTotal:     32107256 kB
MemFree:      27564648 kB
MemShared:           0 kB
Cached:        4196528 kB
SwapCached:          0 kB
Active:        1924400 kB
Inactive:      2381404 kB
HighTotal:    31588352 kB
HighFree:     27563224 kB
LowTotal:       518904 kB
LowFree:          1424 kB
SwapTotal:           0 kB
SwapFree:            0 kB
Dirty:               0 kB
Writeback:           0 kB
Committed_AS:  4330600 kB
PageTables:      12804 kB
ReverseMaps:    133841
TLB flushes:      1709
non flushes:      1093
