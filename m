Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262355AbUBKBYC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 20:24:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263101AbUBKBYB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 20:24:01 -0500
Received: from ms-smtp-02.rdc-kc.rr.com ([24.94.166.122]:27575 "EHLO
	ms-smtp-02.rdc-kc.rr.com") by vger.kernel.org with ESMTP
	id S263606AbUBKBXf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 20:23:35 -0500
From: Paul Misner <paul@misner.org>
To: linux-kernel@vger.kernel.org
Subject: Re: ieee1394 and fbdev oops in 2.6.3rc2
Date: Tue, 10 Feb 2004 19:23:31 -0600
User-Agent: KMail/1.6.1
References: <20040210165202.GA7590@suse.de>
In-Reply-To: <20040210165202.GA7590@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200402101923.31396.paul@misner.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 10 February 2004 10:52 am, Olaf Hering wrote:
> The same config worked ok with 2.6.3rc1.
>
>
> Total memory = 1792MB; using 4096kB for hash table (at c0800000)
> Linux version 2.6.3-rc2-olh (olaf@nectarine) (gcc version 3.2.3 (SuSE
> Linux)) #1 Tue Feb 10 15:58:16 CET 2004
> Found UniNorth memory controller & host bridge, revision: 3
> Mapped at 0xfdfc0000
> Found a Keylargo mac-io controller, rev: 2, mapped at 0xfdf40000
> PowerMac motherboard: PowerMac G4 AGP Graphics
<snip>
> ohci1394: $Rev: 1097 $ Ben Collins <bcollins@debian.org>
> PCI: Enabling device 0001:02:0a.0 (0010 -> 0012)
> ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[63]  MMIO=[80080000-800807ff]
>  Max Packet=[2048]
> ieee1394: Node added: ID:BUS[0-00:1023]  GUID[0001a30000009a06]
> ieee1394: Host added: ID:BUS[0-01:1023]  GUID[000a27fffee2f33e]
> Badness in kobject_get at lib/kobject.c:434Motherboard is ASUS P4GX8, and 
this boot was with ACPI=off, which kept the console from constantly emitting 
'$' characters, which allowed me co capture the dmesg.  
> Call trace:
>  [<c000b798>] dump_stack+0x18/0x28
>  [<c0008b04>] check_bug_trap+0x8c/0xb0
>  [<c0008c58>] ProgramCheckException+0x130/0x170
>  [<c0008214>] ret_from_except_full+0x0/0x4c
>  [<c00a8494>] kobject_get+0x14/0x30
>  [<c00cd1bc>] bus_for_each_dev+0x78/0x114
>  [<f23d96dc>] nodemgr_node_probe+0x58/0x124 [ieee1394]
>  [<f23d9ae4>] nodemgr_host_thread+0x13c/0x1c4 [ieee1394]
>  [<c000ae50>] kernel_thread+0x44/0x60
> Oops: kernel access of bad area, sig: 11 [#1]
> NIP: 2C030000 LR: C00A855C SP: EFD3FF20 REGS: efd3fe70 TRAP: 0401    Not
> tainted MSR: 40009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
> TASK = c0763860[3041] 'knodemgrd_0' Last syscall: -1
> GPR00: 2C030000 EFD3FF20 C0763860 F2428594 EFD3FF98 EFD3FF98 F23D951C
> 00000000 GPR08: 00000010 F24285AC 00000000 C00CD144 C2BBDA20
> Call trace:
>  [<c00cc110>] put_device+0x14/0x24
>  [<c00cd1d8>] bus_for_each_dev+0x94/0x114
>  [<f23d96dc>] nodemgr_node_probe+0x58/0x124 [ieee1394]
>  [<f23d9ae4>] nodemgr_host_thread+0x13c/0x1c4 [ieee1394]
>  [<c000ae50>] kernel_thread+0x44/0x60
> sbp2: $Rev: 1096 $ Ben Collins <bcollins@debian.org>
> drivers/usb/net/pegasus.c: v0.5.12 (2003/06/06):Pegasus/Pegasus II USB
> Ethernet driver
> eth1: D-Link DSB-650TX
> drivers/usb/core/usb.c: registered new driver pegasus
> PHY ID: 406212, addr: 0
> process `syslogd' is using obsolete setsockopt SO_BSDCOMPAT
> eth0: Link is up at 100 Mbps, full-duplex.
> eth0: Pause is disabled
> process `named' is using obsolete setsockopt SO_BSDCOMPAT
> Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
> nfs warning: mount version older than kernel
> process `host' is using obsolete setsockopt SO_BSDCOMPAT
> nfs warning: mount version older than kernel
> nfs warning: mount version older than kernel
> [drm] Initialized r128 2.5.0 20030725 on minor 0
> agpgart: Putting AGP V2 device at 0000:00:0b.0 into 1x mode
> agpgart: Putting AGP V2 device at 0000:00:10.0 into 1x mode
> Oops: Exception in kernel mode, sig: 4 [#2]
> NIP: C0101000 LR: C0100F90 SP: EF185CF0 REGS: ef185c40 TRAP: 0700    Not
> tainted MSR: 00089032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
> TASK = ef1938a0[4325] 'X' Last syscall: 54
> GPR00: 00000002 EF185CF0 EF1938A0 EFFA3C00 EF185CF8 00000000 EF185D94
> 00000000 GPR08: 00000000 FFFFFF00 00000001 00000000 28004884 101E6A58
> 101EEE08 101EED88 GPR16: 101EF108 101EEF88 101EEE08 7FFFF438 101ECCF8
> 101E0000 101E0000 101E0000 GPR24: 00000001 C02EBA40 000000A0 00000040
> 00000400 00000010 EFFA3C00 00000008 Call trace:
>  [<c01011ac>] fbcon_switch+0x11c/0x288
>  [<c00c56c4>] redraw_screen+0x1c0/0x22c
>  [<c00c027c>] complete_change_console+0x44/0xf8
>  [<c00bfa34>] vt_ioctl+0x16c0/0x1d60
>  [<c00b8604>] tty_ioctl+0x160/0x5d4
>  [<c006c51c>] sys_ioctl+0xdc/0x2fc
>  [<c0007c7c>] ret_from_syscall+0x0/0x44

I see a similar, and completely repeatable error when booting 2.6.3-rc2, which 
didn't happen under 2.6.3-rc1 with the same .config.  Motherboard is ASUS 
P4GX8, kernel built for the P4, and this boot was with ACPI=off, which kept 
the console from constantly emitting '$' characters, which allowed me to 
capture the dmesg.  After booting, I also see only shifted punctuation keys 
(like > instead of .), and the shift key on my keyboard doesn't work.  The 
shift lock does make letters uppercase.  Section of dmesg follows.

ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[12]  MMIO=[dd000000-dd0007ff]  
Max Packet=[2048]
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00e018000014944f]
Badness in kobject_get at lib/kobject.c:431
Call Trace:
 [<c01aa887>] kobject_get+0x49/0x4b
 [<c01e691b>] get_device+0x1a/0x21
 [<c01e74ad>] bus_for_each_dev+0x6b/0xbd
 [<f8cf1e64>] nodemgr_node_probe+0x4a/0x11c [ieee1394]
 [<f8cf1d22>] nodemgr_probe_ne_cb+0x0/0x90 [ieee1394]
 [<f8cf1fa9>] nodemgr_do_irm_duties+0x73/0x128 [ieee1394]
 [<f8cf22c0>] nodemgr_host_thread+0x18d/0x19d [ieee1394]
 [<f8cf2133>] nodemgr_host_thread+0x0/0x19d [ieee1394]
 [<c0108cb5>] kernel_thread_helper+0x5/0xb

Unable to handle kernel paging request at virtual address ffedba55
 printing eip:
ffedba55
*pde = 00001067
*pte = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<ffedba55>]    Not tainted
EFLAGS: 00010286
EIP is at 0xffedba55
eax: ffedba55   ebx: f8cfe084   ecx: f7661f9c   edx: 00000000
esi: f8cf176a   edi: 00000000   ebp: f7661f50   esp: f7661f38
ds: 007b   es: 007b   ss: 0068
Process knodemgrd_0 (pid: 1100, threadinfo=f7660000 task=f768a080)
Stack: c01aa91b f8cfe084 f8cf044e f8cfe060 f8cfe068 f8cfdfc0 f7661f78 c01e74c7 
       f8cfe084 f7661f9c f8cfe00c 00000000 f6792044 f679203c f7661f9c f698ab18 
       f7661fc0 f8cf1e64 f8cfdfc0 f679203c f7661f9c f8cf1d22 f7661fc0 f8cf1fa9 
Call Trace:
 [<c01aa91b>] kobject_cleanup+0x92/0x94
 [<f8cf044e>] nodemgr_bus_match+0x0/0x85 [ieee1394]
 [<c01e74c7>] bus_for_each_dev+0x85/0xbd
 [<f8cf1e64>] nodemgr_node_probe+0x4a/0x11c [ieee1394]
 [<f8cf1d22>] nodemgr_probe_ne_cb+0x0/0x90 [ieee1394]
 [<f8cf1fa9>] nodemgr_do_irm_duties+0x73/0x128 [ieee1394]
 [<f8cf22c0>] nodemgr_host_thread+0x18d/0x19d [ieee1394]
 [<f8cf2133>] nodemgr_host_thread+0x0/0x19d [ieee1394]
 [<c0108cb5>] kernel_thread_helper+0x5/0xb

Code:  Bad EIP value.
 <6>tg3.c:v2.6 (February 3, 2004)

If there is any additional information you want, please let me know.

Paul Misner
