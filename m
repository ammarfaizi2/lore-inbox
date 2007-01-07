Return-Path: <linux-kernel-owner+w=401wt.eu-S932567AbXAGPCW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932567AbXAGPCW (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 10:02:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932564AbXAGPCW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 10:02:22 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:6025 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932569AbXAGPCW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 10:02:22 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=LR6CXx8XH8fbviYMQqXSlidfiEZ//m4483NTAXNEku5TxhyZ8N6FNpX16Irl0QZ5uJ7Vs06eX3t4K7eyfEeKPtZHIhjdOcDLz3Gi+lRmt3GTId/ZGk9DDkyMl6mUvSkmeRtrU8dVeKoSCIHcLhoaRr72EWiv0PyiMywrTBt/FFg=
Message-ID: <84144f020701070702t717ede93n90db41c77cead573@mail.gmail.com>
Date: Sun, 7 Jan 2007 17:02:20 +0200
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "=?ISO-8859-1?Q?Sebastian_K=E4rgel?=" <mailing@wodkahexe.de>
Subject: Re: Oops with 2.6.29.1 (slab_get_obj,free_block,journal_write_metadata_buffer)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20070107151726.0c462938.mailing@wodkahexe.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <20070107151726.0c462938.mailing@wodkahexe.de>
X-Google-Sender-Auth: 1e87e7c3c219e969
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/7/07, Sebastian Kärgel <mailing@wodkahexe.de> wrote:
> BUG: unable to handle kernel paging request at virtual address 1b1ca570
>  printing eip:
> c014c3b1
> *pde = 00000000
> Oops: 0000 [#1]
> Modules linked in:
> CPU:    0
> EIP:    0060:[<c014c3b1>]    Not tainted VLI
> EFLAGS: 00010807   (2.6.19.1 #1)
> EIP is at slab_get_obj+0x14/0x1f
> eax: 55555544   ebx: 00000017   ecx: 55555555   edx: c5c75000
> esi: c5c75000   edi: c18ddc60   ebp: c18d7e00   esp: e54bfc58
> ds: 007b   es: 007b   ss: 0068
> Process shred (pid: 3393, ti=e54be000 task=f77fda70 task.ti=e54be000)
> Stack: c014c62b c18dfba0 c5c75000 00000000 00000024 00000246 00000050 c18dfba0
>        00000001 c014c8c3 c18dfba0 00000050 f77cb8f4 00000400 00000400 c016dd60
>        c18dfba0 00000050 f77cb8f4 c016b66c 00000050 c1309d60 00000800 c1309d60
> Call Trace:
>  [<c014c62b>] cache_alloc_refill+0xc8/0x17d
>  [<c014c8c3>] kmem_cache_alloc+0x55/0x61
>  [<c016dd60>] alloc_buffer_head+0x18/0x2f
>  [<c016b66c>] alloc_page_buffers+0x26/0xa9
>  [<c016be86>] create_empty_buffers+0x25/0x7c
>  [<c016c2ca>] __block_prepare_write+0x95/0x445
>  [<c01386c8>] __alloc_pages+0x72/0x2f0
>  [<c016ce5a>] block_prepare_write+0x31/0x3e
>  [<c016f289>] blkdev_get_block+0x0/0x3e
>  [<c01362d8>] generic_file_buffered_write+0x231/0x61e
>  [<c016f289>] blkdev_get_block+0x0/0x3e
>  [<c01036f3>] apic_timer_interrupt+0x1f/0x24
>  [<c011b2d8>] current_fs_time+0x47/0x52
>  [<c016070f>] file_update_time+0x37/0x9f
>  [<c0136bbd>] __generic_file_aio_write_nolock+0x4f8/0x526
>  [<c02f47d9>] ide_dma_exec_cmd+0x30/0x34
>  [<c02f480f>] ide_dma_start+0x32/0x40
>  [<c02f6354>] __ide_do_rw_disk+0x3ba/0x49e
>  [<c0232407>] as_move_to_dispatch+0xff/0x124
>  [<c0136c43>] generic_file_aio_write_nolock+0x58/0xb1
>  [<c014efe9>] do_sync_write+0xdd/0x11a
>  [<c0127fb2>] autoremove_wake_function+0x0/0x4b
>  [<c0133a64>] handle_edge_irq+0xcd/0xee
>  [<c010513c>] do_IRQ+0x70/0x83
>  [<c0133a64>] handle_edge_irq+0xcd/0xee
>  [<c014f0c6>] vfs_write+0xa0/0x16b
>  [<c014f24d>] sys_write+0x4b/0x71
>  [<c0102d47>] syscall_call+0x7/0xb
>  =======================
> Code: 15 0f 0b 3e 0a d1 5e 44 c0 c3 a8 01 74 08 0f 0b 40 0a d1 5e 44 c0 c3 8b 54 24 08 8b 44 24 04 8b 4a 14 8b 40 10 ff 42 10 0f af c1 <8b> 4c 8a 1c 03 42 0c 89 4a 14 c3 8b 54 24 08 8b 4c 24 04 8b 44
> EIP: [<c014c3b1>] slab_get_obj+0x14/0x1f SS:ESP 0068:e54bfc58

Looks like someone corrupted slab->free with 0x55555555. If possible,
try running with CONFIG_SLAB_DEBUG enabled to catch the offender.
