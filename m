Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290229AbSBSVQf>; Tue, 19 Feb 2002 16:16:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290236AbSBSVQZ>; Tue, 19 Feb 2002 16:16:25 -0500
Received: from h24-67-15-4.cg.shawcable.net ([24.67.15.4]:51187 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S290229AbSBSVQR>;
	Tue, 19 Feb 2002 16:16:17 -0500
Date: Tue, 19 Feb 2002 14:15:38 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Joao Guimaraes da Costa <guima@huhepl.harvard.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: e2fsck compatibility problem with 2.4.17?
Message-ID: <20020219141538.G25713@lynx.adilger.int>
Mail-Followup-To: Joao Guimaraes da Costa <guima@huhepl.harvard.edu>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3C725D1C.3060001@huhepl.harvard.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C725D1C.3060001@huhepl.harvard.edu>; from guima@huhepl.harvard.edu on Tue, Feb 19, 2002 at 08:11:40AM -0600
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 19, 2002  08:11 -0600, Joao Guimaraes da Costa wrote:
> I am having a problem that might be due to an incompatibility between
> e2fsck and kernel 2.4.17.
> 
> My machine has a redhat kernel 2.4.3-12 and a kernel 2.4.17 I have 
> recently built from source.
> 
> While doing a routine filesystem check at boot time (running kernel 
> 2.4.17), e2fsck found a problem with one of the partitions (I am using 
> e2fsck 1.25 from the redhat rawhide rpm  e2fsprogs-1.25-2.i386.rpm).
> 
> I decided not to fix the problem and checked it with a different kernel
> and version 1.19 of e2fsck. In both cases, the partition was clean.
> 
> So, I get:
> 
> kernel     e2fsck    result
> 2.4.17      1.25     problem
> 2.4.3-12    1.25      OK
> 2.4.3-12    1.19      OK
> 
> Are there any know incompatibilities between kernel 2.4.17 and e2fsck
> 1.25? Right now, I am not sure if the filesystem is damaged or not!
> 
> The error I get is the following:
> 1) e2fsck gets stuck after only checking 2.5% of the partition. It stays
>    there for about 5 minutes doing clik-clak noises until starting giving
> errors
> 2) First error is:
> Block 32783 - 32791 (attempt to read block from filesystem resulted in
> short read) while doing inode scan.
> 3) Then in Pass 2:
> resources in /src/linux-2.4.3/drivers/acpi (1894) has deleted/unused
> inode 16435.

Well, this clik-clak noise sounds like a hardware problem.  I don't know
why it would only show up under 2.4.17 and not 2.4.3.

Can you try "dd if=/dev/hdX of=/dev/null bs=4k" to see if this completes
under both kernels?  Any messages in 'dmesg' that look like IDE errors?

The one thing I also thought of was that kernels 2.4.10+ have the block
devices in page cache, and some people have problems with ulimits when
reading >2GB from the device, but that wouldn't affect block 32783...

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

