Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261883AbSJIRSD>; Wed, 9 Oct 2002 13:18:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261882AbSJIRSC>; Wed, 9 Oct 2002 13:18:02 -0400
Received: from air-2.osdl.org ([65.172.181.6]:31918 "EHLO cherise.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S261878AbSJIRRB>;
	Wed, 9 Oct 2002 13:17:01 -0400
Date: Wed, 9 Oct 2002 10:24:38 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise.pdx.osdl.net
To: Linus Torvalds <torvalds@transmeta.com>
cc: Alexander Viro <viro@math.psu.edu>, <linux-kernel@vger.kernel.org>
Subject: Re: [bk/patch] driver model update: device_unregister()
In-Reply-To: <Pine.LNX.4.44.0210091010360.7355-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0210091015480.16276-100000@cherise.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 9 Oct 2002, Linus Torvalds wrote:

> 
> On Wed, 9 Oct 2002, Patrick Mochel wrote:
> > 
> > No problem; I'll do that today. But, I also think some of the stuff in 
> > fs/partitions/check.c is bogus and should die. Partitions are not devices, 
> > and shouldn't be treated as such. 
> 
> I think that is a valid argument as long as it's called "driverfs" or
> something, but since the thing is clearly evolving into a "kernelfs"  and
> has drivers and devices as only a part of its structure knowledge, and is
> used to expose various kernel hierarchies and relationships, I actually
> think that it makes sense to expose the relationship of partitions to
> devices.
> 
> (Not that it has to use "struct device" to do so, of course, although I 
> don't see any major reason why it couldn't..)

I agree that it is useful to expose the partitions of devices via the 
filesystem, but struct device seems way too heavy-handed to describe them. 
I think they would be better off as a single attribute file that dumped 
the partition data about the disk. 

You would have something like:

/sys/class/disk/
|-- devices
|   |   `-- 0 -> ../../../root/wherever

and in 'wherever': 

/sys/root/wherever/
|-- partitions

I dunno about the format; or if we would want one file or one per 
partition.

> What's the oops due to?

Sorry, I take it back. It wasn't an oops; it was a backtrace due to the
partitions being removed during an illegal context.

	-pat

