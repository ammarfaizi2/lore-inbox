Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290679AbSA3WaK>; Wed, 30 Jan 2002 17:30:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290680AbSA3W3x>; Wed, 30 Jan 2002 17:29:53 -0500
Received: from [217.9.226.246] ([217.9.226.246]:22657 "HELO
	merlin.xternal.fadata.bg") by vger.kernel.org with SMTP
	id <S290679AbSA3W3l>; Wed, 30 Jan 2002 17:29:41 -0500
To: John Stoffel <stoffel@casc.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Radix-tree pagecache for 2.5
In-Reply-To: <Pine.LNX.4.33.0201291515480.1747-100000@penguin.transmeta.com>
	<87d6zrlefa.fsf@fadata.bg>
	<15448.28224.481925.430169@gargle.gargle.HOWL>
From: Momchil Velikov <velco@fadata.bg>
Date: 31 Jan 2002 00:15:09 +0200
In-Reply-To: <15448.28224.481925.430169@gargle.gargle.HOWL>
Message-ID: <87wuxzjxjm.fsf@fadata.bg>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "John" == John Stoffel <stoffel@casc.com> writes:

Momchil> Memory overhead due to allocator overhead is of no concern with the
Momchil> slab allocator. What matters most is probably the overhead of the
Momchil> radix tree nodes themselves, compared to the two pointers in struct
Momchil> page with the hash table approach. rat-4 variant ought to have less
Momchil> overhead compared to rat-7 at the expense of deeper/higher tree. I
Momchil> have no figures for the actual memory usage though. For small files it
Momchil> should be negligible, i.e. one radix tree node, 68 or 516 bytes for
Momchil> rat-4 or rat-7, for a file of size up to 65536 or 524288 bytes.  The
Momchil> worst case would be very large file with a few cached pages with
Momchil> offsets uniformly distributed across the whole file, that is having
Momchil> deep tree with only one page hanging off each leaf node.

John> Isn't this a good place to use AVL trees then, since they balance
John> automatically?  Admittedly, it may be more overhead than we want in
John> the case where the tree is balanced by default anyway.  

The widespread opinion is that binary trees are generally way too deep
compared to radix trees, so searches have larger cache footprint.

John> Again, benchmarks would be the good thing to see either way.

I've posted some with 2.4.


