Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262103AbUBWXG6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 18:06:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262091AbUBWXEX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 18:04:23 -0500
Received: from fw.osdl.org ([65.172.181.6]:29362 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262082AbUBWXBF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 18:01:05 -0500
Date: Mon, 23 Feb 2004 15:02:57 -0800
From: Andrew Morton <akpm@osdl.org>
To: Bart Janssens <bart.janssens@polytechnic.be>
Cc: linux-kernel@vger.kernel.org
Subject: Re: OOPS: ext3 on 2.6.3 with high IO
Message-Id: <20040223150257.18e8d4d5.akpm@osdl.org>
In-Reply-To: <200402231202.17307.bart.janssens@polytechnic.be>
References: <200402231202.17307.bart.janssens@polytechnic.be>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bart Janssens <bart.janssens@polytechnic.be> wrote:
>
> Hello all
> 
> 1. I am getting a kernel oops when having high IO on an ext3 partition in 
> 2.6.3.

I doubt if this is related to high-IO.

> Unable to handle kernel NULL pointer dereference at virtual address 00000037
> c0223467
> *pde = 00000000
> Oops: 0000 [#1]
> CPU:    0
> EIP:    0060:[<c0223467>]    Tainted: P  
> Using defaults from ksymoops -t elf32-i386 -a i386
> EFLAGS: 00010212
> eax: ffffffff   ebx: 00000001   ecx: f7bf1900   edx: ce02a680
> esi: 00000008   edi: ce02a680   ebp: 00000001   esp: f7d39d50
> ds: 007b   es: 007b   ss: 0068
> Stack: f7d39d50 f7d39d50 d9914000 f7e03978 c1bb4610 ce02a680 00000000 00000000 
>        00000010 c0156dab f7fee8c0 00000010 00000000 cfe7c270 00000001 00000001 
>        00000002 00000029 00000001 c022361d ce02a680 cfe7c270 c01566c3 00000001 
> Call Trace:
>  [<c0156dab>] bio_alloc+0xcb/0x1a0
>  [<c022361d>] submit_bio+0x3d/0x70
>  [<c01566c3>] ll_rw_block+0x63/0x90
>  [<c01990d7>] journal_commit_transaction+0x1057/0x12c0
>  [<c0117a60>] recalc_task_prio+0x90/0x1a0
>  [<c019b6aa>] kjournald+0xca/0x260
>  [<c011a2c0>] autoremove_wake_function+0x0/0x50
>  [<c011a2c0>] autoremove_wake_function+0x0/0x50
>  [<c010907e>] ret_from_fork+0x6/0x14
>  [<c019b5c0>] commit_timeout+0x0/0x10
>  [<c019b5e0>] kjournald+0x0/0x260
>  [<c0106fc9>] kernel_thread_helper+0x5/0xc
> Code: 8b 50 38 8b 40 34 0f ac d0 09 85 c0 89 c3 0f 84 8b 00 00 00 
> 
> 
> >>EIP; c0223467 <generic_make_request+17/190>   <=====
> 

It looks like bio->bi_bdev->bd_inode is 0xffffffff in generic_make_request().

(Please enable CONFIG_KALLSYMS: it gives better traces and you don't need
ksymoops).

The fact that this happens when you're doing something which thousands
of other people do makes me wonder.  Is the oops always the same?  Are
you sure the hardware is good?
