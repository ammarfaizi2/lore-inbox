Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290618AbSA3V0S>; Wed, 30 Jan 2002 16:26:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290620AbSA3V0K>; Wed, 30 Jan 2002 16:26:10 -0500
Received: from [217.9.226.246] ([217.9.226.246]:9345 "HELO
	merlin.xternal.fadata.bg") by vger.kernel.org with SMTP
	id <S290618AbSA3VZ4>; Wed, 30 Jan 2002 16:25:56 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Radix-tree pagecache for 2.5
In-Reply-To: <Pine.LNX.4.33.0201291515480.1747-100000@penguin.transmeta.com>
From: Momchil Velikov <velco@fadata.bg>
In-Reply-To: <Pine.LNX.4.33.0201291515480.1747-100000@penguin.transmeta.com>
Date: 30 Jan 2002 23:25:13 +0200
Message-ID: <87d6zrlefa.fsf@fadata.bg>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Linus" == Linus Torvalds <torvalds@transmeta.com> writes:

Linus> On 30 Jan 2002, Momchil Velikov wrote:
>> 
>> rat-7 is with 128-way radix tree branch factor, rat-4 is with 16-way.

Linus> Hmm. It appears that the 128-way one is no slower, at least.

Linus> Probably not very relevant question: What are the memory usage
Linus> implications? I love having that global big page_hash_table gone, but what
Linus> are the differences in memory usage between rat-4 and rat-7? In
Linus> particular, it _looks_ like the way the radix_node is done, it will
Linus> basically always be a factor-of-two+1 words, which sounds like the worst
Linus> possible schenario from an allocator standpoint.

Memory overhead due to allocator overhead is of no concern with the
slab allocator. What matters most is probably the overhead of the
radix tree nodes themselves, compared to the two pointers in struct
page with the hash table approach. rat-4 variant ought to have less
overhead compared to rat-7 at the expense of deeper/higher tree. I
have no figures for the actual memory usage though. For small files it
should be negligible, i.e. one radix tree node, 68 or 516 bytes for
rat-4 or rat-7, for a file of size up to 65536 or 524288 bytes.  The
worst case would be very large file with a few cached pages with
offsets uniformly distributed across the whole file, that is having
deep tree with only one page hanging off each leaf node.

Regards,
-velco

