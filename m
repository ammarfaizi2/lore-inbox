Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264750AbUHWQ6Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264750AbUHWQ6Z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 12:58:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265812AbUHWQ6Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 12:58:25 -0400
Received: from jade.spiritone.com ([216.99.193.136]:21988 "EHLO
	jade.spiritone.com") by vger.kernel.org with ESMTP id S264750AbUHWQ6W
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 12:58:22 -0400
Date: Mon, 23 Aug 2004 09:58:06 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Nick Piggin <piggin@cyberone.com.au>
Subject: Performance of -mm2 and -mm4
Message-ID: <336080000.1093280286@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Kernbench: (make -j vmlinux, maximal tasks)
                              Elapsed      System        User         CPU
                  2.6.8.1       43.90       87.76      572.94     1505.67
              2.6.8.1-mm1       44.26       87.71      574.73     1496.33
              2.6.8.1-mm2       44.27       90.27      574.84     1502.33
              2.6.8.1-mm4       45.87       97.60      595.23     1510.00

mm2 seems to take slightly (but consistently) more systime than mm1, and
mm4 is significantly worse still ;-(

diffprofile from mm1 to mm2:

      5469  32170.6% find_get_page
       785    13.0% __d_lookup
       476     0.4% total
       128    21.9% generic_file_open
        93    22.5% __alloc_pages
        62    26.1% file_ra_state_init
        58     0.0% put_page
        54     9.9% dput
...
       -51    -2.8% finish_task_switch
       -55    -4.3% __wake_up
       -67    -6.6% file_move
      -128    -1.7% __copy_to_user_ll
      -156    -1.1% do_anonymous_page
     -2189    -4.7% default_idle
     -3632  -100.0% find_trylock_page

and -mm1 to -mm4

      5841  34358.8% find_get_page
      5394     4.0% total
      1459    24.2% __d_lookup
       740     9.2% __copy_from_user_ll
       718     9.5% __copy_to_user_ll
       304    24.0% __wake_up
       253    20.2% free_hot_cold_page
       248    19.8% atomic_dec_and_lock
       229    42.2% dput
       228    13.7% path_lookup
       226    43.0% Letext
       202    34.6% generic_file_open
       197    23.6% pte_alloc_one
       194    77.0% pgd_ctor
       180    22.6% kmem_cache_free
       173     6.5% zap_pte_range
       170     9.2% buffered_rmqueue
       146    16.1% in_group_p
       123    22.3% __fput
...
       -56   -23.5% file_ra_state_init
       -72   -31.7% page_add_anon_rmap
      -104    -5.6% finish_task_switch
      -124    -0.9% do_anonymous_page
     -3633  -100.0% find_trylock_page
     -4636   -10.0% default_idle

The -mm4 looks more like sched stuff to me (copy_to/from_user, etc),
but the -mm2 stuff looks like something else. Buggered if I know what.
-mm3 didn't compile cleanly, so I didn't bother, but I prob can if you
like.

m.

