Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311570AbSCXFRM>; Sun, 24 Mar 2002 00:17:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311565AbSCXFRD>; Sun, 24 Mar 2002 00:17:03 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:32772
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S311564AbSCXFQ5>; Sun, 24 Mar 2002 00:16:57 -0500
Date: Sat, 23 Mar 2002 21:16:35 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Douglas Gilbert <dougg@torque.net>
cc: Pete Zaitcev <zaitcev@redhat.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Patch to split kmalloc in sd.c in 2.4.18+
In-Reply-To: <3C9D5219.1403288B@torque.net>
Message-ID: <Pine.LNX.4.10.10203232101420.2377-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Mar 2002, Douglas Gilbert wrote:

> Your patch worked ok for me. I have a couple of real
> disks and 120 simulated ones with scsi_debug. My last disk
> was /dev/sddq and I was able to fdisk, mke2fs, mount
> and copy files to it ok.
> 
> 
> I had a look at ide-disk.c (lk 2.4.19-pre4) and it
> looks remarkably clean compared to sd.c . It seems
> to warrant further study.
> 
> Doug Gilbert

WOW, that is the first compliment I have ever heard about my work from
another storage expert.  Doug if I could have a minute to make a
suggestion about the ./drivers/scsi/, would you concider making sg.c into
the core transport layer for the subsystem?  This would be similar to what
I am doing in ./drivers/ide with ide-taskfile.c.  Where as mine intial
migration will cover all "ATA" commands, but there are ZERO real state
machine engines for ATAPI.  I have considered and still looking at the
scope of pkt-taskfile.c as a generic transport layer for all atapi but
mating all the various standards into one is ugly.  I would prefer to
provide an ASPI layer between ATA/SCSI and work with you to create real
personality extentions.

sd.c direct		sane			ide-disk.c
sr.c optical/rom	more sg'ish		ide-cd.c/ide-floppy.c
st.c stream		noise makes from hell.	ide-tape.c

My goal is to force the personalities in ata/atapi to deal with their own
errors and destroy the mainloop error thread/jungle.  Also export to the
personality cores their own request and completion mappings.

I think similar things could be done in SCSI vi SG, then close up some of
the goofiness we both have (me more so) on HBA or OBHA (onboard).

Comments?

Cheers,

Andre Hedrick
LAD Storage Consulting Group

PS: I already popped the balloon head so no need to get out the voodoo dolls.

