Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265384AbUAMX0c (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 18:26:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265406AbUAMX0c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 18:26:32 -0500
Received: from amsfep12-int.chello.nl ([213.46.243.18]:62225 "EHLO
	amsfep12-int.chello.nl") by vger.kernel.org with ESMTP
	id S265384AbUAMX01 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 18:26:27 -0500
Date: Wed, 14 Jan 2004 00:26:24 +0100
From: Haakon Riiser <hakonrk@ulrik.uio.no>
To: linux-kernel@vger.kernel.org
Subject: Re: Busy-wait delay in qmail 1.03 after upgrading to Linux 2.6
Message-ID: <20040113232624.GA302@s.chello.no>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20040113210923.GA955@s.chello.no> <20040113135152.3ed26b85.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040113135152.3ed26b85.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Andrew Morton]

> Seems innocuous.  What filesystem type is lock/trigger on?

Reiserfs.

> Can you generate a kernel profile of this activity?

Done.  Note that I had to reboot to do the profiling, so the
delay is not as bad as the first example:

  344   00:19:07.476825 write(5, "\0", 1) = 1 <0.291500>

Still around 700 times slower than 2.4 though. :-)  Anyway,
here are the results:

Output from time:

  real    0m0.309s
  user    0m0.011s
  sys     0m0.004s

Data in prof.time:

  c0117440 do_page_fault                                 2   0.0015
  c01196e0 __wake_up                                     2   0.0208
  c0139d80 free_hot_cold_page                            2   0.0078
  c0139ea0 buffered_rmqueue                              2   0.0057
  c013d650 kmem_cache_free                               2   0.0250
  c0141e10 page_address                                  2   0.0104
  c0142a20 zap_pte_range                                 2   0.0046
  c0145670 __insert_vm_struct                            2   0.0139
  c0146300 find_vma                                      2   0.0208
  c0151860 dentry_open                                   2   0.0038
  c0153760 fget                                          2   0.0312
  c0168e90 locks_remove_posix                            2   0.0074
  c016dbb0 dnotify_flush                                 2   0.0104
  c0210f40 decrement_counters_in_path                    2   0.0250
  c022bd90 atomic_dec_and_lock                           2   0.0250
  c022c340 strncpy_from_user                             2   0.0179
  c0120b00 current_kernel_time                           3   0.0469
  c013d6a0 kfree                                         3   0.0268
  c0144040 do_anonymous_page                             3   0.0057
  c0153640 __fput                                        3   0.0104
  c015f640 pipe_poll                                     3   0.0234
  c0161660 may_open                                      3   0.0065
  c01654f0 __pollwait                                    3   0.0144
  c01655c0 max_select_fd                                 3   0.0134
  c022c650 __copy_from_user_ll                           3   0.0170
  c0145490 find_vma_prepare                              4   0.0357
  c0145ab0 do_mmap_pgoff                                 4   0.0022
  c0182190 write_profile                                 4   0.0625
  c0211030 is_leaf                                       4   0.0086
  c0155230 __find_get_block                              5   0.0223
  c02112a0 is_tree_node                                  6   0.0536
  c022c5d0 __copy_to_user_ll                             6   0.0469
  c01606a0 link_path_walk                                8   0.0035
  c01656a0 do_select                                     9   0.0125
  c01659a0 sys_select                                    9   0.0070
  c016aaa0 __d_lookup                                   10   0.0298
  c0109174 system_call                                  16   0.3636
  c0211310 search_by_key                                16   0.0044
  c022c0b0 fast_clear_page                              21   0.2188
  00000000 total                                       232   0.0001

-- 
 Haakon
