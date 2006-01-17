Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932312AbWAQTft@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932312AbWAQTft (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 14:35:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932411AbWAQTft
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 14:35:49 -0500
Received: from laurel.actlab.utexas.edu ([128.83.194.15]:35985 "EHLO
	laurel.muq.org") by vger.kernel.org with ESMTP id S932312AbWAQTfs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 14:35:48 -0500
From: Cynbe ru Taren <cynbe@muq.org>
To: linux-kernel@vger.kernel.org
Subject: FYI: RAID5 unusably unstable through 2.6.14
Message-Id: <E1EywcM-0004Oz-IE@laurel.muq.org>
Date: Tue, 17 Jan 2006 13:35:46 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Just in case the RAID5 maintainers aren't aware of it:

The current Linux kernel RAID5 implementation is just
too fragile to be used for most of the applications
where it would be most useful.

In principle, RAID5 should allow construction of a
disk-based store which is considerably MORE reliable
than any individual drive.

In my experience, at least, using Linux RAID5 results
in a disk storage system which is considerably LESS
reliable than the underlying drives.

What happens repeatedly, at least in my experience over
a variety of boxes running a variety of 2.4 and 2.6
Linux kernel releases, is that any transient I/O problem
results in a critical mass of RAID5 drives being marked
'failed', at which point there is no longer any supported
way of retrieving the data on the RAID5 device, even
though the underlying drives are all fine, and the underlying
data on those drives almost certainly intact.

This has just happened to me for at least the sixth time,
this time in a brand new RAID5 consisting of 8 200G hotswap
SATA drives backing up the contents of about a dozen onsite
and offsite boxes via dirvish, which took me the better part
of December to get initialized and running, and now two weeks
later I'm back to square one.

I'm currently digging through the md kernel source code
trying to work out some ad-hoc recovery method, but this
level of flakiness just isn't acceptable on systems where
reliable mass storage is a must -- and when else would
one bother with RAID5?

I run a RAID1 mirrored boot and/or root partition on all
the boxes I run RAID5 on -- and lots more as well -- and
RAID1 -does- work as one would hope, providing a disk
store -more- reliable than the underlying drives.  A
Linux RAID1 system will ride out any sort of sequence
of hardware problems, and if the hardware is physically
capable of running at all, the RAID1 system will pop
right back like a cork coming out of white water.

I've NEVER had a RAID1 throw a temper trantrum and go
into apoptosis mode the way RAID5s do given the slightest
opportunity.

We need RAID5 to be equally resilient in the face of
real-world problems, people -- it isn't enough to
just be able to function under ideal lab conditions!

A design bug is -still- a bug, and -still- needs to
get fixed.

Something HAS to be done to make the RAID5 logic
MUCH more conservative about destroying RAID5
systems in response to a transient burst of I/O
errors, before it can in good conscience be declared
ready for production use -- or at MINIMUM to provide
a SUPPORTED way of restoring a butchered RAID5 to
last-known-good configuration or such once transient
hardware issues have been resolved.

There was a time when Unix filesystems disintegrated
on the slightest excuse, requiring guru-level inode
hand-editing to fix.  fsck basically ended that,
allowing any idiot to successfully maintain a unix
filesystem in the face of real-life problems like
power failures and kernel crashes.  Maybe we need
a mdfsck which can fix sick RAID5 subsystems?

In the meantime, IMHO Linux RAID5 should be prominently flagged
EXPERIMENTAL -- NONCRITICAL USE ONLY or some such, to avoid
building up ill-will and undeserved distrust of Linux
software quality generally.

Pending some quantum leap in Linux RAID5 resistance to
collapse, I'm switching to RAID1 everywhere:  Doubling
my diskspace hardware costs is a SMALL price to pay to
avoid weeks of system downtime and rebuild effort annually.
I like to spend my time writing open source, not
rebuilding servers. :)   (Yes, I could become an md
maintainer myself.  But only at the cost of defaulting
on pre-existing open source commitments.  We all have
full plates.)

Anyhow -- kudos to everyone involved:  I've been using
Unix since v7 on PDP-11, Irix since its 68020 days,
and Linux since booting off floppy was mandatory, and
in general I'm happy as a bug in a rug with the fleet
of Debian Linux boxes I manage, with uptimes often exceeding
a year, typically limited only by hardware or software
upgrades -- great work all around, everyone!

Life is Good!

 -- Cynbe



