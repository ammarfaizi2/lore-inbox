Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317957AbSGPUAP>; Tue, 16 Jul 2002 16:00:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317958AbSGPUAO>; Tue, 16 Jul 2002 16:00:14 -0400
Received: from ns.suse.de ([213.95.15.193]:56332 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S317957AbSGPUAN>;
	Tue, 16 Jul 2002 16:00:13 -0400
Date: Tue, 16 Jul 2002 22:03:02 +0200
From: Andi Kleen <ak@suse.de>
To: announce@x86-64.org
Cc: linux-kernel@vger.kernel.org
Subject: Second x86-64 kernel snapshot based on 2.4.19rc1 released
Message-ID: <20020716220302.A5400@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


A new snapshot of the linux/x86-64 kernel has been released. Linux/x86-64
is a port of Linux to the x86-64 architecture. For more information on
x86-64 see http://www.x86-64.org. 

This is the second snapshot based on 2.4.19rc1. 

This release fixes some bugs in the IOMMU code. These can cause file system
corruption with IDE. If you're already using the 2.4.19rc1-1 snapshot
it is strongly recommended to upgrade to 2.4.19rc1-2. 

Full tar ball:

ftp://ftp.x86-64.org/pub/linux/v2.4/linux-x86_64-2.4.19rc1-2.tar.bz2

Patch against official 2.4.19rc1 from kernel.org: 

ftp://ftp.x86-64.org/pub/linux/v2.4/x86_64-2.4.19rc1-2.bz2

2.4.19rc1-2 snapshot:

- Fix radeon and vesafb framebuffer drivers.
- Various bugfixes for the IOMMU code:
	* on/off/force switching logic is more intelligent
	* never flush caches except at initialization
	* don't access the IOMMU part of the GART via the CPU.
	* fix scatter gather freeing problems
	* various other cleanups and fixes.1
- More driver fixes.	
- Fix strncpy_from_user problems which caused glibc and LTP failures
- Support VFAT ioctls in 32bit emulation
- Fix vsyscall linker bug
- Reenable AMD7469 IDE tuning
- Various other cleanups and fixes

2.4.19rc1-1 snapshot:

- Merge to 2.4.19rc1
- HPET timer support. When the box doesn't support HPET it'll fallback to accessing
the 8253 timer chip. The support is checked using the acpitable mini ACPI. When
there is no ACPI entry found it tries to enable HPET timers manually. 
- PCI GART IOMMU support. Allows operation of 32bit PCI cards on boxes with more
than 4GB of memory.
This code is currently enabled for all drivers that use the pci-dma API even for
memory addresses smaller than 4GB. This is done to get better test coverage.
The code can be disabled with a configuration option.
To use this code it is recommended to use a big AGP aperture (256MB - 512MB) 
It can be also disabled at bootup using iommu=off
- change_page_attr implemented to fix mappings with conflicting caching attributes in AGP
- AGP driver for AMD 8151
- Machine check handler for AMD Opteron
- New early console support to print messages
- Various driver fixes. Several not 64bit clean drivers disabled in the configuration
and others fixed.
- NMI watchdog works now.
- mtrr driver works now on SMP
- New optimized IP checksum/memset/memcpy functions
- Some bugs in IA32 emulation fixed.
- signal handler stack alignment bug fixed.
- Lots of bugfixes and cleanups.

Known Problems/Caveats: 

- vsyscalls are currently disabled because they trigger too many linker bugs together
with HPET timers. The vsyscall pages just call normal syscalls.
- ISDN driver should not be enabled in the configuration because it partly 
doesn't compile.
- The drivers/usb/se401.c USB driver triggers a compiler bug and should not be 
enabled in the configuration.
- gdb sometimes corrupts the kernel stack frame and can cause an oops in error_restore.
- Still many drivers untested and may not work.
- LDT sharing between threads may not work.

-Andi Kleen, SuSE Labs
