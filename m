Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290259AbSAaKmK>; Thu, 31 Jan 2002 05:42:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290596AbSAaKl5>; Thu, 31 Jan 2002 05:41:57 -0500
Received: from helen.CS.Berkeley.EDU ([128.32.131.251]:49553 "EHLO
	helen.CS.Berkeley.EDU") by vger.kernel.org with ESMTP
	id <S290259AbSAaKlg>; Thu, 31 Jan 2002 05:41:36 -0500
Date: Thu, 31 Jan 2002 02:41:29 -0800
From: Josh MacDonald <jmacd@CS.Berkeley.EDU>
To: Momchil Velikov <velco@fadata.bg>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Radix-tree pagecache for 2.5
Message-ID: <20020131024128.B14482@helen.CS.Berkeley.EDU>
In-Reply-To: <Pine.LNX.4.33.0201291515480.1747-100000@penguin.transmeta.com> <87d6zrlefa.fsf@fadata.bg> <15448.28224.481925.430169@gargle.gargle.HOWL> <87wuxzjxjm.fsf@fadata.bg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <87wuxzjxjm.fsf@fadata.bg>; from velco@fadata.bg on Thu, Jan 31, 2002 at 12:15:09AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Momchil Velikov (velco@fadata.bg):
> >>>>> "John" == John Stoffel <stoffel@casc.com> writes:
> 
> Momchil> Memory overhead due to allocator overhead is of no concern with the
> Momchil> slab allocator. What matters most is probably the overhead of the
> Momchil> radix tree nodes themselves, compared to the two pointers in struct
> Momchil> page with the hash table approach. rat-4 variant ought to have less
> Momchil> overhead compared to rat-7 at the expense of deeper/higher tree. I
> Momchil> have no figures for the actual memory usage though. For small files it
> Momchil> should be negligible, i.e. one radix tree node, 68 or 516 bytes for
> Momchil> rat-4 or rat-7, for a file of size up to 65536 or 524288 bytes.  The
> Momchil> worst case would be very large file with a few cached pages with
> Momchil> offsets uniformly distributed across the whole file, that is having
> Momchil> deep tree with only one page hanging off each leaf node.
> 
> John> Isn't this a good place to use AVL trees then, since they balance
> John> automatically?  Admittedly, it may be more overhead than we want in
> John> the case where the tree is balanced by default anyway.  
> 
> The widespread opinion is that binary trees are generally way too deep
> compared to radix trees, so searches have larger cache footprint.

I've posted this before -- my cache-optimized skip list solves the
problem of balanced-tree cache footprint.  It uses cacheline-sized
nodes and per-node locking to avoid false-sharing and increase 
concurrency.  The memory usage for the skip list is also less than
the red-black tree for trees larger than several hundred nodes.

I posted a graph on space consumption (using the Linux vm_area_struct to 
calculate space overhead) at:

	http://prdownloads.sourceforge.net/skiplist/slrb_space.gif

There are also results for concurrency and performance as a function 
of node size.

-josh

-- 
PRCS version control system    http://sourceforge.net/projects/prcs
Xdelta storage & transport     http://sourceforge.net/projects/xdelta
Need a concurrent skip list?   http://sourceforge.net/projects/skiplist
