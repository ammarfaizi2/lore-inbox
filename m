Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274102AbRISQop>; Wed, 19 Sep 2001 12:44:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274103AbRISQog>; Wed, 19 Sep 2001 12:44:36 -0400
Received: from [217.201.19.65] ([217.201.19.65]:24046 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S274102AbRISQoR>;
	Wed, 19 Sep 2001 12:44:17 -0400
Date: Wed, 19 Sep 2001 18:35:48 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.10-pre11
Message-ID: <20010919183548.W720@athlon.random>
In-Reply-To: <Pine.LNX.4.33.0109180935180.2077-100000@penguin.transmeta.com> <Pine.GSO.4.21.0109181354470.27125-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0109181354470.27125-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Tue, Sep 18, 2001 at 02:19:42PM -0400
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2001 at 02:19:42PM -0400, Alexander Viro wrote:
> with Andrea and once he gets back to life (no, 'e's just sleepin') we'll

yes, I'm back to life but I had a surprise: but my ISP is down so I'm
now masqueraded my dekstop over a wirless GPRS link via irda on the
laptop [GRPS is flat rate in Italy :) ] so it's quite dogslow at the
moment, I cannot read emails and RTT over GSM is of the order of 1
second (but I can send emails and slowly browse the web). I still hope
the ISP returns alive before tomorrow... (I'm looking into Andrew's
report at the moment and I don't need good connectivity for debugging it
luckily :)

I think the bug we have in the inode pinning isn't a showstopper (I
probably could live with it forever without ever have chance to notice it),
so no user should be hurted by it [but I understand it can hurt you very
much], and I am _very_ concerned in addressing it ASAP and I'm very
happy you spoteed it immediatly. I'll also check your worries with the
ramdisk BLKFLSBUF (the logic should be just like before the changes, the
reason I backed out the rd_bdev changes is because I was always working
with inodes for everything related to the physical address space, not
with bdevs so I didn't see a value in the change, but after the bugfix
[bdev->bd_mapping] probably this will change), for the other issue with the
->writepage as said it is fine and intentional, except we can do
something more efficient for the ramdisk adding some special case to the
memory balancing code (for istance we could always put the ramdisk stuff
over the active list rather than rolling it over in the inactive list
again, but quite frankly that's low prio unless somebody has a real
patological case and of course that applies and it always applied to
ramfs too [I did it with the argument: it works for ramfs so it will
obviously work work for ramdisk too]). In the next days I'll also be
very busy with some non linux-kernel developement issue, but I'll try to
be still as much responsive as possible for anything urgent (I'll
certainly be 100% responsive again next week starting from Wed 26).

At the moment my very first prio is to address the BUG() reported by
Andrew (if it is just been fixed please somebody at SuSE send me an SMS
so I don't waste time since as said I cannot read emails at the moment).

Andrea
