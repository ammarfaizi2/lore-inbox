Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293276AbSDMT0X>; Sat, 13 Apr 2002 15:26:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293596AbSDMT0X>; Sat, 13 Apr 2002 15:26:23 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:20107 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S293276AbSDMT0W>; Sat, 13 Apr 2002 15:26:22 -0400
Date: Sat, 13 Apr 2002 13:26:16 -0600
Message-Id: <200204131926.g3DJQGI06532@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Andreas Dilger <adilger@clusterfs.com>, linux-kernel@vger.kernel.org
Subject: Re: RAID superblock confusion
In-Reply-To: <15540.59659.114876.390224@notabene.cse.unsw.edu.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown writes:
> On Wednesday April 10, rgooch@ras.ucalgary.ca wrote:
> > 
> > The device is set up (i.e. SCSI host driver is loaded) long before I
> > do raidstart /dev/md/0
> 
> raidstart simply does not and cannot work reliably when your device
> numbers change around.  It takes the first device listed in
> /etc/raidtab and gives it to the kernel.
> The kernel reads the superblock, finds some device numbers and tries
> to attach those devices.  If device number have changed, you loose.

Sounds to me like the flaw is in the ioctl(2) interface, in that it
doesn't allow passing all the block devices in the RAID set. If it
allowed you to pass all the block devices, then it could check if all
the signatures on each block device match.

I tried the alternative of setting persistent-superblock=0 in
/etc/raidtab, but the stupid thing complained because it found a
superblock. Sigh.

If there was only a "do as I say, regardless" mode, I would be happy.
This programmer-knows-best attitude smacks of M$.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
