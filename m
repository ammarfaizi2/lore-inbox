Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262939AbUKXXMP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262939AbUKXXMP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 18:12:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262904AbUKXXKO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 18:10:14 -0500
Received: from fw.osdl.org ([65.172.181.6]:50586 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262894AbUKXXIT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 18:08:19 -0500
Date: Wed, 24 Nov 2004 15:12:34 -0800
From: Andrew Morton <akpm@osdl.org>
To: Phil Dier <phil@dier.us>
Cc: linux-kernel@vger.kernel.org
Subject: Re: oops with dual xeon 2.8ghz  4gb ram +smp, software raid, lvm,
 and xfs
Message-Id: <20041124151234.714f30d4.akpm@osdl.org>
In-Reply-To: <20041124094549.4c51d6d5.phil@dier.us>
References: <20041122130622.27edf3e6.phil@dier.us>
	<20041122161725.21adb932.akpm@osdl.org>
	<20041124094549.4c51d6d5.phil@dier.us>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Phil Dier <phil@dier.us> wrote:
>
> > Can you rebuild the kernel with CONFIG_4KSTACKS=n?
> > 
> 
> 
> Looks like 8k stacks did the trick, at least for the oops. Now I'm
> seeing the stuff below.
> 
> I got a ton more of this with jfs and xfs, but it seems much less with
> reiser. Should I be worried, or is this something I can safely ignore?
> It doesn't lock the system..  Could files be getting corrupted?
> 
> 
> Nov 23 17:38:20 calculon swapper: page allocation failure. order:0, mode:0x20
> Nov 23 17:38:20 calculon [<c013c854>] __alloc_pages+0x1b9/0x35e
> Nov 23 17:38:20 calculon [<c013ca1e>] __get_free_pages+0x25/0x3f
> Nov 23 17:38:20 calculon [<c013fccb>] kmem_getpages+0x21/0xc9
> Nov 23 17:38:20 calculon [<c0140813>] alloc_slabmgmt+0x55/0x5f
> Nov 23 17:38:20 calculon [<c0140992>] cache_grow+0xab/0x14d
> Nov 23 17:38:20 calculon [<c0140ba8>] cache_alloc_refill+0x174/0x219
> Nov 23 17:38:20 calculon [<c0140ffe>] __kmalloc+0x85/0x8c
> Nov 23 17:38:20 calculon [<c03f4f89>] alloc_skb+0x47/0xe0
> Nov 23 17:38:20 calculon [<c032ebe5>] e1000_alloc_rx_buffers+0x44/0xe3

You didn't mention the kernel version.  2.6.9 had problems in this area, so
2.6.10-rc2 should be better.  And there are post-2.6.10-rc2 fixes which
will provide more headroom.

