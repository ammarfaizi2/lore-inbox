Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275552AbRKMP7t>; Tue, 13 Nov 2001 10:59:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275743AbRKMP7q>; Tue, 13 Nov 2001 10:59:46 -0500
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:35980 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S275270AbRKMP7B>; Tue, 13 Nov 2001 10:59:01 -0500
Date: Tue, 13 Nov 2001 09:58:45 -0600 (CST)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200111131558.JAA58186@tomcat.admin.navo.hpc.mil>
To: roy@karlsbakk.net, <linux-kernel@vger.kernel.org>
Subject: Re: Tuning Linux for high-speed disk subsystems
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roy Sigurd Karlsbakk <roy@karlsbakk.net>:
> 
> Hi all
> 
> After some testing at Compaq's lab in Oslo, I've come to the conclusion
> that Linux cannot scale higher than about 30-40MB/sec in or out of a
> hardware or software RAID-0 set with several stripe/chunk sizes tried out.
> The set is based on 5 18GB 10k disks running SCSI-3 (160MBps) alone on a
> 32bit/33MHz PCI bus.
> 
> After speking to the storage guys here, I was told the problem generally
> was that the OS should send the data requests at 256kB block sizes, as the
> drives (10k) could handle 100 I/O operations per second, and thereby could
> give a total of (256*100)kB/sec per spindle. When using smaller block
> sizes, the speed would decrease in a linear fasion.
> 
> Does anyone know this stuff good enough to help me how to tune the system?
> PS: The CPUs were almost idle during the test. Tested file system was
> ext2.

I shouldn't be the authoritative answer on this, but to start with:

a. You don't provide enough info on the hardware configuration:

	a. are all of the drives on one SCSI controller?
	b. is there only one PCI?
	c. since you mention "CPUs", how many, and which ones
	d. which chipset?
	e. what was used for the benchmark?
	f. which hardware raids were tested?

b. Your mentioned limit (40MB/sec) sounds like it is really a
   memory<->bridge<->PCI<->controller bandwidth limit - this is about what I
   get from a SCSI-3 alone on 33MHz bus (I use SCSI 3 for system disk, SCSI 2
   for audio/CDRW/tape drive).

c. Based on the statement that the "CPUs were almost idle", it sounds like
   the limit is outside the OS. If you are trying to setup a disk server then
   you should check into multiple PCI busses @ 66MHz, and multiple disk
   controllers.

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
