Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261591AbSI0IRH>; Fri, 27 Sep 2002 04:17:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261615AbSI0IRH>; Fri, 27 Sep 2002 04:17:07 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:56705 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261591AbSI0IRG>; Fri, 27 Sep 2002 04:17:06 -0400
Date: Fri, 27 Sep 2002 13:57:43 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: William Lee Irwin III <wli@holomorphy.com>,
       Zwane Mwaikambo <zwane@linuxpower.ca>, Andrew Morton <akpm@digeo.com>,
       lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: 2.5.38-mm3
Message-ID: <20020927135743.B25021@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20020926124244.GO3530@holomorphy.com> <Pine.LNX.4.44.0209260926480.1819-100000@montezuma.mastecende.com> <20020926133919.GQ3530@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020926133919.GQ3530@holomorphy.com>; from wli@holomorphy.com on Thu, Sep 26, 2002 at 06:39:19AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2002 at 06:39:19AM -0700, William Lee Irwin III wrote:
> Interesting, can you narrow down the poll overheads any? No immediate
> needs (read as: leave your box up, but  watch for it when you can),
> but I'd be interested in knowing if it's fd chunk or poll table setup
> overhead.

Hmm.. I don't see this by just leaving the box up (and a fiew interactive
commands) (4CPU P3 2.5.38-vanilla) -

8744695 default_idle                             136635.8594
  4371 __rdtsc_delay                            136.5938
 22793 do_softirq                               118.7135
  1734 serial_in                                 21.6750
   261 .text.lock.serio                          13.7368
8777715 total                                      6.2461
   422 tasklet_hi_action                          2.0288
   106 bh_action                                  1.3250
    46 system_call                                1.0455
    56 __generic_copy_to_user                     0.8750
   575 timer_bh                                   0.8168
    70 __cpu_up                                   0.7292
    57 cpu_idle                                   0.5089
    24 __const_udelay                             0.3750
    35 mdio_read                                  0.3646
   120 probe_irq_on                               0.3571
   134 page_remove_rmap                           0.3102
   108 page_add_rmap                              0.3068
    18 find_get_page                              0.2812
   189 do_wp_page                                 0.2513
     7 fput                                       0.2188
    27 pte_alloc_one                              0.1875
   135 __free_pages_ok                            0.1834
     2 syscall_call                               0.1818
    11 pgd_alloc                                  0.1719
    11 __free_pages                               0.1719
    65 i8042_interrupt                            0.1693
     8 __wake_up                                  0.1667
    16 find_vma                                   0.1667
    15 serial_out                                 0.1562
    15 radix_tree_lookup                          0.1339
    17 kmem_cache_free                            0.1328
    17 get_page_state                             0.1328
    62 zap_pte_range                              0.1292
     6 mdio_sync                                  0.1250
     3 ret_from_intr                              0.1250
     2 cap_inode_permission_lite                  0.1250
     2 cap_file_permission                        0.1250
    49 do_anonymous_page                          0.1178
     9 lru_cache_add                              0.1125
     9 fget                                       0.1125

What application were you all running ?

Thanks
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.
