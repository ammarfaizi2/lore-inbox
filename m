Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264897AbTGBWqN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 18:46:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264980AbTGBWqN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 18:46:13 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:10646 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264897AbTGBWpt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 18:45:49 -0400
Date: Wed, 02 Jul 2003 15:48:35 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: Andrew Morton <akpm@digeo.com>
Subject: ext2 vs ext3
Message-ID: <573930000.1057186115@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew asked for updated numbers ... is about the same on kernbench, 
still significantly slower on SDET (about 1/4 of the speed of ext2), 
though much better than it was.

Kernbench: (make -j N vmlinux, where N = 16 x num_cpus)
                              Elapsed      System        User         CPU
               2.5.73-mm3       45.36      111.71      565.71     1493.75
          2.5.73-mm3-ext3       45.59      114.12      565.72     1489.50

       853     5.2% total
       570    11.4% default_idle
        72     3.6% page_remove_rmap
        58   580.0% fd_install
        38   292.3% __blk_queue_bounce
        24     1.7% do_anonymous_page
        23     4.5% __copy_to_user_ll
        20    13.1% __wake_up
        14   700.0% __find_get_block_slow
        13     6.6% do_page_fault
        13     9.2% __down
        12     8.6% kmem_cache_free
        12     0.0% journal_add_journal_head
        11    26.8% __fput
        10     0.0% find_next_usable_block
        10     0.0% do_get_write_access
...
       -12   -21.8% copy_page_range
       -21    -6.0% __copy_from_user_ll
       -28   -68.3% may_open
       -58  -100.0% generic_file_open

DISCLAIMER: SPEC(tm) and the benchmark name SDET(tm) are registered
trademarks of the Standard Performance Evaluation Corporation. This 
benchmarking was performed for research purposes only, and the run results
are non-compliant and not-comparable with any published results.

SDET 128  (see disclaimer)
                           Throughput    Std. Dev
               2.5.73-mm3       100.0%         0.1%
          2.5.73-mm3-ext3        23.1%         4.4%

    168834   222.4% total
    142610   375.4% default_idle
     10901     0.0% .text.lock.transaction
      3674     0.0% do_get_write_access
      3345     0.0% journal_dirty_metadata
      3227  5867.3% __down
      1548   710.1% schedule
      1514  1916.5% __wake_up
      1306     0.0% start_this_handle
      1268     0.0% journal_stop
       831     0.0% journal_add_journal_head
       627  2985.7% __blk_queue_bounce
       522     0.0% journal_dirty_data
       441     0.0% ext3_get_inode_loc
       305  30500.0% prepare_to_wait_exclusive
       277   513.0% __find_get_block_slow
       265     0.0% ext3_journal_start
       238     0.0% find_next_usable_block
       213   116.4% __find_get_block
       209     0.0% ext3_do_update_inode
       157  15700.0% unlock_buffer
       147     0.0% journal_cancel_revoke
       141     0.0% ext3_orphan_del
       136     0.0% ext3_orphan_add
       130     0.0% ext3_reserve_inode_write
       128   209.8% generic_file_aio_write_nolock
       126     0.0% journal_unmap_buffer
       123  12300.0% blk_run_queues
       120    94.5% __brelse
       108     0.0% ext3_new_inode
...
      -102   -22.1% remove_shared_vm_struct
      -104    -8.1% copy_page_range
      -108  -100.0% generic_file_open
      -110   -31.9% free_pages_and_swap_cache
      -113   -92.6% .text.lock.highmem
      -115   -49.8% follow_mount
      -151   -69.6% .text.lock.dcache
      -182   -59.3% .text.lock.dec_and_lock
      -182  -100.0% ext2_new_inode
      -194   -11.6% zap_pte_range
      -196   -32.8% path_lookup
      -223   -34.7% atomic_dec_and_lock
      -237  -100.0% grab_block
      -262   -22.9% __d_lookup
      -283   -27.5% release_pages
      -843   -21.6% page_add_rmap
     -2259   -26.3% page_remove_rmap



