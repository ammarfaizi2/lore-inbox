Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272057AbRIIQ27>; Sun, 9 Sep 2001 12:28:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272059AbRIIQ2t>; Sun, 9 Sep 2001 12:28:49 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:35336 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S272057AbRIIQ2l>; Sun, 9 Sep 2001 12:28:41 -0400
Date: Sun, 9 Sep 2001 09:24:51 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@math.psu.edu>
Subject: Re: linux-2.4.10-pre5
In-Reply-To: <20010909164738.T11329@athlon.random>
Message-ID: <Pine.LNX.4.33.0109090922330.14365-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 9 Sep 2001, Andrea Arcangeli wrote:
>
> > filesystems. The only case it doesn't like is the "rw-open of a device
> > that is rw-mounted".
>
> it also doesn't work for ro-open of a device that is rw-mounted, hdparm
> -t as said a million of times now.

It _does_ work for that case, and you just aren't reading my emails.

You only need to invalidate the device if the open was a read-write open.

It would be _stupid_ to force a writeback and device invalidate for
read-only opens, now wouldn't it?

The fact that you cannot know the difference between a read-only and a
read-write open is _entirely_ due to the fact that you leave the flush
until the last close. If you do it at every close (like I have said for
the last twohundred mails or so), you can trivially see if the open was a
read-only or not.

		Linus

