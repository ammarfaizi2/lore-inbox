Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261673AbVEJP1J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261673AbVEJP1J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 11:27:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261683AbVEJP1J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 11:27:09 -0400
Received: from gw.exalead.com ([212.234.111.157]:18371 "EHLO exalead.com")
	by vger.kernel.org with ESMTP id S261673AbVEJP0P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 11:26:15 -0400
Message-ID: <4280D292.2030509@exalead.com>
Date: Tue, 10 May 2005 17:26:10 +0200
From: Xavier Roche <roche+kml2@exalead.com>
Organization: Exalead
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.7) Gecko/20050414
X-Accept-Language: fr, en-us, en, ja
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [XFS] Kernel (2.6.11) deadlock in user mode when writing data through
 mmap on large files (64-bit systems)
References: <427F6310.9020709@exalead.com>
In-Reply-To: <427F6310.9020709@exalead.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again,

It seems that this bug is _only_ related to XFS - EXT3 tests were 
successfull, but the same test run on an XFS filesystem crashed.


ngtest        D ffff810078303468     0 20514  20505 (NOTLB)
ffff810078302eb8 0000000000000086 00000001013820a7 0000000000000008
       0000000000000086 0000006e7c5cfe88 ffffffff805915c0 ffff81007fe095a0
       000000000000006e ffff810002c1a780
Call Trace:<ffffffff80139d89>{__mod_timer+318} 
<ffffffff803782c2>{schedule_timeout+165}
       <ffffffff8013a8d0>{process_timeout+0} 
<ffffffff803781ff>{io_schedule_timeout+49}
       <ffffffff802b94cf>{blk_congestion_wait+151} 
<ffffffff80145f95>{autoremove_wake_function+0}
       <ffffffff80145f95>{autoremove_wake_function+0} 
<ffffffff8022982e>{kmem_alloc+210}
       <ffffffff802298cd>{kmem_realloc+43} 
<ffffffff8020d181>{xfs_iext_realloc+245}
       <ffffffff801e62a8>{xfs_bmap_insert_exlist+53} 
<ffffffff801e7194>{xfs_bmap_add_extent_hole_real+949}
       <ffffffff801e84df>{xfs_bmap_add_extent+4759} 
<ffffffff8021f92e>{xfs_trans_brelse+84}
       <ffffffff8021faa8>{xfs_trans_log_buf+107} 
<ffffffff801dbb04>{xfs_alloc_ag_vextent+4013}
       <ffffffff8022995c>{kmem_zone_alloc+70} 
<ffffffff801f215f>{xfs_btree_init_cursor+72}
       <ffffffff801eb7b7>{xfs_bmapi+6221} 
<ffffffff801e8be8>{xfs_bmap_do_search_extents+778}
       <ffffffff80210443>{xfs_iomap_write_direct+646} 
<ffffffff803786c7>{__down_write+129}
       <ffffffff80145f95>{autoremove_wake_function+0} 
<ffffffff8020ff2d>{xfs_iomap+569}
       <ffffffff802ba0ad>{submit_bio+221} 
<ffffffff80229b83>{xfs_map_blocks+66}
       <ffffffff8022a844>{xfs_page_state_convert+996} 
<ffffffff8017281c>{__set_page_dirty_buffers+191}
       <ffffffff801653c5>{page_referenced_file+209} 
<ffffffff80173958>{alloc_buffer_head+50}
       <ffffffff80173fa5>{alloc_page_buffers+99} 
<ffffffff8022af95>{linvfs_writepage+179}
       <ffffffff8015a457>{shrink_zone+3000} 
<ffffffff8022ab3d>{__linvfs_get_block+136}
       <ffffffff80241fc2>{__memset+50} 
<ffffffff80192ed3>{do_mpage_readpage+949}
       <ffffffff80157148>{do_drain+0} <ffffffff8012b801>{try_to_wake_up+755}
       <ffffffff8023e937>{radix_tree_node_alloc+19} 
<ffffffff8023eb29>{radix_tree_insert+291}
       <ffffffff8015aa0c>{try_to_free_pages+278} 
<ffffffff801534d8>{__alloc_pages+531}
       <ffffffff8015575e>{__do_page_cache_readahead+215} 
<ffffffff8014fe07>{filemap_nopage+347}
       <ffffffff8015f511>{do_no_page+984} 
<ffffffff8015f8e4>{handle_mm_fault+419}
       <ffffffff80378992>{_spin_unlock_irqrestore+5} 
<ffffffff8011d090>{do_page_fault+1185}
       <ffffffff8010dd9d>{error_exit+0}

