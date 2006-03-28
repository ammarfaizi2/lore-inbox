Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932193AbWC1Uoh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932193AbWC1Uoh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 15:44:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932196AbWC1Uog
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 15:44:36 -0500
Received: from ws6-2.us4.outblaze.com ([205.158.62.197]:29126 "HELO
	ws6-2.us4.outblaze.com") by vger.kernel.org with SMTP
	id S932193AbWC1Uog (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 15:44:36 -0500
Message-ID: <4429A027.1010509@daxsolutions.com>
Date: Tue, 28 Mar 2006 12:44:23 -0800
From: Paul Risenhoover <prisenhoover@daxsolutions.com>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: kernel: BUG: soft lockup detected on CPU#0!
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings friends,

I have been experiencing a number of networking issues with three new 
machines I have purchased.  They are Dell SC1425 machines, each with two 
64-bit processors.  I have attached the dmesg log to this email for your 
review.

The symptom is simply that every once and a while the machine appears to 
go off line.  I can ping it and it responds, but I cannot SSH into it or 
generally get any other type of network access to it.  This happened a 
few times and so I turned kernel logging on in the hopes that I could 
catch some debugging information.  Here's what I found this morning 
(after the machine went down).  In order to restart the machine I had to 
pull the plug.  It would not respond to the three-fingered salute or to 
the power button.

Additionally, you will not that I am not running an SMP kernel right 
now, even though I have a dual-processor machine.  The reason is that 
when I run the SMP kernel I get frequent Kernel Panics, and I have not 
been able to gather the required log information to provide this list 
(although it was an smbfs panic complaining about not being able to 
allocate a spin-lock).

Let me know what else I can provide.

Mar 28 07:52:39 xenon kernel: SELinux: initialized (dev smbfs, type 
smbfs), uses genfs_contexts
Mar 28 07:54:54 xenon kernel: SELinux: initialized (dev smbfs, type 
smbfs), uses genfs_contexts
Mar 28 07:55:33 xenon kernel: smb_receive_header: long packet: 65648
Mar 28 07:56:03 xenon kernel: smb_add_request: request 
[ffff81003c1e2380, mid=1114] timed out!
Mar 28 07:56:03 xenon kernel: smb_lookup: find 
625/b5aa7496-PICT0324_prv.jpg failed, error=-5
Mar 28 07:56:04 xenon kernel: smb_add_request: request 
[ffff81003c1e2200, mid=1115] timed out!
Mar 28 07:56:08 xenon kernel: smb_add_request: request 
[ffff81003c1e2080, mid=1116] timed out!
Mar 28 07:56:33 xenon kernel: smb_add_request: request 
[ffff81003c1e2380, mid=1117] timed out!
Mar 28 07:56:33 xenon kernel: smb_add_request: request 
[ffff81003c1e2500, mid=1118] timed out!
Mar 28 07:56:33 xenon kernel: smb_lookup: find 625/6d537496-PICT0322 
copy_prv.jpg failed, error=-5
Mar 28 07:56:38 xenon kernel: smb_add_request: request 
[ffff81003c1e2080, mid=1119] timed out!
Mar 28 07:57:03 xenon kernel: smb_add_request: request 
[ffff81003c1e2380, mid=1120] timed out!
Mar 28 07:57:03 xenon kernel: smb_add_request: request 
[ffff81003c1e2200, mid=1121] timed out!
Mar 28 07:57:03 xenon kernel: smb_lookup: find 625/6ec17396-PICT0306 
copy_prv.jpg failed, error=-5
Mar 28 07:57:03 xenon kernel: smb_add_request: request 
[ffff81003c1e2500, mid=1122] timed out!
Mar 28 07:57:23 xenon kernel: smb_add_request: request 
[ffff81003c1e2e00, mid=1123] timed out!
Mar 28 07:57:33 xenon kernel: smb_add_request: request 
[ffff81003c1e2380, mid=1124] timed out!
Mar 28 07:57:33 xenon kernel: smb_add_request: request 
[ffff81003c1e2b00, mid=1125] timed out!
Mar 28 07:57:33 xenon kernel: smb_lookup: find 625/14537396-PICT0289 
copy_prv.jpg failed, error=-5
Mar 28 07:57:33 xenon kernel: smb_add_request: request 
[ffff81003c1e2200, mid=1126] timed out!
Mar 28 07:57:53 xenon kernel: smb_add_request: request 
[ffff81003c1e2e00, mid=1127] timed out!
Mar 28 07:58:03 xenon kernel: smb_add_request: request 
[ffff81003c1e2380, mid=1128] timed out!
Mar 28 07:58:03 xenon kernel: smb_add_request: request 
[ffff81003c1e2680, mid=1129] timed out!
Mar 28 07:58:03 xenon kernel: smb_lookup: find 625/a6c37296-PICT0288 
copy_prv.jpg failed, error=-5
Mar 28 08:10:07 xenon kernel: BUG: soft lockup detected on CPU#0!
Mar 28 08:10:07 xenon kernel: Mar 28 08:10:07 xenon kernel: Modules 
linked in: smbfs md5 ipv6 parport_pc lp parport autofs4 i2c_dev i2c_core 
rfcomm l2cap bluetooth sunrpc pcmcia yenta_socket rsrc_nonstatic 
pcmcia_core video button battery ac uhci_hcd ehci_hcd shpchp e1000 
dm_snapshot dm_zero dm_mirror ext3 jbd dm_mod ata_piix libata sd_mod 
scsi_mod
Mar 28 08:10:07 xenon kernel: Pid: 2601, comm: smbiod Not tainted 
2.6.11-1.1369_FC4
Mar 28 08:10:07 xenon kernel: RIP: 0010:[<ffffffff80349754>] 
<ffffffff80349754>{skb_copy_datagram_iovec+52}
Mar 28 08:10:07 xenon kernel: RSP: 0018:ffff810073219b58  EFLAGS: 00000206
Mar 28 08:10:07 xenon kernel: RAX: ffff810073219e08 RBX: 
0000000000000003 RCX: 0000000000000000
Mar 28 08:10:07 xenon kernel: RDX: ffff810073219e48 RSI: 
00000000000000c5 RDI: ffff81005ddbb380
Mar 28 08:10:07 xenon kernel: RBP: 00000000000000c5 R08: 
0000000000000000 R09: 0000000000004000
Mar 28 08:10:07 xenon kernel: R10: ffffffff804cc7e0 R11: 
0000000000000048 R12: 00000000000000c8
Mar 28 08:18:10 xenon kernel: R13: ffff810064a72160 R14: 
00000000000000c5 R15: 0000000000000000
Mar 28 08:18:10 xenon kernel: FS:  00002aaaaadfc6e0(0000) 
GS:ffffffff80576c00(0000) knlGS:0000000000000000
Mar 28 08:18:10 xenon kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 
000000008005003b
Mar 28 08:22:11 xenon kernel: CR2: 00002aaaaaaac000 CR3: 
000000003e11c000 CR4: 00000000000006e0
Mar 28 08:22:11 xenon kernel: Mar 28 08:22:11 xenon kernel: Call 
Trace:<ffffffff8037a148>{tcp_recvmsg+1320} 
<ffffffff80343df3>{sock_common_recvmsg+51}
Mar 28 08:22:11 xenon kernel:        
<ffffffff80343210>{sock_recvmsg+304} 
<ffffffff8015cad0>{autoremove_wake_function+0}
Mar 28 08:22:11 xenon kernel:        <ffffffff8034468f>{lock_sock+783} 
<ffffffff803439fb>{kernel_recvmsg+59}
Mar 28 08:22:11 xenon kernel:        
<ffffffff8821face>{:smbfs:smb_receive_drop+158} 
<ffffffff8039b2a7>{inet_ioctl+167}
Mar 28 08:22:11 xenon kernel:        
<ffffffff88222896>{:smbfs:smb_request_recv+86} 
<ffffffff8039b2a7>{inet_ioctl+167}
Mar 28 08:22:11 xenon kernel:        
<ffffffff882224c8>{:smbfs:smbiod+1080} 
<ffffffff8015cad0>{autoremove_wake_function+0}
Mar 28 08:22:11 xenon kernel:        <ffffffff8010fc33>{child_rip+8} 
<ffffffff88222090>{:smbfs:smbiod+0}
Mar 28 08:22:11 xenon kernel:        <ffffffff8010fc2b>{child_rip+0} Mar 
28 08:22:11 xenon kernel: Mar 28 08:22:11 xenon kernel: Call Trace: 
<IRQ> <ffffffff8017012d>{softlockup_tick+285} 
<ffffffff80113fc1>{timer_interrupt+913}
Mar 28 08:22:11 xenon kernel:        
<ffffffff801703ec>{handle_IRQ_event+44} <ffffffff801705fd>{__do_IRQ+477}
Mar 28 08:22:11 xenon kernel:        <ffffffff8013c54e>{profile_tick+78} 
<ffffffff801120b8>{do_IRQ+72}
Mar 28 08:22:11 xenon kernel:        
<ffffffff8010f6c3>{ret_from_intr+0}  <EOI> 
<ffffffff80349754>{skb_copy_datagram_iovec+52}
Mar 28 08:22:11 xenon kernel:        
<ffffffff8037a148>{tcp_recvmsg+1320} 
<ffffffff80343df3>{sock_common_recvmsg+51}
Mar 28 08:22:11 xenon kernel:        
<ffffffff80343210>{sock_recvmsg+304} 
<ffffffff8015cad0>{autoremove_wake_function+0}
Mar 28 08:22:11 xenon kernel:        <ffffffff8034468f>{lock_sock+783} 
<ffffffff803439fb>{kernel_recvmsg+59}
Mar 28 08:22:11 xenon kernel:        
<ffffffff8821face>{:smbfs:smb_receive_drop+158} 
<ffffffff8039b2a7>{inet_ioctl+167}
Mar 28 08:22:11 xenon kernel:        
<ffffffff88222896>{:smbfs:smb_request_recv+86} 
<ffffffff8039b2a7>{inet_ioctl+167}
Mar 28 08:24:12 xenon kernel:        
<ffffffff882224c8>{:smbfs:smbiod+1080} 
<ffffffff8015cad0>{autoremove_wake_function+0}
Mar 28 08:24:12 xenon kernel:        <ffffffff8010fc33>{child_rip+8} 
<ffffffff88222090>{:smbfs:smbiod+0}
Mar 28 08:24:12 xenon kernel:        <ffffffff8010fc2b>{child_rip+0} Mar 
28 08:24:12 xenon kernel: smb_add_request: request [ffff81003c1e2200, 
mid=1130] timed out!
Mar 28 08:24:12 xenon kernel: smb_add_request: request 
[ffff81003c1e2b00, mid=1131] timed out!
Mar 28 08:24:12 xenon kernel: smb_add_request: request 
[ffff81003c1e2380, mid=1132] timed out!
Mar 28 08:24:12 xenon kernel: smb_add_request: request 
[ffff81003c1e2500, mid=1133] timed out!
Mar 28 08:24:12 xenon kernel: smb_lookup: find 
625/a0547296-PICT0282_prv.jpg failed, error=-5
Mar 28 08:24:12 xenon kernel: BUG: soft lockup detected on CPU#0!
Mar 28 08:24:12 xenon kernel: Mar 28 08:24:12 xenon kernel: Modules 
linked in: smbfs md5 ipv6 parport_pc lp parport autofs4 i2c_dev i2c_core 
rfcomm l2cap bluetooth sunrpc pcmcia yenta_socket rsrc_nonstatic 
pcmcia_core video button battery ac uhci_hcd ehci_hcd shpchp e1000 
dm_snapshot dm_zero dm_mirror ext3 jbd dm_mod ata_piix libata sd_mod 
scsi_mod
Mar 28 08:24:12 xenon kernel: Pid: 2601, comm: smbiod Not tainted 
2.6.11-1.1369_FC4
Mar 28 08:24:12 xenon kernel: RIP: 0010:[<ffffffff80221f8f>] 
<ffffffff80221f8f>{avc_has_perm_noaudit+815}
Mar 28 08:24:12 xenon kernel: RSP: 0018:ffff810073219ab8  EFLAGS: 00000286
Mar 28 08:24:12 xenon kernel: RAX: 0000000000000002 RBX: 
ffff810079f88f38 RCX: ffff810079f88f38
Mar 28 08:24:12 xenon kernel: RDX: 000000000000000f RSI: 
ffffffff80541ed0 RDI: 000000000000000f
Mar 28 08:24:12 xenon kernel: RBP: 0000000000000001 R08: 
ffff810073219b78 R09: 0000000000000000
Mar 28 08:24:12 xenon kernel: R10: ffff810073219bd8 R11: 
0000000000000048 R12: ffff81000de60880
Mar 28 08:33:55 xenon kernel: R13: 00000000000000e9 R14: 
000000000000003a R15: ffff810073219b78
Mar 28 08:33:55 xenon kernel: FS:  00002aaaaadfc6e0(0000) 
GS:ffffffff80576c00(0000) knlGS:0000000000000000
Mar 28 08:33:55 xenon kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 
000000008005003b
Mar 28 08:33:55 xenon kernel: CR2: 00000000005aa2f0 CR3: 
0000000066f19000 CR4: 00000000000006e0
Mar 28 08:33:55 xenon kernel: Mar 28 08:33:55 xenon kernel: Call 
Trace:<ffffffff80222e4c>{avc_has_perm+60} 
<ffffffff8022601c>{socket_has_perm+108}
Mar 28 08:33:55 xenon kernel:        
<ffffffff80343df3>{sock_common_recvmsg+51} 
<ffffffff803431f5>{sock_recvmsg+277}
Mar 28 08:33:55 xenon kernel:        
<ffffffff880f5330>{:uhci_hcd:stall_callback+0} 
<ffffffff8015cad0>{autoremove_wake_function+0}
Mar 28 08:33:55 xenon kernel:        <ffffffff8034468f>{lock_sock+783} 
<ffffffff803439fb>{kernel_recvmsg+59}
Mar 28 08:33:55 xenon kernel:        
<ffffffff8821face>{:smbfs:smb_receive_drop+158} 
<ffffffff8039b2a7>{inet_ioctl+167}
Mar 28 08:33:55 xenon kernel:        
<ffffffff88222896>{:smbfs:smb_request_recv+86} 
<ffffffff8039b2a7>{inet_ioctl+167}
Mar 28 08:33:55 xenon kernel:        
<ffffffff882224c8>{:smbfs:smbiod+1080} 
<ffffffff8015cad0>{autoremove_wake_function+0}
Mar 28 08:33:55 xenon kernel:        <ffffffff8010fc33>{child_rip+8} 
<ffffffff88222090>{:smbfs:smbiod+0}
Mar 28 08:41:47 xenon kernel: klogd 1.4.1, log source = /proc/kmsg started.
Mar 28 08:41:47 xenon kernel: Bootdata ok (command line is ro 
root=/dev/VolGroup00/LogVol00)
Mar 28 08:41:47 xenon kernel: Linux version 2.6.15-1.1833_FC4 
(bhcompile@hs20-bc1-3.build.redhat.com) (gcc version 4.0.2 20051125 (Red 
Hat 4.0.2-8)) #1 Wed Mar 1 23:41:25 EST 2006
Mar 28 08:41:47 xenon kernel: BIOS-provided physical RAM map:
Mar 28 08:41:47 xenon kernel:  BIOS-e820: 0000000000000000 - 
00000000000a0000 (usable)
Mar 28 08:41:47 xenon kernel:  BIOS-e820: 0000000000100000 - 
000000007ffc0000 (usable)

Any help or advice would be appreciated.

Very grateful,
Paul


Dmesg --
X-Account-Key: account2
Return-Path: <root@daxsolutions.com>
Delivered-To: prisenhoover:daxsolutions.com@register.com
Received: (qmail 16724 invoked by uid 0); 28 Mar 2006 18:10:39 -0000
X-OB-Received: from unknown (192.168.9.161)
  by mta6-3.us4.outblaze.com; 28 Mar 2006 18:10:39 -0000
Received: from av1-1.us4.outblaze.com (localhost.localdomain [127.0.0.1])
    by av1-1.us4.outblaze.com (Postfix) with SMTP id 0342949C101
    for <"prisenhoover:daxsolutions.com"@register.com.av.int>; Tue, 28 
Mar 2006 18:10:39 +0000 (GMT)
Received: from xenon.daxsolutions.com (daxsolutions.com [209.223.177.250])
    by spf6-2s.us4.outblaze.com (Postfix) with ESMTP id C85551AC52B
    for <prisenhoover@daxsolutions.com>; Tue, 28 Mar 2006 18:10:37 +0000 
(GMT)
Received: by xenon.daxsolutions.com (Postfix, from userid 0)
    id E515840072; Tue, 28 Mar 2006 10:05:48 -0800 (PST)
To: prisenhoover@daxsolutions.com
Subject: Kernel Log
Message-Id: <20060328180548.E515840072@xenon.daxsolutions.com>
Date: Tue, 28 Mar 2006 10:05:48 -0800 (PST)
From: root@daxsolutions.com (root)

Bootdata ok (command line is ro root=/dev/VolGroup00/LogVol00)
Linux version 2.6.15-1.1833_FC4 (bhcompile@hs20-bc1-3.build.redhat.com) 
(gcc version 4.0.2 20051125 (Red Hat 4.0.2-8)) #1 Wed Mar 1 23:41:25 EST 
2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 0000000000100000 - 000000007ffc0000 (usable)
 BIOS-e820: 000000007ffc0000 - 000000007ffcfc00 (ACPI data)
 BIOS-e820: 000000007ffcfc00 - 000000007ffff000 (reserved)
 BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec90000 (reserved)
 BIOS-e820: 00000000fed00000 - 00000000fed00400 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
 BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
ACPI: RSDP (v000 DELL                                  ) @ 
0x00000000000fd650
ACPI: RSDT (v001 DELL   PESC1425 0x00000001 MSFT 0x0100000a) @ 
0x00000000000fd664
ACPI: FADT (v001 DELL   PESC1425 0x00000001 MSFT 0x0100000a) @ 
0x00000000000fd6b0
ACPI: MADT (v001 DELL   PESC1425 0x00000001 MSFT 0x0100000a) @ 
0x00000000000fd724
ACPI: SPCR (v001 DELL   PESC1425 0x00000001 MSFT 0x0100000a) @ 
0x00000000000fd7c0
ACPI: HPET (v001 DELL   PESC1425 0x00000001 MSFT 0x0100000a) @ 
0x00000000000fd810
ACPI: MCFG (v001 DELL   PESC1425 0x00000001 MSFT 0x0100000a) @ 
0x00000000000fd848
ACPI: DSDT (v001 DELL   PESC1425 0x00000001 MSFT 0x0100000e) @ 
0x0000000000000000
On node 0 totalpages: 515860
  DMA zone: 2843 pages, LIFO batch:0
  DMA32 zone: 513017 pages, LIFO batch:31
  Normal zone: 0 pages, LIFO batch:0
  HighMem zone: 0 pages, LIFO batch:0
ACPI: PM-Timer IO Port: 0x808
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:4 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x06] enabled)
Processor #6 15:4 APIC version 20
WARNING: NR_CPUS limit of 1 reached. Processor ignored.
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x01] enabled)
Processor #1 15:4 APIC version 20
WARNING: NR_CPUS limit of 1 reached. Processor ignored.
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x07] enabled)
Processor #7 15:4 APIC version 20
WARNING: NR_CPUS limit of 1 reached. Processor ignored.
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
ACPI: IOAPIC (id[0x08] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 8, version 32, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x09] address[0xfec80000] gsi_base[32])
IOAPIC[1]: apic_id 9, version 32, address 0xfec80000, GSI 32-55
ACPI: IOAPIC (id[0x0a] address[0xfec80800] gsi_base[64])
IOAPIC[2]: apic_id 10, version 32, address 0xfec80800, GSI 64-87
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Setting APIC routing to flat
ACPI: HPET id: 0xffffffff base: 0xfed00000
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 80000000 (gap: 7ffff000:60001000)
Checking aperture...
Built 1 zonelists
Kernel command line: ro root=/dev/VolGroup00/LogVol00
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 131072 bytes)
time.c: Using 14.318180 MHz HPET timer.
time.c: Detected 3000.201 MHz processor.
time.c: Using HPET/TSC based timekeeping.
Console: colour VGA+ 80x25
Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Memory: 2058060k/2096896k available (2298k kernel code, 38252k reserved, 
1377k data, 188k init)
Calibrating delay using timer specific routine.. 6005.16 BogoMIPS 
(lpj=12010334)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 256
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 2048K
using mwait in idle threads.
CPU0: Thermal monitoring enabled (TM1)
mtrr: v2.0 (20020519)
CPU:                   Intel(R) Xeon(TM) CPU 3.00GHz stepping 03
Using local APIC timer interrupts.
Detected 12.500 MHz APIC timer.
testing NMI watchdog ... OK.
checking if image is initramfs... it is
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using configuration type 1
PCI: Using MMCONFIG at e0000000
ACPI: Subsystem revision 20050902
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI quirk: region 0800-087f claimed by ICH4 ACPI/GPIO/TCO
PCI quirk: region 0880-08bf claimed by ICH4 GPIO
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: PXH quirk detected, disabling MSI for SHPC device
PCI: PXH quirk detected, disabling MSI for SHPC device
Boot video device is 0000:04:0d.0
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PALO._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PALO.PXHB._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PALO.PXHA._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PICH._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 10 *11 12)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 10 11 12)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 *10 11 12)
ACPI: PCI Interrupt Link [LNKE] (IRQs *3 4 5 6 7 10 11 12)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 *6 7 10 11 12)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 8 devices
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a 
report
hpet0: at MMIO 0xfed00000 (virtual 0xffffffffff5fe000), IRQs 2, 8, 0
hpet0: 3 64-bit timers, 14318180 Hz
PCI-DMA: Disabling IOMMU.
pnp: 00:05: ioport range 0x800-0x87f could not be reserved
pnp: 00:05: ioport range 0x880-0x8bf has been reserved
pnp: 00:05: ioport range 0x8c0-0x8df has been reserved
pnp: 00:05: ioport range 0x8e0-0x8e3 has been reserved
pnp: 00:05: ioport range 0xc00-0xc0f has been reserved
pnp: 00:05: ioport range 0xc10-0xc1f has been reserved
pnp: 00:05: ioport range 0xca0-0xcaf has been reserved
pnp: 00:05: ioport range 0xc20-0xc3f has been reserved
PCI: Bridge: 0000:01:00.0
  IO window: e000-efff
  MEM window: fe900000-feafffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:01:00.2
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:02.0
  IO window: e000-efff
  MEM window: fe700000-feafffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1e.0
  IO window: d000-dfff
  MEM window: fe500000-fe6fffff
  PREFETCH window: f0000000-f7ffffff
