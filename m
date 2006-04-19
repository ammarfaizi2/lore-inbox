Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750814AbWDSOvY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750814AbWDSOvY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 10:51:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750819AbWDSOvY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 10:51:24 -0400
Received: from [202.125.80.34] ([202.125.80.34]:57553 "EHLO mail.esn.co.in")
	by vger.kernel.org with ESMTP id S1750814AbWDSOvY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 10:51:24 -0400
x-mimeole: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: Simple Block Driver (RAM DISK) - Console Crash (specific case)
Date: Wed, 19 Apr 2006 20:20:48 +0530
Message-ID: <3AEC1E10243A314391FE9C01CD65429B3FD039@mail.esn.co.in>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Simple Block Driver (RAM DISK) - Console Crash (specific case)
Thread-Index: AcZiMbg3jyjNj6AeRNGyRz458kXIRwAABbAgAGMRbZA=
From: "Srinivas G." <srinivasg@esntechnologies.co.in>
To: "linux-kernel-Mailing-list" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear All,

I developed a simple ram disk driver. It is working fine.
Please find the sources at the following link.
http://pastebin.com/669338

But I am facing a new problem (console crash) when I try to run the "ls"
command on a mount point after removing the disk with out unmounting
(see the below - How I am removing the ram disk after mount without
unmounting).

I understand that removing a mounted device will lead to inconsistent
data. But, in case of a removable media this may happen. Right?

I am trying to simulate a REMOVABLE MEDIA (FLASH MEDIA) driver
environment. This is an attempt to understand what to handle on surprise
removal of a mounted Flash Media disk.

Please find the attached source. I am using the following configuration.
--> x86 UNI Processor system with Fedora Core 3 installed 
--> Running 2.6.x kernels like 2.6.10, 2.6.12 and 2.6.14 on the same
system.

To reproduce the "console crash error" you just have to follow exactly
the next steps:

1) Copy the attached files to your system 
2) Build the sbd.ko file using the attached Makefile (make)
3) Load (insert) the module into the kernel space (insmod sbd.ko)
4) wait a few milli seconds to create the device node and format the
device (mke2fs /dev/sbd0)
5) mount the device (mount /dev/sbd0 /mnt)
6) copy some files into the mount point (cp *.c /mnt)
7) un mount the device (umount /mnt OR umount /dev/sbd0)
8) then again, mount the device (mount /dev/sbd0 /mnt)
9) remove the mounted device (compile the app.c file [cc app.c] then run
the ./a.out which will remove the mounted device) 
10) cd /mnt
11) run ls (which shows the errors messages - see attachment mes_log
file)
12) run again ls - console crash 

SEE THE BELOW TWO CONDITIONS WHERE I AM NOT ABLE TO SEE THE CONSOLE
CRASH.

1)	After mounting the FDD, I removed the floppy with out un
mounting (The floppy disk has already some files in it).
2)	If I perform the above procedure WITH OUT STEPS 6, 7 and 8.

Could any one explain why the problem occurs?
If I am wrong please correct me.

Thanks in very advance.

Thanks and Regards,
Srinivas G

