Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261920AbSJITnT>; Wed, 9 Oct 2002 15:43:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261936AbSJITnT>; Wed, 9 Oct 2002 15:43:19 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:63755 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261920AbSJITnR>; Wed, 9 Oct 2002 15:43:17 -0400
Date: Wed, 9 Oct 2002 12:47:41 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alexander Viro <viro@math.psu.edu>
cc: Patrick Mochel <mochel@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [bk/patch] driver model update: device_unregister()
In-Reply-To: <Pine.GSO.4.21.0210091520000.8980-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.44.0210091241050.24067-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 9 Oct 2002, Alexander Viro wrote:
>
> Even aside of the problems with putting filesystems (and filesystem types)
> into driverfs (can_unload() for each fs module?), partitions _ARE_ reused.
> So logics with ->release() will be a killer.

Note that we don't actually do this yet, and when/if we do it it obviously
will require us to have the association data structures in place. And
clearly the rule would have to be that a partition can't be re-used while
a filesystem is busily bound to it - and that has nothing to do with
driverfs/kernel/sysfs/xxxfs.

(That rule pretty much exists already, although we obviously don't
_enforce_ the rule, since we don't even have the data structure linkages
in place).

As to the "can_unload()" thing, I really suspect that the reason it shows 
up is because module unloading is fundamentally broken - again regardless 
of any driverfs issues. Talk to Rusty some day about it ;)

(Side note: it may be that we could _fix_ module unloading by adding a
driverfs node to modules too, and getting rid of the "single module count"  
thing, and replacing it with a more generic "list of nodes using it".  
The reason module unloading is so painful largely is exactly the fact that
we only have a count, and the generic module layer has no idea what is
actually _using_ the module - except for other modules. In other words, we
get the inter-module dependencies right, but we don't see any other
dependencies).

		Linus


