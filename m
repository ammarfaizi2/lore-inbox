Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314906AbSEXUMl>; Fri, 24 May 2002 16:12:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314929AbSEXUMk>; Fri, 24 May 2002 16:12:40 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:52875 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S314906AbSEXUMj>;
	Fri, 24 May 2002 16:12:39 -0400
Date: Fri, 24 May 2002 16:12:39 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Jens Axboe <axboe@suse.de>
cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: [RFC] change of ->bd_op->open() semantics
Message-ID: <Pine.GSO.4.21.0205241603270.9792-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Folks, I propose to cache the result of blk_get_queue() in
struct block_device upon ->open().

	We already have struct block_device * whenever we are looking for
a queue.  So the only real problem arises if value of blk_get_queue()
changes while device is opened.  AFAICS nothing in the kernel pulls
such tricks (and to support them we would need to take care of a lot
of things, so changing the cached value wouldn't be a problem anyway).

	Yes, it means updating every instance of ->open() for block
devices.  All 30-odd of them.  I can do that in a single pass - changes
are trivial.

	It has an additional benefit of killing the array of default
queues on the same pass - a thing we will need to do sooner or later
anyway.

	Does anybody see a problem with that?

