Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261917AbTE2GK0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 02:10:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261923AbTE2GK0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 02:10:26 -0400
Received: from franka.aracnet.com ([216.99.193.44]:31624 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S261917AbTE2GKY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 02:10:24 -0400
Date: Wed, 28 May 2003 23:23:23 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.5.70-mm1
Message-ID: <1980000.1054189401@[10.10.2.4]>
In-Reply-To: <20030527004255.5e32297b.akpm@digeo.com>
References: <20030527004255.5e32297b.akpm@digeo.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> . A number of fixes against the ext3 work which Alex and I have been doing.
>   This code is stable now.  I'm using it on my main SMP desktop machine.
> 
>   These are major changes to a major filesystem.  I would ask that
>   interested parties now subject these patches to stresstesting and to
>   performance testing.  The performance gains on SMP will be significant.

Sexy. SDET beats the hell out of this, and is much improved:

SDET 128  (see disclaimer)
                           Throughput    Std. Dev
               2.5.66-mm2       100.0%         0.6%
          2.5.66-mm2-ext3         3.9%         0.4%

SDET 128  (see disclaimer)
                           Throughput    Std. Dev
          2.5.70-mm1-ext2       100.0%         0.1%
          2.5.70-mm1-ext3        22.7%         2.0%


diffprofile 2.5.70-mm1-ext2 2.5.70-mm1-ext3
(for SDET 128: + worse with ext3, - better.)
   1857406   245.2% total
   1531720   431.5% default_idle
    106589     0.0% .text.lock.transaction
     40119     0.0% do_get_write_access
     37170     0.0% journal_dirty_metadata
     35031  6560.1% __down
     24412  8030.3% .text.lock.attr
     19535  2556.9% __wake_up
     19201   907.0% schedule
     11344     0.0% start_this_handle
     10104     0.0% journal_add_journal_head
     10007     0.0% .text.lock.sched
      7352     0.0% journal_stop
      5949  99150.0% prepare_to_wait_exclusive
      5867  3008.7% __blk_queue_bounce
      4724   335.3% __find_get_block
      4618     0.0% ext3_get_inode_loc
      4410     0.0% journal_dirty_data
      3754   590.3% __find_get_block_slow
      3079   738.4% .text.lock.base
      2176     0.0% ext3_do_update_inode
      2132  11844.4% unlock_buffer
      1995     0.0% ext3_journal_start
      1888     0.0% ext3_orphan_del
      1783   145.2% __brelse
      1642  4829.4% blk_run_queues
      1555     0.0% ext3_orphan_add
      1495     0.0% ext3_new_inode
      1430     0.0% ext3_reserve_inode_write
      1412     0.0% journal_destroy_handle_cache
      1344     0.0% journal_cancel_revoke
      1279     0.0% journal_unmap_buffer
      1198     0.0% ext3_free_blocks
...
     -1057   -88.4% .text.lock.highmem
     -1064   -24.5% remove_shared_vm_struct
     -1112   -52.8% .text.lock.dec_and_lock
     -1126  -100.0% ext2_new_inode
     -1516  -100.0% grab_block
     -1594   -28.3% path_lookup
     -1599   -28.0% atomic_dec_and_lock
     -1660   -10.4% copy_page_range
     -1695   -15.4% __d_lookup
     -2585   -23.6% release_pages
     -2614   -13.5% zap_pte_range
     -9758   -20.7% page_add_rmap
    -26185   -25.3% page_remove_rmap

