Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276695AbRJ0TT1>; Sat, 27 Oct 2001 15:19:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276764AbRJ0TTR>; Sat, 27 Oct 2001 15:19:17 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:24733 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S276695AbRJ0TTN>;
	Sat, 27 Oct 2001 15:19:13 -0400
Date: Sat, 27 Oct 2001 15:19:48 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: alain@linux.lu
cc: Linus Torvalds <torvalds@transmeta.com>,
        Richard Gooch <rgooch@ras.ucalgary.ca>, linux-kernel@vger.kernel.org
Subject: Re: Poor floppy performance in kernel 2.4.10 
In-Reply-To: <200110271913.f9RJDup01632@hitchhiker.org.lu>
Message-ID: <Pine.GSO.4.21.0110271517010.21545-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 27 Oct 2001, Alain Knaff wrote:

> And "mapping" itself seems to point to i_data of the device's inode
> structure (not the device entry's inode, but the device's itself).
 
> Which means that if the inode is put (all references to the block
> device closed), and later the same major/minor is reopened, it may

Stop here.  bdev->bd_inode is destroyed only when bdev is destroyed.
If we make block_device long-living (i.e. they stay around until all
pages are evicted from cache _or_ device gets unregistered) ->bd_inode
will follow.

