Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132034AbQKSBRB>; Sat, 18 Nov 2000 20:17:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132144AbQKSBQl>; Sat, 18 Nov 2000 20:16:41 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:26552 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S132034AbQKSBQb>;
	Sat, 18 Nov 2000 20:16:31 -0500
Date: Sat, 18 Nov 2000 19:46:29 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Andrea Arcangeli <andrea@suse.de>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext2 largefile fixes + [f]truncate() error value fix
In-Reply-To: <20001119013324.F26779@athlon.random>
Message-ID: <Pine.GSO.4.21.0011181943110.21893-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 19 Nov 2000, Andrea Arcangeli wrote:

> On Sat, Nov 18, 2000 at 04:55:23PM -0500, Alexander Viro wrote:
> > > 		if (size >> 33) {
> >                        ITYM 32 
> 
> this is a bug in 2.2.x mainstream btw.

I don't have recent 2.2 at hand, but...

ed fs/ext2/inode.c <<EOF
/ext2_notify_change/
/size >> 33/
s/33/32/
w
q
EOF

is probably in order. Alan? Place in question is the check for notify_change()
growing the file past 4Gb - it should check for size >> 32, obviously.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
