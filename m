Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136473AbREDR4W>; Fri, 4 May 2001 13:56:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136474AbREDR4M>; Fri, 4 May 2001 13:56:12 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:5380 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S136473AbREDR4E>; Fri, 4 May 2001 13:56:04 -0400
Date: Fri, 4 May 2001 10:55:58 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alexander Viro <viro@math.psu.edu>
cc: Rogier Wolff <R.E.Wolff@BitWizard.nl>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        volodya@mindspring.com, Andrea Arcangeli <andrea@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SMP race in ext2 - metadata corruption.
In-Reply-To: <Pine.GSO.4.21.0105041330510.19970-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.21.0105041048290.521-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 4 May 2001, Alexander Viro wrote:
> 
> Ehh... There _is_ a way to deal with that, but it's deeply Albertesque:
> 	* add pagecache access for block device
> 	* put your "real" root on /dev/loop0 (setup from initrd)
> 	* dd

You're one sick puppy.

Now, the above is basically equivalent to using and populating a
dynamically sized ramdisk.

If you really want to go this way, I'd much rather see you using a real
ram-disk (that you populate at startup with something like a compressed
tar-file). THAT is definitly going to speed up booting - thanks to
compression you'll not only get linear reads, but you will get fewer reads
than the amount of data you need would imply.

Couple that with tmpfs, or possibly something like coda (to dynamically
move things between the ramdisk and the "backing store" filesystem), and
you can get a ramdisk approach that actually shrinks (and, in the case of
coda or whatever, truly grows) dynamically.

Think of it as an exercise in multi-level filesystems and filesystem
management. Others have done it before (usually between disk and tape, or
disk and network), and in these days of ever-growing memory it might just
make sense to do it on that level too.

(No, I don't seriously think it makes sense today. But if RAM keeps
growing and becoming ever cheaper, it might some day. At the point where
everybody has multi-gigabyte memories, and don't really need it for
anything but caching, you could think of it as just moving the caching to
a higher level - you don't cache blocks, you cache parts of the
filesystem).

> 	Al, feeling sadistic today...

Sadistic you are.

		Linus

