Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265177AbSLBGog>; Mon, 2 Dec 2002 01:44:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265187AbSLBGog>; Mon, 2 Dec 2002 01:44:36 -0500
Received: from franka.aracnet.com ([216.99.193.44]:42215 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S265177AbSLBGof>; Mon, 2 Dec 2002 01:44:35 -0500
Date: Sun, 01 Dec 2002 22:48:14 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@digeo.com>, Stephen Rothwell <sfr@canb.auug.org.au>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Maximum Physical Memory on 2.4 and ia32
Message-ID: <1879842821.1038782883@[10.10.2.3]>
In-Reply-To: <3DEAC905.86769170@digeo.com>
References: <3DEAC905.86769170@digeo.com>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It's a practical limit.  The mem_map array alone would consume 720 megabytes,
> so you have no normal-zone memory left.
> 
> At 16G, mem_map[] consumes 180 megabytes and there's 540ish megabytes
> of normal zone left for general use.
> 
> Even at this 20:1 highmem:lowmem ratio, the system will be struggling.
> Any time you have normal-zone data structures which are pinned by
> pages, the maths gets you in the end.
> 
> buffer_heads, pagetable pages, radix-tree nodes, pte_chains and inodes
> are normal-zone data structures which, depending on the kernel version,
> may be pinned into the normal zone by highmem pages.
> 
> In 2.5, with ext2's no-buffer-head option, shared pagetables, highpte,
> with your fingers crossed and the wind in the south east, 32G might
> be practical.

32Gb was indeed what we've been working towards for 2.6, and we've 
been running that on some workloads.

However, if you're willing to run with a 2:2 or even a 1:3 user:kernel
split instead of the default 3:1, you can get away with all sorts of
things, probably including 64Gb. I've got the hardware to build such
a beast, but haven't bothered yet (we have enough problems already ;-)).
Big databases won't like it, but other workloads without huge individual
processes (or shared mappings) will be fine.

M.

