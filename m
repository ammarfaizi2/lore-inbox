Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293464AbSCEQoU>; Tue, 5 Mar 2002 11:44:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293459AbSCEQoH>; Tue, 5 Mar 2002 11:44:07 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:32734 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S293461AbSCEQnu>; Tue, 5 Mar 2002 11:43:50 -0500
Date: Tue, 5 Mar 2002 11:43:47 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, zaitcev@redhat.com
Subject: Re: s390 is totally broken in 2.4.18
Message-ID: <20020305114347.A4062@devserv.devel.redhat.com>
In-Reply-To: <OF6510BC1D.720C525B-ONC1256B73.003619EE@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <OF6510BC1D.720C525B-ONC1256B73.003619EE@de.ibm.com>; from schwidefsky@de.ibm.com on Tue, Mar 05, 2002 at 11:10:37AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: s390 is totally broken in 2.4.18
> From: "Martin Schwidefsky" <schwidefsky@de.ibm.com>
> Date: Tue, 5 Mar 2002 11:10:37 +0100
 
> The patch that was merged in 2.4.18-pre* has been created against
> 2.4.17-pre7 and it did work. The problem is that not all of the
> changes I sent Marcelo have been accepted. One of the patches was
> the asm-offsets fix that removes all of the hardcoded offsets from
> entry.S. Another patch was accepted that changed the thread
> structure and this created the inconsistency.

A patch that generated offsets at compilation time would be
a superiour solution. As a matter of fact, I was thinking
about adopting DaveM's script that generates offsets for sparc.
He does it a make dep time in order to prevent mass rebuilds
on every recompile. See arch/sparc64/kernel/check_asm.sh
and the corresponding Makefile. Good thing you mentioned that
and saved me a bunch of work :)

Please keep poking Marcelo with it, and it's a great pity that
you did not before 2.4.18 came out.

> >Patch attached.

> Well your patch halfway fixes one of the problems. Halfway because
> not the fp_regs structure has changed its size but the pt_regs
> pointer has been removed from the thread structure.

Yes, I noticed. However, offsets are all chained together,
so all other offsets become correct. But once again, having
them all generated automatically is preferable.

> Incidentally I sent an s390 update to Marcelo yesterday and the
> minimal fixes including an rwsem.h implementation and the partition
> detection fixes are about 2000 lines. Want a copy ?

Certainly, I do. I worked around the partitions part with "obvious"
fixup:

-       if (ioctl_by_bdev(bdev, HDIO_GETGEO, (unsigned long)geo);
+       if (ioctl_by_bdev(bdev, HDIO_GETGEO, (unsigned long)geo))
-       data = read_dev_sector(bdev, inode->label_block*blocksize, &sect);
+       data = read_dev_sector(bdev, info->label_block*blocksize, &sect);

But that code did not look too good, in particular it was
not checking return codes. So, it was on my TODO list to
clean it up.

-- Pete
