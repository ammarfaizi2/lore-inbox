Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131661AbRAPQyk>; Tue, 16 Jan 2001 11:54:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131745AbRAPQya>; Tue, 16 Jan 2001 11:54:30 -0500
Received: from host194.steeleye.com ([216.33.1.194]:56071 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S131661AbRAPQyX>; Tue, 16 Jan 2001 11:54:23 -0500
Message-Id: <200101161653.f0GGrl101735@aslan.sc.steeleye.com>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: Venkatesh Ramamurthy <Venkateshr@ami.com>
cc: "'arjan@fenrus.demon.nl'" <arjan@fenrus.demon.nl>,
        linux-kernel@vger.kernel.org,
        "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>
Subject: Re: Linux not adhering to BIOS Drive boot order? 
In-Reply-To: Message from Venkatesh Ramamurthy <Venkateshr@ami.com> 
   of "Tue, 16 Jan 2001 11:31:25 EST." <1355693A51C0D211B55A00105ACCFE64E9518F@ATL_MS1> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 16 Jan 2001 11:53:47 -0500
From: Eddie Williams <Eddie.Williams@steeleye.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Why is this a SCSI ML problem?  The problem is that the OS can't figure out 
where to mount root from.  Sounds like an OS problem.

I think the file system label is the leading candidate to solve this.  One 
really does not care if the root disk is called /dev/sda or /dev/fred.  All 
one cares is that you can boot your system and the right disks are mounted.  
What I have seen so far with the fs label this either does solve this today or 
it can solve this.  I notice today on some systems the entries in /etc/fstab 
already are "deviceless" in that it does not have the disk/partition but 
simply the disk label.

Can lilo use a label for the root disk also?  I have not looked into that yet. 
 If it does not can it?  When I noticed the use of the label in /etc/fstab my 
first thought was "alright, someone is solving this problem."  I have not 
taken the time - not a burning issue with me right now - to see if this is all 
done yet though.

Keep in mind that the example where /dev/sda is where root lies is that "easy" 
case.  The hard case is what happens if someone installs on /dev/sdg.  Now 
they boot up with a disk array turned off.  Is the mid-layer going to figure 
out that what is now /dev/sda suppose to be /dev/sdg?  Or they install to 
/dev/sdb and /dev/sda goes bad so they pull it out?

Eddie 
> > In article <1355693A51C0D211B55A00105ACCFE64E9518C@ATL_MS1> you wrote:
> > 
> > > we need some kind of signature being written in the drive, which the
> > kernel
> > > will use for determining the boot drive and later re-order drives, if
> > > required.
> > 
> > Like the ext2 labels? (man e2label)
> 	[Venkatesh Ramamurthy]  This re-ordering of the scsi drives should
> be done by SCSI ML , so is incorporating ext2 fs data structure knowledge on
> the SCSI ML a good idea?. 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-scsi" in
> the body of a message to majordomo@vger.kernel.org


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
