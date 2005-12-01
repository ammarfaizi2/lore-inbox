Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932239AbVLAOuA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932239AbVLAOuA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 09:50:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932256AbVLAOuA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 09:50:00 -0500
Received: from web34105.mail.mud.yahoo.com ([66.163.178.103]:58982 "HELO
	web34105.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932239AbVLAOt7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 09:49:59 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=J4QI81CStnpTQypTmnkiwl/OJ7LKMXCS/sp3vZAN9nCV/UrW6GyZHYsK0C3YClUad82su9DdrXsVBeA3LY3lK3vMRf9bpVrgBZKiLyVWyYTyVoTnbEi1gwipqmNOOLWkmzuafcagOmDlgPHqBYlBvlvod5/zUmaKSvsAhAmzc14=  ;
Message-ID: <20051201144958.73198.qmail@web34105.mail.mud.yahoo.com>
Date: Thu, 1 Dec 2005 06:49:58 -0800 (PST)
From: Kenny Simpson <theonetruekenny@yahoo.com>
Subject: Re: nfs unhappiness with memory pressure
To: Keith Mannthey <kmannth@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <a762e240511301342x6e754cafsed9db386d05a6b2b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Keith Mannthey <kmannth@gmail.com> wrote:
> You are still reporing free pages.  Do you seen the OOM killer killing
> processes?

Running the test with /proc/sys/vm/overcommit_memory = 2, I get a similar 
result.  It still hangs after about 5.9GB, but it starts trying to write 
out the file sooner.
Here is the stack trace I have for the process (again, by hand, what didn't scroll by as nothing
makes it to logs...)

writetest:
  schedule_timeout
  io_schedule_timeout
  blk_congestion_wait
  throttle_vm_writeout
  shrink_zone
  shrink_caches
  try_to_free_pages
  __alloc_pages
    -> (up to here it matches the previous run's stack from rpciod/0)
  kmem_getpages
  cache_grow
  cache_alloc_refill
  kmem_cache_alloc
  mempool_alloc_slab
  mempool_alloc
  nfs_flush_one
  nfs_flush_list
  nfs_flush_inode
  nfs_write_pages
  do_writepages
  __filemap_fdatawrite_range
  filemap_fdatawrite
  filemap_write_and_wait
  nfs_revalidate_mapping
  nfs_file_write
  do_sync_write
  vfs_write
  sys_pwrite64

The memory dump showed there was memory still available, with no swap in use.

-Kenny



	
		
__________________________________ 
Yahoo! Mail - PC Magazine Editors' Choice 2005 
http://mail.yahoo.com
