Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264433AbTIDAJY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 20:09:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264460AbTIDAJY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 20:09:24 -0400
Received: from dragon.woods.net ([166.70.175.35]:1920 "EHLO c.smtp.woods.net")
	by vger.kernel.org with ESMTP id S264433AbTIDAHx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 20:07:53 -0400
Date: Wed, 3 Sep 2003 18:07:52 -0600 (MDT)
From: Aaron Dewell <acd@woods.net>
To: linux-kernel@vger.kernel.org
Subject: partition weirdness
Message-ID: <Pine.LNX.4.44.0309031758140.385-100000@dragon.woods.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,

I'm having an odd problem with one of my disks.  This disk has been through a lot
in the last week and a half, including being re-written with dd repeatedly (from
an image originally taken by dd), hexedited, etc.  It started in an Ultrasparc,
and now lives in a PC, has a sun disklabel, and has stuff on it that I want from
when it was in the ultra.  The ultra was running 2.4.19-rc1, the PC originally had
the same, has since been upgraded to 2.4.22-ac1.

The problem is this:  the partition table is recognized, but the individual
partitions (the ones I care about) are zero, that is to say, they contain the
right size of zeros.  The disk device itself, at the partition table boundaries,
is not zero, and I can't explain this discrepency.  On the disk, there seem to be
correct and valid superblocks at the right places, they just don't exist in the
partition devices.

i.e. read from /dev/discs/disc2/part4 (or 6 or 7) is all zeros
/dev/discs/disc2/part1 (/) is a valid ext3 filesystem, as is part3 and disc.
part2 was swap, there is stuff in there, but I don't care about it.

Of course, the ones I want the information from is 4, 6, and 7.

A related question:  If I have the dd image of the disk, shouldn't I be able to
cut it at the right places, put that in a new file, and mount that?  i.e. 'mount
-o loop -r filename /mnt', but when I do that, e2fsck says bad magic number in
superblock, however, e2dump -s can read it fine.  (none of the other flags to
e2dump works, however.)  If I can slice up the disk into files and read those,
that works too, so solving either problem is adequate.

Any suggestions?  I appreciate any help.

Thanks!

Aaron


