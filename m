Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261707AbTDHQCZ (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 12:02:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261863AbTDHQCZ (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 12:02:25 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:47940 "EHLO
	mtvmime03.VERITAS.COM") by vger.kernel.org with ESMTP
	id S261707AbTDHQCW (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 8 Apr 2003 12:02:22 -0400
Date: Tue, 8 Apr 2003 17:15:58 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: venom@sns.it
cc: linux-kernel@vger.kernel.org
Subject: Re: three oops starting XF86 4.3.0 on i810 video card (kernel 2.5.67)
In-Reply-To: <Pine.LNX.4.43.0304081645210.10297-100000@cibs9.sns.it>
Message-ID: <Pine.LNX.4.44.0304081710310.10184-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Apr 2003 venom@sns.it wrote:
> When I start XF86 4.3.0, and then I stop X11, and then, after e few seconds I
> restart it again X11 crashes and I get those three oops:

	BUG_ON(!cur_pte_chain->ptes[NRPTE-1]);

That's a check internal to rmap.c, just making sure it understands
itself.  I've not seen similar reports before.  Sounds like corruption.
Try rebuilding your kernel with CONFIG_DEBUG_SLAB=y for more info?

> kernel BUG at mm/rmap.c:212!
> invalid operand: 0000 [#1]
> CPU:    0
> EIP:    0060:[<c013f4b7>]    Not tainted
> Using defaults from ksymoops -t elf32-i386 -a i386
> EFLAGS: 00010246
> eax: 00000000   ebx: c14f5920   ecx: d5830600   edx: d64a29c0
> esi: d12cc030   edi: c1000000   ebp: d46e7220   esp: d60e9e88
> ds: 007b   es: 007b   ss: 0068
> Stack: 00000002 d12cc030 c013b1a0 000000d0 4000c000 00000000 40150000 4014d000
>        d4938960 00000000 00000286 db0961c0 d4938960 d5830600 c14f5920 d5f90400
>        db0961c0 d5f90400 4000c547 db0961c0 d46e7220 c013b5f9 db0961c0 d46e7220
> Call Trace: [<c013b1a0>]  [<c013b5f9>]  [<c01159bc>]  [<c010f155>]  [<c0147a8d>]
> [<c0115880>]  [<c0109ab9>]
> Code: 0f 0b d4 00 9a 2c 26 c0 eb d6 eb 0d 90 90 90 90 90 90 90 90
> 
> >>EIP; c013f4b7 <page_add_rmap+b7/d0>   <=====
> 
> Trace; c013b1a0 <do_no_page+180/3d0>
> Trace; c013b5f9 <handle_mm_fault+f9/170>
> Trace; c01159bc <do_page_fault+13c/45e>
> Trace; c010f155 <old_mmap+e5/150>
> Trace; c0147a8d <filp_close+4d/80>
> Trace; c0115880 <do_page_fault+0/45e>
> Trace; c0109ab9 <error_code+2d/38>

