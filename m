Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136303AbRD1BRA>; Fri, 27 Apr 2001 21:17:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136308AbRD1BQu>; Fri, 27 Apr 2001 21:16:50 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:14097 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S136303AbRD1BQk>; Fri, 27 Apr 2001 21:16:40 -0400
Date: Fri, 27 Apr 2001 18:16:26 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alexander Viro <viro@math.psu.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cleanup for fixing get_super() races
In-Reply-To: <Pine.GSO.4.21.0104272043490.21109-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.21.0104271813150.970-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 27 Apr 2001, Alexander Viro wrote:
>
> Each of these places is an oopsable race with umount. We can't fix them
> without touching a lot of drivers. However, we can make the future fix
> easier if we put the above into a helper function. Patch below does that.

I don't like the name "ream_inodes()".

Also, a driver shouldn't know about "inodes" and "buffers". It should just
do something like

	invalidate_device(dev);

because the only thing the driver knows about is the _device_.

Then, invalidate_device() might do 

	sb = get_super(dev)
	if (sb)
		invalidate_inodes (sb);
	invalidate_buffers(dev);

which makes some amount of sense. And which can later be extended to deal
with the page cache etc without the drivers ever knowing or caring.

		Linus

