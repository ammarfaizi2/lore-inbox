Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265637AbUFDGkH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265637AbUFDGkH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 02:40:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265659AbUFDGkH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 02:40:07 -0400
Received: from postoffice9.mail.cornell.edu ([132.236.56.39]:24997 "EHLO
	postoffice9.mail.cornell.edu") by vger.kernel.org with ESMTP
	id S265637AbUFDGkA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 02:40:00 -0400
Message-ID: <40C0193F.2030200@cornell.edu>
Date: Fri, 04 Jun 2004 00:39:59 -0600
From: Ivan Gyurdiev <ivg2@cornell.edu>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040519)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nathan Scott <nathans@sgi.com>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>, linux-xfs@oss.sgi.com
Subject: Re: xfs corruption or not
References: <40BFDB13.7000901@cornell.edu> <20040604052953.GE13756@frodo>
In-Reply-To: <20040604052953.GE13756@frodo>
X-Enigmail-Version: 0.84.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-PMX-Version: 4.5.0.90627, Antispam-Core: 4.0.4.92622, Antispam-Data: 2004.6.3.102573
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Do you know if the kernel was low on memory at the time?  (any
> signs of allocation failures in your system log?)
> 
> This looks like a memory allocation failure which hasn't been
> gracefully handled (or approriately retried) in XFS - there's
> a few patches being worked on to improve this, but they aren't
> ready to be merged in just yet.

Well, now that you mention it, there's another trace right in front of 
the oops. Don't know why I missed it - probably thought it was the same 
thing. It says allocation failure. I am running FC2 with 128MB SDRAM.

thunderbird-bin: page allocation failure. order:5, mode:0x50
[<0212d155>] __alloc_pages+0x29a/0x2b4
[<0212d187>] __get_free_pages+0x18/0x24
[<0212f6ec>] kmem_getpages+0x15/0x98
[<0212ff3c>] cache_grow+0x7b/0x18e
[<02130184>] cache_alloc_refill+0x135/0x164
[<02130562>] __kmalloc+0x64/0x76
[<0a8e7e0a>] xfs_iext_realloc+0x1c8/0x23b [xfs]
[<0a8c4883>] xfs_bmap_insert_exlist+0x23/0xae [xfs]
[<0a8c1cc7>] xfs_bmap_add_extent_hole_delay+0x42f/0x485 [xfs]
[<0218fcd9>] __delay+0x9/0xa
[<021f9ec8>] dma_timer_expiry+0x0/0x63
[<0a8bf6e8>] xfs_bmap_add_extent+0x13b/0x38e [xfs]
[<0a8c66d9>] xfs_bmapi+0x946/0x104d [xfs]
[<0a8f997b>] xfs_trans_read_buf+0x44/0x2d9 [xfs]
[<0a8cbe79>] xfs_bmbt_get_state+0xa/0x18 [xfs]
[<0a8c4ef4>] xfs_bmap_search_extents+0x3d/0x43 [xfs]
[<0a8c60a7>] xfs_bmapi+0x314/0x104d [xfs]
[<0a8ea9fe>] xfs_iomap_write_delay+0x54a/0x5b6 [xfs]
[<0212c0a1>] mempool_alloc+0x5d/0xf6
[<0a8e9f4c>] xfs_iomap+0x23b/0x3eb [xfs] Jun  3 19:57:11 cobra kernel: 
[<0a8e9ff4>] xfs_iomap+0x2e3/0x3eb [xfs]
[<0a90910c>] xfs_bmap+0x1a/0x1e [xfs]
[<0a9036f3>] linvfs_get_block_core+0x83/0x234 [xfs]
[<021e25f6>] cfq_next_request+0x21/0x37
[<02140f8b>] __wait_on_buffer+0x7d/0x85 Jun  3 19:57:11 cobra kernel: 
[<0a9038b7>] linvfs_get_block+0x13/0x17 [xfs]
[<021425a7>] __block_prepare_write+0x146/0x3a5
[<02142e47>] block_prepare_write+0x16/0x22
[<0a9038a4>] linvfs_get_block+0x0/0x17 [xfs]
[<0212b79d>] generic_file_aio_write_nolock+0x57e/0x84e
[<0a9038a4>] linvfs_get_block+0x0/0x17 [xfs]
[<0a8e91d1>] xfs_ichgtime+0xee/0xf6 [xfs] Jun  3 19:57:11 cobra kernel: 
  [<0a908e2a>] xfs_write+0x3e5/0x675 [xfs]
[<0a9058cf>] linvfs_write+0xa6/0xbc [xfs]
[<021400cb>] do_sync_write+0x68/0x9d
[<02146f77>] sys_stat64+0x1e/0x23
[<021401b8>] vfs_write+0xb8/0xe4
[<02140252>] sys_write+0x2c/0x42
