Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265758AbUFIMak@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265758AbUFIMak (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 08:30:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265701AbUFIM2l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 08:28:41 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:35984 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S263850AbUFIM1A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 08:27:00 -0400
Date: Wed, 9 Jun 2004 14:26:47 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: nathans@sgi.com, owner-xfs@oss.sgi.com
Cc: linux-kernel@vger.kernel.org
Subject: [STACK] >3k call path in xfs
Message-ID: <20040609122647.GF21168@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

xfs is quite interesting.  No single function is particularly
stack-hungry, but the sheer depth of the call path adds up.  Nathan,
can you see if some bytes can be saved here and there?

3k is not really bad yet, I just like to keep 1k of headroom for
surprises like an extra int foo[256] in a structure.

stackframes for call path too long (3064):
    size  function
     144  xfs_ioctl
     328  xfs_swapext
       0  xfs_iaccess
      16  xfs_acl_iaccess
     104  xfs_attr_fetch
       0  xfs_attr_node_get
      28  xfs_da_node_lookup_int
      68  xfs_dir2_leafn_lookup_int
       0  xfs_da_read_buf
     288  xfs_bmapi
      52  xfs_rtpick_extent
      24  xfs_trans_iget
      32  xfs_iget
      32  xfs_iread
      72  xfs_itobp
      60  xfs_imap
      84  xfs_dilocate
       0  xfs_inobt_lookup_le
      16  xfs_inobt_increment
      28  xfs_btree_readahead_core
      20  xfs_btree_reada_bufl
      12  pagebuf_readahead
      16  pagebuf_get
       0  pagebuf_iostart
       0  xfs_bdstrat_cb
      68  pagebuf_iorequest
       0  pagebuf_iodone
       0  pagebuf_iodone_work
       0  pagebuf_rele
       0  preempt_schedule
      84  schedule
      16  __put_task_struct
      20  audit_free
      36  audit_log_start
      16  __kmalloc
       0  __get_free_pages
      28  __alloc_pages
     284  try_to_free_pages
       0  out_of_memory
       0  mmput
      16  exit_aio
       0  __put_ioctx
      16  do_munmap
       0  split_vma
      36  vma_adjust
       0  fput
       0  __fput
       0  locks_remove_flock
      12  panic
       0  sys_sync
       0  sync_inodes
     308  sync_inodes_sb
       0  do_writepages
     128  mpage_writepages
       4  write_boundary_block
       0  ll_rw_block
      28  submit_bh
       0  bio_alloc
      88  mempool_alloc
     256  wakeup_bdflush
      20  pdflush_operation
       0  printk
      16  release_console_sem
      16  __wake_up
       0  printk
       0  vscnprintf
      32  vsnprintf
     112  number

Jörn

-- 
Ninety percent of everything is crap.
-- Sturgeon's Law
