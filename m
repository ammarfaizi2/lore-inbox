Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264400AbRFNCIj>; Wed, 13 Jun 2001 22:08:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264402AbRFNCI3>; Wed, 13 Jun 2001 22:08:29 -0400
Received: from dsl-64-192-150-245.telocity.com ([64.192.150.245]:41996 "EHLO
	mail.communicationsboard.net") by vger.kernel.org with ESMTP
	id <S264400AbRFNCIU>; Wed, 13 Jun 2001 22:08:20 -0400
To: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>
Subject: Re: 2.4.6-pre2, pre3 VM Behavior
Message-ID: <992484497.3b281c91ce043@eargle.com>
Date: Wed, 13 Jun 2001 22:08:17 -0400 (EDT)
From: Tom Sightler <ttsig@tuxyturvy.com>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.10.10106140024230.980-100000@coffee.psychology.mcmaster.ca>
In-Reply-To: <Pine.LNX.4.10.10106140024230.980-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: IMP/PHP IMAP webmail program 2.2.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Mark Hahn <hahn@coffee.psychology.mcmaster.ca>:

> > 1.  Transfer of the first 100-150MB is very fast (9.8MB/sec via 100Mb
> Ethernet,
> > close to wire speed).  At this point Linux has yet to write the first
> byte to
> > disk.  OK, this might be an exaggerated, but very little disk activity
> has
> > occured on my laptop.
> 
> right.  it could be that the VM scheduling stuff needs some way to
> tell
> whether the IO system is idle.  that is, if there's no contention for 
> the disk, it might as well be less lazy about writebacks.

That's exactly the way it seems.

> > 2.  Suddenly it's as if Linux says, "Damn, I've got a lot of data to
> flush,
> > maybe I should do that" then the hard drive light comes on solid for
> several
> > seconds.  During this time the ftp transfer drops to about 1/5 of the
> original
> > speed.
> 
> such a dramatic change could be the result of IDE misconfiguration;
> is it safe to assume you have DMA or UDMA enabled?

Yes, UDMA/33 is enabled and working on the drive (using hdparm -d 0 makes the
problem way worse and my drive performs about 1/4 the speed).

> > This was much less noticeable on a server with a much faster SCSI hard
> disk
> > subsystem as it took significantly less time to flush the information
> to the
> 
> is the SCSI disk actually faster (unlikley, for modern disks), or 
> is the SCSI controller simply busmastering, like DMA/UDMA IDE,
> but wholly unlike PIO-mode IDE?

First, lets be fair, we're comparing a UDMA/33 IDE drive in a 1 year old laptop
(IBM Travelstar, if your interested) to a true SCSI Disk Subsystem with
mirrored/striped Ultra160 SCSI disk connected via 64bit PCI/66Mhz bus, so yes,
the SCSI subsystem is MUCH faster.  Specific numbers:

Laptop with TravelStar IDE HD Max sustained read: 16.5MB/s
Server with Ultra160 SCSI disk array Max sustained read: >100MB/s

That's a big difference.  The Travelstar is probably only 5400RPM and is
optimized for power savings, not speed, the SCSI subsystem has multiple 15000RPM
in a striped/mirrored configuration for speed.

Later,
Tom

