Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143853AbRA1SlW>; Sun, 28 Jan 2001 13:41:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143854AbRA1SlD>; Sun, 28 Jan 2001 13:41:03 -0500
Received: from cx425802-a.blvue1.ne.home.com ([24.0.54.216]:10756 "EHLO
	wr5z.localdomain") by vger.kernel.org with ESMTP id <S143807AbRA1Skd>;
	Sun, 28 Jan 2001 13:40:33 -0500
Date: Sun, 28 Jan 2001 12:27:46 -0600 (CST)
From: Thomas Molina <tmolina@home.com>
To: <linux-kernel@vger.kernel.org>
cc: <sensors@stimpy.netroedge.com>
Subject: time in the future during make for 2.4.0
Message-ID: <Pine.LNX.4.30.0101281210240.16358-100000@wr5z.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I seem to recall a discussion on faster processors causing timing
problems during a kernel make, but I'm unable to find it in the kernel
archives.  I've now upgraded to an Athlon 900 MHz processor and an ASUS
A7V motherboard and have started seeing this.  It shows up as the
following messages during a make bzImage:

make[3]: *** Warning:  Clock skew detected.  Your build may be
incomplete.
make[3]: *** Warning: File
`/mnt/hd/local/kernel/linux.24.new/include/linux/sched.h' has
modification time in the future (2001-01-28 17:41:05 > 2001-01-28
10:07:02)

I would appreciate any pointers to the discussion archive or solutions.

It doesn't seem to have a major problem with kernel compiles, but it
appears to send compiles of lm-sensors 2.5.5 into endless loops.  Each
loop begins with the following:

make: *** Warning: File `/usr/local/kernel/linux/include/linux/types.h'
has modification time in the future (2001-01-28 17:41:05 > 2001-01-28
12:21:28)
gcc -M -MG -I. -Ikernel/include -I/usr/local/include
-I/usr/local/kernel/linux/include -O2  prog/detect/i2cdetect.c | \
        sed -e 's@^\(.*\)\.o:@prog/detect/i2cdetect.rd
prog/detect/i2cdetect.ro: Makefile '`dirname
prog/detect/i2cdetect.rd`/Module.mk' @' > prog/detect/i2cdetect.rd

and ends with the following before starting over again:

gcc -M -MG -I. -Ikernel/include -I/usr/local/include
-I/usr/local/kernel/linux/include -O2  -D__KERNEL__ -DMODULE
-fomit-frame-pointer  -DEXPORT_SYMTAB -DMODVERSIONS -include
/usr/local/kernel/linux/include/linux/modversions.h kernel/sensors.c | \
        sed -e 's@^\(.*\)\.o:@kernel/sensors.d kernel/sensors.o:
Makefile '`dirname kernel/sensors.d`/Module.mk' @' > kernel/sensors.d


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
