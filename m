Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129410AbQKGR73>; Tue, 7 Nov 2000 12:59:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129307AbQKGR7Q>; Tue, 7 Nov 2000 12:59:16 -0500
Received: from topaz.3com.com ([192.156.136.158]:49103 "EHLO topaz.3com.com")
	by vger.kernel.org with ESMTP id <S129408AbQKGR7B>;
	Tue, 7 Nov 2000 12:59:01 -0500
X-Lotus-FromDomain: 3COM
From: Steven_Snyder@3com.com
To: linux-kernel@vger.kernel.org
Message-ID: <88256990.0062E87E.00@hqoutbound.ops.3com.com>
Date: Tue, 7 Nov 2000 11:58:48 -0600
Subject: Linux v2.2.17: IDE disk error on Compact Flash device
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hello.

When attempting to boot Linux kernel v2.2.17 from a Compact Flash (CF) device I
am getting the errors shown below.  This CF device is in a PCMCIA form factor
and is the Master device on the secondary IDE controller

Before we get to the errors, though, a little background.  I can reproduce this
boot error on 2 different systems, and have seen the same error messages
(non-booting) on a 3rd system.  For both boot systems the CF device is the only
IDE device and is the Master on the secondary IDE controller (/dev/hdc).  For
the non-booting system the device is in a PCMCIA slot (/dev/hde).

This is what I see at boot time:

ide1 at 0x170-0x177,0x376 on irq 15
hdc: SanDisk SDCFB-128, 122MB /w1kB Cache, CHS=980/8/32
Partition check:
 hdc: hdc1 hdc2
 hdc: hdc1 hdc2
hdc: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
hdc: drive_cmd: error=0x04 { DriveStatusError }
 hdc: hdc1 hdc2
 hdc: hdc1 hdc2
[MS-DOS FS Rel. 12 FAT 16 check=n,conv=b,uid=0,umask=022,bmap]
[me=0x1,cs=0x1240,#f=191,fs=34616,fl=1699280,ds=327153000,de=1536,data=327153120,se=185,ts=1015022771,ls=20487,rc=0,fc=4294967295]
Transaction block size = 512
UMSDOS: msdos_read_super failed mount aborted
 hdc: hdc1 hdc2
[MS-DOS FS Rel. 12 FAT 16 check=n,conv=b,uid=0,umask=022,bmap]
[me=0x1,cs=0x1240,#f=191,fs=34616,fl=1699280,ds=327153000,de=1536,data=327153120,se=185,ts=1015022771,ls=20487,rc=0,fc=4294967295]
Transaction block size = 512
Kernel panic: VFS: Unable to mount root fs on 16:00

That's it.  I've listed the (U)MSDOS complaints for completeness, but as I get
the same drive_cmd messages when simply inserting the device in a PCMCIA slot
(that is, before attempting to mount any filesystem), I don't think that it is a
factor.

This is definately an OS issue.  I've booted many OSes (DOS, Win95, VxWorks,
LynxOS) from this same configuration (CF = IDE1/Master as the sole IDE device)
and have seen no complaints like the ones shown above.

So... what can I do to work around this problem?  Thank you.




PLANET PROJECT will connect millions of people worldwide through the combined
technology of 3Com and the Internet. Find out more and register now at
http://www.planetproject.com


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
