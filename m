Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261646AbVASIQm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261646AbVASIQm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 03:16:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261640AbVASIP3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 03:15:29 -0500
Received: from egg.hpc2n.umu.se ([130.239.45.244]:2447 "EHLO egg.hpc2n.umu.se")
	by vger.kernel.org with ESMTP id S261633AbVASILf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 03:11:35 -0500
Date: Wed, 19 Jan 2005 09:11:32 +0100
To: linux-kernel@vger.kernel.org
Subject: multiple page allocation errors in 2.6.10
Message-ID: <20050119081132.GD4494@hpc2n.umu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
From: Ake.Sandgren@hpc2n.umu.se (Ake)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
I'm getting multiple page allocation errors under high load.
Should i worry about them?

/etc/sysctl.conf:
net/core/rmem_max = 83333333
net/core/wmem_max = 83333333
net/ipv4/tcp_rmem = 4096 833333 83333333
net/ipv4/tcp_wmem = 4096 833333 83333333
vm/min_free_kbytes = 32768

(The tcp stuff is there since we mostly have long distance traffic.)
Please reply to me, i'm not on the list.

nfsd: page allocation failure. order:4, mode:0x50
 [<c010365e>] dump_stack+0x1e/0x30
 [<c013cefc>] __alloc_pages+0x1bc/0x350
 [<c013d0b7>] __get_free_pages+0x27/0x40
 [<c0140872>] kmem_getpages+0x22/0xd0
 [<c01415e1>] cache_grow+0xc1/0x170
 [<c014176b>] cache_alloc_refill+0xdb/0x220
 [<c0141b7f>] __kmalloc+0x7f/0x90
 [<f8ca0529>] kmem_alloc+0x59/0xe0 [xfs]
 [<f8ca0661>] kmem_realloc+0x21/0x70 [xfs]
 [<f8c7d59c>] xfs_iext_realloc+0xfc/0x150 [xfs]
 [<f8c52cc2>] xfs_bmap_insert_exlist+0x32/0xa0 [xfs]
 [<f8c4f98d>] xfs_bmap_add_extent_hole_delay+0x34d/0x540 [xfs]
 [<f8c4d0b1>] xfs_bmap_add_extent+0x391/0x450 [xfs]
 [<f8c557a4>] xfs_bmapi+0xf54/0x1540 [xfs]
 [<f8c80ad3>] xfs_iomap_write_delay+0x5a3/0x940 [xfs]
 [<f8c7fd79>] xfs_iomap+0x2d9/0x4c0 [xfs]
 [<f8ca1cff>] linvfs_get_block_core+0x8f/0x2e0 [xfs]
 [<f8ca1f95>] linvfs_get_block+0x45/0x50 [xfs]
 [<c015b62b>] __block_prepare_write+0x1eb/0x400
 [<c015c052>] block_prepare_write+0x32/0x50
 [<c013a3e3>] generic_file_buffered_write+0x1a3/0x5a0
 [<f8ca965a>] xfs_write+0x91a/0xb40 [xfs]
 [<f8ca4f94>] linvfs_writev+0xd4/0xf0 [xfs]
 [<c0158619>] do_readv_writev+0x149/0x240
 [<c01587e5>] vfs_writev+0x65/0x70
 [<f8d509ff>] nfsd_write+0xef/0x310 [nfsd]
 [<f8d57e5d>] nfsd3_proc_write+0xbd/0x120 [nfsd]
 [<f8d4c67b>] nfsd_dispatch+0xdb/0x210 [nfsd]
 [<f8cf81ca>] svc_process+0x50a/0x650 [sunrpc]
 [<f8d4c410>] nfsd+0x1b0/0x340 [nfsd]
 [<c01009b5>] kernel_thread_helper+0x5/0x10

-- 
Ake Sandgren, HPC2N, Umea University, S-90187 Umea, Sweden
Internet: ake@hpc2n.umu.se	Phone: +46 90 7866134 Fax: +46 90 7866126
Mobile: +46 70 7716134 WWW: http://www.hpc2n.umu.se
