Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129780AbRAPVTZ>; Tue, 16 Jan 2001 16:19:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129789AbRAPVTQ>; Tue, 16 Jan 2001 16:19:16 -0500
Received: from [24.65.192.120] ([24.65.192.120]:21752 "EHLO webber.adilger.net")
	by vger.kernel.org with ESMTP id <S129780AbRAPVS5>;
	Tue, 16 Jan 2001 16:18:57 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200101162118.f0GLIRL14159@webber.adilger.net>
Subject: Re: Linux not adhering to BIOS Drive boot order?
In-Reply-To: <Pine.LNX.4.21.0101161221530.17397-100000@sol.compendium-tech.com>
 "from Dr. Kelsey Hudson at Jan 16, 2001 12:30:34 pm"
To: "Dr. Kelsey Hudson" <kernel@blackhole.compendium-tech.com>
Date: Tue, 16 Jan 2001 14:18:26 -0700 (MST)
CC: Venkatesh Ramamurthy <Venkateshr@ami.com>,
        "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
X-Mailer: ELM [version 2.4ME+ PL73 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kelsey Hudson writes:
> however, this brings up an interesting question: what happens if two disks
> (presumably from two different machines) have the same disk label? what
> happens then? for instance, i have several linux machines both at my
> workplace and my home. if for some reason one of these machines dies due
> to hardware failure and i want to get stuff off the drives, i put the disk
> containing the /home partition on the failed machine into a working
> machine and reboot. What /home gets mounted then? the original /home or
> the new one from the dead machine? (and don't say end users wouldn't
> possibly do that... if they are adding hardware into their systems this is
> by no means beyond their capabilities)

Don't do that (tm).  You may still have that problem (or even all filesystems
being mounted wrong) if you add a new drive to a SCSI chain.  Likewise if
you add an IDE controller, the controllers may be numbered differently...

> at least with physical device nodes i can say 'computer, you will mount
> this partition on this mountpoint!' and be done with it.

If you use a UUID, you will never have conflicts (unless you do drive
imaging, which is bad).  The label is just a lot more convenient to use
than the UUID.

> so tell me then, how would one discern between two partitions with the
> same label?

It will pick the first one found, I guess.  However, this still reduces
the problem of drive renaming by 99%.  It goes from "each time drives
are added/moved/removed my system may be broken" to "if I insert two
drives with the same label 50% chance my system is broken".  I'll take
the latter any day.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
