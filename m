Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277380AbRK2TSZ>; Thu, 29 Nov 2001 14:18:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279307AbRK2TSQ>; Thu, 29 Nov 2001 14:18:16 -0500
Received: from [193.252.19.44] ([193.252.19.44]:51878 "EHLO
	mel-rti19.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S277380AbRK2TSE>; Thu, 29 Nov 2001 14:18:04 -0500
Date: Thu, 29 Nov 2001 19:42:01 +0100 (CET)
From: Pascal Lengard <pascal.lengard@wanadoo.fr>
To: "Leonard N. Zubkoff" <lnz@dandelion.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: dac960 broken ?
In-Reply-To: <200111290615.fAT6Fv1l020712@dandelion.com>
Message-ID: <Pine.LNX.4.33.0111291939310.17742-100000@h2o.chezmoi.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Nov 2001, Leonard N. Zubkoff wrote:

> Hmmm.  Nothing you've described makes any sense to me as I don't believe the
> driver has changed in a way that would break the basic detection of the boards.
> When you say that the card is not detected, precisely what do you mean?  Does
> the driver report anything at all?

OK, I did not write down the messages, but while testing, with DAC960
compiled as module, It did load and initialise but said "no such peripheral"
or something equivalent once (I know it's not precise enough ...).

I ran some tests to record precise messages today:

Here are the messages from the kernel 2.4.9-13 shipped by redhat:
-----------------------------------------------------------------
	Loading scsi_mod module
	Loading DAC960 module
	/lib/DAC960.o: init_module: Operation not permitted
	Hint: insmod errors can be caused by incorrect module parameters, including invalid IO or IRQ parameters
	ERROR /bin/insmod exited abnormally!
	Loading jbd module
	Journalled Block Device driver loaded
	Loading ext3 module
	Mounting /proc filesystem
	Creaing root device
	Mounting root filesystem
	mount: error 19 mounting ext3
	pivotroot: pivot_root(/sysroot,/sysroot/initrd) failed: 2
	Freeing unused kernel memory: 216k freed
	Kernel panic: No init found. Try passing init= option to kernel


Here is dmesg of 2.4.7-10 with dac960 compiled INSIDE kernel (WORKS):
---------------------------------------------------------------------
	Journalled Block Device driver loaded
	pty: 512 Unix98 ptys configured
	Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
	ttyS00 at 0x03f8 (irq = 4) is a 16550A
	ttyS01 at 0x02f8 (irq = 3) is a 16550A
	Real Time Clock Driver v1.10d
	block: queued sectors max/low 41557kB/13852kB, 128 slots per queue
	RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
	Floppy drive(s): fd0 is 2.88M
	FDC 0 is an 82078.
	DAC960: ***** DAC960 RAID Driver Version 2.4.10 of 1 February 2001 *****
	DAC960: Copyright 1998-2001 by Leonard N. Zubkoff <lnz@dandelion.com>
	DAC960#0: Configuring Mylex DAC960PD PCI RAID Controller
	DAC960#0:   Firmware Version: 3.51-0-04, Channels: 2, Memory Size: 4MB
	DAC960#0:   PCI Bus: 1, Device: 10, Function: 0, I/O Address: 0x6200
	DAC960#0:   PCI Address: 0xBF800C00 mapped at 0x45002C00, IRQ Channel: 11
	DAC960#0:   Controller Queue Depth: 64, Maximum Blocks per Command: 128
	DAC960#0:   Driver Queue Depth: 63, Scatter/Gather Limit: 17 of 17 Segments
	DAC960#0:   Stripe Size: 64KB, Segment Size: 8KB, BIOS Geometry: 128/32
	DAC960#0:   Physical Devices:
	<snip the devices>
	DAC960#0:   Logical Drives:
	<snip logical drives>
	Partition check:
	<snip>
	loop: loaded (max 8 devices)
	SCSI subsystem driver Revision: 1.00
	request_module[scsi_hostadapter]: Root fs not mounted
	NET4: Linux TCP/IP 1.0 for NET4.0

Here are messages from 2.4.16 compiled INSIDE kernel (BROKEN)
with this method:
copy .config from 2.4.7-10 that worked (dmesg just above)
and "make oldconfig"
------------------------------------------------------------
	Journalled Block device driver loaded
	pty 512 Unix98 ptys configured
	Serial driver version 5.05c ....
	ttyS0 at ...
	ttyS1 at ...
	Real Time Clock Driver 1.10e
	block: 128 slots per queue, batch=32
	RAMDISK driver initilized ...
	Floppy drives ...
	FDC0 is an 82078

here DAC960 should talk!!

	loop: loaded (max 8 devices)
	SCSI subsystem driver Revision: 1.00
	request_module [scsi_hostadapter]: Root fs not mounted
	NET4: Linux TCP/IP ...
	IP Protocols ...
	IP: Routing ...
	TCP: Hash ...
	NET4: Unix domain ...
	request_module[block-major-48]: Root fs not mounted
	VFS: Cannot open root device "300b" or 30:0b
	please append a correct "root=" boot option
	Kernel Panic: VFS: Unable to mount root fs on 30:0b


When it works, DAC960 is initialized and "talks" just after FDC0,
You have seen that with 2.4.16 it does not.
the sentence "please append a correct root= boot option" makes no sens
to me since in lilo.conf both kernels are started with same options:
	image=/boot/vmlinuz-2.4.16-dac960
		label=linuxdac
		read-only
		root=/dev/rd/c0d1p3
	image=/boot/vmlinuz-2.4.7-10custom
		label=linux247
		read-only
		root=/dev/rd/c0d1p3

I can tell you DAC960 REALLY is compiled inside the kernel since
a "grep DAC960" System.map-2.4.16-dac960 shows lots of entries.

 
Now I am lost ... If anyone has an idea of the problem ...


Pascal Lengard

