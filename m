Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287863AbSANSED>; Mon, 14 Jan 2002 13:04:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287866AbSANSDw>; Mon, 14 Jan 2002 13:03:52 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:3086 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S287863AbSANSDk>; Mon, 14 Jan 2002 13:03:40 -0500
Date: Mon, 14 Jan 2002 10:01:25 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alexander Viro <viro@math.psu.edu>
cc: <linux-kernel@vger.kernel.org>, <linux-LVM@sistina.com>
Subject: Re: [RFLART] kdev_t in ioctls
In-Reply-To: <Pine.GSO.4.21.0201141227260.224-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.33.0201140957040.15128-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 14 Jan 2002, Alexander Viro wrote:
>
> 	Linus, at least some ioctls (e.g. lvm ones) pass kdev_t from/to
> userland.  While the common policy with ioctls is "anything goes", this
> kind of abuse is IMNSHO over the top.

That's completely bogus.

The good news is that the bit-for-bit representation of old kdev_t and
"dev_t" are obviously 100% the same, so we should just make the damn thing
be dev_t, and user land will never notice anything.

So we can just change all structures that are exported to user land to use
"dev_t", and add the required conversion magic. Possibly by duplicating
the structure, and having "used_lvm_struct_x" and functions to read and
write them from/to user space.

> Public statement along the lines "any API that passes kdev_t values
> across the kernel boundary is unacceptable" would be a nice thing...

Consider that done. ANYTHING that exports kdev_t to user space is
incredibly broken, and will not work in a few months when the actual bit
representation (and size) will change.

Do we have any lvm people willing to fix this? (linux-lvm cc'd, but I know
they've been very silent on the 2.5.x changes so far)

		Linus

