Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264080AbTEWPSW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 11:18:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264082AbTEWPSV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 11:18:21 -0400
Received: from franka.aracnet.com ([216.99.193.44]:2480 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S264080AbTEWPSU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 11:18:20 -0400
Date: Fri, 23 May 2003 08:31:14 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
cc: haveblue@us.ibm.com
Subject: Re: 2.5.69-mm8
Message-ID: <31930000.1053703873@[10.10.2.4]>
In-Reply-To: <17990000.1053670694@[10.10.2.4]>
References: <20030522021652.6601ed2b.akpm@digeo.com> <17990000.1053670694@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>       1004     2.0% default_idle
>        272     8.3% __copy_from_user_ll
>        129     1.7% __d_lookup
>         79     7.5% link_path_walk
> ...
>        -50    -1.3% find_get_page
>        -55    -1.5% zap_pte_range
>        -66    -6.5% file_move
>        -74    -1.2% page_add_rmap
>        -80    -0.6% do_anonymous_page
>       -110    -6.9% schedule
>       -139    -7.0% atomic_dec_and_lock
>       -698    -0.4% total
>      -1139    -4.6% page_remove_rmap
> 
> Not sure quite what that's all about, but there it is ;-)

WRT consistency, a second set of runs indicates it's very consistent.
And the user time is down significantly too. These are all averages
of 5 runs to start with (well, averages of the median 3 runs of 5).
Same for the profiles.

Kernbench: (make -j vmlinux, maximal tasks)
                              Elapsed      System        User         CPU
               2.5.69-mm7       46.58      117.00      578.47     1492.00
             2.5.69-mm7-2       47.39      117.24      578.58     1468.75
               2.5.69-mm8       46.09      115.11      570.74     1487.25
             2.5.69-mm8-2       45.91      115.00      571.22     1494.25

The copy to/from user stuff may be noise, but page_remove_rmap and
atomic_dec_and_lock are certainly happier. Second set of runs gives:

      3708     8.0% default_idle
      1285     0.8% total
       161     4.9% __copy_from_user_ll
        95     2.5% find_get_page
        77     5.8% kmem_cache_free
        58     4.7% release_pages
        57     5.4% link_path_walk
...
       -52   -14.0% .text.lock.filemap
       -62   -14.3% .text.lock.file_table
       -63    -3.8% do_page_fault
       -67    -3.6% path_lookup
       -70    -0.5% do_anonymous_page
       -84   -10.0% pte_alloc_one
       -91    -5.7% schedule
      -111   -11.2% clear_page_tables
      -118    -6.0% atomic_dec_and_lock
      -200    -3.7% __copy_to_user_ll
      -338    -4.1% __d_lookup
      -931    -3.8% page_remove_rmap

