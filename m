Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266232AbUANAJq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 19:09:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265878AbUANAIg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 19:08:36 -0500
Received: from amsfep12-int.chello.nl ([213.46.243.18]:864 "EHLO
	amsfep20-int.chello.nl") by vger.kernel.org with ESMTP
	id S266215AbUANAHt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 19:07:49 -0500
Date: Wed, 14 Jan 2004 01:07:46 +0100
From: Haakon Riiser <hakonrk@ulrik.uio.no>
To: linux-kernel@vger.kernel.org
Subject: Re: Busy-wait delay in qmail 1.03 after upgrading to Linux 2.6
Message-ID: <20040114000746.GA691@s.chello.no>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20040113210923.GA955@s.chello.no> <20040113135152.3ed26b85.akpm@osdl.org> <20040113232624.GA302@s.chello.no> <20040113154348.5542cb7b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040113154348.5542cb7b.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Andrew Morton]

> OK, that's inconclusive.  Could you do a few runs, or leave it a day or
> two, wait until the problem is really prominent and see if you can gather a
> clearer profile?  The profiling overhead is negligible when profiling is
> enabled but not in use, so there is no need to reboot.

I tried running the test over and over, and after around 20 times,
it suddenly jumped from 0.3 seconds to 1.6 again.  Results follow:

strace:

  678   01:04:16.722816 write(5, "\0", 1) = 1 <1.635007>

time:

  real    0m1.666s
  user    0m0.008s
  sys     0m0.005s

prof.time:

  c0139ea0 buffered_rmqueue                              9   0.0256
  c0141e10 page_address                                  9   0.0469
  c0151a70 get_unused_fd                                 9   0.0216
  c0161830 open_namei                                    9   0.0089
  c01f8500 bin_search_in_dir_item                        9   0.0511
  c0144040 do_anonymous_page                            10   0.0189
  c0146300 find_vma                                     10   0.1042
  c013d650 kmem_cache_free                              11   0.1375
  c0145ab0 do_mmap_pgoff                                11   0.0061
  c0153640 __fput                                       11   0.0382
  c0161180 path_lookup                                  11   0.0362
  c01654f0 __pollwait                                   11   0.0529
  c022bec0 memcpy                                       11   0.1146
  c011aad0 add_wait_queue                               12   0.1250
  c0151860 dentry_open                                  12   0.0227
  c01539b0 __constant_c_and_count_memset                12   0.0833
  c0151d50 filp_close                                   13   0.0903
  c01f85b0 search_by_entry_key                          13   0.0262
  c01457c0 vma_merge                                    14   0.0186
  c02112a0 is_tree_node                                 14   0.1250
  c0142a20 zap_pte_range                                15   0.0347
  c022c650 __copy_from_user_ll                          15   0.0852
  c015f640 pipe_poll                                    16   0.1250
  c01655c0 max_select_fd                                16   0.0714
  c0117440 do_page_fault                                17   0.0131
  c0106d30 default_idle                                 19   0.3958
  c013d6a0 kfree                                        20   0.1786
  c0153760 fget                                         21   0.3281
  c01606a0 link_path_walk                               21   0.0091
  c022c5d0 __copy_to_user_ll                            22   0.1719
  c0211030 is_leaf                                      23   0.0496
  c016aaa0 __d_lookup                                   28   0.0833
  c0203d70 reiserfs_readdir                             28   0.0184
  c0155230 __find_get_block                             36   0.1607
  c01656a0 do_select                                    47   0.0653
  c01659a0 sys_select                                   50   0.0391
  c0211310 search_by_key                                90   0.0247
  c0109174 system_call                                 107   2.4318
  c022c0b0 fast_clear_page                             119   1.2396
  00000000 total                                      1251   0.0005

-- 
 Haakon
