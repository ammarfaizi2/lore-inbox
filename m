Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267264AbUBNALZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 19:11:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267280AbUBNALZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 19:11:25 -0500
Received: from s4.uklinux.net ([80.84.72.14]:9949 "EHLO mail2.uklinux.net")
	by vger.kernel.org with ESMTP id S267264AbUBNAKl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 19:10:41 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, piggin@cyberone.com.au
Subject: Re: 2.6.1 slower than 2.4, smp/scsi/sw-raid/reiserfs
References: <87oesieb75.fsf@codematters.co.uk>
	<20040202194626.191cbb95.akpm@osdl.org>
	<87llnk2js9.fsf@codematters.co.uk>
	<20040203132913.6145f4e6.akpm@osdl.org>
From: Philip Martin <philip@codematters.co.uk>
Date: Sat, 14 Feb 2004 00:10:37 +0000
In-Reply-To: <20040203132913.6145f4e6.akpm@osdl.org> (Andrew Morton's
 message of "Tue, 3 Feb 2004 13:29:13 -0800")
Message-ID: <87ptcicygy.fsf@codematters.co.uk>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Common Lisp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> Philip Martin <philip@codematters.co.uk> wrote:
>>
>> Andrew Morton <akpm@osdl.org> writes:
>> 
>> > Could you generate a kernel profile?  Add `profile=1' to the kernel boot
>> ...
>> 2.4.24
>
> OK.
>
>> 2.6.1
>
> Odd.  Are you really sure that it was the correct System.map?

I'm reasonably confident that I am, but the 2.6 numbers still look
odd, I don't know why.  So I've installed oprofile and used that to
profile instead; thus same problem different numbers.

As before I'm timing a software build (using make -j4) and it's slower
on 2.6 than 2.4 and it appears increased system CPU is the problem.
It's a dual P3 450MHz, 512MB ram, 2-disk aic7xxx SCSI RAID-0 and it's
not swapping.  Typical timings are

kernel 2.4.24
239.24user 85.80system 2:50.73elapsed 190%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (1741932major+1948496minor)pagefaults 0swaps

kernel 2.6.3-rc2
248.82user 122.01system 3:37.24elapsed 170%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (474major+3768844minor)pagefaults 0swaps

This is oprofile report for 2.4.24

CPU: PIII, speed 451.03 MHz (estimated)
Counted CPU_CLK_UNHALTED events (clocks processor is not halted) with a unit mask of 0x00 (No unit mask) count 100000
samples  %        app name                 symbol name
130946    8.7017  bash                     (no symbols)
89695     5.9604  vmlinux-2.4.24           do_wp_page
88996     5.9140  as                       (no symbols)
47436     3.1522  ld-2.2.5.so              _dl_lookup_versioned_symbol
38161     2.5359  libbfd-2.14.90.0.7.so    (no symbols)
35216     2.3402  cc1                      yyparse
29175     1.9387  vmlinux-2.4.24           do_anonymous_page
24594     1.6343  vmlinux-2.4.24           zap_page_range
23044     1.5313  vmlinux-2.4.24           copy_page_range
22401     1.4886  libc-2.2.5.so            memset
21343     1.4183  ld-2.2.5.so              _dl_relocate_object
21111     1.4029  cc1                      skip_block_comment
20104     1.3360  libc-2.2.5.so            chunk_alloc
19883     1.3213  cc1                      ht_lookup
17248     1.1462  cc1                      _cpp_lex_direct
14680     0.9755  libc-2.2.5.so            _IO_vfprintf
14158     0.9408  cc1                      grokdeclarator
13853     0.9206  cc1                      ggc_alloc
13838     0.9196  libc-2.2.5.so            chunk_free
13433     0.8927  libc-2.2.5.so            __malloc
13431     0.8925  ld-2.2.5.so              strcmp
13259     0.8811  vmlinux-2.4.24           do_no_page
11993     0.7970  libc-2.2.5.so            strncpy
11640     0.7735  libc-2.2.5.so            strcmp
9912      0.6587  vmlinux-2.4.24           machine_check
9537      0.6338  vmlinux-2.4.24           nr_free_pages
9300      0.6180  cc1                      parse_identifier
8977      0.5965  vmlinux-2.4.24           rmqueue
8935      0.5938  libc-2.2.5.so            _IO_new_file_xsputn
8092      0.5377  libc-2.2.5.so            memcpy
7824      0.5199  cc1                      calc_hash
7496      0.4981  cc1                      find_reloads
7144      0.4747  cc1                      htab_find_slot_with_hash
6867      0.4563  vmlinux-2.4.24           file_read_actor
6670      0.4432  cc1                      record_reg_classes
6597      0.4384  vmlinux-2.4.24           do_page_fault
6404      0.4256  libc-2.2.5.so            strcpy

and this is 2.6.3-rc2

CPU: PIII, speed 451.163 MHz (estimated)
Counted CPU_CLK_UNHALTED events (clocks processor is not halted) with a unit mask of 0x00 (No unit mask) count 100000
samples  %        app name                 symbol name
137869    7.8626  bash                     (no symbols)
95232     5.4310  vmlinux-2.6.3-rc2        do_wp_page
89606     5.1102  as                       (no symbols)
62052     3.5388  vmlinux-2.6.3-rc2        default_idle
47196     2.6916  ld-2.2.5.so              _dl_lookup_versioned_symbol
41176     2.3482  vmlinux-2.6.3-rc2        page_add_rmap
38747     2.2097  libbfd-2.14.90.0.7.so    (no symbols)
35483     2.0236  cc1                      yyparse
32590     1.8586  vmlinux-2.6.3-rc2        do_anonymous_page
32224     1.8377  vmlinux-2.6.3-rc2        copy_page_range
22685     1.2937  libc-2.2.5.so            memset
21935     1.2509  vmlinux-2.6.3-rc2        __copy_to_user_ll
21475     1.2247  ld-2.2.5.so              _dl_relocate_object
20979     1.1964  cc1                      skip_block_comment
20938     1.1941  libc-2.2.5.so            chunk_alloc
19628     1.1194  cc1                      ht_lookup
17279     0.9854  vmlinux-2.6.3-rc2        page_remove_rmap
17140     0.9775  cc1                      _cpp_lex_direct
16122     0.9194  vmlinux-2.6.3-rc2        do_no_page
14690     0.8378  libc-2.2.5.so            _IO_vfprintf
14689     0.8377  libc-2.2.5.so            chunk_free
14300     0.8155  cc1                      grokdeclarator
14164     0.8078  libc-2.2.5.so            __malloc
14001     0.7985  cc1                      ggc_alloc
13678     0.7800  ld-2.2.5.so              strcmp
12038     0.6865  libc-2.2.5.so            strncpy
11770     0.6712  libc-2.2.5.so            strcmp
10788     0.6152  vmlinux-2.6.3-rc2        mark_offset_tsc
10258     0.5850  vmlinux-2.6.3-rc2        page_fault
9848      0.5616  libc-2.2.5.so            memcpy
9581      0.5464  cc1                      parse_identifier
9210      0.5252  vmlinux-2.6.3-rc2        zap_pte_range
8994      0.5129  libc-2.2.5.so            _IO_new_file_xsputn
8005      0.4565  cc1                      calc_hash
7681      0.4380  cc1                      find_reloads
7564      0.4314  vmlinux-2.6.3-rc2        pte_alloc_one
7446      0.4246  vmlinux-2.6.3-rc2        do_page_fault

extracting just the vmlinux bits I get this for 2.4.24

89695     5.9604  vmlinux-2.4.24           do_wp_page
29175     1.9387  vmlinux-2.4.24           do_anonymous_page
24594     1.6343  vmlinux-2.4.24           zap_page_range
23044     1.5313  vmlinux-2.4.24           copy_page_range
13259     0.8811  vmlinux-2.4.24           do_no_page
9912      0.6587  vmlinux-2.4.24           machine_check
9537      0.6338  vmlinux-2.4.24           nr_free_pages
8977      0.5965  vmlinux-2.4.24           rmqueue
6867      0.4563  vmlinux-2.4.24           file_read_actor
6597      0.4384  vmlinux-2.4.24           do_page_fault
6166      0.4097  vmlinux-2.4.24           default_idle
6001      0.3988  vmlinux-2.4.24           __free_pages_ok
5404      0.3591  vmlinux-2.4.24           find_trylock_page
5179      0.3442  vmlinux-2.4.24           lookup_swap_cache
4969      0.3302  vmlinux-2.4.24           exit_notify
4928      0.3275  vmlinux-2.4.24           clear_page_tables
4830      0.3210  vmlinux-2.4.24           d_lookup
3843      0.2554  vmlinux-2.4.24           link_path_walk
3714      0.2468  vmlinux-2.4.24           system_call
3549      0.2358  vmlinux-2.4.24           do_fork
3340      0.2220  vmlinux-2.4.24           copy_mm
3293      0.2188  vmlinux-2.4.24           find_vma_prev
3237      0.2151  vmlinux-2.4.24           schedule
3226      0.2144  vmlinux-2.4.24           do_generic_file_read
3198      0.2125  vmlinux-2.4.24           handle_mm_fault
3096      0.2057  vmlinux-2.4.24           mm_init
3067      0.2038  vmlinux-2.4.24           set_page_dirty
2727      0.1812  vmlinux-2.4.24           get_swaparea_info
2348      0.1560  vmlinux-2.4.24           flush_tlb_page
2143      0.1424  vmlinux-2.4.24           filemap_nopage
2083      0.1384  vmlinux-2.4.24           lru_cache_add
2051      0.1363  vmlinux-2.4.24           __free_pte
1923      0.1278  vmlinux-2.4.24           search_by_key
1777      0.1181  vmlinux-2.4.24           error_code
1735      0.1153  vmlinux-2.4.24           kmem_cache_alloc
1733      0.1152  vmlinux-2.4.24           do_generic_file_write
1702      0.1131  vmlinux-2.4.24           __get_user_2
1627      0.1081  vmlinux-2.4.24           __alloc_pages
1602      0.1065  vmlinux-2.4.24           sys_rt_sigprocmask
1546      0.1027  vmlinux-2.4.24           is_leaf

and this for 2.6.3-rc2

95232     5.4310  vmlinux-2.6.3-rc2        do_wp_page
62052     3.5388  vmlinux-2.6.3-rc2        default_idle
41176     2.3482  vmlinux-2.6.3-rc2        page_add_rmap
32590     1.8586  vmlinux-2.6.3-rc2        do_anonymous_page
32224     1.8377  vmlinux-2.6.3-rc2        copy_page_range
21935     1.2509  vmlinux-2.6.3-rc2        __copy_to_user_ll
17279     0.9854  vmlinux-2.6.3-rc2        page_remove_rmap
16122     0.9194  vmlinux-2.6.3-rc2        do_no_page
10788     0.6152  vmlinux-2.6.3-rc2        mark_offset_tsc
10258     0.5850  vmlinux-2.6.3-rc2        page_fault
9210      0.5252  vmlinux-2.6.3-rc2        zap_pte_range
7564      0.4314  vmlinux-2.6.3-rc2        pte_alloc_one
7446      0.4246  vmlinux-2.6.3-rc2        do_page_fault
6308      0.3597  vmlinux-2.6.3-rc2        handle_mm_fault
5878      0.3352  vmlinux-2.6.3-rc2        __d_lookup
5688      0.3244  vmlinux-2.6.3-rc2        release_pages
5181      0.2955  vmlinux-2.6.3-rc2        schedule
5021      0.2863  vmlinux-2.6.3-rc2        do_journal_end
4899      0.2794  vmlinux-2.6.3-rc2        find_vma
4576      0.2610  vmlinux-2.6.3-rc2        link_path_walk
4517      0.2576  vmlinux-2.6.3-rc2        buffered_rmqueue
4490      0.2561  vmlinux-2.6.3-rc2        find_get_page
3966      0.2262  vmlinux-2.6.3-rc2        search_by_key
3891      0.2219  vmlinux-2.6.3-rc2        system_call
3867      0.2205  vmlinux-2.6.3-rc2        is_leaf
3829      0.2184  vmlinux-2.6.3-rc2        copy_mm
3405      0.1942  vmlinux-2.6.3-rc2        flush_tlb_page
3405      0.1942  vmlinux-2.6.3-rc2        kmem_cache_alloc
3300      0.1882  vmlinux-2.6.3-rc2        scheduler_tick
3297      0.1880  vmlinux-2.6.3-rc2        __copy_from_user_ll
3286      0.1874  vmlinux-2.6.3-rc2        .text.lock.sched
3200      0.1825  vmlinux-2.6.3-rc2        copy_process
3194      0.1822  vmlinux-2.6.3-rc2        filemap_nopage
3081      0.1757  vmlinux-2.6.3-rc2        timer_interrupt
2779      0.1585  vmlinux-2.6.3-rc2        pte_alloc_map
2578      0.1470  vmlinux-2.6.3-rc2        radix_tree_lookup
2368      0.1350  vmlinux-2.6.3-rc2        unlock_page
2337      0.1333  vmlinux-2.6.3-rc2        __alloc_pages
2251      0.1284  vmlinux-2.6.3-rc2        restore_all
2187      0.1247  vmlinux-2.6.3-rc2        init_journal_hash

-- 
Philip Martin
