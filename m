Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262361AbTHYXVc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 19:21:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262309AbTHYXVc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 19:21:32 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:14062 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262361AbTHYXVa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 19:21:30 -0400
Date: Mon, 25 Aug 2003 16:10:42 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test4-mm1
Message-ID: <30190000.1061853042@flay>
In-Reply-To: <20030824171318.4acf1182.akpm@osdl.org>
References: <20030824171318.4acf1182.akpm@osdl.org>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

System time is still rather higher in kernbench, though maybe the
elapsed time isn't degraded so much any more. Not sure if this is
scheduler changes or not, but last time, we isolated a change of
exactly this magnitude to one of those patches (Ingo's IIRC).

I tried "set TIMESLICE_GRANULARITY to MAX_TIMESLICE in sched.c" as
requested, makes no difference really (-max result below).

Kernbench: (make -j vmlinux, maximal tasks)
                              Elapsed      System        User         CPU
              2.6.0-test4       45.87      116.92      571.10     1499.00
          2.6.0-test4-mm1       46.29      121.39      570.52     1494.75
      2.6.0-test4-mm1-max       46.00      122.18      570.73     1505.75

diffprofile:

      7763     4.8% total
      2921     6.4% default_idle
       949     0.0% direct_strnlen_user
       719    20.6% __copy_from_user_ll
       554    10.4% __copy_to_user_ll
       544    33.5% kmem_cache_free
       425     0.0% kpmd_ctor
       372    26.1% schedule
       349    18.7% atomic_dec_and_lock
       322     4.1% __d_lookup
       318     8.6% find_get_page
       283   165.5% may_open
       279     1.2% page_remove_rmap
       275    16.0% buffered_rmqueue
       263    42.4% __wake_up
       212    15.3% free_hot_cold_page
       119     6.4% path_lookup
       117     3.7% zap_pte_range
       114     0.0% direct_strncpy_from_user
       107    17.3% generic_file_open
...
      -102    -1.6% page_add_rmap
      -122  -100.0% strncpy_from_user
      -288   -79.8% dentry_open
      -305   -66.2% do_page_cache_readahead
      -353  -100.0% pgd_ctor
      -447   -80.4% file_ra_state_init
      -558   -74.9% filp_close
      -854  -100.0% strnlen_user

