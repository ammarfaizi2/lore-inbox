Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S131626AbRC1TG3>; Wed, 28 Mar 2001 14:06:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S132003AbRC1TGU>; Wed, 28 Mar 2001 14:06:20 -0500
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:5963 "EHLO tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP id <S131626AbRC1TGK>; Wed, 28 Mar 2001 14:06:10 -0500
Date: Wed, 28 Mar 2001 13:05:25 -0600 (CST)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200103281905.NAA41794@tomcat.admin.navo.hpc.mil>
To: Oliver.Neukum@lrz.uni-muenchen.de, jesse@cats-chateau.net
Subject: Re: Larger dev_t
In-Reply-To: <01032820130006.01508@idun>
Cc: linux-kernel@vger.kernel.org
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de>:
> 
> > My suggestion would be to add a filesystem label (optional) to the
> > homeblock of all filesystmes, then load that identifier into the
> > /proc/partitions file. This would allow a search to locate the
> > device parameters for any filesystem being mounted. If the label
> > is unavailable, then it must be mounted manually or via the current
> > structure. This would work for floppy/CD/DVD (although SCSI versions
> > would have a relocation problem for these devices).
> 
> And what would you do if the names collide ?

refuse to mount - give the admin time to fix them in single user mode
changing a volumn name only should not be prevented. How to fix... let
the admin look in the /proc/partitions, take one (I'd pick the second
one seen) and change its name. Mount the first using the devfs associated
name and verify that the contents are what is expected. Mount the second
and see what it should be. This situation should only occur via a dd copy
of an entire volumn; the procedure on copying should include changing the
copied volumn name... This is almost equivalent to having multiple mirror
partitions, in which case a "mount the first seen" would be reasonable.

> This might work for drives with unique identifiers in hardware, but for 
> anything else it is a nice addition, but I wouldn't identify an essential 
> partition that way. Furthermore you need to address removable media. There a 
> way to specify a drive opposed to a filesystem or medium is needed.

I didn't mean to say that there should be NO way to reach a specific drive.
There should be a devfs entry that corresponds to the entries in the
/proc/partitions list. This is what I think mount should do anyway.
First search the /proc/partitions list for the volumn; then use the
associated entry in devfs to actually do the mount. It's just a way
to allow the reorganization of volume to device name mapping.

I'm still thinking about how the root filesystem could be mounted during
boot where devfs and /proc are not yet mounted.

There should be a similar way to map removable media devices (even if it
takes using device serial numbers) to fixed device names. That way a
symbolic link could be created to point to the correct physical device:

ie: I want my SCSI tape drive (serial number 06408-XXX) to be called "tape" 

locate the serial number in /proc/scsi/scsi. use devfs name that
corresponds to this device (scsi2/target 6/lun/00 or similar) and
create a symbolic link for it. This does assume that the serial number or
equivalent is available to be searched for. It also assumes that the
devfs name can be derived from the entry in /proc/scsi/scsi (or where ever
the specification ends up).

Is this reasonable? Perhaps not for small systems, but when lots of dynamic
devices are available it is needed

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
