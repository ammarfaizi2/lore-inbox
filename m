Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751373AbWBPDGP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751373AbWBPDGP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 22:06:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751374AbWBPDGP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 22:06:15 -0500
Received: from mxsf23.cluster1.charter.net ([209.225.28.223]:65442 "EHLO
	mxsf23.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S1751373AbWBPDGP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 22:06:15 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17395.60448.356879.548491@smtp.charter.net>
Date: Wed, 15 Feb 2006 22:06:08 -0500
From: "John Stoffel" <john@stoffel.org>
To: Rob Landley <rob@landley.net>
Cc: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>,
       Matthias Andree <matthias.andree@gmx.de>,
       Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
In-Reply-To: <200602151409.41523.rob@landley.net>
References: <5a2cf1f60602130407j79805b8al55fe999426d90b97@mail.gmail.com>
	<200602142155.03407.rob@landley.net>
	<20060215183115.GE29940@csclub.uwaterloo.ca>
	<200602151409.41523.rob@landley.net>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Rob" == Rob Landley <rob@landley.net> writes:

Rob> Yup.  Apparently with SAS, the controllers are far more likely to
Rob> fail than the drives.

While a single drive is more likely to fail when compared to a single
controller, for a truly redundant system you want no single point of
failure, which means redundant controllers is a requirement.

>> Makes redundant systems much simpler to build if you can connect
>> each physical drive to two places at once.

Rob> Or you could use raid and get complete redundancy rather than two
Rob> paths to the same single point of failure.  Your choice.

Excuse me?  Think about what you just wrote here and what you're
implying.  

Of course you would use RAID here, along with two controllers and two
paths to the single disk.  But you'd also have multiple disks here as
well.  Not a single disk and two controllers and consider that
reliable.  

>> They support port expanders (which SATA seems to be starting to
>> support although more limited).

Rob> I still don't see why drives are expected to be more reliable
Rob> than controllers.

He never said they were. 

Rob> I think the most paranoid setup I've seen was six disks holding
Rob> two disks worth of information.  A three way raid-5, mirrored.
Rob> It could lose any three disks out of the group, and several 4
Rob> disk combinations.  If six SATA drives are cheaper than two SAS
Rob> drives.  (Yeah, the CRC calculation eats CPU and flushes your
Rob> cache.  So what?)

And how many controllers could that setup lose?  You need to think of
the whole path, not just the disks at the ends, when you are planning
for reliability (and performance as well).  

Also, with dual ports on a drive, it becomes much easier to build two
machine clusters which both can see all the drives shared between the
clusters.  Just like SCSI (old, original 5MB/S scsi) where you changed
hte ID of one of the initiators.  Not done frequently, but certainly
done alot with VMS/VAX clusters.

Rob> I keep thinking there should be something more useful you could
Rob> do than "hot spare" with extra disks in simple RAID 5, some way
Rob> of dynamically scaling more parity info.  But it's not an area I
Rob> play in much...

RAID6, or as NetApp calls it, Dual Parity.  You can lose any TWO disks
in a raid group and still be working.  It covers to more common single
disk fails, and then you still have full parity coverage if another
disk fails during the re-build of the parity info onto the spare
drive.  

With 250Gb disks, that run a 50MB/S, it takes a LONG time to actually
sweep though all the data and rebuild the parity.  24 hours or more.
So to cover your butt, you'd like to have even more redundancy.

I've run fully mirrored servers, where I had redundant paths to each
disk from each controller.  When I lost a controller, which certainly
happened, I didn't lose any data, nor disk I lose mirroring either.
Very nice.

In the situtations where I only had one controller per set of disks,
and mirrored between controlles, losing a controller meant I had to
re-mirror things once they got running again, but I didn't lose data.
Very nice.

Building reliable disk storage is not cheap.  Fast, reliable, cheap.
Pick any two.  :]

John
