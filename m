Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130614AbQL3BYX>; Fri, 29 Dec 2000 20:24:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131642AbQL3BYM>; Fri, 29 Dec 2000 20:24:12 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:28087 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S130614AbQL3BYF>;
	Fri, 29 Dec 2000 20:24:05 -0500
Date: Fri, 29 Dec 2000 19:49:51 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <aviro@redhat.com>,
        "Stephen C. Tweedie" <sct@redhat.com>, "Marco d'Itri" <md@Linux.IT>,
        Jeff Lightfoot <jeffml@pobox.com>, Dan Aloni <karrde@callisto.yi.org>,
        Anton Blanchard <anton@linuxcare.com.au>
Subject: Re: test13-pre6
In-Reply-To: <Pine.LNX.4.10.10012291609470.1123-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0012291932380.1464-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 29 Dec 2000, Linus Torvalds wrote:

> Al: this changes "mapping->host" to be truly defined as a pointer to the
> inode that owns the mapping. That's how every user actually _used_ the
> host pointer, so this cleans those up to not need any casts. The main
> reason, however, is that we needed to have some FS-level anchor for dirty
> pages in order to get the correct sync() semantics. If you think it's
> worth it to have a notion of an anonymous host we need to add something
> else.

Two examples: devices and bitmaps-in-pagecache trick. But both belong to
2.5, so...

BTW, nice timing ;-) -pre6 appeared 5 minutes after I've started testing
sane-s_lock patch (SMP-safe lock_super() and friends, refcount on superblocks,
death of mount_sem, beginning of SMP-safe super.c). Oh, well...

Oblock_super(): what the hell is wait_on_super() doing in fsync_file()?
It gives absolutely no warranties - ->write_super() can easily block, so
it looks very odd.

BTW, while we are dropping the junk from vm_operations_struct, could we lose
->protect() and ->wppage()? Both are never used and never defined. I can
send a diff, indeed, but
ed include/linux/mm.h <<EOF
g/\*protect/d
g/wppage/d
w
q
EOF
should take care of them.
						Cheers,
							Al
It's nice to be back... 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
