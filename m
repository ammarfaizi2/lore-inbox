Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267931AbTAHU7q>; Wed, 8 Jan 2003 15:59:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267928AbTAHU7q>; Wed, 8 Jan 2003 15:59:46 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:50701 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267931AbTAHU7o>; Wed, 8 Jan 2003 15:59:44 -0500
Date: Wed, 8 Jan 2003 13:03:14 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: John Levon <levon@movementarian.org>
cc: linux-kernel@vger.kernel.org, <davem@redhat.com>
Subject: Re: [PATCH] /proc/sys/kernel/pointer_size
In-Reply-To: <20030108205220.GB35912@compsoc.man.ac.uk>
Message-ID: <Pine.LNX.4.44.0301081300200.1497-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 8 Jan 2003, John Levon wrote:
> On Wed, Jan 08, 2003 at 12:28:23PM -0800, Linus Torvalds wrote:
> 
> > doesn't change suddenly on the machine, there's no point at all in doing
> > something like this and exporting it through proc, when the information is
> > perfectly available in other ways
> 
> What other ways ? Dave M reasonably argued it wasn't part of the
> architecture's ABI, so did not have a place in the headers.

You should certainly see it in "uname -a" output, for example.

> > or could even be a user program config file option.
> 
> Eww.

And it's less disgusting than adding a kernel hack for it?

Trust me, kernel stuff is for stuff that _cannot_ be gotten in user space, 
not for random hacks.

> It's not silly, it's a necessity on architectures like pa-risc, sparc64,
> ppc64, etc. where pointers are 32 bit in userspace. OProfile simply
> cannot work at all on such systems without being able to figure out the
> units of the oprofile kernel buffer.

So? 

The same is true of kernel modules - 32-bit kernel modules do not work at 
all when the kernel is 64-bit.

Compile oprofile for the proper architecture if you do it yourself, and
complain to the vendor if the vendor is stupid enough to supply a 32-bit 
oprofile with a 64-bit kernel.

There is _no_ excuse to bloat the kernel for user mistakes.

			Linus

