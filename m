Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265492AbUEVACC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265492AbUEVACC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 20:02:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265146AbUEVAAa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 20:00:30 -0400
Received: from zeus.kernel.org ([204.152.189.113]:28347 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S265125AbUEUXe3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 19:34:29 -0400
Date: Wed, 19 May 2004 21:23:28 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux@horizon.com
Cc: kerndev@sc-software.com, linux-kernel@vger.kernel.org,
       Neil Brown <neilb@cse.unsw.edu.au>
Subject: Re: 2.6.6 is crashing repeatedly
Message-Id: <20040519212328.0eea3350.akpm@osdl.org>
In-Reply-To: <20040520040505.14642.qmail@science.horizon.com>
References: <20040520040505.14642.qmail@science.horizon.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux@horizon.com wrote:
>
> I already reported (I thought) this message:
> 
>  May 19 02:23:47: Unable to handle kernel paging request at virtual address efd78000
>  May 19 02:23:47:  printing eip:
>  May 19 02:23:47: c01a999b
>  May 19 02:23:47: *pde = 004a7067
>  May 19 02:23:47: *pte = 2fd78000
>  May 19 02:23:47: Oops: 0002 [#1]
>  May 19 02:23:47: DEBUG_PAGEALLOC
>  May 19 02:23:47: CPU:    0
>  May 19 02:23:47: EIP:    0060:[<c01a999b>]    Not tainted
>  May 19 02:23:47: EFLAGS: 00010246   (2.6.6) 
>  May 19 02:23:47: EIP is at encode_entry+0x4b/0x530
>  May 19 02:23:47: eax: 00000000   ebx: 00000000   ecx: 00000644   edx: f3532df8
>  May 19 02:23:47: esi: efd78000   edi: e4a19644   ebp: 00000654   esp: f14b7b98
>  May 19 02:23:47: ds: 007b   es: 007b   ss: 0068
>  May 19 02:23:47: Process nfsd (pid: 1029, threadinfo=f14b6000 task=f1532a80)
>  May 19 02:23:47: Stack: 00000008 0000002f f5217080 00000027 00000000 f5217084 f3532df8 00000006 
>  May 19 02:23:47:        e4a1964c 0000001c 02000001 04000900 0019a291 0022e7a8 14343bfc 0022e76b 
>  May 19 02:23:47:        14343b61 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
>  May 19 02:23:47: Call Trace:
>  May 19 02:23:47:  [<c016af1f>] ext3_bread+0x1f/0x90
>  May 19 02:23:47:  [<c0168505>] ext3_readdir+0x305/0x490
>  May 19 02:23:47:  [<c011dd18>] in_group_p+0x38/0x70
>  May 19 02:23:47:  [<c01a9ed0>] nfs3svc_encode_entry_plus+0x0/0x50
>  May 19 02:23:47:  [<c019d930>] fh_verify+0x280/0x550
>  May 19 02:23:47:  [<c019d5d0>] nfsd_acceptable+0x0/0xe0
>  May 19 02:23:47:  [<c013da8c>] open_private_file+0x1c/0x90
>  May 19 02:23:47:  [<c014ba2d>] vfs_readdir+0x7d/0x90
>  May 19 02:23:47:  [<c01a11f9>] nfsd_readdir+0x79/0xc0
>  May 19 02:23:47:  [<c01a6b8a>] nfsd3_proc_readdirplus+0xda/0x1d0
>  May 19 02:23:47:  [<c01a9ed0>] nfs3svc_encode_entry_plus+0x0/0x50
>  May 19 02:23:47:  [<c01a8e90>] nfs3svc_decode_readdirplusargs+0x0/0x180
>  May 19 02:23:47:  [<c019bce6>] nfsd_dispatch+0xb6/0x1a0
>  May 19 02:23:47:  [<c03139fd>] svc_authenticate+0x4d/0x80
>  May 19 02:23:47:  [<c03112d7>] svc_process+0x487/0x5f0
>  May 19 02:23:47:  [<c0103b6c>] common_interrupt+0x18/0x20
>  May 19 02:23:47:  [<c019bad9>] nfsd+0x179/0x2d0
>  May 19 02:23:47:  [<c019b960>] nfsd+0x0/0x2d0
>  May 19 02:23:47:  [<c0101fbd>] kernel_thread_helper+0x5/0x18
>  May 19 02:23:47: 
>  May 19 02:23:47: Code: 89 06 89 c8 0f c8 89 46 04 81 7c 24 1c 00 01 00 00 b8 ff 00 

Is it repeatable?  If so, does it go away if you disable
CONFIG_DEBUG_PAGEALLOC?

>  Which later turned into a reboot-requiring cascade of these:
> 
>  May 19 06:29:57:  <4>qmail-rspawn: page allocation failure. order:0, mode:0x20
>  May 19 06:29:57: Call Trace:
>  May 19 06:29:57:  [<c0127395>] __alloc_pages+0x2d5/0x330
>  May 19 06:29:57:  [<c012740f>] __get_free_pages+0x1f/0x40
>  May 19 06:29:57:  [<c012a961>] cache_grow+0x91/0x270
>  May 19 06:29:57:  [<c012ae3e>] cache_alloc_refill+0x2fe/0x400
>  May 19 06:29:57:  [<c01261a7>] mempool_alloc+0x67/0x110

hm, you seem to be totally out of memory in the swapout path and in the
tulip Rx ISR.  Both codepaths handle that OK as it's not uncommon.  This is
probably unrelated to the oops, but it's not good.

