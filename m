Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272223AbRIKAVM>; Mon, 10 Sep 2001 20:21:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272225AbRIKAVC>; Mon, 10 Sep 2001 20:21:02 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:1796 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S272223AbRIKAUt>; Mon, 10 Sep 2001 20:20:49 -0400
Date: Mon, 10 Sep 2001 17:20:48 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Daniel Phillips <phillips@bonn-fries.net>
cc: Andreas Dilger <adilger@turbolabs.com>, Andrea Arcangeli <andrea@suse.de>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-2.4.10-pre5
In-Reply-To: <20010911000547Z16588-26185+142@humbolt.nl.linux.org>
Message-ID: <Pine.LNX.4.33.0109101716590.3249-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 11 Sep 2001, Daniel Phillips wrote:
> On September 11, 2001 12:15 am, Linus Torvalds wrote:
> > However, physical read-ahead really isn't the answer here. I bet you could
> > cut your time down with it, agreed. But you'd hurt a lot of other loads,
> > and it really depends on nice layout on disk. Plus you wouldn't even know
> > where to put the data you read-ahead: you only have the physical address,
> > not the logical address, and the page-cache is purely logically indexed..
>
> You leave it in the buffer cache and the page cache checks for it there
> before deciding it has to hit the disk.

Umm..

Ehh.. So now you have two cases:
 - you hit in the cache, in which case you've done an extra allocation,
   and will have to do an extra memcpy.
 - you don't hit in the cache, in which case you did IO that was
   completely useless and just made the system slower.

Considering that the extra allocation and memcpy is likely to seriously
degrade performance on any high-end hardware if it happens any noticeable
percentage of the time, I don't see how your suggest can _ever_ be a win.
The only time you avoid the memcpy is when you wasted the IO completely.

So please explain to me how you think this is all a good idea? Or explain
why you think the memcpy is not going to be noticeable in disk throughput
for normal loads?

		Linus

