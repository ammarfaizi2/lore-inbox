Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284235AbRLPDmG>; Sat, 15 Dec 2001 22:42:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284237AbRLPDl5>; Sat, 15 Dec 2001 22:41:57 -0500
Received: from [213.97.199.90] ([213.97.199.90]:6016 "HELO fargo")
	by vger.kernel.org with SMTP id <S284235AbRLPDlj> convert rfc822-to-8bit;
	Sat, 15 Dec 2001 22:41:39 -0500
From: "David Gomez" <davidge@jazzfree.com>
Date: Sun, 16 Dec 2001 04:40:58 +0100 (CET)
X-X-Sender: <huma@fargo>
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Copying to loop device hangs up everything
Message-ID: <Pine.LNX.4.33.0112160421170.372-100000@fargo>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I'm using kernel 2.4.17-rc1 and found what i think is a bug, maybe related
to the loop device. This is the situation:

I've created and ext2 image (around 550Mb), and mounted it as loopback.
Then i've tried to copy some files from another ext2 image also mounted in
another loop device, with a 'cp -a'. After some data has been copied, I/O
stopped but the system was still usable, loop, and cp process were in D
state. Loop devices couldn't be umounted, so i rebooted the computer,
e2fsck the images because of the reboot, and tried again to copy the data,
this time successfully.
Next, i had some more data in my root partition to add to the ext2 images,
so i did another cp -a of some directory (around 200mb of data) to the
ext2 image mounted as loop. This time i got a 'full hang' ;), i couldn't
login, a alt+sysrq+t shows that cp and loop were again in D state, and
syncing/umounting with the magic key didn't work at all. I can reproduce
this hang always, copying the data to the mounted loop device.

All the data is in the same disk (hda1), which is an ext2 partition.

Any ideas about what is causing this ?



David Gómez

"The question of whether computers can think is just like the question of
 whether submarines can swim." -- Edsger W. Dijkstra


