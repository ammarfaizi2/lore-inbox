Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267598AbTAQQuK>; Fri, 17 Jan 2003 11:50:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267599AbTAQQuK>; Fri, 17 Jan 2003 11:50:10 -0500
Received: from franka.aracnet.com ([216.99.193.44]:34738 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S267598AbTAQQuI>; Fri, 17 Jan 2003 11:50:08 -0500
Date: Fri, 17 Jan 2003 08:58:43 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Ingo Molnar <mingo@elte.hu>, Erich Focht <efocht@ess.nec.de>
cc: Christoph Hellwig <hch@infradead.org>, Robert Love <rml@tech9.net>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>,
       Andrew Theurer <habanero@us.ibm.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
Subject: Re: [patch] sched-2.5.59-A2
Message-ID: <270920000.1042822723@titus>
In-Reply-To: <Pine.LNX.4.44.0301171607510.10244-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0301171607510.10244-100000@localhost.localdomain>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> agreed, i've attached the -B0 patch that does this. The balancing rates
> are 1 msec, 2 msec, 200 and 400 msec (idle-local, idle-global, busy-local,
> busy-global).

Hmmm... something is drastically wrong here, looks like we're thrashing
tasks between nodes?

Kernbench:
                                   Elapsed        User      System         CPU
                        2.5.59     20.032s     186.66s      47.73s       1170%
                  2.5.59-ingo2     23.578s    198.874s     90.648s     1227.4%

NUMA schedbench 4:
                                   AvgUser     Elapsed   TotalUser    TotalSys
                        2.5.59        0.00       36.38       90.70        0.62
                  2.5.59-ingo2        0.00       47.62      127.13        1.89

NUMA schedbench 8:
                                   AvgUser     Elapsed   TotalUser    TotalSys
                        2.5.59        0.00       42.78      249.77        1.85
                  2.5.59-ingo2        0.00       59.45      358.31        5.23

NUMA schedbench 16:
                                   AvgUser     Elapsed   TotalUser    TotalSys
                        2.5.59        0.00       56.84      848.00        2.78
                  2.5.59-ingo2        0.00      114.70     1430.95       21.21

diffprofile:

44770 total
27840 do_anonymous_page
3180 buffered_rmqueue
1814 default_idle
1534 __copy_from_user_ll
1465 free_hot_cold_page
1172 __copy_to_user_ll
919 page_remove_rmap
881 zap_pte_range
730 do_wp_page
687 do_no_page
601 __alloc_pages
527 vm_enough_memory
432 __set_page_dirty_buffers
426 page_add_rmap
322 release_pages
311 __pagevec_lru_add_active
233 prep_new_page
202 clear_page_tables
181 schedule
132 current_kernel_time
127 __block_prepare_write
103 kmap_atomic
100 __wake_up
97 pte_alloc_one
95 may_open
87 find_get_page
76 dget_locked
72 bad_range
69 pgd_alloc
62 __fput
50 copy_strings
...
-66 open_namei
-68 path_lookup
-115 .text.lock.file_table
-255 .text.lock.dec_and_lock
-469 .text.lock.namei

