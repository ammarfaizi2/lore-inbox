Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750812AbVKWOP5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750812AbVKWOP5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 09:15:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750813AbVKWOP4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 09:15:56 -0500
Received: from wproxy.gmail.com ([64.233.184.196]:6645 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750812AbVKWOPz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 09:15:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QNl00DetX9HQdDuGvEHXIFbeWsUfzPPsESKYWswTeJMmOIgjr4bEjQDTePwnLR2Ul3oI9bxroGRURDX7OeKszZVIrvnmb7qaTpRH4ZuahoTupm1GqFgJqZsUZOYBToIikrnocYq46fUiFf59yMS3Y1yDMNLah5R6wRKYoJEuxE8=
Message-ID: <6bffcb0e0511230615y7531e268n@mail.gmail.com>
Date: Wed, 23 Nov 2005 15:15:51 +0100
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.15-rc2-mm1
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051123033550.00d6a6e8.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051123033550.00d6a6e8.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 23/11/05, Andrew Morton <akpm@osdl.org> wrote:
>
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15-rc2/2.6.15-rc2-mm1/
>


[1.] One line summary of the problem:
Oops while /etc/init.d/networking start. Full reproductible.

[3.] Keywords (i.e., modules, networking, kernel):
networking, iptables, netfilter

[4.] Kernel version (from /proc/version):
Linux version 2.6.15-rc2-mm1 (michal@debian) (gcc version 4.0.3
20051111 (prerelease) (Debian 4.0.2-4)) #12 SMP PREEMPT Wed Nov 23
14:19:16 CET 2005

[5.] Output of Oops
Nov 23 15:00:01 localhost kernel: eth0: network connection up using port A
Nov 23 15:00:01 localhost kernel:     speed:           100
Nov 23 15:00:01 localhost kernel:     autonegotiation: yes
Nov 23 15:00:01 localhost kernel:     duplex mode:     full
Nov 23 15:00:01 localhost kernel:     flowctrl:        symmetric
Nov 23 15:00:01 localhost kernel:     irq moderation:  disabled
Nov 23 15:00:01 localhost kernel:     scatter-gather:  enabled
Nov 23 15:00:01 localhost kernel: ip_tables: (C) 2000-2002 Netfilter core team
Nov 23 15:00:01 localhost kernel: Debug: sleeping function called from
invalid context at include/asm/semaphore.h:123
Nov 23 15:00:01 localhost kernel: in_atomic():1, irqs_disabled():0
Nov 23 15:00:01 localhost kernel:  [<c0103be6>] dump_stack+0x17/0x19
Nov 23 15:00:01 localhost kernel:  [<c011a0c3>] __might_sleep+0x9c/0xae
Nov 23 15:00:01 localhost kernel:  [<fd9a090d>]
translate_table+0x147/0xc14 [ip_tables]
Nov 23 15:00:01 localhost kernel:  [<fd9a2b2a>]
ipt_register_table+0x93/0x20d [ip_tables]
Nov 23 15:00:01 localhost kernel:  [<f98fe027>] init+0x27/0x9e [iptable_filter]
Nov 23 15:00:01 localhost kernel:  [<c01376d0>] sys_init_module+0xd7/0x26c
Nov 23 15:00:01 localhost kernel:  [<c0102cc7>] sysenter_past_esp+0x54/0x75
Nov 23 15:00:01 localhost kernel: ---------------------------
Nov 23 15:00:01 localhost kernel: | preempt count: 00000001 ]
Nov 23 15:00:01 localhost kernel: | 1 level deep critical section nesting:
Nov 23 15:00:01 localhost kernel: ----------------------------------------
Nov 23 15:00:01 localhost kernel: .. [<fd9a2aca>] ....
ipt_register_table+0x33/0x20d [ip_tables]
Nov 23 15:00:01 localhost kernel: .....[<f98fe027>] ..   ( <=
init+0x27/0x9e [iptable_filter])
Nov 23 15:00:01 localhost kernel:
Nov 23 15:00:01 localhost kernel: ip_conntrack version 2.4 (8185
buckets, 65480 max) - 172 bytes per conntrack
Nov 23 15:00:01 localhost kernel: scheduling while atomic:
iptables/0x00000001/2121
Nov 23 15:00:01 localhost kernel:  [<c0103be6>] dump_stack+0x17/0x19
Nov 23 15:00:01 localhost kernel:  [<c0297b5c>] schedule+0xb8c/0xe65
Nov 23 15:00:01 localhost kernel:  [<c0297f80>] wait_for_completion+0x95/0xf4
Nov 23 15:00:01 localhost kernel:  [<c012c72c>]
call_usermodehelper_keys+0xcb/0xdf
Nov 23 15:00:01 localhost kernel:  [<c012c476>] request_module+0x96/0xda
Nov 23 15:00:01 localhost kernel:  [<fd9a1170>]
translate_table+0x9aa/0xc14 [ip_tables]
Nov 23 15:00:01 localhost kernel:  [<fd9a1ac1>] do_replace+0x11f/0x7e6
[ip_tables]
Nov 23 15:00:01 localhost kernel:  [<fd9a2437>]
do_ipt_set_ctl+0x50/0x57 [ip_tables]
Nov 23 15:00:01 localhost kernel:  [<c026118c>] nf_sockopt+0xc2/0x128
Nov 23 15:00:01 localhost kernel:  [<c0261213>] nf_setsockopt+0x21/0x27
Nov 23 15:00:01 localhost kernel:  [<c026d2bc>] ip_setsockopt+0xc3/0xcfb
Nov 23 15:00:01 localhost kernel:  [<c0285ebc>] raw_setsockopt+0x25/0x50
Nov 23 15:00:01 localhost kernel:  [<c024a780>] sock_common_setsockopt+0x1e/0x25
Nov 23 15:00:01 localhost kernel:  [<c02480dd>] sys_setsockopt+0x4b/0x7f
Nov 23 15:00:01 localhost kernel:  [<c024875e>] sys_socketcall+0x212/0x275
Nov 23 15:00:01 localhost kernel:  [<c0102cc7>] sysenter_past_esp+0x54/0x75
Nov 23 15:00:01 localhost kernel: ---------------------------
Nov 23 15:00:01 localhost kernel: | preempt count: 00000001 ]
Nov 23 15:00:01 localhost kernel: | 1 level deep critical section nesting:
Nov 23 15:00:01 localhost kernel: ----------------------------------------
Nov 23 15:00:01 localhost kernel: .. [<fd9a1a18>] ....
do_replace+0x76/0x7e6 [ip_tables]
Nov 23 15:00:01 localhost kernel: .....[<fd9a2437>] ..   ( <=
do_ipt_set_ctl+0x50/0x57 [ip_tables])
Nov 23 15:00:01 localhost kernel:
Nov 23 15:00:01 localhost kernel: NET: Registered protocol family 10
Nov 23 15:00:01 localhost kernel: IPv6 over IPv4 tunneling driver
Nov 23 15:00:01 localhost kernel: eth0: no IPv6 routers present
Nov 23 15:00:02 localhost kernel: Debug: sleeping function called from
invalid context at arch/i386/lib/usercopy.c:728
Nov 23 15:00:02 localhost kernel: in_atomic():1, irqs_disabled():0
Nov 23 15:00:02 localhost kernel:  [<c0103be6>] dump_stack+0x17/0x19
Nov 23 15:00:02 localhost kernel:  [<c011a0c3>] __might_sleep+0x9c/0xae
Nov 23 15:00:02 localhost kernel:  [<c01cdd48>] copy_to_user+0x1b/0x63
Nov 23 15:00:02 localhost kernel:  [<fd9a15b4>]
copy_entries_to_user+0x6d/0x1a1 [ip_tables]
Nov 23 15:00:02 localhost kernel:  [<fd9a1864>]
get_entries+0x17c/0x1a1 [ip_tables]
Nov 23 15:00:02 localhost kernel:  [<fd9a24cd>]
do_ipt_get_ctl+0x8f/0x4e7 [ip_tables]
Nov 23 15:00:02 localhost kernel:  [<c0261159>] nf_sockopt+0x8f/0x128
Nov 23 15:00:02 localhost kernel:  [<c026123a>] nf_getsockopt+0x21/0x27
Nov 23 15:00:02 localhost kernel:  [<c026df71>] ip_getsockopt+0x7d/0x59c
Nov 23 15:00:02 localhost kernel:  [<c0285f0c>] raw_getsockopt+0x25/0x50
Nov 23 15:00:02 localhost kernel:  [<c024a708>] sock_common_getsockopt+0x1e/0x25
Nov 23 15:00:02 localhost kernel:  [<c0248154>] sys_getsockopt+0x43/0x7a
Nov 23 15:00:02 localhost kernel:  [<c0248786>] sys_socketcall+0x23a/0x275
Nov 23 15:00:02 localhost kernel:  [<c0102cc7>] sysenter_past_esp+0x54/0x75
Nov 23 15:00:02 localhost kernel: ---------------------------
Nov 23 15:00:02 localhost kernel: | preempt count: 00000001 ]
Nov 23 15:00:02 localhost kernel: | 1 level deep critical section nesting:
Nov 23 15:00:02 localhost kernel: ----------------------------------------
Nov 23 15:00:02 localhost kernel: .. [<fd9a159b>] ....
copy_entries_to_user+0x54/0x1a1 [ip_tables]
Nov 23 15:00:02 localhost kernel: .....[<fd9a1864>] ..   ( <=
get_entries+0x17c/0x1a1 [ip_tables])
Nov 23 15:00:02 localhost kernel:

