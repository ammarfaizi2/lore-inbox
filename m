Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263584AbTD1N6I (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 09:58:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263612AbTD1N6I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 09:58:08 -0400
Received: from ns.suse.de ([213.95.15.193]:34828 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263584AbTD1N6H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 09:58:07 -0400
Date: Mon, 28 Apr 2003 16:10:23 +0200
From: Andi Kleen <ak@suse.de>
To: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
Cc: Henti Smith <bain@tcsn.co.za>, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] Re: maximum possible memory limit ..
Message-ID: <20030428141023.GC4525@Wotan.suse.de>
References: <20030424200524.5030a86b.bain@tcsn.co.za> <3EAD27B2.9010807@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EAD27B2.9010807@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Linux supports up to 4 GB (~2^32 bytes) of memory on 32-bit
> architectures and 64 GB (~2^36 bytes) on x86 with PAE. No other

That's far too optimistic. 64GB will need patches, like the pgcl 
patch. It is unlikely to work out of the box. Just do the math.

900MB low mem for all the kernel data structures on IA32.

44 byte struct page for each 4K page. This gives 704MB just
for the mem_map array. Leaves you 196MB left for the kernel to 
manage your 64GB of memory and your processes. Unlikely to work.

2.5 uses 40 bytes for an struct page, but that doesn't help much.

Yes you can move the kernel:user split to give the kernel more memory
at the expense of the application, but that is likely to not make the 
user programs happy and also helps only very limited 
(even 2GB lowmem are probably not enough to make it run well with 64GB)

Realistic limit currently is ~16GB with an IA32 box.  For more you need
an 64bit architecture.

-Andi

