Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291090AbSAaOUr>; Thu, 31 Jan 2002 09:20:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291089AbSAaOUi>; Thu, 31 Jan 2002 09:20:38 -0500
Received: from sun.fadata.bg ([80.72.64.67]:18705 "HELO fadata.bg")
	by vger.kernel.org with SMTP id <S291085AbSAaOUU>;
	Thu, 31 Jan 2002 09:20:20 -0500
To: Josh MacDonald <jmacd@CS.Berkeley.EDU>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Radix-tree pagecache for 2.5
In-Reply-To: <Pine.LNX.4.33.0201291515480.1747-100000@penguin.transmeta.com>
	<87d6zrlefa.fsf@fadata.bg>
	<15448.28224.481925.430169@gargle.gargle.HOWL>
	<87wuxzjxjm.fsf@fadata.bg>
	<20020131024128.B14482@helen.CS.Berkeley.EDU>
X-No-CC: Reply to lists, not to me.
From: Momchil Velikov <velco@fadata.bg>
In-Reply-To: <20020131024128.B14482@helen.CS.Berkeley.EDU>
Date: 31 Jan 2002 16:21:48 +0200
Message-ID: <87hep2a9dv.fsf@fadata.bg>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Josh" == Josh MacDonald <jmacd@CS.Berkeley.EDU> writes:

Josh> Quoting Momchil Velikov (velco@fadata.bg):
>> >>>>> "John" == John Stoffel <stoffel@casc.com> writes:

Momchil>  The worst case would be very large file with a few cached
Momchil> pages with offsets uniformly distributed across the whole
Momchil> file, that is having deep tree with only one page hanging off
Momchil> each leaf node.

John> Isn't this a good place to use AVL trees then, since they balance
John> automatically?  Admittedly, it may be more overhead than we want in
John> the case where the tree is balanced by default anyway.  

>> The widespread opinion is that binary trees are generally way too deep
>> compared to radix trees, so searches have larger cache footprint.

Josh> I've posted this before -- my cache-optimized skip list solves the
Josh> problem of balanced-tree cache footprint.  It uses cacheline-sized

I don't think skip lists differ from the balanced trees w.r.t cache
line footprint.

Josh> nodes and per-node locking to avoid false-sharing and increase 

Whether there _is_ a (non-negligible) false sharing would be an open
question.

Josh> concurrency.  The memory usage for the skip list is also less than
Josh> the red-black tree for trees larger than several hundred nodes.

Yes. Skip list or (whatever) b-tree are sure to have less space
overhead in the worst case.  Therefore, I'd be curious to see
comparisons with the three pagecache implementations.  Note that in my
last patch you can do a drop-in replacement of the radix tree with a
skip list, since memory allocation issues are solved.

Regards,
-velco
