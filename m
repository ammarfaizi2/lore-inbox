Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265934AbRGOGHA>; Sun, 15 Jul 2001 02:07:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265933AbRGOGGv>; Sun, 15 Jul 2001 02:06:51 -0400
Received: from otter.mbay.net ([206.40.79.2]:14600 "EHLO otter.mbay.net")
	by vger.kernel.org with ESMTP id <S265641AbRGOGGf>;
	Sun, 15 Jul 2001 02:06:35 -0400
Date: Sat, 14 Jul 2001 23:05:36 -0700 (PDT)
From: John Alvord <jalvo@mbay.net>
To: Chris Wedgwood <cw@f00f.org>
cc: Daniel Phillips <phillips@bonn-fries.net>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Andrew Morton <andrewm@uow.edu.au>,
        Andreas Dilger <adilger@turbolinux.com>,
        "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        Ben LaHaise <bcrl@redhat.com>,
        Ragnar Kjxrstad <kernel@ragnark.vestdata.no>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mike@bigstorage.com, kevin@bigstorage.com, linux-lvm@sistina.com
Subject: Re: [PATCH] 64 bit scsi read/write
In-Reply-To: <20010715153607.A7624@weta.f00f.org>
Message-ID: <Pine.LNX.4.20.0107142304010.17541-100000@otter.mbay.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 15 Jul 2001, Chris Wedgwood wrote:

> On Sat, Jul 14, 2001 at 10:11:30PM +0200, Daniel Phillips wrote:
> 
>     Atomic commit.  The superblock, which references the updated
>     version of the filesystem, carries a sequence number and a
>     checksum.  It is written to one of two alternating locations.  On
>     restart, both locations are read and the highest numbered
>     superblock with a correct checksum is chosen as the new filesystem
>     root.
> 
> Yes... and which ever part of the superblock contains the sequence
> number must be written atomically.
> 
> The point is, you _NEED_ to be sure that data written before the
> superblock (or indeed anywhere further up the tree, you can make
> changes in theory which don't require super-block updates) are written
> firmly to the platters before any thing which refers to it is updated.
> 
> Alan was saying with IDE you cannot reliably do this, I assume you can
> with SCSI was my point.

In the IBM solution to this (1977-78, VM/CMS) the critical data was
written at the begining and the end of the block. If the two data items
didn't match then the block was rejected.

john alvord
 > 
> 
> 
>   --cw
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

