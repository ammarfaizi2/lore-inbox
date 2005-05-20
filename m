Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261582AbVETVRe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261582AbVETVRe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 17:17:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261589AbVETVRe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 17:17:34 -0400
Received: from gannon.phys.uwm.edu ([129.89.61.108]:35506 "EHLO
	gannon.phys.uwm.edu") by vger.kernel.org with ESMTP id S261582AbVETVR2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 17:17:28 -0400
Date: Fri, 20 May 2005 16:17:27 -0500 (CDT)
From: Adam Miller <amiller@gravity.phys.uwm.edu>
X-X-Sender: amiller@gannon.phys.uwm.edu
To: lsorense@csclub.uwaterloo.ca
cc: linux-kernel@vger.kernel.org
Subject: Re: software RAID  (fwd)
Message-ID: <Pine.LNX.4.62.0505201616370.16608@gannon.phys.uwm.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here is a response from Bruce Allen.

>> If you have a bad sector, it doesn't go away by writing to it again.  On
>> modern drives, if you see bad sectors the disk is just about dead, and
>> will probably be seen as such by the raid system which will then stop
>> using the disk entirely and expect you to replace it ASAP.

This is false.

Modern ATA and SCSI disk drives have several thousand spare sectors.
When a sector is unreadable (UNC) which means that the ECC codes are
inconsistent, the drive will REALLOCATE the sector, assigning a spare
sector the LBA of the failed sector.  However it will only do this when
you WRITE to the LBA of the failed sector.

> The one exception here is if you have a miswritten sector (usually
> caused by unexpected power-down), which won't read back correctly -
> but running badblocks with one of the 'write-verify' options will
> resurrect it.

Sectors can have inconsistent ECC codes for a number of reasons:
   -- failed write during sudden power-down
   -- damage to magnetic media at this LBA
   -- other reasons

> If you have a drive that has a bad block in it even *after* badblocks has
> re-written it, it's time to replace the drive *now*....

Not true.  Disks which have reallocated large numbers of blocks are
usually failing. But most good disks have some reallocated blocks.

> For the original poster: Breaking the mirror and then re-mirroring
> from the "good" drive *might* recover the bad block when it re-writes
> it.  But don't bet on it...

It won't 'recover' the bad block.  It will write the data (obtained from
the good drive) to a newly allocated spare sector on the bad drive.

Cheers,
 	Bruce
