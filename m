Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267968AbRG3Uvh>; Mon, 30 Jul 2001 16:51:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267885AbRG3UvW>; Mon, 30 Jul 2001 16:51:22 -0400
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:34624 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S267938AbRG3Uuq>; Mon, 30 Jul 2001 16:50:46 -0400
Date: Mon, 30 Jul 2001 15:50:33 -0500 (CDT)
From: Jeff Garzik <jgarzik@mandrakesoft.com>
To: Mike Touloumtzis <miket@bluemug.com>
cc: Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@transmeta.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [CFT] initramfs patch
In-Reply-To: <20010730132957.A20284@bluemug.com>
Message-ID: <Pine.LNX.3.96.1010730153712.7347D-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Mon, 30 Jul 2001, Mike Touloumtzis wrote:
> On Mon, Jul 30, 2001 at 02:05:55AM -0400, Alexander Viro wrote:
> > The thing unpacks cpio archive (currently - linked into the kernel image)
> > on root ramfs and execs /init. After that we are in userland code. Said
> > code (source in init/init.c and init/nfsroot.c) emulates the vanilla
> > 2.4 behaviour. You can replace it with your own - that's just the default
> > that gives (OK, is supposed to give) a backwards-compatible behaviour.
> 
> One thing that would make embedded systems developers very happy
> is the ability to map a romfs or cramfs filesystem directly from
> the kernel image, avoiding the extra copy necessitated by the cpio
> archive.  Are there problems with this approach?

Yes -- you need to at that point store initialized structures.  Store
the dcache in its unpacked state on the ROM image, etc.  That's the only
way to "map" a romfs directly.  Otherwise there is ALWAYS an unpacking
or translation step between filesystem image and in-memory image.

Mapping an in-memory image directly may seem like a good idea, but it is
really not.  ESPECIALLY for embedded folks.

Use a programmatic solution to unpack your filesystem... like say cpio
format in initramfs. :)

	Jeff



