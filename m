Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261711AbSJITMu>; Wed, 9 Oct 2002 15:12:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261924AbSJITMu>; Wed, 9 Oct 2002 15:12:50 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:54793 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261711AbSJITMY>; Wed, 9 Oct 2002 15:12:24 -0400
Date: Wed, 9 Oct 2002 12:16:58 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alexander Viro <viro@math.psu.edu>
cc: Patrick Mochel <mochel@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [bk/patch] driver model update: device_unregister()
In-Reply-To: <Pine.GSO.4.21.0210091453160.8980-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.44.0210091208490.14911-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 9 Oct 2002, Alexander Viro wrote:
> 
> That's what I'm asking about - do we want to have objects on the _partition_
> side of things that would require per-partition directory?  Not on the
> filesystem/swap/whatnot side...

You're going about this the wrong way.

It doesn't _matter_ if you have associations on the partition side. The 
_only_ thing that matters is that somebody else has associations _to_ a 
partition. That is already enough to require a "node" to associate to.

How would you otherwise describe that association in filesystem terms?

Look, let me give you an example of an existing association.

/devices/bus/scsi/devices:
	lrwxrwxrwx    1 root     root           40 Oct  7 17:17 1:0:0:0 -> ../../../root/pci0/00:0b.0/scsi1/1:0:0:0

Here the association is from the "list of scsi devices" to the "hardware 
device node that is associated with that device".

The thing I want to point out is that you need a "target node" in order to 
be able to _have_ this association.

In other words, if you think that it is reasonable to have an assocation 
from the MD device to the list of partitions that are part of that MD 
device, then you _need_ to have a "partition node", because otherwise you 
cannot have the pointer to it. See?

So your "partition side" vs "filesystem side" thing doesn't matter. It 
doesn't matter which side the associations are, you need to have a node to 
associate _with_. 

Noth sides need a node. Even if the relationship is only going in one 
direction.

			Linus

