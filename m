Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318069AbSHDBas>; Sat, 3 Aug 2002 21:30:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318073AbSHDBar>; Sat, 3 Aug 2002 21:30:47 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:9227 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318069AbSHDBar>; Sat, 3 Aug 2002 21:30:47 -0400
Date: Sat, 3 Aug 2002 18:35:11 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrew Morton <akpm@zip.com.au>
cc: Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de>,
       <linux-kernel@vger.kernel.org>
Subject: Re: question on dup_task_struct
In-Reply-To: <3D4C5BF0.90CD2850@zip.com.au>
Message-ID: <Pine.LNX.4.44.0208031829230.1549-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 3 Aug 2002, Andrew Morton wrote:
>
> It's not a 1-order allocation.  I'll go back to sleep now.

According to slabinfo, it's an order-2 allocation at least on SMP-x86,
which is kind of sad. The object size is 1664 bytes, and the slab code
decides that putting two of them per page is too wasteful, so it
apparently puts 9 of them on 4 pages instead.

That does explain why it wants to dip into the low resources, but since
the VM for the last year or so tries hard to avoid allocation errors for
up to order-3 allocations the only thing that GFP_HIGH would add is to get
better latency at the cost of potentially being really nasty on the MM
balancing.

So I think it should be just GFP_KERNEL.

		Linus

