Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261990AbVDVGrs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261990AbVDVGrs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 02:47:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261991AbVDVGrs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 02:47:48 -0400
Received: from www.proficuous.com ([209.240.79.128]:734 "EHLO
	mail.proficuous.com") by vger.kernel.org with ESMTP id S261990AbVDVGrj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 02:47:39 -0400
Subject: kernel panic and then oops
From: "Aaron P. Martinez" <ml@proficuous.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Fri, 22 Apr 2005 01:47:35 -0500
Message-Id: <1114152455.5272.30.camel@aaron.proficuous.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-14) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am running Centos 4 with the latest kernel (updated yesterday)
2.6.9-5.0.5.EL on a P4 2.4 machine w/1 Gb ram and for the last couple
weeks the machine has just been randomly hanging.  I did upgrade the
memory from a 512m stick to 2 1 gig sticks because the machine was
regularly using 100% of the swap and would simply crawl.  I know the
thing to look at here obviously is the memory but i've already run
memtest86+ and it reported that there was nothing wrong with the memory.
I have tried running with a single stick of the 1Gb for the last couple
days and tomorrow will be putting the 512 back in just for testing.

I searched the archives for the error, but as far as kernel debugging
goes, i'm very new to it.  I saw a lot of errors that looked similar but
as i'm not exactly sure how to read all of the data from a crash I hoped
i could get some help from the experts.

Generally when the machine hangs i get __nothing__ in the logs as far as
a crash trace goes...the machine just seems to hang (sometimes i can
ping it..other times not) and a hard reset is forced.  When it comes
up..the log is void of any info.  Today the machine reset, I wasn't
onsite, but as it was hanging i got the onsite person to give me the
error:

<0> kernel panic not syncing: fatal exception in interrupt
<0> kernel panic not syncing: arch/i386/kernel/irq.c:590 spin_is_locked
on
initialized spinlock C03a5098


I'm sure there was other messages but this is all i got from him before
he needed to get the machine running again.  He reset the machine and
about 2 minutes later the following messages showed up in the log:


