Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315746AbSILOIS>; Thu, 12 Sep 2002 10:08:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315919AbSILOIS>; Thu, 12 Sep 2002 10:08:18 -0400
Received: from relay.muni.cz ([147.251.4.35]:930 "EHLO anor.ics.muni.cz")
	by vger.kernel.org with ESMTP id <S315746AbSILOIQ>;
	Thu, 12 Sep 2002 10:08:16 -0400
Date: Thu, 12 Sep 2002 16:12:58 +0200
From: Jan Kasprzak <kas@informatics.muni.cz>
To: linux-kernel@vger.kernel.org
Subject: AMD 760MPX DMA lockup
Message-ID: <20020912161258.A9056@fi.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hello, kernel hackers,

my dual athlon box is unstable in some situations. I can consistently
lock it up by running the following code:

fd = open("/dev/hda3", O_RDWR);
for (i=0; i<1024*1024; i++) {
	read(fd, buffer, 8192);
	lseek(fd, -8192, SEEK_CUR);
	write(fd, buffer, 8192);
}

It locks up in a minute or so (solid lock up, it does not react even
to a NumLock key or console switching). It can surely be a HW problem
(this is a new box), but how to tell whether this is the case?

The mainboard is MSI K7D Master, AMD 760MPX chipset, 460W power supply,
1GB RAM.

The box survived whole night of memtest86 and the whole night of three kernel
compiles running in parallel in an infinite loop.

This problem is on many recent kernels (tried 2.4.18-11 from RedHat "null",
2.4.20-pre5-ac1, 2.4.20-pre5-ac5, 2.4.20-pre6). It does not matter whether
I compile the kernel SMP or UP, with or without CONFIG_HIGHMEM.

I tried several disks (WD1200JB, WD1200BB, IBM 120GXP).
I tried to remove all other PCI cards and 512MB of RAM. No change.
I tried to create an ext3 filesystem on /dev/hda3, mounted it 
as /mnt, created big file /mnt/bigfile and run the above code
on /mnt/bigfile. System still locks up.

I tried to put the tested disk to a separate IDE controller
(Promise PDC20269 PCI card) - then I do not get a complete lockup,
just the drive starts to complain about the DMA timeout, and the kernel
reesets the controller. However, DMA timeouts start to occur even on
the primary controller.

When I switch off the DMA (hdparm -d0 /dev/hda), the problem goes away
(however, the disk is very slow, as expected).

Is anybody able to run the above code on AMD 760MPX-based system?
Is it a kernel problem or hardware problem?

	Thanks in advance,

-Yenya

-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/   Czech Linux Homepage: http://www.linux.cz/ |
|----------- If you want the holes in your knowledge showing up -----------|
|----------- try teaching someone.                  -- Alan Cox -----------|
