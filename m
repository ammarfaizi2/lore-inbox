Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310625AbSCSKqU>; Tue, 19 Mar 2002 05:46:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310632AbSCSKqL>; Tue, 19 Mar 2002 05:46:11 -0500
Received: from 203-109-249-30.ihug.net ([203.109.249.30]:35850 "EHLO
	boags.getsystems.com") by vger.kernel.org with ESMTP
	id <S310625AbSCSKp6>; Tue, 19 Mar 2002 05:45:58 -0500
Date: Tue, 19 Mar 2002 21:45:45 +1100
From: Zenaan Harkness <zen@getsystems.com>
To: linux-kernel@vger.kernel.org
Subject: 
Message-ID: <20020319214545.A29224@getsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Please CC me on replies: not subscribed to list.)

I think that I've discovered that when using the loopback device there
are significant problems with achieving low latency. I'm wondering
whether this is known or if there is something else causing my mp3
dropouts. My test is as follows:

I've been setting up a local debian distribution mirror on my laptop:
DELL Inspiron 8100, 384MB, 60G drive, Radeon Mobility 7500 graphics,
PIII 1GHz, Maestro 3i sound.
Kernel 2.4.18.

To set up my Debian mirror, I'm using apt-move, using apt-move movefile
on each .deb on each of my cd's to get them into my mirror.

The 3rd CD in the set (February 'testing' 8 cds) was thrashing and
taking much longer than the first two - the CD drive sounded like it was
moving the head from inside to outside and back for each file or
something... anyway:

I decided to dd the cd and loopback mount the image. Which I did (ended
up doing this for each of the 8 cds). loop.o is a module.

First I tried the preempt patch combined with lockbreak patch,
configure, rebuild, reboot and then ran my test:

mount /imgN /mnt -o loop,ro
nice find /mnt -type f -name "*.deb"|nice xargs nice apt-move movefile

in parallel with:

nice -n -19 mpg123 some.mp3

Consistently ugly gaps in sound, so I figured the preempt patch may have
some problems at this stage (hand't read anything on it at that point),
so:

Second I tried the andrew k morton lowlatency patch (slightly different
version to kernel available as of today, but patch figured it out).

Ran the above test and had very similar experience. Realised I'd
forgotten to turn on the option in make menuconfig for low latency, so
did so, recompiled again and rebooted ....
BTW, apt-move does a bunch of file related stuff - looking at the files,
then copying the files (from my loopback mounted cd image, to a
partition on my drive).
I had the same results with an image on the same and on different
partition as the destination partition.

So I got a little suspicious and decided to try a test that I read (I
went reading a lot) -> while playing mp3, do:

make clean && make bzImage

This ran flawlessly. At this point I was running with akm lowlat patch.
I can also run an mp3 and swap workspaces, windows, VTs, etc - holding
down the respective 'change' key so that it changes as fast as possible:
never a skip in the slightest. During these tests I'm not doing the
loopback thing.

ta
zen