Unable to handle kernel paging request at virtual address b9e91c8a
Apr 21 16:12:44 wolverine kernel:  printing eip:
Apr 21 16:12:44 wolverine kernel: f88aed9a
Apr 21 16:12:44 wolverine kernel: *pde = 00000000
Apr 21 16:12:44 wolverine kernel: Oops: 0002 [#1]
Apr 21 16:12:44 wolverine kernel: Modules linked in: md5 ipv6 autofs4
iptable_mangle iptable_nat ipt_LOG ipt_state ip_conntrack iptable_filter
ip_tables uhci_hcd ehci_hcd 8139too mii floppy dm_snapshot dm_zero
dm_mirror ext3 jbd dm_mod
Apr 21 16:12:44 wolverine kernel: CPU:    0
Apr 21 16:12:44 wolverine kernel: EIP:    0060:[<f88aed9a>]    Not
tainted VLI
Apr 21 16:12:44 wolverine kernel: EFLAGS: 00010246   (2.6.9-5.0.5.EL)
Apr 21 16:12:44 wolverine kernel: EIP is at
ext3_try_to_allocate_with_rsv+0xd1/0x358 [ext3]
Apr 21 16:12:44 wolverine kernel: eax: 00000000   ebx: f7e01aa8   ecx:
00158000   edx: 00000000
Apr 21 16:12:44 wolverine kernel: esi: e85bb669   edi: 00007000   ebp:
00000000   esp: e64abbd5
Apr 21 16:12:44 wolverine kernel: ds: 007b   es: 007b   ss: 0068
Apr 21 16:12:44 wolverine kernel: Process imapd (pid: 3502,
threadinfo=e64ab000 task=e3ae38f0)
Apr 21 16:12:44 wolverine kernel: Stack: 00000000 2b001580 94000000
00f69a32 00f6e4d8 00f6e4d8 01000000 00000000
Apr 21 16:12:44 wolverine kernel:        00f6e104 00f7e01a 00000070
5bf6e4d8 ecf88af2 00f5d512 68000070 4ce85bb6
Apr 21 16:12:44 wolverine kernel:        e4e64abc 80c02a10 2bf500fc
68000000 00e85bb6 60f6e104 00f6e785 00000000
Apr 21 16:12:44 wolverine kernel: Call Trace:
Apr 21 16:12:44 wolverine kernel: Code: 8d 98 a8 00 00 00 8b 42 14 01 c1
89 4c 24 04 8b 56 00 80 14 24 8b 46 34 89 44 24 14 8b 46 38 89 44 24 00
8b 04 24 8b
14 24 22 06 <18> 83 e2 01 09 c2 64 84 83 7c 24 18 00 74 20 84 ed 78 1c
ff 74
Apr 21 16:12:44 wolverine kernel:  <1>Unable to handle kernel paging
request at virtual address b9e9168a
Apr 21 16:12:44 wolverine kernel:  printing eip:
Apr 21 16:12:44 wolverine kernel: f88aed9a
Apr 21 16:12:44 wolverine kernel: *pde = 00000000
Apr 21 16:12:44 wolverine kernel: Oops: 0002 [#2]
Apr 21 16:12:44 wolverine kernel: Modules linked in: md5 ipv6 autofs4
iptable_mangle iptable_nat ipt_LOG ipt_state ip_conntrack iptable_filter
ip_tables uhci_hcd ehci_hcd 8139too mii floppy dm_snapshot dm_zero
dm_mirror ext3 jbd dm_mod
Apr 21 16:12:44 wolverine kernel: CPU:    0
Apr 21 16:12:44 wolverine kernel: EIP:    0060:[<f88aed9a>]    Not
tainted VLI
Apr 21 16:12:44 wolverine kernel: EFLAGS: 00010206   (2.6.9-5.0.5.EL)
Apr 21 16:12:44 wolverine kernel: EIP is at
ext3_try_to_allocate_with_rsv+0xd1/0x358 [ext3]
Apr 21 16:12:44 wolverine kernel: eax: 00000430   ebx: f7e014a8   ecx:
00048000   edx: 000004b0
Apr 21 16:12:44 wolverine kernel: esi: f3f0ccd1   edi: 00002f54   ebp:
00000000   esp: f5f4fbd5
Apr 21 16:12:44 wolverine kernel: ds: 007b   es: 007b   ss: 0068
Apr 21 16:12:44 wolverine kernel: Process cleanup (pid: 2005,
threadinfo=f5f4f000 task=f594e1b0)
Apr 21 16:12:44 wolverine kernel: Stack: 000004b0 09000480 64000000
00f69a37 00f6ebac 00f6ebac 00000000 00000000
Apr 21 16:12:44 wolverine kernel:        00f6f3c4 54f7e014 0000002f
5bf6ebac a0f88af2 54f64e89 d000002f 4cf3f0cc
Apr 21 16:12:44 wolverine kernel:        08f5f4fc 7e000000 09c01655
d0000000 00f3f0cc 20f6f3c4 00f69e31 d4000000
Apr 21 16:12:44 wolverine kernel: Call Trace:
Apr 21 16:12:44 wolverine kernel: Code: 8d 98 a8 00 00 00 8b 42 14 01 c1
89 4c 24 04 8b 56 00 80 14 24 8b 46 34 89 44 24 14 8b 46 38 89 44 24 00
8b 04 24 8b
14 24 22 06 <18> 83 e2 01 09 c2 64 84 83 7c 24 18 00 74 20 84 ed 78 1c
ff 74


at this point i was still logged in but after issuing a shutdown
command..it just kept running.  Same thing when the onsite person tried
to shut down as well.

After the reboot everything seems fine of course but i get these errors
every time that also concern me:

Apr 21 15:31:01 wolverine kernel: PCI: Probing PCI hardware
Apr 21 15:31:01 wolverine kernel: PCI: Probing PCI hardware (bus 00)
Apr 21 15:31:01 wolverine kernel: PCI: Using IRQ router default
[1106/3128] at 0000:00:00.0
Apr 21 15:31:01 wolverine kernel: PCI: IRQ 0 for device 0000:00:0f.0
doesn't match PIRQ mask - try pci=usepirqmask
Apr 21 15:31:01 wolverine kernel: PCI: IRQ 0 for device 0000:00:0f.1
doesn't match PIRQ mask - try pci=usepirqmask
Apr 21 15:31:01 wolverine kernel: PCI: IRQ 0 for device 0000:00:0f.2
doesn't match PIRQ mask - try pci=usepirqmask


and further down:

Apr 21 15:31:03 wolverine kernel: 8139too Fast Ethernet driver 0.9.27
Apr 21 15:31:03 wolverine kernel: eth0: RealTek RTL8139 at 0xb400,
00:40:63:c0:2c:fb, IRQ 10
Apr 21 15:31:03 wolverine kernel: PCI: IRQ 0 for device 0000:00:0f.2
doesn't match PIRQ mask - try pci=usepirqmask
Apr 21 15:31:03 wolverine kernel: PCI: No IRQ known for interrupt pin C
of device 0000:00:0f.2. Please try using pci=biosirq.
Apr 21 15:31:03 wolverine kernel: ehci_hcd 0000:00:0f.2: Found HC with
no IRQ.  Check BIOS/PCI 0000:00:0f.2 setup!
Apr 21 15:31:04 wolverine kernel: USB Universal Host Controller
Interface driver v2.2
Apr 21 15:31:04 wolverine kernel: PCI: IRQ 0 for device 0000:00:0f.0
doesn't match PIRQ mask - try pci=usepirqmask
Apr 21 15:31:04 wolverine kernel: PCI: No IRQ known for interrupt pin A
of device 0000:00:0f.0. Please try using pci=biosirq.
Apr 21 15:31:04 wolverine kernel: uhci_hcd 0000:00:0f.0: Found HC with
no IRQ.  Check BIOS/PCI 0000:00:0f.0 setup!
Apr 21 15:31:04 wolverine kernel: PCI: IRQ 0 for device 0000:00:0f.1
doesn't match PIRQ mask - try pci=usepirqmask
Apr 21 15:31:04 wolverine kernel: PCI: No IRQ known for interrupt pin B
of device 0000:00:0f.1. Please try using pci=biosirq.
Apr 21 15:31:04 wolverine kernel: uhci_hcd 0000:00:0f.1: Found HC with
no IRQ.  Check BIOS/PCI 0000:00:0f.1 setup!

I will repost w/the full dmesg if it's needed. 


TIA,

Aaron Martinez

P.S.
I'm not a developer, but i would like to learn more about how to debug
these errors, at least so that i may post better questions in the
future, any pointers to info in this regard would be appreciated.