GSI 16 sharing vector 0xA9 and IRQ 16
ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:02.0 to 64
PCI: Setting latency timer of device 0000:01:00.0 to 64
PCI: Setting latency timer of device 0000:01:00.2 to 64
PCI: Setting latency timer of device 0000:00:1e.0 to 64
IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
audit: initializing netlink socket (disabled)
audit(1143536119.460:1): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
SELinux:  Registering netfilter hooks
Initializing Cryptographic API
ksign: Installing public key data
Loading keyring
- Added public key 6346FA22F3322FDB
- User ID: Red Hat, Inc. (Kernel Module GPG key)
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:02.0 to 64
Allocate Port Service[pcie00]
Allocate Port Service[pcie01]
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
Real Time Clock Driver v1.12
hpet_resources: 0xfed00000 is busy
Linux agpgart interface v0.101 (c) Dave Jones
PNP: No PS/2 controller found. Probing ports directly.
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:04: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH5: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
GSI 17 sharing vector 0xB1 and IRQ 17
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 177
ICH5: chipset revision 2
ICH5: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:pio
Probing IDE interface ide0...
hda: TEAC CD-ROM CD-224E-N, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hda: ATAPI 24X CD-ROM drive, 256kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ide-floppy driver 0.99.newide
usbcore: registered new driver libusual
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
mice: PS/2 mouse device common for all mice
md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 4.39
NET: Registered protocol family 2
IP route cache hash table entries: 65536 (order: 7, 524288 bytes)
TCP established hash table entries: 131072 (order: 9, 3145728 bytes)
TCP bind hash table entries: 65536 (order: 9, 2097152 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
TCP bic registered
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
ACPI wakeup devices:
PCI0 PALO  PXH PXHB PXHA PICH
ACPI: (supports S0 S4 S5)
Freeing unused kernel memory: 188k freed
Write protecting the kernel read-only data: 829k
SCSI subsystem initialized
libata version 1.20 loaded.
ata_piix 0000:00:1f.2: version 1.05
ACPI: PCI Interrupt 0000:00:1f.2[A] -> GSI 18 (level, low) -> IRQ 177
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata1: SATA max UDMA/133 cmd 0xCCB8 ctl 0xCCB2 bmdma 0xCC80 irq 177
ata2: SATA max UDMA/133 cmd 0xCCA0 ctl 0xCC9A bmdma 0xCC88 irq 177
ata1: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4673 85:7c69 86:3c21 87:4663 
88:207f
ata1: dev 0 ATA-7, max UDMA/133, 156250000 sectors: LBA48
ata1: dev 0 configured for UDMA/133
scsi0 : ata_piix
ata2: SATA port has no device.
scsi1 : ata_piix
  Vendor: ATA       Model: Maxtor 6L080M0    Rev: BACE
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 156250000 512-byte hdwr sectors (80000 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 156250000 512-byte hdwr sectors (80000 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2
sd 0:0:0:0: Attached scsi disk sda
device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
cdrom: open failed.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
security:  3 users, 6 roles, 889 types, 109 bools
security:  55 classes, 244452 rules
SELinux:  Completing initialization.
SELinux:  Setting up existing superblocks.
SELinux: initialized (dev dm-0, type ext3), uses xattr
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
SELinux: initialized (dev debugfs, type debugfs), uses genfs_contexts
SELinux: initialized (dev selinuxfs, type selinuxfs), uses genfs_contexts
SELinux: initialized (dev mqueue, type mqueue), uses transition SIDs
SELinux: initialized (dev hugetlbfs, type hugetlbfs), uses genfs_contexts
SELinux: initialized (dev devpts, type devpts), uses transition SIDs
SELinux: initialized (dev eventpollfs, type eventpollfs), uses 
genfs_contexts
SELinux: initialized (dev inotifyfs, type inotifyfs), uses genfs_contexts
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
SELinux: initialized (dev futexfs, type futexfs), uses genfs_contexts
SELinux: initialized (dev pipefs, type pipefs), uses task SIDs
SELinux: initialized (dev sockfs, type sockfs), uses task SIDs
SELinux: initialized (dev proc, type proc), uses genfs_contexts
SELinux: initialized (dev bdev, type bdev), uses genfs_contexts
SELinux: initialized (dev rootfs, type rootfs), uses genfs_contexts
SELinux: initialized (dev sysfs, type sysfs), uses genfs_contexts
SELinux: initialized (dev usbfs, type usbfs), uses genfs_contexts
floppy0: no floppy controllers found
Intel(R) PRO/1000 Network Driver - version 6.1.16-k2-NAPI
Copyright (c) 1999-2005 Intel Corporation.
GSI 18 sharing vector 0xB9 and IRQ 18
ACPI: PCI Interrupt 0000:02:04.0[A] -> GSI 32 (level, low) -> IRQ 185
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
GSI 19 sharing vector 0xC1 and IRQ 19
ACPI: PCI Interrupt 0000:04:03.0[A] -> GSI 20 (level, low) -> IRQ 193
e1000: eth1: e1000_probe: Intel(R) PRO/1000 Network Connection
hw_random: RNG not detected
GSI 20 sharing vector 0xC9 and IRQ 20
ACPI: PCI Interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 201
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: debug port 1
PCI: cache line size of 128 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: irq 201, io mem 0xfeb00000
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 4 ports detected
USB Universal Host Controller Interface driver v2.3
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.0: irq 169, io base 0x0000cce0
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
GSI 21 sharing vector 0xD1 and IRQ 21
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 209
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.1: irq 209, io base 0x0000ccc0
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: Power Button (FF) [PWRF]
ibm_acpi: ec object not found
ACPI: Video Device [EVGA] (multi-head: no  rom: yes  post: no)
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
cdrom: open failed.
cdrom: open failed.
EXT3 FS on dm-0, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
SELinux: initialized (dev sda1, type ext3), uses xattr
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
Adding 2031608k swap on /dev/VolGroup00/LogVol01.  Priority:-1 extents:1 
across:2031608k
SELinux: initialized (dev binfmt_misc, type binfmt_misc), uses 
genfs_contexts


