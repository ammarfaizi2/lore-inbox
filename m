Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263659AbRFGXJQ>; Thu, 7 Jun 2001 19:09:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263673AbRFGXJH>; Thu, 7 Jun 2001 19:09:07 -0400
Received: from mail2.aracnet.com ([216.99.193.35]:53767 "EHLO
	mail2.aracnet.com") by vger.kernel.org with ESMTP
	id <S263659AbRFGXJD>; Thu, 7 Jun 2001 19:09:03 -0400
Date: Thu, 7 Jun 2001 16:09:01 -0700 (PDT)
From: Paul Buder <paulb@aracnet.com>
To: <linux-kernel@vger.kernel.org>
Subject: Large ramdisk crashes system
Message-ID: <Pine.LNX.4.33.0106071607180.3940-100000@shell1.aracnet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am trying to create a system which boots off of a cd and has no hard
disks.  So it needs ramdisks.  But I haven't had much luck creating
large ones.

I tried on two different boxes.  In both cases the kernel is 2.4.5 with
'Simple RAM-based file system support' turned on.

One box is a dual Pentium 750 with a gig of ram in it.  I had the
kernel 'Default RAM disk size' set to 800000 for this box.  I issued
the following commands.

mkfs /dev/ram0 400000
mount /dev/ram0 /mnt
dd if=/dev/zero of=/mnt/junk bs=1024 count=500000

This is fine, dd creates a 400 meg file, reports there isn't enough
space and exits.  But if I change the first line to

mkfs /dev/ram0 500000

I'm essentially crashed.  I can ping the box and switch between virtual
terminals but that's it.  Any program that was running on the other
virtual terminals is frozen (as in top, tail, login).  The dd is frozen
and can't be control-c'd.  so I can't do anything other than powercycle.
I should have at least 400 megs of ram left for the system so I don't
get it.

I tried the same thing on a 128 meg box.  The results were similar.  A 40
meg ram disk worked.  A 60 meg ram disk crashed the box.  The numbers
seem a little odd since in both cases the magic threshold seems to be
roughly 40% of ram.

I get no messages in the system logfiles nor an oops on the screen.

Any ideas?

