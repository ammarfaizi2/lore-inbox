Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261384AbUKWSR6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261384AbUKWSR6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 13:17:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261455AbUKWSPR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 13:15:17 -0500
Received: from tus-gate1.raytheon.com ([199.46.245.230]:47251 "EHLO
	tus-gate1.raytheon.com") by vger.kernel.org with ESMTP
	id S261464AbUKWSIw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 13:08:52 -0500
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>,
       Esben Nielsen <simlo@phys.au.dk>
From: Mark_H_Johnson@raytheon.com
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm2-V0.7.30-9
Date: Tue, 23 Nov 2004 12:06:28 -0600
Message-ID: <OF333BD8AC.9A839B3C-ON86256F55.00637844-86256F55.00637868@raytheon.com>
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.5.2|June 01, 2004) at
 11/23/2004 12:06:42 PM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>i have released the -V0.7.30-9 Real-Time Preemption patch, which can be
>downloaded from the usual place:
>
>    http://redhat.com/~mingo/realtime-preempt/

Grr. Had downloaded -V0.7.30-7 and was building when this message came in.

I do have a repeatable problem with -7 however (not yet checked in -9).
This
was with PREEMPT_DESKTOP and unthreaded IRQ's (hard and soft). As I look
at the .config differences, also enabled in 7PK (and not 7RT) was
  CONFIG_ASM_SEMAPHORES=y
  CONFIG_RWSEM_XCHGADD_ALGORITHM=y
and enabled in 7RT (and not 7PK) was
  CONFIG_RT_DEADLOCK_DETECT=y
I should also note that I applied a patch for NMI profiling in my build
as well (but not sure that caused the problem).

The system dies early in the boot process. Locks up and completely not
responsive and no error messages prior to failure. Serial console output
follows at the end of this email.

The PREEMPT_RT kernel I built (same source, only difference was previously
described .config changes) comes up OK.
  --Mark

--- first attempt ---

Linux version 2.6.10-rc2-mm2-V0.7.30-7PK (root@dws77) (gcc version 3.3.3
20040412 (Red Hat Linux 3.3.3-7)) #2 SMP Tue Nov 23 10:58:11 CST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fff8000 (ACPI data)
 BIOS-e820: 000000001fff8000 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
511MB LOWMEM available.
found SMP MP-table at 000fb170
DMI 2.3 present.
Using APIC driver default
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 6:8 APIC version 17
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 6:8 APIC version 17
Using ACPI for processor (LAPIC) configuration information
Intel MultiProcessor Specification v1.1
    Virtual Wire compatibility mode.
OEM ID: VIA      Product ID: VT3075       APIC at: 0xFEE00000
I/O APIC #2 Version 17 at 0xFEC00000.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Processors: 2
Built 1 zonelists
Initializing CPU#0
Kernel command line: ro root=LABEL=/ nmi_watchdog=1 single
console=ttyS0,38400n8r profile=2
kernel CPU profiling enabled
kernel profiling shift: 2
PID hash table entries: 2048 (order: 11, 32768 bytes)
Detected 864.162 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25

--- second attempt ---

Linux version 2.6.10-rc2-mm2-V0.7.30-7PK (root@dws77) (gcc version 3.3.3
20040412 (Red Hat Linux 3.3.3-7)) #2 SMP Tue Nov 23 10:58:11 CST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fff8000 (ACPI data)
 BIOS-e820: 000000001fff8000 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
511MB LOWMEM available.
found SMP MP-table at 000fb170
DMI 2.3 present.
Using APIC driver default
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 6:8 APIC version 17
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 6:8 APIC version 17
Using ACPI for processor (LAPIC) configuration information
Intel MultiProcessor Specification v1.1
    Virtual Wire compatibility mode.
OEM ID: VIA      Product ID: VT3075       APIC at: 0xFEE00000
I/O APIC #2 Version 17 at 0xFEC00000.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Processors: 2
Built 1 zonelists
Initializing CPU#0
Kernel command line: ro root=LABEL=/ nmi_watchdog=1 single
console=ttyS0,38400n8r profile=2
kernel CPU profiling enabled
kernel profiling shift: 2
PID hash table entries: 2048 (order: 11, 32768 bytes)
Detected 864.157 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 511160k/524224k available (2236k kernel code, 12524k reserved, 634k
data, 236k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode...
Ok.
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support...

