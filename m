Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313860AbSDJVkb>; Wed, 10 Apr 2002 17:40:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313861AbSDJVka>; Wed, 10 Apr 2002 17:40:30 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:46211 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S313860AbSDJVk3>; Wed, 10 Apr 2002 17:40:29 -0400
Date: Wed, 10 Apr 2002 15:39:09 -0600
Message-Id: <200204102139.g3ALd9m15133@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: Andreas Dilger <adilger@clusterfs.com>, linux-kernel@vger.kernel.org
Subject: Re: RAID superblock confusion
In-Reply-To: <20020410213645.GE23513@matchmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Fedyk writes:
> On Wed, Apr 10, 2002 at 02:37:48PM -0600, Richard Gooch wrote:
> > Andreas Dilger writes:
> > > On Apr 10, 2002  13:24 -0600, Richard Gooch wrote:
> > > > Andreas Dilger writes:
> > > > > On Apr 10, 2002  09:33 -0600, Richard Gooch wrote:
> > > > > > Even though I'm using persistent superblockss, which is supposed to
> > > > > > allow one to move devices from one controller to another, I can't
> > > > > > use my RAID) set in this configuration. Looks like a bug.
> > > > > > 
> > > > > > md0: former device scsi/host2/bus0/target1/lun0/part2 is unavailable,
> > > > > >      removing from array!
> > > > > > md: md0, array needs 6 disks, has 5, aborting.
> > > > > 
> > > > > Note that this appears to be your real problem.
> > > > 
> > > > No. I tested all 6 partitions used in the RAID set. They are all
> > > > available.
> > > 
> > > Well, MD seems to think it is unavailable...  I would check the
> > > codepath that generates this message and see why it is happening.
> > > Maybe it is a timing issue or something, that MD autostart is
> > > starting before this device is set up or something?  I don't know.
> > 
> > The device is set up (i.e. SCSI host driver is loaded) long before I
> > do raidstart /dev/md/0
> 
> But kernel auto-detection doesn't depend on the raidstart command.  If
> things are setup correctly, you can remove that from your init scripts.

I'm not (explicitely) using auto-detection. When I insmod the raid0
module, there are no messages about finding devices. All I get is:
md: raid0 personality registered as nr 2

Only when I run raidstart do I get kernel messages about the devices.

In any case, I should be able to move my devices around (especially
if /etc/raidtab is still correct), whether or not autostart is
running. The behaviour I'm observing is a bug (I assume it's not a
mis-feature, since the raidstart man page tells me that moving devices
around should be safe).

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
