Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132772AbQKXMPV>; Fri, 24 Nov 2000 07:15:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132790AbQKXMPL>; Fri, 24 Nov 2000 07:15:11 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:28687 "HELO
        hermine.idb.hist.no") by vger.kernel.org with SMTP
        id <S132772AbQKXMO7>; Fri, 24 Nov 2000 07:14:59 -0500
Message-ID: <3A1E54BB.CA4DF540@idb.hist.no>
Date: Fri, 24 Nov 2000 12:44:59 +0100
From: Helge Hafting <helgehaf@idb.hist.no>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: no, da, en
MIME-Version: 1.0
To: mwm@i.am, linux-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: "Hyper-Mount" option possible???
In-Reply-To: <3A1D3DF9.9199C744@earthlink.net> <3A1E2556.CC9B24B1@i.am>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Mark W. McClelland" wrote:
> 
> Robert L Martin wrote:
> >
> > Not on list just throwing an idea out.
> > One thing that "bugs" me is if a given drive has more than one partion
> > each partion has to be mounted seperatly.
> > With CDs this also means you can not mount "split" cds in full if you
> > want to. Soo  Given that Super-Mount is already taken, How about (in
> > 2.5??)  hashing out a Hypermount option.
> 
> This would also make it easier to mount media that only have one
> partition. For example, some of my Zip disks have to be mounted as
> "sdb", some as "sdb1", and some as "sdb4", depending on what OS
> formatted it.
> 
> I think this might also be good for multisession CDs, though I'm not
> really sure how they are currently handled.
> 
> > The way it could work is if you mount a full drive say "hdd" and have
> > each partion mounted on a tree from the mount point
> > of the drive.
> 
> This would require mount to check for a partition table first, since
> "hdd" could either mean "hdd as a partitionless device" or "all devices
> on hdd". This check could probably even be done in user space, along
> with "hyper-mount". Maybe someone has done it already; I'll have to
> check freshmeat :)

This looks like a job for a script.  I.e. no kernel change necessary.

The script could go something like this:
1. User invokes with "hypermount sdb" in case of the sdb device
2. The script creates a /mnt/sdb directory
3. The script creates a /mnt/sdb/sdb<n> directory for
   each sdb1, sdb2,... found in /dev
4. /dev/sdb1 is then mounted on /mnt/sdb/sdb1 and so on.

You may also want some checks that the device isn't mounted already,
remove subdirectories that didn't mount (error return from the "mount"
command)

A "hyper-umount sdb" would simply umount every directory under /mnt/sdb/

This isn't really a kernel issue, you may want to discuss this with
distribution
maintainers instead.

Helge Hafting
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
