Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135211AbRAGUfa>; Sun, 7 Jan 2001 15:35:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135721AbRAGUfU>; Sun, 7 Jan 2001 15:35:20 -0500
Received: from linuxjedi.org ([192.234.5.42]:62225 "EHLO linuxjedi.org")
	by vger.kernel.org with ESMTP id <S135483AbRAGUfH>;
	Sun, 7 Jan 2001 15:35:07 -0500
Message-ID: <3A58D418.32111AD@linuxjedi.org>
Date: Sun, 07 Jan 2001 15:39:52 -0500
From: "David L. Parsley" <parsley@linuxjedi.org>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-ac2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linus Torvalds <torvalds@transmeta.com>,
        "Adam J. Richter" <adam@yggdrasil.com>, parsley@roanoke.edu,
        linux-kernel@vger.kernel.org
Subject: Re: Patch (repost): cramfs memory corruption fix
In-Reply-To: <E14FLi2-0003Cy-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> -ac has the rather extended ramfs with resource limits and stuff. That one
> also has rather more extended bugs 8). AFAIK none of those are in the vanilla
> ramfs code

Nifty stuff, too; it's nice for a ramfs mount to show up in 'df' with
useful figures.  Shame I can't put anything there. ;-)

2.4.0 ramfs with the one-liner does it's job for me already; what I'd
really love to fool with is _cramfs_. ;-)  In case you missed the
beginning of this thread: all my cramfs initrd's fail to mount as
/dev/ram0 with 'wrong magic'; their romfs counterparts work fine.  I did
manage to pivot_root into a cramfs root, but it blew up pretty quick
with 'attempt to access beyond end of device', and killed my init
shell.  Then there's the wierdness where cramfs compiled in the kernel
corrupts the romfs.  Adam's one-liner (bforget -> brelse on superblock)
didn't fix this.

The cramfs docs are contradictory btw; the kernel help says 'doesn't
support hardlinks', and Documentation/filesystems/cramfs.txt says
'Hardlinks are supported, but...'.  I made my cramfs with and without
hardlinks (to busybox); but that didn't affect whether it mounted.  I
haven't tested whether this fixes the 'access beyond end of device'
problems.

regards,
	David
-- 
David L. Parsley
Network Administrator
Roanoke College
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
