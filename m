Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135536AbRAVX3h>; Mon, 22 Jan 2001 18:29:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135527AbRAVX32>; Mon, 22 Jan 2001 18:29:28 -0500
Received: from postfix.conectiva.com.br ([200.250.58.155]:15111 "HELO
	postfix.conectiva.com.br") by vger.kernel.org with SMTP
	id <S130615AbRAVX3M>; Mon, 22 Jan 2001 18:29:12 -0500
Message-ID: <3A6CC21B.D4ABE21C@conectiva.com.br>
Date: Mon, 22 Jan 2001 21:28:27 -0200
From: Andrew Clausen <clausen@conectiva.com.br>
Organization: Conectiva
X-Mailer: Mozilla 4.76 [pt_BR] (X11; U; Linux 2.2.17-14cl i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, bug-parted@gnu.org,
        linux-kernel@vger.kernel.org
Subject: Re: Partition IDs in the New World TM
In-Reply-To: <200101222242.WAA00893@raistlin.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> 
> Andrew Clausen writes:
> > Why is this necessary?  Can't the RAID drivers probe the device for
> > signatures, the same way file systems do?
> 
> One possible problem I can see here is to do with removal of RAID.  Think
> of a RAID-1 array (2 or more disks containing identical data).  The
> partition can be validly identified as an ext2 filesystem.  But wait, it
> has a RAID superblock at the end.
> 
> How do we know if this superblock is current or not?  After all, a mke2fs
> on the device won't remove it.  Yes, you could fill the partition with
> zeros and start again, or you could just change the partition ID.

Yeah, this is a big problem.

Parted solves it, by defining a clobber() operation for each file system
type (which can/should be extended to RAID, if/when we get around to
supporting it properly).  clobber() removes all signatures.

So, I guess the short answer is: mke2fs should remove the RAID super.
For those of you who don't like all-in-one libraries like libparted -
not mentioning any Christo^Wnames - you could probably have
clobber.ext2,
etc.

However, you would want to have a comprehensive set of clobber.*.
Fortunately, clobber.X is going to be very small, so this should be
a problem.

So, the alternative is to define a RAID partition "data" type.  (And
forget about IDs for file systems)

Andrew Clausen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
