Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261425AbUFIMXt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261425AbUFIMXt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 08:23:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265758AbUFIMXn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 08:23:43 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:60303 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S265747AbUFIMUf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 08:20:35 -0400
Date: Wed, 9 Jun 2004 14:20:02 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: vandrove@vc.cvut.cz, vl@kki.org
Cc: linux-kernel@vger.kernel.org
Subject: [STACK] >3k call path in ncpfs
Message-ID: <20040609122002.GD21168@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ncpfs has a few stack-hungry functions.  Could you try to put
ncp_ioctl() and/or ncp_conn_logged_in() on a diet?  Example call path
is below.

stackframes for call path too long (3004):
    size  function
     720  ncp_ioctl
     616  ncp_conn_logged_in
      24  ncp_lookup_volume
       0  ncp_request2
     164  sock_sendmsg
       0  wait_on_sync_kiocb
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
       0  preempt_schedule
      84  schedule

Jörn

-- 
Time? What's that? Time is only worth what you do with it.
-- Theo de Raadt
