Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264924AbRF3KHB>; Sat, 30 Jun 2001 06:07:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264927AbRF3KGv>; Sat, 30 Jun 2001 06:06:51 -0400
Received: from eschelon.gamesquad.net ([216.115.239.45]:5642 "HELO
	eschelon.gamesquad.net") by vger.kernel.org with SMTP
	id <S264924AbRF3KGe>; Sat, 30 Jun 2001 06:06:34 -0400
From: "Vibol Hou" <vhou@khmer.cc>
To: "Dylan Griffiths" <Dylan_G@bigfoot.com>,
        "Linux kernel" <linux-kernel@vger.kernel.org>
Subject: RE: EEPro100 problems in SMP on 2.4.5 ?
Date: Sat, 30 Jun 2001 03:04:08 -0700
Message-ID: <NDBBKKONDOBLNCIOPCGHEEMKIEAA.vhou@khmer.cc>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Importance: Normal
In-Reply-To: <3B3D4A96.A81A13AD@bigfoot.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a lock problem on a dual P3 1GHz w/1GB RAM setup and 2.4.5, but it
doesn't seem to be NIC related although I have two EEPro100's in it.

I get lockups while doing large disk reads that use larges amounts of memory
(MySQL's myisamchk on a 600MB MyISAM table, for instance).  The SCSI
subsystem is an Adaptec Ultra160 card w/Ultra160 drives.

Since the system locks even when doing a fsck on one of the badly damaged
drives (from the hard lock) during bootup, I am pretty sure this is an
isolated problem.

In SMP mode, when the system does manage to boot, it will load up MySQL and
run fine for about 10 minutes.  Afterwards, the system hardlocks.  In
another instance, shutting down MySQL right after starting it also caused
the system to hardlock in SMP mode.  I thought it might have something to do
with the bounce buffers, so I disabled the 4GB bigmem area, but that didn't
change the situation.

The chipset is a VIA 686B Southbridge and VIA 694DP Northbridge, though I
don't know whether this would affect the hard locks on the SCSI subsystem
(SysRQ unresponsive).

It's rock solid with a uniprocessor kernel compiled with the exact same
configuration as the SMP kernel (minus the SMP switch, of course
(APIC+IO-APIC+4GBhighmem enabled.  I've tried various kernels from 2.4.3 to
2.4.5-ac21).

Have you checked to see if it's the SCSI subsystem that is causing your
locks?

--
Vibol Hou
KhmerConnection, http://khmer.cc
"Stay Connected."

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Dylan Griffiths
Sent: Friday, June 29, 2001 8:42 PM
To: Linux kernel
Subject: EEPro100 problems in SMP on 2.4.5 ?


	Hi.  While doing some file tranfers to our new server (a Compaq Proliant
8way XEON 500 with 4gb ram and an EEPro100 NIC), the box socked solid (no
oops, no response via network, no response via console).  The other hardware
in the system was a Compaq Smart Array 9SMART2 driver).  It's running
Slackware 7.1.  The other system was a dual P3 450 running Redhat 7.1 (Linux
velocity.kuro5hin.org 2.4.2-2smp #1 SMP Sun Apr 8 20:21:34 EDT 2001 i686
unknown) w/ 3c59x NIC.  The Redhat machine experienced no problems.
	In Uni processor mode, the system is totally stable.  But only using 1/8th
of its power :-/  We had to roll back to 2.2.19 with a bigmem patch, but
we'd like to have a stable 2.4 kernel to use (since it's so much better SMP
wise, throughput wise, etc).
--
    www.kuro5hin.org -- technology and culture, from the trenches.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

