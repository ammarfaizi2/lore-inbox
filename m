Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313791AbSDPRub>; Tue, 16 Apr 2002 13:50:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313790AbSDPRua>; Tue, 16 Apr 2002 13:50:30 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:19441 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S313791AbSDPRuQ>; Tue, 16 Apr 2002 13:50:16 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Tue, 16 Apr 2002 11:42:34 -0600
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Vojtech Pavlik <vojtech@suse.cz>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Richard Gooch <rgooch@ras.ucalgary.ca>,
        David Lang <david.lang@digitalinsight.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.8 IDE 36
Message-ID: <20020416174234.GI14783@turbolinux.com>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Vojtech Pavlik <vojtech@suse.cz>,
	Martin Dalecki <dalecki@evision-ventures.com>,
	Richard Gooch <rgooch@ras.ucalgary.ca>,
	David Lang <david.lang@digitalinsight.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <E16xVcT-0000H9-00@the-village.bc.nu> <Pine.LNX.4.33.0204160857470.1244-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 16, 2002  09:01 -0700, Linus Torvalds wrote:
> And I know from personal experience that allowing partitioning of a
> loopback thing would certainly have made some things a _lot_ easier (ie
> not having to figure out the damn offsets in order to mount a filesystem
> on a loopback volume), so having support for partitioning would be good.

This can be done trivially in user-space without breaking any existing
code and without having to enable partitioning of a single loop device.
All that we need to do is take a tool like partx (from util-linux)
to decode the partition table and find the partition offset+size, and then
feed that to losetup (or call the loop setup ioctl directly) for each
partition.  You get a bunch of loop devices set up, one for each partition.

The only thing one might want to have is some option to losetup to list
all of the loop devices currently set up ("losetup -a" or something) so
you can see which loop device corresponds to what disk partition.  Of
course the partx tool would also print that out at setup time, but
people have short memories for this sort of stuff.

> Although I do have this suspicion that that partitioning support should be
> in user space (along with all the rest of the partitioning support, but
> that's another matter and has some rather more serious backwards
> compatibility issues, of course.

The partx tool (and GNU parted as well) _already_ can grok partitions
from user-space and tell the kernel about them (I had set up some
GPT/ia64 partitions on my ia32 box and mounted them just fine).  All
that needs to be done is run this in early setup before we need to
mount the root filesystem.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