[7.] Environment

[7.1.] Software
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux debian 2.6.15-rc2-mm1 #12 SMP PREEMPT Wed Nov 23 14:19:16 CET
2005 i686 GNU/Linux

Gnu C                  4.0.3
Gnu make               3.80
binutils               2.16.91
util-linux             2.12p
mount                  2.12p
module-init-tools      3.2-pre9
e2fsprogs              1.38
jfsutils               1.1.8
reiserfsprogs          3.6.19
reiser4progs           1.0.5
xfsprogs               2.7.7
Linux C Library        2.3.5
Dynamic linker (ldd)   2.3.5
Procps                 3.2.6
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.93
udev                   074
Modules Loaded         binfmt_misc ipv6 ipt_limit ipt_LOG ipt_REJECT
ip_conntrack_ftp ipt_state ip_conntrack iptable_filter ip_tables
af_packet ide_generic ide_cd cdrom ide_disk generic snd_intel8x0
snd_ac97_codec snd_ac97_bus snd_pcm_oss snd_mixer_oss psmouse snd_pcm
snd_timer snd parport_pc parport 8250_pnp sk98lin 8250 serial_core
piix rtc soundcore ide_core snd_page_alloc ehci_hcd intel_agp agpgart
hw_random uhci_hcd usbcore unix

[7.3.] Module information
binfmt_misc 9480 1 - Live 0xfd973000
ipv6 227008 8 - Live 0xfdeee000
ipt_limit 2432 7 - Live 0xfd98d000
ipt_LOG 6400 5 - Live 0xfd992000
ipt_REJECT 4736 1 - Live 0xfd95a000
ip_conntrack_ftp 6384 0 - Live 0xfd94a000
ipt_state 2048 0 - Live 0xf98fe000
ip_conntrack 41240 2 ip_conntrack_ftp,ipt_state, Live 0xfd967000
iptable_filter 2816 1 - Live 0xf8854000
ip_tables 21212 5
ipt_limit,ipt_LOG,ipt_REJECT,ipt_state,iptable_filter, Live 0xfd9a0000
af_packet 13960 2 - Live 0xfd955000
ide_generic 1536 0 [permanent], Live 0xf884b000
ide_cd 35460 0 - Live 0xfd940000
cdrom 34464 1 ide_cd, Live 0xfd936000
ide_disk 14592 0 - Live 0xfd931000
generic 4612 0 [permanent], Live 0xfd94d000
snd_intel8x0 27932 0 - Live 0xfd95f000
snd_ac97_codec 86048 1 snd_intel8x0, Live 0xfd9b3000
snd_ac97_bus 2432 1 snd_ac97_codec, Live 0xf8845000
snd_pcm_oss 45472 0 - Live 0xfd913000
snd_mixer_oss 16128 1 snd_pcm_oss, Live 0xf98f9000
psmouse 37284 0 - Live 0xfd908000
snd_pcm 76932 3 snd_intel8x0,snd_ac97_codec,snd_pcm_oss, Live 0xf98e5000
snd_timer 21252 1 snd_pcm, Live 0xf98de000
snd 46948 6 snd_intel8x0,snd_ac97_codec,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer,
Live 0xf98d1000
parport_pc 22212 0 - Live 0xfd901000
parport 21440 1 parport_pc, Live 0xf98ca000
8250_pnp 8832 0 - Live 0xf887c000
sk98lin 158944 0 - Live 0xf989d000
8250 24612 1 8250_pnp, Live 0xf8874000
serial_core 17792 1 8250, Live 0xf886e000
piix 9348 0 [permanent], Live 0xf8856000
rtc 10420 0 - Live 0xf8850000
soundcore 8032 1 snd, Live 0xf884d000
ide_core 109732 5 ide_generic,ide_cd,ide_disk,generic,piix, Live 0xf9881000
snd_page_alloc 8584 2 snd_intel8x0,snd_pcm, Live 0xf8847000
ehci_hcd 27784 0 - Live 0xf883a000
intel_agp 19228 1 - Live 0xf8834000
agpgart 27740 1 intel_agp, Live 0xf882c000
hw_random 4756 0 - Live 0xf8842000
uhci_hcd 29712 0 - Live 0xf885d000
usbcore 111620 3 ehci_hcd,uhci_hcd, Live 0xf880d000
unix 24208 54 - Live 0xf8867000

[7.8.] dmesg log
Linux version 2.6.15-rc2-mm1 (michal@debian) (gcc version 4.0.3
20051111 (prerelease) (Debian 4.0.2-4)) #12 SMP PREEMPT Wed Nov 23
14:19:16 CET 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e8000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003ff30000 (usable)
 BIOS-e820: 000000003ff30000 - 000000003ff40000 (ACPI data)
 BIOS-e820: 000000003ff40000 - 000000003fff0000 (ACPI NVS)
 BIOS-e820: 000000003fff0000 - 0000000040000000 (reserved)
 BIOS-e820: 00000000ffb80000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000ff780
On node 0 totalpages: 261936
  DMA zone: 4096 pages, LIFO batch:2
  DMA32 zone: 0 pages, LIFO batch:2
  Normal zone: 225280 pages, LIFO batch:64
  HighMem zone: 32560 pages, LIFO batch:16
