Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130487AbRCILp3>; Fri, 9 Mar 2001 06:45:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130491AbRCILpJ>; Fri, 9 Mar 2001 06:45:09 -0500
Received: from zooty.lancs.ac.uk ([148.88.16.231]:2493 "EHLO zooty.lancs.ac.uk")
	by vger.kernel.org with ESMTP id <S130487AbRCILpC>;
	Fri, 9 Mar 2001 06:45:02 -0500
Message-Id: <l03130321b6ce6fe21a72@[192.168.239.101]>
In-Reply-To: <Pine.LNX.4.10.10103051957240.778-100000@penguin.transmeta.com>
In-Reply-To: <l03130307b6ca031531fc@[192.168.239.101]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Fri, 9 Mar 2001 11:39:44 +0000
To: Linus Torvalds <torvalds@transmeta.com>
From: Jonathan Morton <chromi@cyberspace.org>
Subject: Re: scsi vs ide performance on fsync's
Cc: Jeremy Hansen <jeremy@xxedgexx.com>, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> It's pretty clear that the IDE drive(r) is *not* waiting for the physical
>> write to take place before returning control to the user program, whereas
>> the SCSI drive(r) is.
>
>This would not be unexpected.
>
>IDE drives generally always do write buffering. I don't even know if you
>_can_ turn it off. So the drive claims to have written the data as soon as
>it has made the write buffer.
>
>It's definitely not the driver, but the actual drive.

As I suspected.  However, testing shows that many drives, including most
IBMs, do respond to hdparm -W0 which turns write-caching off (some drives
don't, including some Seagates).  There are also drives in existence that
have no cache at all (mostly old sub-1G drives) and some with too little
for this to make a significant difference (the old 1.2G TravelStar in one
of my PowerBooks is an example).

So, is there a way to force (the majority of, rather than all) IDE drives
to wait until it's been truly committed to media?  If so, will this be
integrated into the appropriate parts of the kernel, particularly for
certain members of the sync() family and FS unmounting?

--------------------------------------------------------------
from:     Jonathan "Chromatix" Morton
mail:     chromi@cyberspace.org  (not for attachments)
big-mail: chromatix@penguinpowered.com
uni-mail: j.d.morton@lancaster.ac.uk

The key to knowledge is not to rely on people to teach you it.

Get VNC Server for Macintosh from http://www.chromatix.uklinux.net/vnc/

-----BEGIN GEEK CODE BLOCK-----
Version 3.12
GCS$/E/S dpu(!) s:- a20 C+++ UL++ P L+++ E W+ N- o? K? w--- O-- M++$ V? PS
PE- Y+ PGP++ t- 5- X- R !tv b++ DI+++ D G e+ h+ r- y+
-----END GEEK CODE BLOCK-----


