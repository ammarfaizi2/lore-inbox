Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265084AbUGCMpc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265084AbUGCMpc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jul 2004 08:45:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265086AbUGCMpc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jul 2004 08:45:32 -0400
Received: from mail017.syd.optusnet.com.au ([211.29.132.168]:40150 "EHLO
	mail017.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S265084AbUGCMpa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jul 2004 08:45:30 -0400
Date: Sat, 3 Jul 2004 22:44:35 +1000
From: Andrew Clausen <clausen@gnu.org>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: "Patrick J. LoPresti" <patl@users.sourceforge.net>,
       Szakacsits Szabolcs <szaka@sienet.hu>,
       Andries Brouwer <Andries.Brouwer@cwi.nl>,
       Steffen Winterfeldt <snwint@suse.de>, linux-kernel@vger.kernel.org,
       Thomas Fehr <fehr@suse.de>, bug-parted@gnu.org
Subject: Re: [RFC] Restoring HDIO_GETGEO semantics (was: Re: workaround for BIOS / CHS stuff)
Message-ID: <20040703124435.GH630@gnu.org>
References: <Pine.LNX.4.21.0407021936550.30622-100000@mlf.linux.rulez.org> <s5gzn6iz2or.fsf@patl=users.sf.net> <20040703025457.GC630@gnu.org> <Pine.LNX.4.60.0407030843400.2415@hermes-1.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.60.0407030843400.2415@hermes-1.csi.cam.ac.uk>
X-Accept-Language: en,pt
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 03, 2004 at 08:53:39AM +0100, Anton Altaparmakov wrote:
> On Sat, 3 Jul 2004, Andrew Clausen wrote:
> > In any case, I don't have any evidence that anything is wrong.  On my
> > computer, I can tell the BIOS to use CHS geometry, (as opposed to
> > "Auto", "LBA" or "Large") modify the partition table to set the CHS
> > start/end of the Windows partition to 0, 1024, or anything I like, and
> > Windows STILL works.  I can't get anything to break!
> 
> Which version of Windows?

XP home edition (the green box)

> Does it use NTFS as both the boot and system drive?

I am using a single NTFS partition.

Note: I reversed-engineered the Windows FAT bootstrap code.  My analysis
is contained in the file doc/FAT in the Parted source distribution.  I
concluded that Windows uses LBA if the LBA flag is set in the boot
partition table entry.  (i.e. the partition type includes LBA in the
fdisk codes - this corresponds to a bit being set)

> > So, can anyone break Windows?
> 
> Easily.  Modify any of the relevant values in the NTFS bootsector and 
> windows will no longer boot.  So it clearly cares hugely about the 
> geometry.  And at present there is no easy way for us to tell what it is 
> so mkntfs and ntfsclone cannot create bootable partitions on 2.6 kernels.  
> (Works fine on 2.4 using HDIO_GETGEO.)
> 
> The relevant fields are (see linux/fs/ntfs/layout.h or 
> ntfsprogs/include/ntfs/layout.h) in the NTFS_BOOT_SECTOR in the 
> BIOS_PARAMETER_BLOCK:
> 
> u16 sectors_per_track; /* Required to boot Windows. */
> u16 heads;             /* Required to boot Windows. */
> u32 hidden_sectors;    /* Offset to the start of the partition relative 
> to the disk in sectors.  Required to boot Windows. */

I just set the first 2 of these fields to 0, and everything still works.
Am I blessed?  (Or perhaps cursed!)

Isn't hidden_sectors an LBA value (and hence irrelevant to this discussion)?

Cheers,
Andrew

