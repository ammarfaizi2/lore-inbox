Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315440AbSFTUHe>; Thu, 20 Jun 2002 16:07:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314748AbSFTUHd>; Thu, 20 Jun 2002 16:07:33 -0400
Received: from waste.org ([209.173.204.2]:49845 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S315440AbSFTUHb>;
	Thu, 20 Jun 2002 16:07:31 -0400
Date: Thu, 20 Jun 2002 15:06:55 -0500 (CDT)
From: Oliver Xymoron <oxymoron@waste.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: James Bottomley <James.Bottomley@steeleye.com>,
       Patrick Mansfield <patmans@us.ibm.com>,
       Andries Brouwer <aebr@win.tue.nl>, Martin Schwenke <martin@meltin.net>,
       Kurt Garloff <garloff@suse.de>,
       Linux kernel list <linux-kernel@vger.kernel.org>,
       Linux SCSI list <linux-scsi@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>
Subject: Re: [PATCH] /proc/scsi/map 
In-Reply-To: <Pine.LNX.4.44.0206201210420.8225-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0206201442060.16808-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Jun 2002, Linus Torvalds wrote:

> On Thu, 20 Jun 2002, James Bottomley wrote:
> >
> > We should probably have some more discussion about the layout of the device
> > tree, particularly if it's going to be consistent with other devices like ide
> > discs and cds.
>
> Absolutely. I suspect that the _real_ issues start coming up only once
> people start using this for useful work, and we should just accept that
> the format (for now) is in flux. But that doesn't mean that we shouldn't
> try to make it reasonably sane from the very start.
>
> And make sure that the naming convention works for both IDE and SCSI (ie
> there should be a way to figure out _portably_ whether a device is a disk
> or CD-RW or whatever, without even knowing whether it's SCSI or IDE).

There are other device classes beyond disks we need to do similar things
with that we ought to figure out at the same time. Examples off the top of
my head: disk (disk? cdaudio? dvd? cdrw?), sound (wave table? 3d?), v4l
(tuner? radio? mpeg?), net (wireless?).

One possibility is an "interfaces" file that lists the types of interfaces
that a device supports, possibly along with major:minor for that
interface. Then you can do find /devices -name interfaces | xargs grep
disk to locate your disks..

Another general question is how to fit "virtual" devices that aren't
associated with a bus into this scheme. For instance, PPP, VPNs, loopback
block devices, ramdisks, iSCSI, NBD. While you might argue that most of
these aren't really devices, iSCSI is every bit as "real" as a "local" FC
disk. And then you get into logical devices ala LVM and RAID..

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

