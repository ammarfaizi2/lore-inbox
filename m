Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266034AbUBCQr0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 11:47:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266039AbUBCQr0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 11:47:26 -0500
Received: from s4.uklinux.net ([80.84.72.14]:21938 "EHLO mail2.uklinux.net")
	by vger.kernel.org with ESMTP id S266034AbUBCQrN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 11:47:13 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Nick Piggin <piggin@cyberone.com.au>
Subject: Re: 2.6.1 slower than 2.4, smp/scsi/sw-raid/reiserfs
References: <87oesieb75.fsf@codematters.co.uk>
	<20040202194626.191cbb95.akpm@osdl.org>
From: Philip Martin <philip@codematters.co.uk>
Date: Tue, 03 Feb 2004 16:46:14 +0000
In-Reply-To: <20040202194626.191cbb95.akpm@osdl.org> (Andrew Morton's
 message of "Mon, 2 Feb 2004 19:46:26 -0800")
Message-ID: <87llnk2js9.fsf@codematters.co.uk>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Common Lisp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> Could you generate a kernel profile?  Add `profile=1' to the kernel boot
> command line and run:
>
> sudo readprofile -r
> sudo readprofile -M10
> time make -j4
> readprofile -n -v -m /boot/System.map | sort -n +2 | tail -40 | tee ~/profile.txt >&2
>
> on both 2.4 and 2.6?  Make sure the System.map is appropriate to the
> currently-running kernel.

2.4.24

239.24user 85.80system 2:50.73elapsed 190%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (1741932major+1948496minor)pagefaults 0swaps

c013bcd8 fput                                        366   1.5000
c017c154 search_by_key                               377   0.1010
c01242dc sys_rt_sigprocmask                          399   0.6786
c022b388 strnlen_user                                427   4.8523
c013210c kmem_cache_alloc                            431   1.3814
c0134968 __alloc_pages                               445   0.6825
c012d628 filemap_nopage                              449   0.8909
c0133168 delta_nr_inactive_pages                     452   5.6500
c0114478 flush_tlb_page                              533   4.5948
c012c76c do_generic_file_read                        536   0.4573
c012c18c unlock_page                                 608   5.8462
c013300c lru_cache_add                               609   5.2500
c0135fa4 get_swaparea_info                           622   1.0436
c012b514 set_page_dirty                              630   4.0385
c0129b3c handle_mm_fault                             655   3.5598
c0117a68 schedule                                    678   0.5168
c0119444 mm_init                                     695   3.4750
c01195dc copy_mm                                     705   0.9375
c0119d60 do_fork                                     822   0.4061
c012a894 find_vma                                    822   9.7857
c01089b0 system_call                                 865  15.4464
c0135094 free_page_and_swap_cache                    899  17.2885
c0145050 link_path_walk                              977   0.3972
c01284a0 __free_pte                                 1016  14.1111
c012c2d8 __find_get_page                            1032  16.1250
c0128500 clear_page_tables                          1112   4.9643
c014e514 d_lookup                                   1131   3.9824
c011de3c exit_notify                                1216   1.7471
c0134290 __free_pages_ok                            1357   1.9956
c012ce8c file_read_actor                            1515  10.8214
c0134538 rmqueue                                    2011   3.3970
c0134c7c __free_pages                               2122  66.3125
c012999c do_no_page                                 2849   6.8486
c0116a3c do_page_fault                              3996   3.3922
c01285e0 copy_page_range                            4671  10.4263
c01287a0 zap_page_range                             5395   6.1029
c01298bc do_anonymous_page                          6867  30.6562
c0129364 do_wp_page                                20003  37.8845
c0106d60 default_idle                              66782 1284.2692
00000000 total                                    154891   0.1278


2.6.1

248.82user 122.01system 3:37.24elapsed 170%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (474major+3768844minor)pagefaults 0swaps

c011e450 mm_init                                     441   1.8375
c0114658 sched_clock                                 452   3.7667
c0108ac8 copy_thread                                 462   0.8431
c010a79c syscall_call                                471  42.8182
c010b1e0 error_code                                  477   8.5179
c0127a1c del_timer_sync                              492   3.7273
c01229e0 wait_task_zombie                            535   1.1239
c0121970 put_files_struct                            556   2.8958
c010c570 handle_IRQ_event                            621   7.0568
c011fbe0 do_fork                                     642   1.6895
c0128d18 flush_signal_handlers                       661   9.7206
c0123ec0 do_softirq                                  675   3.3088
c011add4 wake_up_forked_process                      721   1.7672
c0110d1c old_mmap                                    866   2.6728
c0122d78 sys_wait4                                   889   1.5223
c012c638 sys_rt_sigaction                            905   3.7090
c01168b8 flush_tlb_mm                               1020   6.8919
c012b0a4 get_signal_to_deliver                      1374   1.4494
c0123e38 current_kernel_time                        1555  22.8676
c011afc8 schedule_tail                              1636   9.0889
c01223e8 do_exit                                    1719   1.7613
c011df4f .text.lock.sched                           2228   7.7093
c012b560 sys_rt_sigprocmask                         2439   7.0901
c012c0a0 do_sigaction                               2709   4.0074
c011e3c8 dup_task_struct                            3056  22.4706
c011de6c __preempt_spin_lock                        3096  38.7000
c011ec08 copy_files                                 3133   3.5602
c012b474 sigprocmask                                3433  14.5466
c011c2e0 __wake_up                                  3495  45.9868
c0121d58 exit_notify                                3945   2.3482
c0121150 release_task                               4053   7.3960
c011bbf0 schedule                                   6904   4.3150
c011694c flush_tlb_page                             7057  44.1063
c011e6d4 copy_mm                                    7931   7.6851
c010a770 system_call                                8361 190.0227
c011efe0 copy_process                               8654   2.8171
c0119588 pte_alloc_one                             15888 248.2500
c01199b8 do_page_fault                             44374  37.2265
c01086b0 default_idle                             739276 14216.8462
00000000 total                                    896883   5.5028
-- 
Philip Martin
