Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261518AbSJIUGC>; Wed, 9 Oct 2002 16:06:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261907AbSJIUGC>; Wed, 9 Oct 2002 16:06:02 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:44421 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S261518AbSJIUGB>;
	Wed, 9 Oct 2002 16:06:01 -0400
Date: Wed, 9 Oct 2002 16:11:42 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Patrick Mochel <mochel@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [bk/patch] driver model update: device_unregister()
In-Reply-To: <Pine.LNX.4.44.0210091241050.24067-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0210091550150.8980-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 9 Oct 2002, Linus Torvalds wrote:

> As to the "can_unload()" thing, I really suspect that the reason it shows 
> up is because module unloading is fundamentally broken - again regardless 
> of any driverfs issues. Talk to Rusty some day about it ;)

I did and I'm less than impressed by his arguments.  Filesystem module
unloading works fine, thank you very much.  There we have explicit points
where thing becomes busy and ceases to be such.  And IMNSHO it's the right
way to deal with that stuff, rather than delving into quiescrap.  Rusty
deals with modules that are one step removed from "make down_write() modular"
so it's hardly a surprise that unloading gets hairy...

Notice that for partitions (and even more so for superblocks) we are talking
about _way_ more than "if it's busy, it can't be removed".  Unlike PCI and
friends, here we have non-trivial locking and driverfs accesses changing
refcount would need to play nice with that.

Sigh...  Screw it.  Tell me what directory tree you want for block
device and I'll do that, ugly or not ;-/  I really don't like the
direction it's going, but it's your tree and since it hadn't reached
my fork threshold yet...


