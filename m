Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130760AbQLWTmP>; Sat, 23 Dec 2000 14:42:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130880AbQLWTlx>; Sat, 23 Dec 2000 14:41:53 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:63250 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130751AbQLWTlr>; Sat, 23 Dec 2000 14:41:47 -0500
Date: Sat, 23 Dec 2000 11:11:07 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: rkreiner@sbox.tu-graz.ac.at
cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: multiple mount of devices possible 2.4.0-test1 - 
 2.4.0-test13-pre4
In-Reply-To: <3A44DEE4.2D94574F@sbox.tu-graz.ac.at>
Message-ID: <Pine.LNX.4.10.10012231103160.2174-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 23 Dec 2000 rkreiner@sbox.tu-graz.ac.at wrote:
> 
> 1. multiple mount of devices possible 2.4.0-test1 - 2.4.0-test13-pre4
> 
> 2. its still possible to mount devices several times.
>    IMHO it shouldnt be possible like 2.2.18

No.

The multi-mount thing is a _major_ feature, and the fact that your "mount"
binary seems to be confused by it is a user-level problem and nothing
more.

There are many absolutely vital reasons for multi-mounting, so it's
extremely useful. Think about:

 - chroot environments, where you want to mount the same filesystem as
   outside the chroot thing. Imagine having your /usr/share thing mounted
   read-only, for example. Things like that.

 - user-private areas - where users see their own version of their tree.
   This can be quite powerful for things like emulation, or simply for
   namespace cleanliness.

 - automounting. "autofs" will use this to mount your local home directory
   the _right_ way. So you'd have the same filesystem mounted as both

	/export/home/machine/torvalds ("native" location)
	/home/torvalds (auto-mount location)

   automounting is also why you want to be able to do things like mounting
   multiple different filesystems at the same point, etc.

Now, I agree that it is inconvenient that the user-space mount binary
hasn't historically known about these things, but I think the current
linux-util stuff already has a multi-mount aware mount that won't be
confused by the fact that the kernel can do more than it historically was
able to.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
