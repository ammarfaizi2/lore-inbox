Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135889AbRDZTTo>; Thu, 26 Apr 2001 15:19:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135890AbRDZTTe>; Thu, 26 Apr 2001 15:19:34 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:35727 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S135889AbRDZTTS>;
	Thu, 26 Apr 2001 15:19:18 -0400
Date: Thu, 26 Apr 2001 15:17:54 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Andrea Arcangeli <andrea@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SMP race in ext2 - metadata corruption.
In-Reply-To: <Pine.GSO.4.21.0104261455530.15385-100000@weyl.math.psu.edu>
Message-ID: <Pine.GSO.4.21.0104261510290.15385-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 26 Apr 2001, I wrote:

> On Thu, 26 Apr 2001, Linus Torvalds wrote:
>  
> > I see the race, but I don't see how you can actually trigger it.
> > 
> > Exactly _who_ does the "read from device" part? Somebody doing a
> > "fsck" while the filesystem is mounted read-write and actively written
> > to? Yeah, you'd get disk corruption that way, but you'll get it regardless
> > of this bug.

OK, I think I've a better explanation now:

Suppose /dev/hda1 is owned by root.disks and permissions are 640.
It is mounted read-write.

Process foo belongs to pfy.staff. PFY is included into disks, but doesn't
have root. I claim that he should be unable to cause fs corruption on
/dev/hda1.

Currently foo _can_ cause such corruption, even though it has nothing
resembling write permissions for device in question.

IMO it is wrong. I'm not saying that it's a real security problem. I'm
not saying that PFY is not idiot or that his actions make any sense.
However, I think that situation when he can do that without write
access to device is just plain wrong.

Does the above make sense?
								Al