DMI 2.3 present.
ACPI: RSDP (v000 ACPIAM                                ) @ 0x000f9e30
ACPI: RSDT (v001 A M I  OEMRSDT  0x10000414 MSFT 0x00000097) @ 0x3ff30000
ACPI: FADT (v002 A M I  OEMFACP  0x10000414 MSFT 0x00000097) @ 0x3ff30200
ACPI: MADT (v001 A M I  OEMAPIC  0x10000414 MSFT 0x00000097) @ 0x3ff30390
ACPI: OEMB (v001 A M I  OEMBIOS  0x10000414 MSFT 0x00000097) @ 0x3ff40040
ACPI: DSDT (v001  P4P81 P4P81104 0x00000104 INTL 0x02002026) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 15:2 APIC version 20
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 50000000 (gap: 40000000:bfb80000)
Built 1 zonelists
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
Kernel command line: root=/dev/sda1 ro
CPU 0 irqstacks, hard=c037a000 soft=c0378000
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 2798.917 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1022904k/1047744k available (1648k kernel code, 23992k
reserved, 679k data, 172k init, 130240k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 5603.43 BogoMIPS (lpj=2801716)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000
00004400 00000000 00000000
CPU: After vendor identify, caps: bfebfbff 00000000 00000000 00000000
00004400 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
CPU: After all inits, caps: bfebfbf7 00000000 00000000 00000080
00004400 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU0: Thermal monitoring enabled
mtrr: v2.0 (20020519)
Checking 'hlt' instruction... OK.
CPU0: Intel(R) Pentium(R) 4 CPU 2.80GHz stepping 05
Booting processor 1/1 eip 2000
CPU 1 irqstacks, hard=c037b000 soft=c0379000
Initializing CPU#1
Calibrating delay using timer specific routine.. 5596.57 BogoMIPS (lpj=2798286)
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000
00004400 00000000 00000000
CPU: After vendor identify, caps: bfebfbff 00000000 00000000 00000000
00004400 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
CPU: After all inits, caps: bfebfbf7 00000000 00000000 00000080
00004400 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel P4/Xeon Extended MCE MSRs (12) available
CPU1: Thermal monitoring enabled
CPU1: Intel(R) Pentium(R) 4 CPU 2.80GHz stepping 05
Total of 2 processors activated (11200.00 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
checking TSC synchronization across 2 CPUs: passed.
Brought up 2 CPUs
-> [0][1][ 262144]   0.0 [  0.0] (0): (    2578     1289)
-> [0][1][ 275941]   0.0 [  0.0] (0): (    3565     1138)
-> [0][1][ 290464]   0.0 [  0.0] (0): (    3013      845)
-> [0][1][ 305751]   0.0 [  0.0] (0): (    -549     2203)
-> [0][1][ 321843]   0.0 [  0.0] (0): (    1530     2141)
-> [0][1][ 338782]   0.0 [  0.0] (0): (    4217     2414)
-> [0][1][ 356612]   0.0 [  0.0] (0): (    6782     2489)
-> [0][1][ 375381]   0.0 [  0.0] (0): (     310     4480)
-> [0][1][ 395137]   0.0 [  0.0] (0): (   -3681     4235)
-> [0][1][ 415933]   0.0 [  0.0] (0): (    3258     5587)
-> [0][1][ 437824]   0.0 [  0.0] (0): (   11091     6710)
-> [0][1][ 460867]   0.0 [  0.0] (0): (   18919     7269)
-> [0][1][ 485123]   0.0 [  0.0] (0): (   19859     4104)
-> [0][1][ 510655]   0.0 [  0.0] (0): (   30075     7160)
-> [0][1][ 537531]   0.0 [  0.0] (0): (   73914    25499)
-> [0][1][ 565822]   0.0 [  0.0] (0): (   20161    39626)
-> [0][1][ 595602]   0.0 [  0.0] (0): (   -3449    31618)
-> [0][1][ 626949]   0.0 [  0.0] (0): (   13249    24158)
-> [0][1][ 659946]   0.0 [  0.0] (0): (   -9778    23592)
-> [0][1][ 694680]   0.0 [  0.0] (0): (   -6396    13487)
-> [0][1][ 731242]   0.0 [  0.0] (0): (   -6873     6982)
-> found max.
[0][1] working set size found: 537531, cost: 73914
---------------------
| migration cost matrix (max_cache_size: 524288, cpu: 2798 MHz):
---------------------
          [00]    [01]
[00]:     -     0.1(0)
[01]:   0.1(0)    -
--------------------------------
| cacheflush times [1]: 0.1 (147828)
| calibration delay: 0 seconds
--------------------------------
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xf0031, last bus=2
PCI: Using configuration type 1
ACPI: Subsystem revision 20050916
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI quirk: region 0800-087f claimed by ICH4 ACPI/GPIO/TCO
PCI quirk: region 0480-04bf claimed by ICH4 GPIO
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Boot video device is 0000:01:00.0
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P4._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 10 *11 12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 14 devices
SCSI subsystem initialized
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI: Cannot allocate resource region 0 of device 0000:00:00.0
pnp: 00:0a: ioport range 0x680-0x6ff has been reserved
pnp: 00:0a: ioport range 0x290-0x297 has been reserved
PCI: Bridge: 0000:00:01.0
  IO window: disabled.
  MEM window: f6000000-f7efffff
  PREFETCH window: e8000000-f4ffffff
PCI: Bridge: 0000:00:1e.0
  IO window: e000-efff
  MEM window: f7f00000-fbffffff
  PREFETCH window: disabled.
PCI: Setting latency timer of device 0000:00:1e.0 to 64
audit: initializing netlink socket (disabled)
audit(1132754358.103:1): initialized
highmem bounce pool size: 64 pages
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
io scheduler noop registered
io scheduler anticipatory registered
ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 16
nvidiafb: nVidia device/chipset 10DE0322
nvidiafb: CRTC0 analog found
nvidiafb: CRTC1 analog not found
nvidiafb: EDID found from BUS1
nvidiafb: CRTC 0 appears to have a CRT attached
nvidiafb: Using CRT on CRTC 0
nvidiafb: MTRR set to ON
Console: switching to colour frame buffer device 128x48
nvidiafb: PCI nVidia NV32 framebuffer (64MB @ 0xE8000000)
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f03:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
libata version 1.20 loaded.
ata_piix 0000:00:1f.2: version 1.05
ACPI: PCI Interrupt 0000:00:1f.2[A] -> GSI 18 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata1: SATA max UDMA/133 cmd 0xCC00 ctl 0xC882 bmdma 0xC400 irq 17
ata2: SATA max UDMA/133 cmd 0xC800 ctl 0xC482 bmdma 0xC408 irq 17
input: AT Translated Set 2 keyboard as /class/input/input0
ata1: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4003 85:7c69 86:3e01 87:4003 88:207f
ata1: dev 0 ATA-7, max UDMA/133, 398297088 sectors: LBA48
ata1: dev 0 configured for UDMA/133
scsi0 : ata_piix
ATA: abnormal status 0x7F on port 0xC807
scsi1 : ata_piix
  Vendor: ATA       Model: Maxtor 6Y200M0    Rev: YAR5
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 398297088 512-byte hdwr sectors (203928 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 398297088 512-byte hdwr sectors (203928 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3
sd 0:0:0:0: Attached scsi disk sda
NET: Registered protocol family 2
IP route cache hash table entries: 65536 (order: 6, 262144 bytes)
TCP established hash table entries: 131072 (order: 9, 3145728 bytes)
TCP bind hash table entries: 65536 (order: 8, 1572864 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
TCP bic registered
Starting balanced_irq
Using IPI Shortcut mode
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 172k freed
NET: Registered protocol family 1
usbcore: registered new driver usbfs
usbcore: registered new driver hub
USB Universal Host Controller Interface driver v2.3
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:1d.0: irq 16, io base 0x0000d480
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
hw_random hardware driver 1.0.0 loaded
Linux agpgart interface v0.101 (c) Dave Jones
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.1: irq 18, io base 0x0000d800
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Real Time Clock Driver v1.12
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.2: irq 17, io base 0x0000d880
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.3[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1d.3 to 64
uhci_hcd 0000:00:1d.3: UHCI Host Controller
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.3: irq 16, io base 0x0000dc00
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
agpgart: Detected an Intel 865 Chipset.
00:07: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
agpgart: AGP aperture is 64M @ 0x54000000
00:08: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
ACPI: PCI Interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: debug port 1
PCI: cache line size of 128 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 5
ehci_hcd 0000:00:1d.7: irq 19, io mem 0xf5fffc00
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 8 ports detected
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378 (0x778), irq 7 [PCSPP(,...)]
ICH5: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 17
ICH5: chipset revision 2
ICH5: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
hda: Maxtor 4D040H2, ATA DISK drive
input: ImPS/2 Generic Wheel Mouse as /class/input/input1
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: LITE-ON DVDRW SOHW-1653S, ATAPI CD/DVD-ROM drive
hdd: LITE-ON LTR-52327S, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
ACPI: PCI Interrupt 0000:02:05.0[A] -> GSI 22 (level, low) -> IRQ 20
ACPI: PCI Interrupt 0000:02:05.0[A] -> GSI 22 (level, low) -> IRQ 20
eth0: 3Com Gigabit LOM (3C940)
      PrefPort:A  RlmtMode:Check Link State
ACPI: PCI Interrupt 0000:00:1f.5[B] -> GSI 17 (level, low) -> IRQ 21
PCI: Setting latency timer of device 0000:00:1f.5 to 64
AC'97 0 analog subsections not ready
intel8x0_measure_ac97_clock: measured 51082 usecs
intel8x0: clocking to 48000
hda: max request size: 1024KiB
hda: 80022600 sectors (40971 MB) w/2048KiB Cache, CHS=16383/255/63, UDMA(100)
hda: cache flushes not supported
 hda: hda1 hda2 < hda5 hda6 >
hdc: ATAPI 48X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
hdd: ATAPI 52X CD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Adding 3903784k swap on /dev/sda2.  Priority:-1 extents:1 across:3903784k
EXT3 FS on sda1, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
NET: Registered protocol family 17
eth0: network connection up using port A
    speed:           100
    autonegotiation: yes
    duplex mode:     full
    flowctrl:        symmetric
    irq moderation:  disabled
    scatter-gather:  enabled
ip_tables: (C) 2000-2002 Netfilter core team
Debug: sleeping function called from invalid context at
include/asm/semaphore.h:123
in_atomic():1, irqs_disabled():0
 [<c0103be6>] dump_stack+0x17/0x19
 [<c011a0c3>] __might_sleep+0x9c/0xae
 [<fd9a090d>] translate_table+0x147/0xc14 [ip_tables]
 [<fd9a2b2a>] ipt_register_table+0x93/0x20d [ip_tables]
 [<f98fe027>] init+0x27/0x9e [iptable_filter]
 [<c01376d0>] sys_init_module+0xd7/0x26c
 [<c0102cc7>] sysenter_past_esp+0x54/0x75
---------------------------
| preempt count: 00000001 ]
| 1 level deep critical section nesting:
----------------------------------------
.. [<fd9a2aca>] .... ipt_register_table+0x33/0x20d [ip_tables]
.....[<f98fe027>] ..   ( <= init+0x27/0x9e [iptable_filter])

ip_conntrack version 2.4 (8185 buckets, 65480 max) - 172 bytes per conntrack
scheduling while atomic: iptables/0x00000001/2121
 [<c0103be6>] dump_stack+0x17/0x19
 [<c0297b5c>] schedule+0xb8c/0xe65
 [<c0297f80>] wait_for_completion+0x95/0xf4
 [<c012c72c>] call_usermodehelper_keys+0xcb/0xdf
 [<c012c476>] request_module+0x96/0xda
 [<fd9a1170>] translate_table+0x9aa/0xc14 [ip_tables]
 [<fd9a1ac1>] do_replace+0x11f/0x7e6 [ip_tables]
 [<fd9a2437>] do_ipt_set_ctl+0x50/0x57 [ip_tables]
 [<c026118c>] nf_sockopt+0xc2/0x128
 [<c0261213>] nf_setsockopt+0x21/0x27
 [<c026d2bc>] ip_setsockopt+0xc3/0xcfb
 [<c0285ebc>] raw_setsockopt+0x25/0x50
 [<c024a780>] sock_common_setsockopt+0x1e/0x25
 [<c02480dd>] sys_setsockopt+0x4b/0x7f
 [<c024875e>] sys_socketcall+0x212/0x275
 [<c0102cc7>] sysenter_past_esp+0x54/0x75
---------------------------
| preempt count: 00000001 ]
| 1 level deep critical section nesting:
----------------------------------------
.. [<fd9a1a18>] .... do_replace+0x76/0x7e6 [ip_tables]
.....[<fd9a2437>] ..   ( <= do_ipt_set_ctl+0x50/0x57 [ip_tables])

NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
eth0: no IPv6 routers present
Debug: sleeping function called from invalid context at
arch/i386/lib/usercopy.c:728
in_atomic():1, irqs_disabled():0
 [<c0103be6>] dump_stack+0x17/0x19
 [<c011a0c3>] __might_sleep+0x9c/0xae
 [<c01cdd48>] copy_to_user+0x1b/0x63
 [<fd9a15b4>] copy_entries_to_user+0x6d/0x1a1 [ip_tables]
 [<fd9a1864>] get_entries+0x17c/0x1a1 [ip_tables]
 [<fd9a24cd>] do_ipt_get_ctl+0x8f/0x4e7 [ip_tables]
 [<c0261159>] nf_sockopt+0x8f/0x128
 [<c026123a>] nf_getsockopt+0x21/0x27
 [<c026df71>] ip_getsockopt+0x7d/0x59c
 [<c0285f0c>] raw_getsockopt+0x25/0x50
 [<c024a708>] sock_common_getsockopt+0x1e/0x25
 [<c0248154>] sys_getsockopt+0x43/0x7a
 [<c0248786>] sys_socketcall+0x23a/0x275
 [<c0102cc7>] sysenter_past_esp+0x54/0x75
---------------------------
| preempt count: 00000001 ]
| 1 level deep critical section nesting:
----------------------------------------
.. [<fd9a159b>] .... copy_entries_to_user+0x54/0x1a1 [ip_tables]
.....[<fd9a1864>] ..   ( <= get_entries+0x17c/0x1a1 [ip_tables])


[7.11.] sysctl -A

[8.] Config file
#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.15-rc1-mm2
# Fri Nov 18 13:12:45 2005
#
CONFIG_X86_32=y
CONFIG_SEMAPHORE_SLEEPERS=y
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
CONFIG_CLEAN_COMPILE=y
CONFIG_LOCK_KERNEL=y
CONFIG_INIT_ENV_ARG_LIMIT=32

#
# General setup
#
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_SWAP=y
CONFIG_SWAP_PREFETCH=y
CONFIG_SYSVIPC=y
CONFIG_POSIX_MQUEUE=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
CONFIG_SYSCTL=y
CONFIG_AUDIT=y
CONFIG_AUDITSYSCALL=y
CONFIG_HOTPLUG=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_CPUSETS is not set
CONFIG_INITRAMFS_SOURCE=""
# CONFIG_EMBEDDED is not set
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
# CONFIG_KALLSYMS_EXTRA_PASS is not set
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_DOUBLEFAULT=y
CONFIG_ELF_CORE=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_SHMEM=y
CONFIG_CC_ALIGN_FUNCTIONS=0
CONFIG_CC_ALIGN_LABELS=0
CONFIG_CC_ALIGN_LOOPS=0
CONFIG_CC_ALIGN_JUMPS=0
CONFIG_SLAB=y
# CONFIG_INITRAMFS_SKIP is not set
CONFIG_SERIAL_PCI=y
# CONFIG_TINY_SHMEM is not set
CONFIG_BASE_SMALL=0
# CONFIG_SLOB is not set

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
# CONFIG_MODVERSIONS is not set
CONFIG_MODULE_SRCVERSION_ALL=y
CONFIG_KMOD=y
CONFIG_STOP_MACHINE=y

#
# Block layer
#
# CONFIG_LBD is not set
CONFIG_BLK_DEV_IO_TRACE=y

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=m
CONFIG_IOSCHED_CFQ=m
CONFIG_DEFAULT_AS=y
# CONFIG_DEFAULT_DEADLINE is not set
# CONFIG_DEFAULT_CFQ is not set
# CONFIG_DEFAULT_NOOP is not set
CONFIG_DEFAULT_IOSCHED="anticipatory"

#
# Processor type and features
#
CONFIG_X86_PC=y
# CONFIG_X86_ELAN is not set
# CONFIG_X86_VOYAGER is not set
# CONFIG_X86_NUMAQ is not set
# CONFIG_X86_SUMMIT is not set
# CONFIG_X86_BIGSMP is not set
# CONFIG_X86_VISWS is not set
# CONFIG_X86_GENERICARCH is not set
# CONFIG_X86_ES7000 is not set
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUMM is not set
CONFIG_MPENTIUM4=y
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MEFFICEON is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MGEODEGX1 is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_X86_GENERIC is not set
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=7
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_TSC=y
# CONFIG_HPET_TIMER is not set
CONFIG_SMP=y
CONFIG_NR_CPUS=2
CONFIG_SCHED_SMT=y
# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
CONFIG_PREEMPT=y
CONFIG_PREEMPT_BKL=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=m
CONFIG_X86_MCE_P4THERMAL=y
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_X86_REBOOTFIXUPS is not set
CONFIG_MICROCODE=m
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m

#
# Firmware Drivers
#
# CONFIG_EDD is not set
# CONFIG_DELL_RBU is not set
# CONFIG_DCDBAS is not set
# CONFIG_NOHIGHMEM is not set
CONFIG_HIGHMEM4G=y
# CONFIG_HIGHMEM64G is not set
CONFIG_HIGHMEM=y
CONFIG_ARCH_FLATMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_FLATMEM_MANUAL=y
# CONFIG_DISCONTIGMEM_MANUAL is not set
# CONFIG_SPARSEMEM_MANUAL is not set
CONFIG_FLATMEM=y
CONFIG_FLAT_NODE_MEM_MAP=y
CONFIG_SPARSEMEM_STATIC=y
CONFIG_SPLIT_PTLOCK_CPUS=4
# CONFIG_HIGHPTE is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
# CONFIG_EFI is not set
CONFIG_IRQBALANCE=y
CONFIG_REGPARM=y
CONFIG_SECCOMP=y
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
CONFIG_PHYSICAL_START=0x100000
CONFIG_KEXEC=y

#
# Power management options (ACPI, APM)
#
CONFIG_PM=y
# CONFIG_PM_LEGACY is not set
# CONFIG_PM_DEBUG is not set

#
# ACPI (Advanced Configuration and Power Interface) Support
#
CONFIG_ACPI=y
# CONFIG_ACPI_AC is not set
# CONFIG_ACPI_BATTERY is not set
# CONFIG_ACPI_BUTTON is not set
# CONFIG_ACPI_VIDEO is not set
# CONFIG_ACPI_HOTKEY is not set
CONFIG_ACPI_FAN=m
CONFIG_ACPI_PROCESSOR=m
CONFIG_ACPI_THERMAL=m
# CONFIG_ACPI_ASUS is not set
# CONFIG_ACPI_IBM is not set
# CONFIG_ACPI_TOSHIBA is not set
CONFIG_ACPI_BLACKLIST_YEAR=0
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_SYSTEM=y
# CONFIG_X86_PM_TIMER is not set
# CONFIG_ACPI_CONTAINER is not set

#
# APM (Advanced Power Management) BIOS Support
#

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set

#
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
#
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GOMMCONFIG is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
# CONFIG_PCIEPORTBUS is not set
# CONFIG_PCI_MSI is not set
CONFIG_PCI_LEGACY_PROC=y
# CONFIG_PCI_DEBUG is not set
CONFIG_ISA_DMA_API=y
# CONFIG_ISA is not set
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set
# CONFIG_HOTPLUG_CPU is not set

#
# PCCARD (PCMCIA/CardBus) support
#
# CONFIG_PCCARD is not set

#
# PCI Hotplug Support
#
# CONFIG_HOTPLUG_PCI is not set

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_AOUT=m
CONFIG_BINFMT_MISC=m

#
# Networking
#
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=m
# CONFIG_PACKET_MMAP is not set
CONFIG_UNIX=m
# CONFIG_NET_KEY is not set
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_FIB_HASH=y
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_ARPD is not set
CONFIG_SYN_COOKIES=y
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
# CONFIG_INET_TUNNEL is not set
CONFIG_INET_DIAG=m
CONFIG_INET_TCP_DIAG=m
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_BIC=y

#
# IP: Virtual Server Configuration
#
# CONFIG_IP_VS is not set
CONFIG_IPV6=m
# CONFIG_IPV6_PRIVACY is not set
# CONFIG_INET6_AH is not set
# CONFIG_INET6_ESP is not set
# CONFIG_INET6_IPCOMP is not set
# CONFIG_INET6_TUNNEL is not set
# CONFIG_IPV6_TUNNEL is not set
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_NETLINK=m
CONFIG_NETFILTER_NETLINK_QUEUE=m
CONFIG_NETFILTER_NETLINK_LOG=m

#
# IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=m
# CONFIG_IP_NF_CT_ACCT is not set
# CONFIG_IP_NF_CONNTRACK_MARK is not set
# CONFIG_IP_NF_CONNTRACK_EVENTS is not set
# CONFIG_IP_NF_CONNTRACK_NETLINK is not set
# CONFIG_IP_NF_CT_PROTO_SCTP is not set
CONFIG_IP_NF_FTP=m
# CONFIG_IP_NF_IRC is not set
# CONFIG_IP_NF_NETBIOS_NS is not set
# CONFIG_IP_NF_TFTP is not set
# CONFIG_IP_NF_AMANDA is not set
# CONFIG_IP_NF_PPTP is not set
# CONFIG_IP_NF_QUEUE is not set
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_LIMIT=m
CONFIG_IP_NF_MATCH_IPRANGE=m
CONFIG_IP_NF_MATCH_MAC=m
CONFIG_IP_NF_MATCH_PKTTYPE=m
CONFIG_IP_NF_MATCH_MARK=m
CONFIG_IP_NF_MATCH_MULTIPORT=m
CONFIG_IP_NF_MATCH_TOS=m
CONFIG_IP_NF_MATCH_RECENT=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_DSCP=m
CONFIG_IP_NF_MATCH_AH_ESP=m
CONFIG_IP_NF_MATCH_LENGTH=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_MATCH_TCPMSS=m
CONFIG_IP_NF_MATCH_HELPER=m
CONFIG_IP_NF_MATCH_STATE=m
CONFIG_IP_NF_MATCH_CONNTRACK=m
CONFIG_IP_NF_MATCH_OWNER=m
CONFIG_IP_NF_MATCH_ADDRTYPE=m
CONFIG_IP_NF_MATCH_REALM=m
# CONFIG_IP_NF_MATCH_SCTP is not set
# CONFIG_IP_NF_MATCH_DCCP is not set
CONFIG_IP_NF_MATCH_COMMENT=m
CONFIG_IP_NF_MATCH_HASHLIMIT=m
CONFIG_IP_NF_MATCH_STRING=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_LOG=m
# CONFIG_IP_NF_TARGET_ULOG is not set
CONFIG_IP_NF_TARGET_TCPMSS=m
CONFIG_IP_NF_TARGET_NFQUEUE=m
# CONFIG_IP_NF_NAT is not set
# CONFIG_IP_NF_MANGLE is not set
# CONFIG_IP_NF_RAW is not set
# CONFIG_IP_NF_ARPTABLES is not set

#
# IPv6: Netfilter Configuration (EXPERIMENTAL)
#
# CONFIG_IP6_NF_QUEUE is not set
# CONFIG_IP6_NF_IPTABLES is not set
# CONFIG_IP6_NF_TARGET_NFQUEUE is not set

#
# DCCP Configuration (EXPERIMENTAL)
#
# CONFIG_IP_DCCP is not set

#
# SCTP Configuration (EXPERIMENTAL)
#
# CONFIG_IP_SCTP is not set
# CONFIG_ATM is not set
# CONFIG_BRIDGE is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set
CONFIG_NET_CLS_ROUTE=y

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_HAMRADIO is not set
# CONFIG_IRDA is not set
# CONFIG_BT is not set
# CONFIG_IEEE80211 is not set

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_STANDALONE=y
# CONFIG_PREVENT_FIRMWARE_BUILD is not set
# CONFIG_FW_LOADER is not set
# CONFIG_DEBUG_DRIVER is not set

#
# Connector - unified userspace <-> kernelspace linker
#
CONFIG_CONNECTOR=m

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
# CONFIG_PARPORT_SERIAL is not set
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_GSC is not set
# CONFIG_PARPORT_1284 is not set

#
# Plug and Play support
#
CONFIG_PNP=y
# CONFIG_PNP_DEBUG is not set

#
# Protocols
#
CONFIG_PNPACPI=y

#
# Block devices
#
# CONFIG_BLK_DEV_FD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_COW_COMMON is not set
CONFIG_BLK_DEV_LOOP=m
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SX8 is not set
# CONFIG_BLK_DEV_UB is not set
# CONFIG_BLK_DEV_RAM is not set
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_CDROM_PKTCDVD=m
CONFIG_CDROM_PKTCDVD_BUFFERS=8
CONFIG_CDROM_PKTCDVD_WCACHE=y
# CONFIG_ATA_OVER_ETH is not set

#
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=m
CONFIG_BLK_DEV_IDE=m

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_IDE_SATA is not set
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=m
# CONFIG_IDEDISK_MULTI_MODE is not set
CONFIG_BLK_DEV_IDECD=m
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set
# CONFIG_IDE_TASK_IOCTL is not set

#
# IDE chipset support/bugfixes
#
CONFIG_IDE_GENERIC=m
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_IDEPNP is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_BLK_DEV_GENERIC=m
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_ATIIXP is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_CS5535 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_SC1200 is not set
CONFIG_BLK_DEV_PIIX=m
# CONFIG_BLK_DEV_IT821X is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_IDE_ARM is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_BLK_DEV_HD is not set

#
# SCSI device support
#
# CONFIG_RAID_ATTRS is not set
CONFIG_SCSI=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
# CONFIG_BLK_DEV_SR is not set
# CONFIG_CHR_DEV_SG is not set
# CONFIG_CHR_DEV_SCH is not set

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
# CONFIG_SCSI_MULTI_LUN is not set
# CONFIG_SCSI_CONSTANTS is not set
# CONFIG_SCSI_LOGGING is not set

#
# SCSI Transport Attributes
#
# CONFIG_SCSI_SPI_ATTRS is not set
# CONFIG_SCSI_FC_ATTRS is not set
# CONFIG_SCSI_ISCSI_ATTRS is not set
# CONFIG_SCSI_SAS_ATTRS is not set

#
# SCSI Transport Layers
#
# CONFIG_SAS_CLASS is not set

#
# SCSI low-level drivers
#
# CONFIG_ISCSI_TCP is not set
# CONFIG_SCSI_ARCMSR is not set
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_MEGARAID_SAS is not set
CONFIG_SCSI_SATA=y
# CONFIG_SCSI_SATA_AHCI is not set
# CONFIG_SCSI_PATA_AMD is not set
# CONFIG_SCSI_SATA_SVW is not set
# CONFIG_SCSI_PATA_TRIFLEX is not set
CONFIG_SCSI_ATA_PIIX=y
# CONFIG_SCSI_SATA_MV is not set
# CONFIG_SCSI_SATA_NV is not set
# CONFIG_SCSI_PATA_OPTI is not set
# CONFIG_SCSI_PDC_ADMA is not set
# CONFIG_SCSI_SATA_QSTOR is not set
# CONFIG_SCSI_PATA_PDC2027X is not set
# CONFIG_SCSI_SATA_PROMISE is not set
# CONFIG_SCSI_SATA_SX4 is not set
# CONFIG_SCSI_SATA_SIL is not set
# CONFIG_SCSI_SATA_SIL24 is not set
# CONFIG_SCSI_PATA_SIL680 is not set
# CONFIG_SCSI_SATA_SIS is not set
# CONFIG_SCSI_SATA_ULI is not set
# CONFIG_SCSI_PATA_VIA is not set
# CONFIG_SCSI_SATA_VIA is not set
# CONFIG_SCSI_SATA_VITESSE is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
CONFIG_SCSI_QLA2XXX=y
# CONFIG_SCSI_QLA21XX is not set
# CONFIG_SCSI_QLA22XX is not set
# CONFIG_SCSI_QLA2300 is not set
# CONFIG_SCSI_QLA2322 is not set
# CONFIG_SCSI_QLA6312 is not set
# CONFIG_SCSI_QLA24XX is not set
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_DEBUG is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set
# CONFIG_FUSION_SPI is not set
# CONFIG_FUSION_FC is not set
# CONFIG_FUSION_SAS is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
# CONFIG_I2O is not set

#
# Network device support
#
CONFIG_NETDEVICES=y
# CONFIG_DUMMY is not set
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
CONFIG_TUN=m
# CONFIG_NET_SB1000 is not set

#
# ARCnet devices
#
# CONFIG_ARCNET is not set

#
# PHY device support
#

#
# Ethernet (10 or 100Mbit)
#
# CONFIG_NET_ETHERNET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SIS190 is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
CONFIG_SK98LIN=m
# CONFIG_TIGON3 is not set
# CONFIG_BNX2 is not set

#
# Ethernet (10000 Mbit)
#
# CONFIG_CHELSIO_T1 is not set
# CONFIG_IXGB is not set
# CONFIG_S2IO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
# CONFIG_NET_FC is not set
# CONFIG_SHAPER is not set
# CONFIG_NETCONSOLE is not set
# CONFIG_KGDBOE is not set
# CONFIG_NETPOLL is not set
# CONFIG_NETPOLL_RX is not set
# CONFIG_NETPOLL_TRAP is not set
# CONFIG_NET_POLL_CONTROLLER is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set

#
# Input device support
#
CONFIG_INPUT=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_TSDEV is not set
CONFIG_INPUT_EVDEV=m
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=m
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_VSXXXAA is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
# CONFIG_SERIO_SERPORT is not set
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
# CONFIG_SERIO_RAW is not set
# CONFIG_GAMEPORT is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
# CONFIG_SERIAL_NONSTANDARD is not set

#
# Serial drivers
#
CONFIG_SERIAL_8250=m
# CONFIG_SERIAL_8250_ACPI is not set
CONFIG_SERIAL_8250_NR_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=m
# CONFIG_SERIAL_JSM is not set
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
# CONFIG_PRINTER is not set
# CONFIG_PPDEV is not set
# CONFIG_TIPAR is not set

#
# IPMI
#
# CONFIG_IPMI_HANDLER is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
CONFIG_HW_RANDOM=m
CONFIG_NVRAM=m
CONFIG_RTC=m
CONFIG_GEN_RTC=m
CONFIG_GEN_RTC_X=y
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
CONFIG_AGP=m
# CONFIG_AGP_ALI is not set
# CONFIG_AGP_ATI is not set
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_AMD64 is not set
CONFIG_AGP_INTEL=m
# CONFIG_AGP_NVIDIA is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_SWORKS is not set
# CONFIG_AGP_VIA is not set
# CONFIG_AGP_EFFICEON is not set
# CONFIG_DRM is not set
# CONFIG_MWAVE is not set
# CONFIG_RAW_DRIVER is not set
# CONFIG_HPET is not set
# CONFIG_HANGCHECK_TIMER is not set

#
# TPM devices
#
# CONFIG_TCG_TPM is not set
# CONFIG_TELCLOCK is not set

#
# I2C support
#
CONFIG_I2C=y
# CONFIG_I2C_CHARDEV is not set

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=y
# CONFIG_I2C_ALGOPCF is not set
# CONFIG_I2C_ALGOPCA is not set

#
# I2C Hardware Bus support
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_I801 is not set
# CONFIG_I2C_I810 is not set
# CONFIG_I2C_PIIX4 is not set
# CONFIG_I2C_NFORCE2 is not set
# CONFIG_I2C_PARPORT is not set
# CONFIG_I2C_PARPORT_LIGHT is not set
# CONFIG_I2C_PROSAVAGE is not set
# CONFIG_I2C_SAVAGE4 is not set
# CONFIG_SCx200_ACB is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_STUB is not set
# CONFIG_I2C_VIA is not set
# CONFIG_I2C_VIAPRO is not set
# CONFIG_I2C_VOODOO3 is not set
# CONFIG_I2C_PCA_ISA is not set

#
# Miscellaneous I2C Chip support
#
# CONFIG_SENSORS_DS1337 is not set
# CONFIG_SENSORS_DS1374 is not set
# CONFIG_SENSORS_EEPROM is not set
# CONFIG_SENSORS_PCF8574 is not set
# CONFIG_SENSORS_PCA9539 is not set
# CONFIG_SENSORS_PCF8591 is not set
# CONFIG_SENSORS_RTC8564 is not set
# CONFIG_SENSORS_MAX6875 is not set
# CONFIG_RTC_X1205_I2C is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# CONFIG_I2C_DEBUG_CHIP is not set

#
# Dallas's 1-wire bus
#
# CONFIG_W1 is not set

#
# Hardware Monitoring support
#
# CONFIG_HWMON is not set
# CONFIG_HWMON_VID is not set

#
# Misc devices
#
# CONFIG_IBM_ASM is not set

#
# Multimedia Capabilities Port drivers
#

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set

#
# Graphics support
#
CONFIG_FB=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
# CONFIG_FB_MACMODES is not set
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_TILEBLITTING=y
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_VESA is not set
CONFIG_VIDEO_SELECT=y
# CONFIG_FB_HGA is not set
# CONFIG_FB_S1D13XXX is not set
CONFIG_FB_NVIDIA=y
CONFIG_FB_NVIDIA_I2C=y
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I810 is not set
# CONFIG_FB_INTEL is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON_OLD is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_CYBLA is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_GEODE is not set
# CONFIG_FB_VIRTUAL is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE=y
# CONFIG_FRAMEBUFFER_CONSOLE_ROTATION is not set
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y

#
# Logo configuration
#
# CONFIG_LOGO is not set
CONFIG_BACKLIGHT_LCD_SUPPORT=y
CONFIG_BACKLIGHT_CLASS_DEVICE=m
CONFIG_BACKLIGHT_DEVICE=y
CONFIG_LCD_CLASS_DEVICE=m
CONFIG_LCD_DEVICE=y

#
# Speakup console speech
#
# CONFIG_SPEAKUP is not set

#
# Sound
#
CONFIG_SOUND=m

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=m
CONFIG_SND_AC97_CODEC=m
CONFIG_SND_AC97_BUS=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_RAWMIDI=m
CONFIG_SND_SEQUENCER=m
CONFIG_SND_SEQ_DUMMY=m
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=m
CONFIG_SND_PCM_OSS=m
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_RTCTIMER=m
CONFIG_SND_SEQ_RTCTIMER_DEFAULT=y
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set
CONFIG_SND_GENERIC_DRIVER=y

#
# Generic devices
#
CONFIG_SND_DUMMY=m
CONFIG_SND_VIRMIDI=m
# CONFIG_SND_MTPAV is not set
# CONFIG_SND_SERIAL_U16550 is not set
# CONFIG_SND_MPU401 is not set

#
# PCI devices
#
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_ATIIXP is not set
# CONFIG_SND_ATIIXP_MODEM is not set
# CONFIG_SND_AU8810 is not set
# CONFIG_SND_AU8820 is not set
# CONFIG_SND_AU8830 is not set
# CONFIG_SND_AZT3328 is not set
# CONFIG_SND_BT87X is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CS4281 is not set
# CONFIG_SND_EMU10K1 is not set
# CONFIG_SND_EMU10K1X is not set
# CONFIG_SND_CA0106 is not set
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_MIXART is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_HDSP is not set
# CONFIG_SND_HDSPM is not set
# CONFIG_SND_TRIDENT is not set
# CONFIG_SND_YMFPCI is not set
# CONFIG_SND_AD1889 is not set
# CONFIG_SND_ALS4000 is not set
# CONFIG_SND_CMIPCI is not set
# CONFIG_SND_ENS1370 is not set
# CONFIG_SND_CS5535AUDIO is not set
# CONFIG_SND_ENS1371 is not set
# CONFIG_SND_ES1938 is not set
# CONFIG_SND_ES1968 is not set
# CONFIG_SND_MAESTRO3 is not set
# CONFIG_SND_FM801 is not set
# CONFIG_SND_ICE1712 is not set
# CONFIG_SND_ICE1724 is not set
CONFIG_SND_INTEL8X0=m
# CONFIG_SND_INTEL8X0M is not set
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_VIA82XX is not set
# CONFIG_SND_VIA82XX_MODEM is not set
# CONFIG_SND_VX222 is not set
# CONFIG_SND_HDA_INTEL is not set

#
# USB devices
#
# CONFIG_SND_USB_AUDIO is not set
# CONFIG_SND_USB_USX2Y is not set

#
# Open Sound System
#
# CONFIG_SOUND_PRIME is not set

#
# USB support
#
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB_ARCH_HAS_OHCI=y
CONFIG_USB=m
# CONFIG_USB_DEBUG is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
# CONFIG_USB_BANDWIDTH is not set
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_SUSPEND is not set
# CONFIG_USB_OTG is not set

#
# USB Host Controller Drivers
#
CONFIG_USB_EHCI_HCD=m
# CONFIG_USB_EHCI_SPLIT_ISO is not set
# CONFIG_USB_EHCI_ROOT_HUB_TT is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_OHCI_HCD is not set
CONFIG_USB_UHCI_HCD=m
# CONFIG_USB_SL811_HCD is not set

#
# USB Device Class drivers
#
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set

#
# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
#

#
# may also be needed; see USB_STORAGE Help for more information
#
# CONFIG_USB_STORAGE is not set
# CONFIG_USB_LIBUSUAL is not set

#
# USB Input Devices
#
# CONFIG_USB_HID is not set

#
# USB HID Boot Protocol drivers
#
# CONFIG_USB_KBD is not set
# CONFIG_USB_MOUSE is not set
# CONFIG_USB_AIPTEK is not set
# CONFIG_USB_WACOM is not set
# CONFIG_USB_ACECAD is not set
# CONFIG_USB_KBTAB is not set
# CONFIG_USB_POWERMATE is not set
# CONFIG_USB_MTOUCH is not set
# CONFIG_USB_ITMTOUCH is not set
# CONFIG_USB_EGALAX is not set
# CONFIG_USB_YEALINK is not set
# CONFIG_USB_XPAD is not set
# CONFIG_USB_ATI_REMOTE is not set
# CONFIG_USB_KEYSPAN_REMOTE is not set
# CONFIG_USB_APPLETOUCH is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set

#
# USB Multimedia devices
#
# CONFIG_USB_DABUSB is not set

#
# Video4Linux support is needed for USB Multimedia device support
#

#
# USB Network Adapters
#
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_USBNET is not set
# CONFIG_USB_MON is not set

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set

#
# USB Serial Converter support
#
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_AUERSWALD is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_LED is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_GOTEMP is not set
# CONFIG_USB_PHIDGETKIT is not set
# CONFIG_USB_PHIDGETSERVO is not set
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_SISUSBVGA is not set
# CONFIG_USB_LD is not set
# CONFIG_USB_TEST is not set

#
# USB DSL modem support
#

#
# USB Gadget Support
#
# CONFIG_USB_GADGET is not set

#
# MMC/SD Card support
#
# CONFIG_MMC is not set

#
# InfiniBand support
#
# CONFIG_INFINIBAND is not set

#
# SN Devices
#

#
# EDAC - error detection and reporting (RAS)
#
# CONFIG_EDAC is not set

#
# Distributed Lock Manager
#
# CONFIG_DLM is not set

#
# File systems
#
CONFIG_EXT2_FS=m
CONFIG_EXT2_FS_XATTR=y
CONFIG_EXT2_FS_POSIX_ACL=y
CONFIG_EXT2_FS_SECURITY=y
CONFIG_EXT2_FS_XIP=y
CONFIG_FS_XIP=y
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
CONFIG_EXT3_FS_POSIX_ACL=y
CONFIG_EXT3_FS_SECURITY=y
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
CONFIG_FS_MBCACHE=y
CONFIG_REISER4_FS=m
# CONFIG_REISER4_DEBUG is not set
CONFIG_REISERFS_FS=m
# CONFIG_REISERFS_CHECK is not set
CONFIG_REISERFS_PROC_INFO=y
CONFIG_REISERFS_FS_XATTR=y
CONFIG_REISERFS_FS_POSIX_ACL=y
CONFIG_REISERFS_FS_SECURITY=y
CONFIG_JFS_FS=m
CONFIG_JFS_POSIX_ACL=y
CONFIG_JFS_SECURITY=y
# CONFIG_JFS_DEBUG is not set
CONFIG_JFS_STATISTICS=y
CONFIG_FS_POSIX_ACL=y
CONFIG_XFS_FS=m
CONFIG_XFS_QUOTA=y
CONFIG_XFS_SECURITY=y
CONFIG_XFS_POSIX_ACL=y
# CONFIG_XFS_RT is not set
# CONFIG_OCFS2_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_INOTIFY=y
CONFIG_QUOTA=y
# CONFIG_QFMT_V1 is not set
CONFIG_QFMT_V2=m
CONFIG_QUOTACTL=y
CONFIG_DNOTIFY=y
# CONFIG_AUTOFS_FS is not set
CONFIG_AUTOFS4_FS=m
CONFIG_FUSE_FS=m

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_ZISOFS_FS=m
CONFIG_UDF_FS=m
CONFIG_UDF_NLS=y

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
CONFIG_NTFS_FS=m
# CONFIG_NTFS_DEBUG is not set
CONFIG_NTFS_RW=y

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
# CONFIG_PROC_KCORE is not set
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_HUGETLBFS is not set
# CONFIG_HUGETLB_PAGE is not set
CONFIG_RAMFS=y
CONFIG_RELAYFS_FS=y
CONFIG_CONFIGFS_FS=m

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_ASFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
# CONFIG_NFS_FS is not set
# CONFIG_NFSD is not set
# CONFIG_SMB_FS is not set
# CONFIG_CIFS is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
# CONFIG_9P_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y

#
# Native Language Support
#
CONFIG_NLS=m
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=m
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
CONFIG_NLS_CODEPAGE_852=m
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
CONFIG_NLS_CODEPAGE_1250=m
# CONFIG_NLS_CODEPAGE_1251 is not set
# CONFIG_NLS_ASCII is not set
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
CONFIG_NLS_UTF8=m

#
# Instrumentation Support
#
CONFIG_PROFILING=y
CONFIG_OPROFILE=m
CONFIG_KPROBES=y

#
# Kernel hacking
#
# CONFIG_PRINTK_TIME is not set
CONFIG_DEBUG_KERNEL=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_LOG_BUF_SHIFT=20
CONFIG_DETECT_SOFTLOCKUP=y
CONFIG_SCHEDSTATS=y
CONFIG_DEBUG_SLAB=y
CONFIG_DEBUG_PREEMPT=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_SPINLOCK_SLEEP=y
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_HIGHMEM=y
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_DEBUG_INFO=y
CONFIG_PAGE_OWNER=y
CONFIG_DEBUG_FS=y
CONFIG_DEBUG_VM=y
CONFIG_FRAME_POINTER=y
CONFIG_RCU_TORTURE_TEST=m
CONFIG_EARLY_PRINTK=y
CONFIG_DEBUG_STACKOVERFLOW=y
CONFIG_DEBUG_STACK_USAGE=y
CONFIG_DEBUG_PAGEALLOC=y
# CONFIG_DEBUG_RODATA is not set
CONFIG_4KSTACKS=y
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y

#
# Security options
#
# CONFIG_KEYS is not set
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
# CONFIG_CRYPTO is not set

#
# Hardware crypto devices
#

#
# Library routines
#
CONFIG_CRC_CCITT=m
CONFIG_CRC16=m
CONFIG_CRC32=y
CONFIG_LIBCRC32C=m
CONFIG_ZLIB_INFLATE=m
CONFIG_ZLIB_DEFLATE=m
CONFIG_TEXTSEARCH=y
CONFIG_TEXTSEARCH_KMP=m
CONFIG_TEXTSEARCH_BM=m
CONFIG_TEXTSEARCH_FSM=m
CONFIG_GENERIC_HARDIRQS=y
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_X86_SMP=y
CONFIG_X86_HT=y
CONFIG_X86_BIOS_REBOOT=y
CONFIG_X86_TRAMPOLINE=y


OOPS Reporting Tool v.b6
www.wsi.edu.pl/~piotrowskim/
/files/ort/beta/

Regards,
Michal Piotrowski
