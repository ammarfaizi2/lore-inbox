Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S144039AbRA1TuI>; Sun, 28 Jan 2001 14:50:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143978AbRA1Tts>; Sun, 28 Jan 2001 14:49:48 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:20180 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S144039AbRA1Ttm>;
	Sun, 28 Jan 2001 14:49:42 -0500
Date: Sun, 28 Jan 2001 20:49:38 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200101281949.UAA11123@harpo.it.uu.se>
To: linux-kernel@vger.kernel.org, tmolina@home.com
Subject: Re: time in the future during make for 2.4.0
Cc: sensors@stimpy.netroedge.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Jan 2001 12:27:46 -0600 (CST), Thomas Molina wrote:

>I seem to recall a discussion on faster processors causing timing
>problems during a kernel make, but I'm unable to find it in the kernel
>archives.  I've now upgraded to an Athlon 900 MHz processor and an ASUS
>A7V motherboard and have started seeing this.  It shows up as the
>following messages during a make bzImage:
>
>make[3]: *** Warning:  Clock skew detected.  Your build may be
>incomplete.
>make[3]: *** Warning: File
>`/mnt/hd/local/kernel/linux.24.new/include/linux/sched.h' has
>modification time in the future (2001-01-28 17:41:05 > 2001-01-28
>10:07:02)

No, this doesn't look like the "fast CPU" problem you are alluding to
(look for subject MODVERSIONS in the archives). We fixed that one.

Your problem is that your kernel source dir (unpacked tarball?)
contains files with time stamps several hours in the future;
'make' doesn't take kindly to this.

I've seen this happen once: during an upgrade (RH-style, i.e. not
fresh install) from RH6.2 to RH7.0, my /etc/localtime had become
overwritten and my machine in an instant moved from CET to some US
time zone 6 or 8 hrs back. Then when I unpacked my kernel tarball to
build a real kernel, I got exactly the problems you listed above.

Check your clock & time zone settings.

/Mikael
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
