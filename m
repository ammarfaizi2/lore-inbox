Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132508AbQL3BvC>; Fri, 29 Dec 2000 20:51:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132513AbQL3Buw>; Fri, 29 Dec 2000 20:50:52 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:772 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S132508AbQL3Bur>; Fri, 29 Dec 2000 20:50:47 -0500
Date: Fri, 29 Dec 2000 17:03:05 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alexander Viro <viro@math.psu.edu>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <aviro@redhat.com>,
        "Stephen C. Tweedie" <sct@redhat.com>, "Marco d'Itri" <md@Linux.IT>,
        Jeff Lightfoot <jeffml@pobox.com>, Dan Aloni <karrde@callisto.yi.org>,
        Anton Blanchard <anton@linuxcare.com.au>
Subject: Re: test13-pre6
In-Reply-To: <Pine.GSO.4.21.0012291932380.1464-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.10.10012291655530.869-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 29 Dec 2000, Alexander Viro wrote:
> 
> Two examples: devices and bitmaps-in-pagecache trick. But both belong to
> 2.5, so...

Also, they can easily be done with a private inode, if required. So even
in 2.5.x this may not be a major problem.

> BTW, nice timing ;-) -pre6 appeared 5 minutes after I've started testing
> sane-s_lock patch (SMP-safe lock_super() and friends, refcount on superblocks,
> death of mount_sem, beginning of SMP-safe super.c). Oh, well...
> 
> Oblock_super(): what the hell is wait_on_super() doing in fsync_file()?
> It gives absolutely no warranties - ->write_super() can easily block, so
> it looks very odd.

A lot of the superblock locking has been odd. It should probably be a
lock_super() + unlock_super(). At least that's what sync_supers() does.

> BTW, while we are dropping the junk from vm_operations_struct, could we lose
> ->protect() and ->wppage()?

Sure. I think sync() and unmap() fall under that heading too - it used to
do a msync(), but that was before we handled dirty pages directly, so...

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
