Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284180AbSBITIF>; Sat, 9 Feb 2002 14:08:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284933AbSBITHz>; Sat, 9 Feb 2002 14:07:55 -0500
Received: from mtiwmhc21.worldnet.att.net ([204.127.131.46]:57806 "EHLO
	mtiwmhc21.worldnet.att.net") by vger.kernel.org with ESMTP
	id <S284180AbSBITHn>; Sat, 9 Feb 2002 14:07:43 -0500
Date: Sat, 9 Feb 2002 11:06:20 -0800
From: "Luis A. Montes" <lmontes@worldnet.att.net>
To: linux-kernel@vger.kernel.org
Cc: andre@linuxdiskcert.org, axboe@suse.de
Subject: Re: 2.4.17 filesystem corruption
Message-ID: <20020209110620.A247@penguin.montes2.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.2.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, I have been testing different kernels and filesystems in my
system lately. To recap, my system is a ECS mobo with the SiS 735
chipset, Athlon CPU, pc133 memory and IDE caviar hd. The problem is
that the kernel 2.4.17 produces massive filesystem corruption. Things
I have been able to eliminate as sources of the problem:

- Memory/CPU: ran memtest86, several full passes, without a problem. I'm
   not overclocking. It's also been stable with other kernels.

- CPU optimization in the kernel: Corruption has happened with i386, K6
   and K7 optimization, and stable kernels have had K7 enabled without
   problem.

- filesystem: I've tried XFS-only systems, mixtures of XFS and ext2 and
   ext2-only systems with identical results.

- I've got a second hd plugged in the system, and I did wonder whether
   it could be the problem as it happens to be on the black list, but
   again whether I have or not connected doesn't seem to change things.

- My harddrive itself. Passes Western Digital test, so there doesn't seem
   to be anything physically wrong with it. And it's worked fine with
   other kernels.

After more test during this week, I think I have something close to a
smoking gun: Compiled a 2.4.5 and a 2.4.17 kernel with identical config
files. Ran 2.4.5 during about 24 hours with continous i/o (compiling
kernels and XFree86), and the filesystem survived. Ran 2.4.17 and it
crashed within the first hour. In either case I didn't use hdparm to
change anything, the hdparms where as they are set by default, everything
off. Again, keeping identical config file I compiled 2.4.17 changing only
the drivers/ide/sis5513.c file as per Lionel Bouton's patch. The system
has been running for a week now with my normal load, compiling lots of
stuff. I still didn't want to turn on dma (this is my workstation, I need
to have it mostly up!). Then I did try the exact same kernel but I did 
enable dma with hdparm -c 1 -d 1 -m 8 and ran the same test I did for the 
other kernels, and it didn't crash (ran for about 12 hours fine). I'll 
probably test it longer before using it in my good partitions, but I'm
confindent it will survive, crashes usually occurred within the first
hour.

Conclusion: It seems to me that something within sis5513.c got broken
between 2.4.5 and 2.4.17 and was repaired by Bouton's patch.

Please let me know if I should do some more tests. I still have the
"sacrificial" partition around and I'm willing to test patches/whatever. 
But
it seems to me that Bouton's patch just fixed it.

Thanks to everybody who answer
