Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751155AbVILOp2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751155AbVILOp2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 10:45:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751158AbVILOp2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 10:45:28 -0400
Received: from mx1.redhat.com ([66.187.233.31]:13219 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751155AbVILOp1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 10:45:27 -0400
Subject: Re: [Aurora-sparc-devel] [2.6.13-rc6-git13/sparc64]: Slab
	corruption (possible stack or buffer-cache corruption)
From: "Tom 'spot' Callaway" <tcallawa@redhat.com>
To: Aurora development <aurora-sparc-devel@lists.auroralinux.org>
Cc: linux-kernel@vger.kernel.org, "David S. Miller" <davem@redhat.com>,
       sparclinux@vger.kernel.org
In-Reply-To: <Pine.BSO.4.62.0509121604360.5000@rudy.mif.pg.gda.pl>
References: <Pine.BSO.4.62.0509121604360.5000@rudy.mif.pg.gda.pl>
Content-Type: text/plain; charset=utf-8
Organization: Red Hat
Date: Mon, 12 Sep 2005 09:45:16 -0500
Message-Id: <1126536316.25031.66.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 (2.4.0-1) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-09-12 at 16:37 +0200, Tomasz Kłoczko wrote:
> Hardware: Sun E250 SMP (2x400MHz), 1.5GB RAM.
> Kernel: 2.6.12-1.1505sp3 (from Aurora corona repo).
> 
> On first it looks like stack or buffer-cache corruption.
> 
>   Slab corruption: (Not tainted) start=fffff8005d9be708, len=808
>   Redzone: 0x5a2cf071/0x5a2cf071.
>   Last user: [destroy_inode+100/144](destroy_inode+0x64/0x90)
>   Call Trace:
>    [00000000004759f4] free_block+0x160/0x1b4
>    [0000000000475bb8] cache_flusharray+0x98/0x128
>    [0000000000475704] kmem_cache_free+0x68/0x94
>    [00000000004a56c4] destroy_inode+0x64/0x90
>    [00000000004a68f4] dispose_list+0xf0/0x12c
>    [00000000004a6af8] shrink_icache_memory+0x1c8/0x22c
>    [0000000000478c74] shrink_slab+0xc8/0x148
>    [000000000047a298] kswapd+0x2ec/0x42c
>    [0000000000415800] kernel_thread+0x30/0x48
>   [0000000000714dc8] kswapd_init+0x24/0x6c
>   090: 6b 6b 6b 6b 6b 6b 6b 6b ff ff f8 00 5d 17 61 50
>   Prev obj: start=fffff8005d9be3c8, len=808
>   Redzone: 0x5a2cf071/0x5a2cf071.
>   Last user: [destroy_inode+100/144](destroy_inode+0x64/0x90)
>   000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
>   010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
>   Next obj: start=fffff8005d9bea48, len=808
>   Redzone: 0x5a2cf071/0x5a2cf071.
>   Last user: [destroy_inode+100/144](destroy_inode+0x64/0x90)
>   000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
>   010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b

We've been seeing this intermittently on arthur since Aurora 1.0 (2.4).

~spot
-- 
Tom "spot" Callaway: Red Hat Senior Sales Engineer || GPG ID: 93054260
Fedora Extras Steering Committee Member (RPM Standards and Practices)
Aurora Linux Project Leader: http://auroralinux.org
Lemurs, llamas, and sparcs, oh my!

