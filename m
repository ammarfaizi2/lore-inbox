Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261486AbTJ2Tgu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 14:36:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261492AbTJ2Tgu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 14:36:50 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:3594
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S261486AbTJ2Tgs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 14:36:48 -0500
Date: Wed, 29 Oct 2003 11:36:46 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: linux-kernel@vger.kernel.org
Cc: ext3-users@redhat.com
Subject: Possible to recover this Raid 5 Array?
Message-ID: <20031029193646.GA18778@matchmail.com>
Mail-Followup-To: linux-kernel@vger.kernel.org, ext3-users@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a 3x160GB linux md raid5 array with ext3 that is having some problems
(to put it lightly).

One drive failed, and I set out yesterday to replace it with a new drive.

The drive that failed (started getting bad blocks (about 100
of them so far according to smartctl -a) was also the boot drive (even
though /boot was on a raid1)), so I booted into knoppix to rerun lilo on the
drive to make it bootable.

I re-assembled the array with mdadm, and set out to chroot into the array to
run lilo, but started getting some filesystem errors.

Ran fsck on the filesystem, and it found some errors (a lot!), so thought it
might be good to log the output, so I canceled the fsck (maybe not a good
idea), mounted a nfs volume (knoppix has some troubles with rpciod, but if
you kill it, you get a working nfs mount -- strange but works -- haven't
reported it to knoppix yet though), and ran fsck -yf /dev/md0 > nfs mount
2>&1. (the last run out of about 4 is attached & compressed)

While that was happening, I started thinking about the array, and checked
the disk that I replaced (mdadm -E), and found out that I replaced the wrong
drive!  I immediately canceled the fsck that was running.

The fsck was running on a degraded raid5 array with one drive that has
current data, and one drive that was failed out of the array over two weeks
ago!

Now I have the two good drives put together in a degraded array, and luckily
I'm able to mount the beast, and am able to read a surprising amount of data
(it takes a long time to fully fsck 300GB, so it wasn't able to get to the
entire filesystem with the old disk in the array before I canceled it)

The array was about 10% full when this happened.

I'm checking what I can recover, but my home directory was on there, and I
only had partial backups.  I have restored what was in the backups, but a
lot of files I hoped were backed up weren't.

Is there some miracle that can be performed on with this?
