Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262653AbREOGmR>; Tue, 15 May 2001 02:42:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262657AbREOGmI>; Tue, 15 May 2001 02:42:08 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:19731 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262653AbREOGly>; Tue, 15 May 2001 02:41:54 -0400
Date: Mon, 14 May 2001 23:41:15 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Neil Brown <neilb@cse.unsw.edu.au>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "H. Peter Anvin" <hpa@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        viro@math.psu.edu
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <15104.17957.253821.765483@notabene.cse.unsw.edu.au>
Message-ID: <Pine.LNX.4.21.0105142332550.23955-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 15 May 2001, Neil Brown wrote:
> 
> I want to create a new block device - it is a different interface to
> the software-raid code that allows the arrays to be partitioned using
> normal partition tables.

See the other posts about creating a "disk" layer. Think of it as just a
simple "lvm" thing, except on a higher level (ie not on the request level,
but on the level _before_ we get to queuing the thing at all).

Plug the thing in at "__blk_get_queue()", and you're done.

> So I need a major number - to give to devfs_register_blkdev at least.
> You don't want me to have a hardcoded one (which is fine) so I need a
> dynamically allocated one - yes?

If you are willing to use devfs, you can just use a major nr of zero, and
devfs will allocate a device for you. 

Not everybody likes devfs, and there are bootstrap issues with this
approach, but it is the simple "get things working quickly" approach that
needs _zero_ changes or infrastructure.

> This means that we need some analogue to {get,put}_unnamed_dev that
> manages a range of dynamically allocated majors.

We already do have that. And have had it for a long time. It's pretty much
been part of "register_blkdev()" since day one (not quite true, but I bet
that code has been there since the days of Linux-1.0.x). 

You just pass in a major number of zero to "register_blkdev()", and it
will make one up for you.

devfs inherited this behaviour from the first version, I think.

> Am I missing something obvious here?

The fact that it already exists, and has existed for 5+ years, but that
nobody really uses it?

Nobody really uses it because it would require you to add a line or two to
your init scripts to pick up the major number from /proc/devices, and
that's obviously too hard. Much better to just hardcode randome numbers,
right?

		Linus

