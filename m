Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278286AbRKFHES>; Tue, 6 Nov 2001 02:04:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278309AbRKFHEJ>; Tue, 6 Nov 2001 02:04:09 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:27826 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S278286AbRKFHEB>;
	Tue, 6 Nov 2001 02:04:01 -0500
Date: Tue, 6 Nov 2001 02:03:59 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
cc: alain@linux.lu, Linus Torvalds <torvalds@transmeta.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Poor floppy performance in kernel 2.4.10 
In-Reply-To: <200111060701.fA671hL20646@vindaloo.ras.ucalgary.ca>
Message-ID: <Pine.GSO.4.21.0111060202160.27713-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 6 Nov 2001, Richard Gooch wrote:

> Alexander Viro writes:
> > 	BTW, here's one more devfs rmmod race: check_disk_changed() in
> > fs/devfs/base.c.  Calling ->check_media_change() with no protection
> > whatsoever.  If rmmod happens at that point...
> 
> How is this different from a call to fs/block_dev.c:check_disk_change()
> which also has no protection?

It's called either from driver itself (and then whatever protects caller
protects it as well) or after we'd pinned the thing down by blkdev_get().

