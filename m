Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317364AbSGDH7d>; Thu, 4 Jul 2002 03:59:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317365AbSGDH7c>; Thu, 4 Jul 2002 03:59:32 -0400
Received: from ns.suse.de ([213.95.15.193]:1807 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S317364AbSGDH7b>;
	Thu, 4 Jul 2002 03:59:31 -0400
Date: Thu, 4 Jul 2002 10:01:49 +0200
From: Andi Kleen <ak@suse.de>
To: announce@x86-64.org
Cc: linux-kernel@vger.kernel.org
Subject: 2.4.19-rc1 based linux/x86-64 snapshot released
Message-ID: <20020704100149.A19467@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


A new snapshot of the Linux/x86-64 kernel has been released. Linux/x86-64 is a port of
the Linux kernel to the X86-64 architecture. X86-64 is a 64bit extension to the 32bit
IA32 architecture.  See http://www.x86-64.org for more information on x86-64.

To compile it a native or cross x86-64 compiler and toolkit is needed. The x86-64
port has been integrated into the latest releases of binutils and gcc (3.1.0+).
See http://www.x86-64.org/documentation_folder/build on how to build the 
toolchain.  Stable snapshots of the toolkit are also available from http://www.x86-64.org

A kernel patch against official 2.4.19-rc1 from kernel.org:
ftp://ftp.x86-64.org/pub/linux-x86_64/v2.4/x86_64-2.4.19rc1-1.bz2 
29ff0aa4489629b39e9e46efecd30f37  x86_64-2.4.19rc1-1.bz2

A complete tarball of the kernel source:
ftp://ftp.x86-64.org/pub/linux-x86_64/v2.4/linux-x86_64-2.4.19-rc1-1.tar.bz2
fc571e3a9aece07712ea9089bf14eda0  linux-x86_64-2.4.19-rc1-1.tar.bz2

More uptodate code can be found in the x86-64 public CVS repository. 
See http://www.x86-64.org/cvs on how to access it. Note that the code in the CVS
repository is a development snapshot and may be instable or not even compile.

Changes:

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
- NMI watchdog now functional and enabled by default.
- mtrr driver works now on SMP
- New optimized IP checksum/memset/memcpy functions
- Some bugs in IA32 emulation fixed.
- signal handler stack alignment bug fixed.
- Lots of bugfixes and cleanups.

Known Problems/Caveats: 

- vsyscalls are currently disabled because they trigger too many linker bugs together
with HPET timers. The vsyscall pages just call normal syscalls.
- AMD 8111 specific IDE driver is temporarily disabled because it corrupts filesystems. 
The generic IDE driver supports DMA for the chipset even without the chipset driver
and seems to work stable.
- ISDN driver should not be enabled in the configuration because it partly 
doesn't compile.
- The drivers/usb/se401.c USB driver triggers a compiler bug and should not be 
enabled in the configuration.
- gdb sometimes corrupts the kernel stack frame and can cause an oops in error_restore.
- Still many drivers untested and may not work.

-Andi Kleen, SuSE Labs.
