Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131264AbRCHDpe>; Wed, 7 Mar 2001 22:45:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131265AbRCHDpZ>; Wed, 7 Mar 2001 22:45:25 -0500
Received: from maynard.mail.mindspring.net ([207.69.200.243]:19262 "EHLO
	maynard.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S131264AbRCHDpQ>; Wed, 7 Mar 2001 22:45:16 -0500
Message-ID: <000f01c0a778$6ef862e0$1601a8c0@zeusinc.com>
From: "Tom Sightler" <ttsig@tuxyturvy.com>
To: <jesse@cats-chateau.net>, <linux-kernel@vger.kernel.org>
In-Reply-To: <E14an7j-0001rZ-00@the-village.bc.nu> <20010307164052.B788@wirex.com> <006301c0a765$3ca118e0$1601a8c0@zeusinc.com> <01030720460701.06635@tabby>
Subject: Re: Questions about Enterprise Storage with Linux
Date: Wed, 7 Mar 2001 21:35:24 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >1.  What is the largest block device that linux currently supports?  i.e.
> >Can I create a single 1TB volume on my storage device and expect linux to
> >see it and be able to format it?
>
> Checkout the GFS project for really large filesystems with a high
capability
> of "fail safe" configuration.
>
> The block/file limits are more determined by the size of the hosts.
Alpha/Sparc
> based systems use 64 bit operations, Intel/AMD use 32 bit. It also depends
> on usage of the sign bit in the drivers. Most 32bit systems are limited
> to 1 TB (depending on the driver of course - some allow for 2 TB).

Yes, I should have clarified, we will be using the Intel platform.

A large portion of the fiber channel storage (as much as 300GB in year one)
will be dedicated to an Oracle 8i database, I'm not sure if GFS is truly
suited for this server, although we have considered using LVM (perhaps even
RAWIO on LVM although I see reports of problems with that) to ease some
storage management issues (we've been testing LVM with reiserfs and are very
impressed with the ease of adding space and growing the filesystem live).

> >2.  Does linux have any problems with large (500GB+) NFS exports, how
about
> >large files over NFS?
>
> I can't really say - you might clarify by what you count as large ( just >
2G
> should be fine for any current kernel), not sure if "large" means
25-100GB.

For example if we purchase a NetApp Filer, or EMC Celerra with 1TB of
storage, and elect to export that entire amount as a single NFS mount, and
then use that storage to allow several Linux boxes to share 100GB
(admittedly temporary) files, will Linux handle that, at least in theory?
Basically, I don't know what the file size limits are on NFS (on any system,
not neccesarily just Linux) and was hoping someone could tell me.

And actually, we have looked at GFS as an alternative for this function,
biggest disadvantage is cost of connecting 7 machines via fiber channel (we
already have GigE from the network connectivity), but it does look like an
excellent option which we may very well go with.

And some of these sizes I'm asking about are just seeking the limits, I'll
personally be amazed if we actually approach within half of these sizes any
time soon, but then again, data always manages to grow to fill whatever
storage you have available so I guess you never know, right?

> >3.  What filesystem would be best for such large volumes?  We currently
use
> >reirserfs on our internal system, but they generally have filesystems in
the
> >18-30GB ranges and we're talking about potentially 10-20x that.  Should
we
> >look at JFS/XFS or others?
>
> The GFS project already has tested 2TB in fiber channel array(s) with full
> multi-host connectivity (shared filesystems rather than NFS).
>
> The big advantage with GFS is that redundant servers can be available
> by having two or more NFS servers attached to the same GFS filesystem.

Yep, as I mentioned above, we may very well use GFS here.  It certainly has
some advantages that we really like, but we need to justify the additional
host of HBA's and another fiber channel switch (saying it won't work over
NFS would be enough to justify it).  We also had some concerns of stability
with GFS, not that we know of any issues, but we don't really have an easy
way test it in our current environment, and we haven't ordered the new
equipment yet.

> >4.  We're seriously considering using LVM for volume management.  Does it
> >have size limits per volume or other limitations that we should be aware
of?
>
> GFS may serve better. It is a full shared filesystem with RAID target
disks
> (these are smart controllers) and incudes journaling.

The LVM issue was largely for the managent of the volumes dedicated to the
Oracle database (basically a replacement for Veritas Volume Manager that
Oracle on Solaris folks seem to love).  Once again, we don't think GFS is
really suited for Oracle (other opinions accepted).  I was interrupted a few
too many times when composing the first email, I should have been more
detailed about exactly what we were doing, what we've looked at, etc.

Thanks,
Tom


