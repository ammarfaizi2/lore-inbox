Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274816AbRIZDkQ>; Tue, 25 Sep 2001 23:40:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274818AbRIZDkH>; Tue, 25 Sep 2001 23:40:07 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:26887 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S274816AbRIZDjs>; Tue, 25 Sep 2001 23:39:48 -0400
Date: Tue, 25 Sep 2001 20:39:35 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Anton Altaparmakov <aia21@cam.ac.uk>
cc: Alexander Viro <viro@math.psu.edu>, Chris Mason <mason@suse.com>,
        <linux-kernel@vger.kernel.org>, <andrea@suse.de>
Subject: Re: [PATCH] invalidate buffers on blkdev_put
In-Reply-To: <5.1.0.14.2.20010925231124.0309ac70@pop.cus.cam.ac.uk>
Message-ID: <Pine.LNX.4.33.0109252037160.7697-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 25 Sep 2001, Anton Altaparmakov wrote:
>
> Looking at the patch, you introduce a static inline blksize_bits. Wouldn't
> it be a lot more efficient to change the function to say:

More efficient? Probably not. We know that the result of blksize_bits is
in the range of 9-12 on x86, and if you look at the thing it uses that
knowledge.

More importantly, I think the whole code will go away, because the bits
(and the size) should be in the bdev structure in the first place (or,
even better, the inode, at which point all the special-case functions go
away and just become calls to the generic ones)

		Linus

