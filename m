Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269852AbRHIQmh>; Thu, 9 Aug 2001 12:42:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269854AbRHIQm2>; Thu, 9 Aug 2001 12:42:28 -0400
Received: from guestpc.physics.umanitoba.ca ([130.179.72.122]:15620 "EHLO
	mobilix.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S269852AbRHIQmJ>; Thu, 9 Aug 2001 12:42:09 -0400
Date: Thu, 9 Aug 2001 11:35:00 -0500
Message-Id: <200108091635.f79GZ0M02901@mobilix.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Michael Reincke <reincke.m@stn-atlas.de>
Cc: linux-kernel@vger.kernel.org, devfs@oss.sgi.com
Subject: Re: problem: devfs scsi tape permissions
In-Reply-To: <20010808072147.00943ce9.reincke.m@stn-atlas.de>
In-Reply-To: <20010808072147.00943ce9.reincke.m@stn-atlas.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Reincke writes:
> Hi,
> 
> i've some trouble with devfs and the permission on my SCSI-tape drive:
> 
> after a reboot the permissions on /dev/scsi/host0/bus0/target4/lun0 are as
> follows
> drwxr-xr-x    1 root     root            0 Jan  1  1970 lun0/

That's fine.

> A request on the tape-drive as normal user gives a permission denied and
> the permissions on /dev/scsi/host0/bus0/target4/lun0  set to 
> drw-------    1 root     root            0 Jan  1  1970 lun0/

How the hell did that happen? Devfs provides no way for changing the
permissions of a directory from kernel-space. So it looks like you
have a busted devfsd configuration.

> all nodes in lun0 are having the right permissions:
> ls -l /dev/scsi/host0/bus0/target4/lun0/
> 
> total 0
> crw-rw----    1 root     tape       9,   0 Jan  1  1970 mt
> crw-rw----    1 root     tape       9,  96 Jan  1  1970 mta
> crw-rw----    1 root     tape       9, 224 Jan  1  1970 mtan
> crw-rw----    1 root     tape       9,  32 Jan  1  1970 mtl
> crw-rw----    1 root     tape       9, 160 Jan  1  1970 mtln
> crw-rw----    1 root     tape       9,  64 Jan  1  1970 mtm
> crw-rw----    1 root     tape       9, 192 Jan  1  1970 mtmn
> crw-rw----    1 root     tape       9, 128 Jan  1  1970 mtn

Well, that's not the default that the kernel provides. The default is
rw access for everyone. Which even more strongly suggests that the
devfsd config you have is broken.

> So to get the whole thing work i need on /dev/scsi/host0/bus0/target4/lun0
> the following permissions:
> drwxrwx---    1 root     tape            0 Jan  1  1970 lun0
> 
> How could i reach this??  I tried using CFUNCTION 

You shouldn't need to do anything in the first place. My guess is to
fix the broken Debian configuration files. Talk to Russel Coker: he's
the new Debian maintainer. Tell him I sent you :-)

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
