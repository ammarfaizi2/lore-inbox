Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273036AbTG3RFD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 13:05:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273040AbTG3RFD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 13:05:03 -0400
Received: from 3eea282f.cable.wanadoo.nl ([62.234.40.47]:52751 "EHLO
	diana.kozmix.org") by vger.kernel.org with ESMTP id S273036AbTG3RE6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 13:04:58 -0400
Date: Wed, 30 Jul 2003 19:04:32 +0200
From: Sander van Malssen <svm@kozmix.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Yaroslav Halchenko <yoh@onerussian.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test2-bk3 phantom I/O errors
Message-ID: <20030730170432.GA692@kozmix.org>
Mail-Followup-To: Sander van Malssen <svm@kozmix.org>,
	Andrew Morton <akpm@osdl.org>,
	Yaroslav Halchenko <yoh@onerussian.com>,
	linux-kernel@vger.kernel.org
References: <20030729153114.GA30071@washoe.rutgers.edu> <20030729135025.335de3a0.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030729135025.335de3a0.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 29 July 2003 at 13:50:25 -0700, Andrew Morton wrote:

> Yaroslav Halchenko <yoh@onerussian.com> wrote:
> >
> > Buffer I/O error on device hda2, logical block 3861502
> > Buffer I/O error on device hda2, logical block 3861504
> > Buffer I/O error on device hda2, logical block 3861506
> 
> Odd.
> 
> What filesystem types are in use?
> 
> Are you using some sort of initrd setup?
> 
> Could you please run with this patch, send the traces?

If I try this on 2.6.0-test2-mm1 with the dump_stack() added (ext3, no
initrd) I get the following:


Buffer I/O error on device hda1, logical block 25361
Call Trace:
 [<c0150f02>] buffer_io_error+0x42/0x50
 [<c013b87d>] cache_grow+0x15d/0x260
 [<c0151601>] end_buffer_async_read+0xf1/0x110
 [<c0154330>] end_bio_bh_io_sync+0x30/0x40
 [<c015548e>] bio_endio+0x4e/0x80
 [<c028109b>] __make_request+0x12b/0x4f0
 [<c02815ca>] generic_make_request+0x16a/0x230
 [<c0119ec0>] autoremove_wake_function+0x0/0x50
 [<c015491b>] alloc_buffer_head+0x3b/0x60
 [<c0154bec>] bio_alloc+0xcc/0x1a0
 [<c02816cd>] submit_bio+0x3d/0x70
 [<c0153453>] block_read_full_page+0x213/0x2b0
 [<c0189720>] ext3_get_block+0x0/0x90
 [<c0170c0a>] do_mpage_readpage+0x23a/0x320
 [<c0189720>] ext3_get_block+0x0/0x90
 [<c0133eb9>] add_to_page_cache+0x59/0xf0
 [<c0170e1a>] mpage_readpages+0x12a/0x170
 [<c0189720>] ext3_get_block+0x0/0x90
 [<c018a640>] ext3_readpages+0x0/0x30
 [<c013a66e>] read_pages+0x16e/0x180
 [<c0189720>] ext3_get_block+0x0/0x90
 [<c01382c3>] __alloc_pages+0x83/0x300
 [<c013a7cf>] do_page_cache_readahead+0x14f/0x1e0
 [<c013a99f>] page_cache_readahead+0x13f/0x180
 [<c0134b1e>] do_generic_mapping_read+0x44e/0x470
 [<c0134b40>] file_read_actor+0x0/0xf0
 [<c0134e09>] __generic_file_aio_read+0x1d9/0x220
 [<c0134b40>] file_read_actor+0x0/0xf0
 [<c0134ea2>] generic_file_aio_read+0x52/0x70
 [<c014f782>] do_sync_read+0xc2/0x100
 [<c0119ec0>] autoremove_wake_function+0x0/0x50
 [<c02aff85>] start_request+0x175/0x290
 [<c0123a16>] update_process_times+0x46/0x50
 [<c012388d>] update_wall_time+0xd/0x40
 [<c0123cfe>] do_timer+0xde/0xf0
 [<c014f86d>] vfs_read+0xad/0x120
 [<c014fb3f>] sys_read+0x3f/0x60
 [<c010936b>] syscall_call+0x7/0xb

Buffer I/O error on device hda1, logical block 25753
Call Trace:
 [<c0150f02>] buffer_io_error+0x42/0x50
 [<c0119e00>] prepare_to_wait_exclusive+0x30/0x80
 [<c0151601>] end_buffer_async_read+0xf1/0x110
 [<c0154330>] end_bio_bh_io_sync+0x30/0x40
 [<c015548e>] bio_endio+0x4e/0x80
 [<c028109b>] __make_request+0x12b/0x4f0
 [<c02815ca>] generic_make_request+0x16a/0x230
 [<c0119ec0>] autoremove_wake_function+0x0/0x50
 [<c015491b>] alloc_buffer_head+0x3b/0x60
 [<c0154bec>] bio_alloc+0xcc/0x1a0
 [<c02816cd>] submit_bio+0x3d/0x70
 [<c0153453>] block_read_full_page+0x213/0x2b0
 [<c0189720>] ext3_get_block+0x0/0x90
 [<c0170c0a>] do_mpage_readpage+0x23a/0x320
 [<c0189720>] ext3_get_block+0x0/0x90
 [<c0133eb9>] add_to_page_cache+0x59/0xf0
 [<c0170e1a>] mpage_readpages+0x12a/0x170
 [<c0189720>] ext3_get_block+0x0/0x90
 [<c018a640>] ext3_readpages+0x0/0x30
 [<c013a66e>] read_pages+0x16e/0x180
 [<c0189720>] ext3_get_block+0x0/0x90
 [<c01382c3>] __alloc_pages+0x83/0x300
 [<c013a7cf>] do_page_cache_readahead+0x14f/0x1e0
 [<c013a99f>] page_cache_readahead+0x13f/0x180
 [<c0134b1e>] do_generic_mapping_read+0x44e/0x470
 [<c0134b40>] file_read_actor+0x0/0xf0
 [<c0134e09>] __generic_file_aio_read+0x1d9/0x220
 [<c0134b40>] file_read_actor+0x0/0xf0
 [<c0134ea2>] generic_file_aio_read+0x52/0x70
 [<c014f782>] do_sync_read+0xc2/0x100
 [<c0119ec0>] autoremove_wake_function+0x0/0x50
 [<c02aff85>] start_request+0x175/0x290
 [<c0123a16>] update_process_times+0x46/0x50
 [<c012388d>] update_wall_time+0xd/0x40
 [<c0123cfe>] do_timer+0xde/0xf0
 [<c014f86d>] vfs_read+0xad/0x120
 [<c014fb3f>] sys_read+0x3f/0x60
 [<c010936b>] syscall_call+0x7/0xb


Cheers,
Sander

-- 
     Sander van Malssen -- svm@kozmix.org -- http://www.kozmix.org/
      http://www.peteandtommysdayout.com/ -- http://www.1-2-5.net/

