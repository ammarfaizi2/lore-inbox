Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272836AbTG3JUd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 05:20:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272837AbTG3JUd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 05:20:33 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:9601 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S272836AbTG3JU3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 05:20:29 -0400
Date: Wed, 30 Jul 2003 10:30:47 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200307300930.h6U9Ulhr000975@81-2-122-30.bradfords.org.uk>
To: dw@pdp1.sys.toronto.edu, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Fault in init/do_mounts.c/change_floppy{} ramdisk file system read failure
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>      I an trying to build a standalone Linux system using the process described 
>      in the Bootdisk-HOWTO.  HOWEVER I am using an *uncompressed* root file 
>      system since I was unable to configure a compressed one that is small 
>      enough to fit on a single floppy.  I built:
>      - a boot floppy containing a bzImage Linux kernel and minimal 
>        infrastructure that gets me to the point of being able to load a file 
>        system from floppy onto ramdisk.  This is the same kernel that I
>        use on my desktop every day.
>      - an ext2 root file system (4000 blocks) that holds a minimal set of 
>        files/programs
>      - a set of 3 floppy disks that contains an uncompressed  copy of the 
>        ext2 root file system
>      
>     When I try to boot the standalone system the following sequence of
>     events occurs:
>     - I load the boot floppy, and the kernel appears to load and
>       initialize correctly.
>     - The kernel prompts me to insert a floppy so it can load a file
>       system onto ramdisk.
>     - The code in init correctly determines that my floppy disk 
>       contains an uncompressed ext2 file system.
>     - in init/do_mounts.c  rd_load_image is called with argument "/dev/root"
>     - the for loop in this function starts reading from the first
>       floppy disk.  Cachunk, cachunk.
>     - When 1440 1k block have been read, the function change_floppy is 
>       called to move to the next floppy disk.
>     - change_floppy does something BROKEN.  See below.
>     - The for loop in rd_load_image continues to try and read in more
>       uncompressed file system from the floppy, BUT THE READ DOES NOT
>       ACCESS the floppy drive.  The reads in the for loop appear to
>       succeed, but nothing is actually transfered from the floppy
>       disk to the ramdisk.
>     - The same read failure  happens for the third floppy disk.

I saw similar behavior last time I tried to make an uncompressed root
fs that spanned five disks, (around 2.4.21-rc1), but I seem to
remember that it read disk 1, ignored disk 2, read disk 3, etc -
I.E. odd numbered disks were actually accessed.

I worked around the problem by making a _really_ minimal root fs that
fitted on a single disk, booting with that, then extracting everything
else I needed from a tar archive on another disk :-).

John.
