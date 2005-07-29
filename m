Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262922AbVG2XVb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262922AbVG2XVb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 19:21:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262879AbVG2XQf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 19:16:35 -0400
Received: from smtp.osdl.org ([65.172.181.4]:13287 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262884AbVG2XP4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 19:15:56 -0400
Date: Fri, 29 Jul 2005 16:17:51 -0700
From: Andrew Morton <akpm@osdl.org>
To: Khalid Aziz <khalid_aziz@hp.com>
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
       linux-acpi@intel.com
Subject: Re: 2.6.13-rc3-mm3
Message-Id: <20050729161751.34705ac6.akpm@osdl.org>
In-Reply-To: <1122678354.20867.48.camel@lyra.fc.hp.com>
References: <20050728025840.0596b9cb.akpm@osdl.org>
	<1122678354.20867.48.camel@lyra.fc.hp.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Khalid Aziz <khalid_aziz@hp.com> wrote:
>
> Serial console is broken on ia64 on an HP rx2600 machine on
> 2.6.13-rc3-mm3. When kernel is booted up with "console=ttyS,...", no
> output ever appears on the console and system is hung. So I booted the
> kernel with "console=uart,mmio,0xff5e0000" to enable early console and
> here is how far the kernel got before hanging:

(cc the ia64 and acpi lists)

OK, thanks.  There have been a few serial driver changes recently, but
there's also a tremendous ACPI patch in -mm.  I'm wondering about those
ACPI error messages:

> -------
> Linux version 2.6.13-rc3-mm3 (root@mars) (gcc version 3.3.5 (Debian 1:3.3.5-12)) #4 SMP Fri Jul 29 16:30:41 MDT 2005
> EFI v1.10 by HP: SALsystab=0x3fb38000 ACPI 2.0=0x3fb2e000 SMBIOS=0x3fb3a000 HCDP=0x3fb2c000
> booting generic kernel on platform hpzx1
> PCDP: v0 at 0x3fb2c000
> Explicit "console="; ignoring PCDP
> Early serial console at MMIO 0xff5e0000 (options '115200')
> efi.trim_top: ignoring 4KB of memory at 0x0 due to granule hole at 0x0
> efi.trim_top: ignoring 636KB of memory at 0x1000 due to granule hole at 0x0
> efi.trim_bottom: ignoring 15360KB of memory at 0x100000 due to granule hole at 0x0
> SAL 3.1: HP version 2.31
> SAL Platform features: None
> SAL: AP wakeup using external interrupt vector 0xff
> No logical to physical processor mapping available
> ACPI: Local APIC address c0000000fee00000
> GSI 36 (level, low) -> CPU 0 (0x0000) vector 48
> 2 CPUs available, 2 CPUs total
> MCA related initialization done
> Virtual mem_map starts at 0xa0007fffc7200000
> Built 1 zonelists
> Kernel command line: BOOT_IMAGE=scsi1:/EFI/debian/boot/vmlinuz-2.6.13-rc3-mm3 root=/dev/sdb2 console=uart,mmio,0xff5e0000  ro
> PID hash table entries: 4096 (order: 12, 131072 bytes)
> Console: colour VGA+ 80x25
> Memory: 12439136k/12542128k available (7051k code, 116240k reserved, 3406k data, 352k init)
> Leaving McKinley Errata 9 workaround enabled
> Dentry cache hash table entries: 2097152 (order: 10, 16777216 bytes)
> Inode-cache hash table entries: 1048576 (order: 9, 8388608 bytes)
> Mount-cache hash table entries: 1024
> Boot processor id 0x0/0x0
> CPU 1: synchronized ITC with CPU 0 (last diff -5 cycles, maxerr 433 cycles)
> Brought up 2 CPUs
> Total of 2 processors activated (2695.16 BogoMIPS).
> -> [0][1][ 786432]   0.5 [  0.5] (0): (  500513   250256)
> -> [0][1][ 827823]   0.5 [  0.5] (0): (  529015   139379)
> -> [0][1][ 871392]   0.5 [  0.5] (0): (  557119    83741)
> -> [0][1][ 917254]   0.5 [  0.5] (0): (  585481    56051)
> -> [0][1][ 965530]   0.6 [  0.6] (0): (  615654    43112)
> -> [0][1][1016347]   0.6 [  0.6] (0): (  653296    40377)
> -> [0][1][1069838]   0.6 [  0.6] (0): (  681359    34220)
> -> [0][1][1126145]   0.7 [  0.7] (0): (  706209    29535)
> -> [0][1][1185415]   0.7 [  0.7] (0): (  754788    39057)
> -> [0][1][1247805]   0.7 [  0.7] (0): (  788675    36472)
> -> [0][1][1313478]   0.8 [  0.8] (0): (  840102    43949)
> -> [0][1][1382608]   0.7 [  0.8] (0): (  742042    71004)
> -> [0][1][1455376]   0.6 [  0.8] (0): (  653934    79556)
> -> [0][1][1531974]   0.7 [  0.8] (0): (  766991    96306)
> -> [0][1][1612604]   0.7 [  0.8] (0): (  779253    54284)
> -> [0][1][1697477]   0.5 [  0.8] (0): (  534912   149312)
> -> [0][1][1786817]   0.5 [  0.8] (0): (  503106    90559)
> -> found max.
> [0][1] working set size found: 1313478, cost: 840102
> ---------------------
> | migration cost matrix (max_cache_size: 1572864, cpu: -1 MHz):
> ---------------------
>           [00]    [01]
> [00]:     -     1.6(0)
> [01]:   1.6(0)    -   
> --------------------------------
> | cacheflush times [1]: 1.6 (1680204)
> | calibration delay: 1 seconds
> --------------------------------
> NET: Registered protocol family 16
> ACPI: bus type pci registered
> ACPI: Subsystem revision 20050708
>     ACPI-0509: *** Error: Method execution failed [\PARS.GFIT] (Node e0000002ffff8a00), AE_BAD_PARAMETER
>     ACPI-0509: *** Error: Method execution failed [\_SB_.SBA0._INI] (Node e0000002ffffa780), AE_BAD_PARAMETER
> ACPI: Interpreter enabled
> ACPI: Using IOSAPIC for interrupt routing

Does the above happen on 2.6.13-rc3 or 2.6.13-rc4?

> SCSI subsystem initialized
> perfmon: version 2.0 IRQ 238
> perfmon: Itanium 2 PMU detected, 16 PMCs, 18 PMDs, 4 counters (47 bits)
> PAL Information Facility v0.5
> perfmon: added sampling format default_format
> perfmon_default_smpl: default_format v2.0 registered
> Total HugeTLB memory allocated, 0
> SGI XFS with large block/inode numbers, no debug enabled
> Initializing Cryptographic API
> EFI Time Services Driver v0.4
> i8042.c: No controller found.
> Serial: 8250/16550 driver $Revision: 1.90 $ 6 ports, IRQ sharing enabled
> mice: PS/2 mouse device common for all mice
> io scheduler noop registered
> io scheduler anticipatory registered
> io scheduler deadline registered
> io scheduler cfq registered
> RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
> Intel(R) PRO/1000 Network Driver - version 6.0.60-k2
> Copyright (c) 1999-2005 Intel Corporation.
> e100: Intel(R) PRO/100 Network Driver, 3.4.10-k2-NAPI
> e100: Copyright(c) 1999-2005 Intel Corporation
> netconsole: not configured, aborting
> Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> ide: Assuming 50MHz system bus speed for PIO modes; override with idebus=xx
> ide-floppy driver 0.99.newide
> Fusion MPT base driver 3.03.02
> Copyright (c) 1999-2005 LSI Logic Corporation
> Fusion MPT SPI Host driver 3.03.02
> EFI Variables Facility v0.08 2004-May-17
> NET: Registered protocol family 2
> IP route cache hash table entries: 2097152 (order: 10, 16777216 bytes)
> TCP established hash table entries: 8388608 (order: 13, 134217728 bytes)
> TCP bind hash table entries: 65536 (order: 6, 1048576 bytes)
> TCP: Hash tables configured (established 8388608 bind 65536)
> TCP reno registered
> TCP bic registered
> NET: Registered protocol family 1
> NET: Registered protocol family 17
> No ttyS device at MMIO 0xff5e0000 for console
> -------
> 
> Serial driver failed to find any serial ports. I am using defconfig. A
> 2.6.13-rc3 kernel (no mm3 patch) compiled with defconfig boots up fine
> and finds all serial ports.

Well it did claim to find an 8250 controller.

If you have time, it would be useful if you could obtain the 2.6.13-rc3 dmesg
output and do

	diff -u dmesg-2.6.13-rc3 dmesg-2.6.13-rc3-mm3

and send it, thanks.
