Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318130AbSG2BA7>; Sun, 28 Jul 2002 21:00:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318131AbSG2BA7>; Sun, 28 Jul 2002 21:00:59 -0400
Received: from holomorphy.com ([66.224.33.161]:20138 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S318130AbSG2BA6>;
	Sun, 28 Jul 2002 21:00:58 -0400
Date: Sun, 28 Jul 2002 18:04:03 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andrew Morton <akpm@zip.com.au>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCH 2.5] Introduce 64-bit versions of PAGE_{CACHE_,}{MASK,ALIGN}
Message-ID: <20020729010403.GU25038@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@zip.com.au>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <5.1.0.14.2.20020728193528.04336a80@pop.cus.cam.ac.uk> <Pine.LNX.4.44.0207281622350.8208-100000@home.transmeta.com> <3D448808.CF8D18BA@zip.com.au> <20020729004325.GS25038@holomorphy.com> <20020729005612.GM1201@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <20020729005612.GM1201@dualathlon.random>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 28, 2002 at 05:43:25PM -0700, William Lee Irwin III wrote:
>> This is so aggressive I'm obligated to pursue it. The pte_chain will
>> die shortly if I get my way as it is.

On Mon, Jul 29, 2002 at 02:56:12AM +0200, Andrea Arcangeli wrote:
> if you look at DaveM first full rmap implementation it never had a
> pte-chain. He used the same rmap logic we always hand in linux since the
> first 2.1 kernel I looked at, to handle correctly truncate against
> MAP_SHARED. Unfortunately that's not very efficient and requires some
> metadata allocation for anonymous pages (that's the address space
> pointer, anon pages regularly doesn't have a dedicated address space),
> and overhead that we never had w/o full rmap (and for inode backed
> mappings we just have this info in the inode, just the shared_lock
> locking isn't trivial). Hope you can came up with a better algorithm
> (nevertheless also the current rmap implementation adds significant
> measurable overhead in the fast paths), Rik told me a few days ago he
> also wanted to drop the pte_chain, but I assume you're just in sync with him.

I've seen davem's implementation. The anonymous page metadata
allocations, while they are overhead, are likely to be significantly
smaller than per-pte overhead. The rest is a matter of details. You're
welcome to participate with the design and/or implementation.


Cheers,
Bill
