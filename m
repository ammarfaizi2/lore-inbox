Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268765AbRHFPPy>; Mon, 6 Aug 2001 11:15:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268767AbRHFPPo>; Mon, 6 Aug 2001 11:15:44 -0400
Received: from [24.93.67.52] ([24.93.67.52]:25357 "EHLO mail5.nc.rr.com")
	by vger.kernel.org with ESMTP id <S268765AbRHFPP1>;
	Mon, 6 Aug 2001 11:15:27 -0400
From: "C. Linus Hicks" <lhicks@nc.rr.com>
To: <linux-kernel@vger.kernel.org>
Subject: PROBLEM: mkfs wrote to wrong partition
Date: Mon, 6 Aug 2001 11:15:10 -0400
Message-ID: <00b201c11e8a$952ba470$0a0a0a0a@k-6_iii-400.mindspring.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook 8.5, Build 4.71.2377.0
X-MimeOLE: Produced By Microsoft MimeOLE V4.72.3110.3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am running Redhat 7.1 with the following:

Software:

kernel                 2.4.6 smp
Gnu C                  2.91.66      (It's a Redhat system but I use kgcc)
Gnu make               3.79.1
binutils               2.10.91.0.2
util-linux             2.10s
mount                  2.10r
modutils               2.4.2
e2fsprogs              1.19
reiserfsprogs          3.x.0j
Linux C Library        2.2.2
Dynamic linker (ldd)   2.2.2
Procps                 2.0.7
Net-tools              1.57
Console-tools          0.3.3
Sh-utils               2.0

Hardware:

Asus P2B-DS with 2 600Mhz P III Intel
1gb memory
3 SCSI disks using the new AIC7XXX driver

The point of the following exercise was to move from a single CPU 400Mhz
system to a dual 600Mhz and from an IDE disk to SCSI. I already had Redhat
7.1 with a 2.4.6 kernel running on the dual 600 and was replacing it with
the system from the 400Mhz IDE system. All operations were performed on the
dual 600.

While running the system booted with root=/dev/sda2 I made partitions on
/dev/sdb just like on /dev/sda, then copied all files over. I modified the
lilo.conf in /etc on /dev/sda2 to have boot=/dev/sdb and set the
root=/dev/sdb2 for each image. I ran lilo then booted the system.

The system looked like I expected it to: mount showed /dev/sdb2 mounted as
the root filesystem.

Next I did mkfs on the partitions on /dev/sda, starting with the higher
partitions and working down, and copied data from hda. By the way, the
P2B-DS BIOS allows me to choose whether IDE or SCSI comes first, therefore I
can boot from SCSI even though an IDE disk is attached. Current setting was
SCSI first. When I got to /dev/sda2 I tried to format it reiserfs, but it
complained about the filesystem being mounted. Not quite realizing what was
going on yet, I tried mkfs -t ext2 and it worked. Shortly after that, I
noticed that df showed /dev/sdb2 as looking nearly empty. I looked with ls
and no files showed up. And I started having problems running most commands,
as you can imagine.

The system seemed to be getting /dev/sda2 confused with /dev/sdb2. This
seems like a bug to me, and I wonder if I tried to do something that isn't
supported.

Keywords: filesystem ext2 reiserfs

I've been using Linux for several years now, but have never submitted a bug
report before.

If you need additional information, please let me know.

Linus Hicks
lhicks@nc.rr.com

