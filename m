Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269985AbUJHOF4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269985AbUJHOF4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 10:05:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269984AbUJHOF4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 10:05:56 -0400
Received: from mail3.utc.com ([192.249.46.192]:8623 "EHLO mail3.utc.com")
	by vger.kernel.org with ESMTP id S269985AbUJHOFB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 10:05:01 -0400
Message-ID: <41669E2D.6060705@cybsft.com>
Date: Fri, 08 Oct 2004 09:03:25 -0500
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>,
       Florian Schmidt <mista.tapas@gmx.net>, Mark_H_Johnson@raytheon.com,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: [patch] voluntary-preempt-2.6.9-rc3-mm3-T3
References: <20040924074416.GA17924@elte.hu> <20040928000516.GA3096@elte.hu> <20041003210926.GA1267@elte.hu> <20041004215315.GA17707@elte.hu> <20041005134707.GA32033@elte.hu> <20041007105230.GA17411@elte.hu> <4165832E.1010401@cybsft.com> <4165A729.5060402@cybsft.com> <20041007215546.GA8541@elte.hu> <4165F050.5050904@cybsft.com> <20041008070252.GA30823@elte.hu>
In-Reply-To: <20041008070252.GA30823@elte.hu>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------070401000505040604000703"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070401000505040604000703
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Ingo Molnar wrote:
> * K.R. Foley <kr@cybsft.com> wrote:
> 
> 
>>Ingo Molnar wrote:
>>
>>>* K.R. Foley <kr@cybsft.com> wrote:
>>>
>>>
>>>
>>>>>For me, this one wants to panic on boot when trying to find the root 
>>>>>filesystem. Acts like either the aic7xxx module is missing (which I 
>>>>>don't think is the case) or hosed, or it's having trouble with the label 
>>>>>for the root partition (Fedora system). Will investigate further when I 
>>>>>get home tonight, unless something jumps out at anyone.
>>>>>
>>>>>kr
>>>>
>>>>For clarification: This appears to be a problem in 2.6.9-rc3-mm3 also.
>>>
>>>
>>>try root=/dev/sda3 (or whereever your root fs is) instead of
>>>root=LABEL=/, in /etc/grub.conf.
>>>
>>>	Ingo
>>>
>>
>>Thanks. Tried that just to be sure. However, I don't seem to be the
>>only one having this problem with aic7xxx.
> 
> 

Ingo,

First let me say that, in case you haven't been following the other 
thread about this "2.6.9-rc3-mm3 fails to detect aic7xxx", I resolved 
this by backing out the bk-scsi.patch and bk-scsi-target.patch. Without 
those everything works fine.

> could you send me the following info:
> 
>   - full log of a failed boot

I would like to be able to be able to send you this, but it doesn't get 
to the point of logging. It dies trying to find the / device. On the 
screen it displays the parameters for the chosen option in grub.conf, 
says its uncompressing, then displays the Nash version info, then 
displays a panic message about not finding the root device. Something on 
the order of:

Kernel panic - not syncing: VFS: Unable to mount root fs on 
unknown-block(0,0)

Do you think that I would actually get to see more info out of this if I 
connect a serial console?

>   - full log of a successful boot

Attached.

>   - the output of 'mount'

[root@porky root]# mount
/dev/sda2 on / type ext3 (rw)
none on /proc type proc (rw)
none on /sys type sysfs (rw)
none on /dev/pts type devpts (rw,gid=5,mode=620)
/dev/sda1 on /boot type ext3 (rw)
/dev/sdb1 on /proj1 type ext3 (rw)
none on /dev/shm type tmpfs (rw)
sunrpc on /var/lib/nfs/rpc_pipefs type rpc_pipefs (rw)

> 
> 	Ingo
> 

thanks,

kr


--------------070401000505040604000703
Content-Type: text/plain;
 name="bootlog.ok"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="bootlog.ok"

Oct  8 06:48:42 porky syslogd 1.4.1: restart.
Oct  8 06:48:42 porky syslog: syslogd startup succeeded
Oct  8 06:48:42 porky syslog: klogd startup succeeded
Oct  8 06:48:42 porky kernel: klogd 1.4.1, log source = /proc/kmsg started.
Oct  8 06:48:42 porky kernel: Linux version 2.6.9-rc3-mm3-VP-T3 (kr@porky.cybersoft.int) (gcc version 3.3.3 20040412 (Red Hat Linux 3.3.3-7)) #8 SMP Thu Oct 7 23:07:40 CDT 2004
Oct  8 06:48:42 porky kernel: BIOS-provided physical RAM map:
Oct  8 06:48:42 porky kernel:  BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
Oct  8 06:48:42 porky kernel:  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
Oct  8 06:48:42 porky kernel:  BIOS-e820: 0000000000100000 - 000000001ff9e000 (usable)
Oct  8 06:48:42 porky kernel:  BIOS-e820: 000000001ff9e000 - 0000000020000000 (reserved)
Oct  8 06:48:42 porky kernel:  BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
Oct  8 06:48:42 porky kernel:  BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
Oct  8 06:48:42 porky kernel:  BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
Oct  8 06:48:42 porky kernel: 0MB HIGHMEM available.
Oct  8 06:48:42 porky kernel: 511MB LOWMEM available.
Oct  8 06:48:42 porky kernel: found SMP MP-table at 000fe710
Oct  8 06:48:42 porky kernel: DMI 2.3 present.
Oct  8 06:48:42 porky irqbalance: irqbalance startup succeeded
Oct  8 06:48:42 porky kernel: ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Oct  8 06:48:42 porky kernel: Processor #0 6:8 APIC version 17
Oct  8 06:48:42 porky kernel: ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Oct  8 06:48:42 porky kernel: Processor #1 6:8 APIC version 17
Oct  8 06:48:42 porky kernel: ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
Oct  8 06:48:42 porky kernel: ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
Oct  8 06:48:42 porky kernel: Using ACPI for processor (LAPIC) configuration information
Oct  8 06:48:42 porky kernel: Intel MultiProcessor Specification v1.4
Oct  8 06:48:42 porky kernel:     Virtual Wire compatibility mode.
Oct  8 06:48:42 porky kernel: OEM ID: DELL     Product ID: WS 620       APIC at: 0xFEE00000
Oct  8 06:48:42 porky kernel: I/O APIC #2 Version 32 at 0xFEC00000.
Oct  8 06:48:42 porky kernel: Enabling APIC mode:  Flat.  Using 1 I/O APICs
Oct  8 06:48:42 porky kernel: Processors: 2
Oct  8 06:48:42 porky portmap: portmap startup succeeded
Oct  8 06:48:42 porky kernel: Built 1 zonelists
Oct  8 06:48:42 porky kernel: Initializing CPU#0
Oct  8 06:48:43 porky kernel: Kernel command line: ro root=LABEL=/ rhgb quiet noapic
Oct  8 06:48:43 porky kernel: (swapper/0): new 196391 us maximum-latency critical section.
Oct  8 06:48:43 porky kernel:  => started at: <start_kernel+0x48/0x1e0>
Oct  8 06:48:43 porky kernel:  => ended at:   <cond_resched+0x25/0x80>
Oct  8 06:48:43 porky kernel:  [<c0137a38>] touch_preempt_timing+0x48/0x50
Oct  8 06:48:43 porky kernel:  [<c0137952>] check_preempt_timing+0x162/0x200
Oct  8 06:48:43 porky kernel:  [<c02b67b5>] cond_resched+0x25/0x80
Oct  8 06:48:43 porky kernel:  [<c0137a38>] touch_preempt_timing+0x48/0x50
Oct  8 06:48:43 porky kernel:  [<c02b67b5>] cond_resched+0x25/0x80
Oct  8 06:48:43 porky kernel:  [<c02b67b5>] cond_resched+0x25/0x80
Oct  8 06:48:43 porky rpc.statd[2435]: Version 1.0.6 Starting
Oct  8 06:48:43 porky kernel:  [<c0138e58>] register_cpu_notifier+0x18/0x60
Oct  8 06:48:43 porky kernel:  [<c0133688>] rcu_cpu_notify+0x38/0x40
Oct  8 06:48:43 porky kernel:  [<c0381d0d>] rcu_init+0x6d/0x80
Oct  8 06:48:43 porky kernel:  [<c037097c>] start_kernel+0xbc/0x1e0
Oct  8 06:48:43 porky nfslock: rpc.statd startup succeeded
Oct  8 06:48:43 porky kernel:  [<c0370440>] unknown_bootoption+0x0/0x190
Oct  8 06:48:43 porky kernel: PID hash table entries: 2048 (order: 11, 32768 bytes)
Oct  8 06:48:43 porky kernel: (swapper/0): new 205265 us maximum-latency critical section.
Oct  8 06:48:43 porky kernel:  => started at: <cond_resched+0x25/0x80>
Oct  8 06:48:43 porky kernel:  => ended at:   <cond_resched+0x25/0x80>
Oct  8 06:48:43 porky kernel:  [<c0137a38>] touch_preempt_timing+0x48/0x50
Oct  8 06:48:43 porky kernel:  [<c0137952>] check_preempt_timing+0x162/0x200
Oct  8 06:48:43 porky kernel:  [<c02b67b5>] cond_resched+0x25/0x80
Oct  8 06:48:43 porky kernel:  [<c0137a38>] touch_preempt_timing+0x48/0x50
Oct  8 06:48:43 porky kernel:  [<c02b67b5>] cond_resched+0x25/0x80
Oct  8 06:48:43 porky kernel:  [<c02b67b5>] cond_resched+0x25/0x80
Oct  8 06:48:43 porky kernel:  [<c0138e58>] register_cpu_notifier+0x18/0x60
Oct  8 06:48:43 porky kernel:  [<c012b21b>] timer_cpu_notify+0x2b/0x30
Oct  8 06:48:43 porky kernel:  [<c03819d5>] init_timers+0x35/0x60
Oct  8 06:48:43 porky kernel:  [<c037098b>] start_kernel+0xcb/0x1e0
Oct  8 06:48:43 porky kernel:  [<c0370440>] unknown_bootoption+0x0/0x190
Oct  8 06:48:43 porky kernel: Detected 931.130 MHz processor.
Oct  8 06:48:43 porky kernel: Using tsc for high-res timesource
Oct  8 06:48:43 porky kernel: (swapper/0): new 502992 us maximum-latency critical section.
Oct  8 06:48:43 porky kernel:  => started at: <cond_resched+0x25/0x80>
Oct  8 06:48:43 porky kernel:  => ended at:   <cond_resched+0x25/0x80>
Oct  8 06:48:43 porky kernel:  [<c0137a38>] touch_preempt_timing+0x48/0x50
Oct  8 06:48:43 porky kernel:  [<c0137952>] check_preempt_timing+0x162/0x200
Oct  8 06:48:43 porky kernel:  [<c02b67b5>] cond_resched+0x25/0x80
Oct  8 06:48:43 porky kernel:  [<c0137a38>] touch_preempt_timing+0x48/0x50
Oct  8 06:48:43 porky rpcidmapd: rpc.idmapd startup succeeded
Oct  8 06:48:43 porky kernel:  [<c02b67b5>] cond_resched+0x25/0x80
Oct  8 06:48:44 porky kernel:  [<c02b67b5>] cond_resched+0x25/0x80
Oct  8 06:48:44 porky kernel:  [<c01212fb>] acquire_console_sem+0x2b/0x60
Oct  8 06:48:44 porky kernel:  [<c038a4e3>] con_init+0x13/0x2b0
Oct  8 06:48:44 porky kernel:  [<c0114df0>] mcount+0x14/0x18
Oct  8 06:48:44 porky kernel:  [<c0389a12>] console_init+0x42/0x50
Oct  8 06:48:44 porky kernel:  [<c037099a>] start_kernel+0xda/0x1e0
Oct  8 06:48:44 porky kernel:  [<c0370440>] unknown_bootoption+0x0/0x190
Oct  8 06:48:44 porky kernel: Console: colour VGA+ 80x25
Oct  8 06:48:44 porky random: Initializing random number generator:  succeeded
Oct  8 06:48:44 porky kernel: Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Oct  8 06:48:44 porky kernel: Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Oct  8 06:48:44 porky kernel: Memory: 513384k/523896k available (1762k kernel code, 9892k reserved, 725k data, 284k init, 0k highmem)
Oct  8 06:48:44 porky kernel: Checking if this processor honours the WP bit even in supervisor mode... Ok.
Oct  8 06:48:44 porky kernel: Security Scaffold v1.0.0 initialized
Oct  8 06:48:44 porky kernel: Capability LSM initialized
Oct  8 06:48:44 porky kernel: Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Oct  8 06:48:44 porky rc: Starting pcmcia:  succeeded
Oct  8 06:48:44 porky kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
Oct  8 06:48:44 porky kernel: CPU: L2 cache: 256K
Oct  8 06:48:44 porky kernel: Intel machine check architecture supported.
Oct  8 06:48:44 porky kernel: Intel machine check reporting enabled on CPU#0.
Oct  8 06:48:44 porky kernel: Enabling fast FPU save and restore... done.
Oct  8 06:48:44 porky kernel: Enabling unmasked SIMD FPU exception support... done.
Oct  8 06:48:44 porky kernel: Checking 'hlt' instruction... OK.
Oct  8 06:48:44 porky kernel: CPU0: Intel Pentium III (Coppermine) stepping 06
Oct  8 06:48:44 porky kernel: per-CPU timeslice cutoff: 731.28 usecs.
Oct  8 06:48:39 porky sysctl: kernel.sysrq = 0 
Oct  8 06:48:44 porky kernel: task migration cache decay timeout: 1 msecs.
Oct  8 06:48:39 porky sysctl: kernel.core_uses_pid = 1 
Oct  8 06:48:44 porky kernel: Booting processor 1/1 eip 2000
Oct  8 06:48:39 porky network: Setting network parameters:  succeeded 
Oct  8 06:48:44 porky kernel: Initializing CPU#1
Oct  8 06:48:39 porky network: Bringing up loopback interface:  succeeded 
Oct  8 06:48:44 porky netfs: Mounting other filesystems:  succeeded
Oct  8 06:48:44 porky kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
Oct  8 06:48:44 porky kernel: CPU: L2 cache: 256K
Oct  8 06:48:44 porky kernel: Intel machine check architecture supported.
Oct  8 06:48:44 porky kernel: Intel machine check reporting enabled on CPU#1.
Oct  8 06:48:44 porky kernel: CPU1: Intel Pentium III (Coppermine) stepping 06
Oct  8 06:48:44 porky kernel: Total of 2 processors activated (3682.30 BogoMIPS).
Oct  8 06:48:44 porky kernel: checking TSC synchronization across 2 CPUs: passed.
Oct  8 06:48:44 porky kernel: ksoftirqd started up.
Oct  8 06:48:44 porky kernel: Brought up 2 CPUs
Oct  8 06:48:44 porky kernel: ksoftirqd started up.
Oct  8 06:48:44 porky kernel: checking if image is initramfs...it isn't (no cpio magic); looks like an initrd
Oct  8 06:48:44 porky kernel: Freeing initrd memory: 355k freed
Oct  8 06:48:44 porky kernel: NET: Registered protocol family 16
Oct  8 06:48:44 porky autofs: automount startup succeeded
Oct  8 06:48:44 porky kernel: PCI: PCI BIOS revision 2.10 entry at 0xfc03e, last bus=4
Oct  8 06:48:44 porky kernel: PCI: Using configuration type 1
Oct  8 06:48:44 porky kernel: mtrr: v2.0 (20020519)
Oct  8 06:48:44 porky kernel: Linux Plug and Play Support v0.97 (c) Adam Belay
Oct  8 06:48:44 porky kernel: PCI: Probing PCI hardware
Oct  8 06:48:44 porky kernel: PCI: Probing PCI hardware (bus 00)
Oct  8 06:48:44 porky kernel: PCI: Transparent bridge - 0000:00:1e.0
Oct  8 06:48:44 porky kernel: PCI: Using IRQ router PIIX/ICH [8086/2410] at 0000:00:1f.0
Oct  8 06:48:45 porky smartd[2575]: smartd version 5.21 Copyright (C) 2002-3 Bruce Allen 
Oct  8 06:48:45 porky kernel: PCI: Failed to allocate mem resource #0:1000@0 for 0000:03:00.0
Oct  8 06:48:45 porky smartd[2575]: Home page is http://smartmontools.sourceforge.net/  
Oct  8 06:48:45 porky kernel: apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
Oct  8 06:48:45 porky smartd[2575]: Opened configuration file /etc/smartd.conf 
Oct  8 06:48:45 porky kernel: apm: disabled - APM is not SMP safe.
Oct  8 06:48:45 porky smartd[2575]: Configuration file /etc/smartd.conf parsed. 
Oct  8 06:48:45 porky kernel: Starting balanced_irq
Oct  8 06:48:45 porky smartd[2575]: Device: /dev/hda, opened 
Oct  8 06:48:45 porky kernel: VFS: Disk quotas dquot_6.5.1
Oct  8 06:48:45 porky smartd[2575]: Device: /dev/hda, unable to read Device Identity Structure 
Oct  8 06:48:45 porky kernel: Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Oct  8 06:48:45 porky smartd[2575]: Unable to register ATA device /dev/hda at line 30 of file /etc/smartd.conf 
Oct  8 06:48:45 porky kernel: Initializing Cryptographic API
Oct  8 06:48:45 porky smartd[2575]: Unable to register device /dev/hda (no Directive -d removable). Exiting. 
Oct  8 06:48:45 porky kernel: vesafb: probe of vesafb0 failed with error -6
Oct  8 06:48:45 porky kernel: isapnp: Scanning for PnP cards...
Oct  8 06:48:45 porky smartd: smartd startup failed
Oct  8 06:48:45 porky kernel: isapnp: No Plug & Play device found
Oct  8 06:48:45 porky kernel: requesting new irq thread for IRQ8...
Oct  8 06:48:45 porky kernel: Real Time Clock Driver v1.12
Oct  8 06:48:45 porky kernel: requesting new irq thread for IRQ12...
Oct  8 06:48:45 porky kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Oct  8 06:48:45 porky kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Oct  8 06:48:45 porky kernel: io scheduler noop registered
Oct  8 06:48:45 porky kernel: io scheduler anticipatory registered
Oct  8 06:48:45 porky kernel: io scheduler deadline registered
Oct  8 06:48:45 porky kernel: io scheduler cfq registered
Oct  8 06:48:45 porky kernel: RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
Oct  8 06:48:45 porky kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
Oct  8 06:48:45 porky kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Oct  8 06:48:45 porky kernel: ICH: IDE controller at PCI slot 0000:00:1f.1
Oct  8 06:48:45 porky kernel: ICH: chipset revision 2
Oct  8 06:48:45 porky kernel: ICH: not 100%% native mode: will probe irqs later
Oct  8 06:48:45 porky kernel:     ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
Oct  8 06:48:45 porky kernel:     ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
Oct  8 06:48:45 porky kernel: hda: SAMSUNG CD-R/RW SW-248F, ATAPI CD/DVD-ROM drive
Oct  8 06:48:45 porky kernel: requesting new irq thread for IRQ14...
Oct  8 06:48:45 porky kernel: elevator: using anticipatory as default io scheduler
Oct  8 06:48:45 porky kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Oct  8 06:48:45 porky kernel: hdc: Lite-On LTN483S 48x Max, ATAPI CD/DVD-ROM drive
Oct  8 06:48:45 porky kernel: requesting new irq thread for IRQ15...
Oct  8 06:48:45 porky kernel: ide1 at 0x170-0x177,0x376 on irq 15
Oct  8 06:48:46 porky kernel: mice: PS/2 mouse device common for all mice
Oct  8 06:48:46 porky kernel: IRQ#12 thread started up.
Oct  8 06:48:46 porky kernel: requesting new irq thread for IRQ1...
Oct  8 06:48:46 porky kernel: IRQ#1 thread started up.
Oct  8 06:48:46 porky kernel: input: AT Translated Set 2 keyboard on isa0060/serio0
Oct  8 06:48:46 porky kernel: input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
Oct  8 06:48:46 porky kernel: md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
Oct  8 06:48:46 porky kernel: NET: Registered protocol family 2
Oct  8 06:48:46 porky kernel: IP: routing cache hash table of 2048 buckets, 32Kbytes
Oct  8 06:48:46 porky kernel: TCP: Hash tables configured (established 16384 bind 21845)
Oct  8 06:48:46 porky kernel: NET: Registered protocol family 1
Oct  8 06:48:46 porky kernel: NET: Registered protocol family 17
Oct  8 06:48:46 porky kernel: NET: Registered protocol family 8
Oct  8 06:48:46 porky kernel: NET: Registered protocol family 20
Oct  8 06:48:46 porky kernel: md: Autodetecting RAID arrays.
Oct  8 06:48:46 porky kernel: md: autorun ...
Oct  8 06:48:46 porky rc: Starting hpoj:  succeeded
Oct  8 06:48:46 porky kernel: md: ... autorun DONE.
Oct  8 06:48:46 porky kernel: RAMDISK: Compressed image found at block 0
Oct  8 06:48:46 porky kernel: VFS: Mounted root (ext2 filesystem).
Oct  8 06:48:46 porky kernel: SCSI subsystem initialized
Oct  8 06:48:46 porky kernel: PCI: Found IRQ 10 for device 0000:04:05.0
Oct  8 06:48:46 porky kernel: PCI: Sharing IRQ 10 with 0000:00:1f.3
Oct  8 06:48:47 porky kernel: requesting new irq thread for IRQ10...
Oct  8 06:48:47 porky kernel: PCI: Found IRQ 5 for device 0000:04:05.1
Oct  8 06:48:47 porky kernel: PCI: Sharing IRQ 5 with 0000:04:0a.0
Oct  8 06:48:47 porky kernel: requesting new irq thread for IRQ5...
Oct  8 06:48:47 porky kernel: scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
Oct  8 06:48:47 porky kernel:         <Adaptec aic7899 Ultra160 SCSI adapter>
Oct  8 06:48:47 porky kernel:         aic7899: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs
Oct  8 06:48:47 porky kernel: 
Oct  8 06:48:47 porky kernel: IRQ#10 thread started up.
Oct  8 06:48:47 porky kernel: (scsi0:A:0): 160.000MB/s transfers (80.000MHz DT, offset 127, 16bit)
Oct  8 06:48:47 porky kernel:   Vendor: QUANTUM   Model: ATLAS10K2-TY092L  Rev: DA40
Oct  8 06:48:47 porky kernel:   Type:   Direct-Access                      ANSI SCSI revision: 03
Oct  8 06:48:48 porky kernel: scsi0:A:0:0: Tagged Queuing enabled.  Depth 32
Oct  8 06:48:48 porky kernel: SCSI device sda: 17783239 512-byte hdwr sectors (9105 MB)
Oct  8 06:48:48 porky kernel: SCSI device sda: drive cache: write back
Oct  8 06:48:48 porky kernel:  sda: sda1 sda2 sda3
Oct  8 06:48:48 porky kernel: Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Oct  8 06:48:48 porky kernel: scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
Oct  8 06:48:48 porky kernel:         <Adaptec aic7899 Ultra160 SCSI adapter>
Oct  8 06:48:48 porky kernel:         aic7899: Ultra160 Wide Channel B, SCSI Id=7, 32/253 SCBs
Oct  8 06:48:48 porky kernel: 
Oct  8 06:48:48 porky kernel: IRQ#5 thread started up.
Oct  8 06:48:48 porky kernel: (scsi1:A:0): 20.000MB/s transfers (20.000MHz, offset 15)
Oct  8 06:48:48 porky kernel:   Vendor: SEAGATE   Model: SX118273LC        Rev: 6679
Oct  8 06:48:48 porky kernel:   Type:   Direct-Access                      ANSI SCSI revision: 02
Oct  8 06:48:48 porky kernel: scsi1:A:0:0: Tagged Queuing enabled.  Depth 32
Oct  8 06:48:48 porky kernel: SCSI device sdb: 35566480 512-byte hdwr sectors (18210 MB)
Oct  8 06:48:48 porky kernel: SCSI device sdb: drive cache: write through
Oct  8 06:48:48 porky kernel:  sdb: sdb1
Oct  8 06:48:48 porky kernel: Attached scsi disk sdb at scsi1, channel 0, id 0, lun 0
Oct  8 06:48:48 porky kernel: EXT3-fs: mounted filesystem with ordered data mode.
Oct  8 06:48:48 porky kernel: kjournald starting.  Commit interval 5 seconds
Oct  8 06:48:48 porky kernel: Freeing unused kernel memory: 284k freed
Oct  8 06:48:48 porky kernel: NET: Registered protocol family 10
Oct  8 06:48:48 porky kernel: IPv6 over IPv4 tunneling driver
Oct  8 06:48:48 porky kernel: IRQ#8 thread started up.
Oct  8 06:48:48 porky kernel: usbcore: registered new driver usbfs
Oct  8 06:48:48 porky kernel: usbcore: registered new driver hub
Oct  8 06:48:48 porky kernel: USB Universal Host Controller Interface driver v2.2
Oct  8 06:48:48 porky kernel: PCI: Found IRQ 11 for device 0000:00:1f.2
Oct  8 06:48:48 porky kernel: uhci_hcd 0000:00:1f.2: Intel Corp. 82801AA USB
Oct  8 06:48:48 porky kernel: requesting new irq thread for IRQ11...
Oct  8 06:48:48 porky kernel: uhci_hcd 0000:00:1f.2: irq 11, io base 0xff80
Oct  8 06:48:48 porky kernel: uhci_hcd 0000:00:1f.2: new USB bus registered, assigned bus number 1
Oct  8 06:48:48 porky kernel: hub 1-0:1.0: USB hub found
Oct  8 06:48:48 porky kernel: hub 1-0:1.0: 2 ports detected
Oct  8 06:48:48 porky kernel: EXT3 FS on sda2, internal journal
Oct  8 06:48:48 porky kernel: device-mapper: 4.1.0-ioctl (2003-12-10) initialised: dm@uk.sistina.com
Oct  8 06:48:48 porky kernel: Adding 1044216k swap on /dev/sda3.  Priority:-1 extents:1
Oct  8 06:48:48 porky kernel: program scsi_unique_id is using a deprecated SCSI ioctl, please convert it to SG_IO
Oct  8 06:48:49 porky last message repeated 11 times
Oct  8 06:48:49 porky kernel: kjournald starting.  Commit interval 5 seconds
Oct  8 06:48:49 porky kernel: EXT3 FS on sda1, internal journal
Oct  8 06:48:49 porky kernel: EXT3-fs: mounted filesystem with ordered data mode.
Oct  8 06:48:49 porky kernel: kjournald starting.  Commit interval 5 seconds
Oct  8 06:48:49 porky kernel: EXT3 FS on sdb1, internal journal
Oct  8 06:48:49 porky kernel: EXT3-fs: mounted filesystem with ordered data mode.
Oct  8 06:48:49 porky kernel: IA-32 Microcode Update Driver: v1.14 <tigran@veritas.com>
Oct  8 06:48:49 porky kernel: microcode: CPU0 already at revision 0x2 (current=0x2)
Oct  8 06:48:49 porky kernel: microcode: CPU1 already at revision 0x2 (current=0x2)
Oct  8 06:48:49 porky kernel: microcode: No suitable data for CPU0
Oct  8 06:48:49 porky kernel: microcode: No suitable data for CPU1
Oct  8 06:48:49 porky kernel: parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,EPP]
Oct  8 06:48:49 porky kernel: parport0: irq 7 detected
Oct  8 06:48:49 porky kernel: Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
Oct  8 06:48:49 porky kernel: Attached scsi generic sg1 at scsi1, channel 0, id 0, lun 0,  type 0
Oct  8 06:48:49 porky kernel: inserting floppy driver for 2.6.9-rc3-mm3-VP-T3
Oct  8 06:48:49 porky kernel: Floppy drive(s): fd0 is 1.44M
Oct  8 06:48:49 porky kernel: requesting new irq thread for IRQ6...
Oct  8 06:48:49 porky kernel: IRQ#6 thread started up.
Oct  8 06:48:49 porky kernel: FDC 0 is a National Semiconductor PC87306
Oct  8 06:48:49 porky kernel: Linux Tulip driver version 1.1.13 (May 11, 2002)
Oct  8 06:48:49 porky kernel: PCI: Found IRQ 5 for device 0000:04:0a.0
Oct  8 06:48:49 porky kernel: PCI: Sharing IRQ 5 with 0000:04:05.1
Oct  8 06:48:49 porky kernel: tulip0:  EEPROM default media type Autosense.
Oct  8 06:48:49 porky kernel: tulip0:  Index #0 - Media MII (#11) described by a 21140 MII PHY (1) block.
Oct  8 06:48:49 porky kernel: tulip0:  MII transceiver #3 config 3100 status 7809 advertising 01e1.
Oct  8 06:48:49 porky kernel: eth0: Digital DS21140 Tulip rev 32 at 0xe480, 00:00:C0:7F:A0:E9, IRQ 5.
Oct  8 06:48:49 porky kernel: tulip 0000:04:0a.0: Device was removed without properly calling pci_disable_device(). This may need fixing.
Oct  8 06:48:49 porky kernel: IRQ#14 thread started up.
Oct  8 06:48:49 porky kernel: hda: ATAPI 48X CD-ROM CD-R/RW drive, 8192kB Cache, UDMA(33)
Oct  8 06:48:49 porky kernel: Uniform CD-ROM driver Revision: 3.20
Oct  8 06:48:49 porky kernel: IRQ#15 thread started up.
Oct  8 06:48:49 porky kernel: hdc: ATAPI 48X CD-ROM drive, 120kB Cache, UDMA(33)
Oct  8 06:48:49 porky kernel: ip_tables: (C) 2000-2002 Netfilter core team
Oct  8 06:48:49 porky kernel: Linux Tulip driver version 1.1.13 (May 11, 2002)
Oct  8 06:48:49 porky kernel: PCI: Found IRQ 5 for device 0000:04:0a.0
Oct  8 06:48:49 porky kernel: PCI: Sharing IRQ 5 with 0000:04:05.1
Oct  8 06:48:49 porky kernel: tulip0:  EEPROM default media type Autosense.
Oct  8 06:48:49 porky kernel: tulip0:  Index #0 - Media MII (#11) described by a 21140 MII PHY (1) block.
Oct  8 06:48:49 porky kernel: tulip0:  MII transceiver #3 config 3100 status 7809 advertising 01e1.
Oct  8 06:48:49 porky kernel: eth0: Digital DS21140 Tulip rev 32 at 0xe480, 00:00:C0:7F:A0:E9, IRQ 5.
Oct  8 06:48:49 porky kernel: ip_tables: (C) 2000-2002 Netfilter core team
Oct  8 06:48:49 porky kernel: eth0: Setting full-duplex based on MII#3 link partner capability of 05e1.
Oct  8 06:48:49 porky kernel: parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,EPP]
Oct  8 06:48:49 porky kernel: parport0: irq 7 detected
Oct  8 06:48:49 porky kernel: lp0: using parport0 (polling).
Oct  8 06:48:50 porky cups: cupsd startup succeeded
Oct  8 06:48:50 porky sshd:  succeeded
Oct  8 06:48:50 porky xinetd: xinetd startup succeeded
Oct  8 06:48:50 porky ntpdate[2906]: step time server 192.168.36.1 offset -0.498488 sec
Oct  8 06:48:50 porky ntpd:  succeeded
Oct  8 06:48:50 porky ntpd[2910]: ntpd 4.2.0@1.1161-r Thu Mar 11 11:46:39 EST 2004 (1)
Oct  8 06:48:50 porky ntpd: ntpd startup succeeded
Oct  8 06:48:50 porky ntpd[2910]: precision = 1.000 usec
Oct  8 06:48:50 porky ntpd[2910]: kernel time sync status 0040
Oct  8 06:48:50 porky ntpd[2910]: frequency initialized 16.655 PPM from /var/lib/ntp/drift
Oct  8 06:48:50 porky ntpd[2910]: configure: keyword "authenticate" unknown, line ignored
Oct  8 06:48:50 porky vsftpd: vsftpd vsftpd succeeded
Oct  8 06:48:50 porky sendmail: sendmail startup succeeded
Oct  8 06:48:50 porky sendmail: sm-client startup succeeded
Oct  8 06:48:50 porky gpm[2959]: *** info [startup.c(95)]: 
Oct  8 06:48:50 porky gpm[2959]: Started gpm successfully. Entered daemon mode.
Oct  8 06:48:50 porky xinetd[2896]: xinetd Version 2.3.13 started with libwrap loadavg options compiled in.
Oct  8 06:48:50 porky xinetd[2896]: Started working: 2 available services
Oct  8 06:48:51 porky gpm[2959]: *** info [mice.c(1766)]: 
Oct  8 06:48:51 porky gpm[2959]: imps2: Auto-detected intellimouse PS/2
Oct  8 06:48:51 porky gpm: gpm startup succeeded
Oct  8 06:48:51 porky crond: crond startup succeeded
Oct  8 06:48:51 porky xfs: xfs startup succeeded
Oct  8 06:48:52 porky anacron: anacron startup succeeded
Oct  8 06:48:52 porky atd: atd startup succeeded
Oct  8 06:48:52 porky readahead: Starting background readahead: 
Oct  8 06:48:52 porky rc: Starting readahead:  succeeded
Oct  8 06:48:53 porky messagebus: messagebus startup succeeded
Oct  8 06:48:53 porky mdmonitor: mdadm succeeded
Oct  8 06:48:53 porky mdmpd: mdmpd succeeded

--------------070401000505040604000703--
