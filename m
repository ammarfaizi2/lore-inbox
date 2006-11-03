Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753521AbWKCUWM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753521AbWKCUWM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 15:22:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753524AbWKCUWM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 15:22:12 -0500
Received: from mail.ggsys.net ([69.26.161.131]:19899 "EHLO mail.ggsys.net")
	by vger.kernel.org with ESMTP id S1753521AbWKCUWL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 15:22:11 -0500
Subject: Re: qstor driver -> irq 193: nobody cared
From: Alberto Alonso <alberto@ggsys.net>
To: Sergey Vlasov <vsu@altlinux.ru>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20061103220018.577ded43.vsu@altlinux.ru>
References: <1162576973.3967.10.camel@w100>
	 <20061103220018.577ded43.vsu@altlinux.ru>
Content-Type: text/plain
Organization: Global Gate Systems LLC.
Date: Fri, 03 Nov 2006 14:22:07 -0600
Message-Id: <1162585327.3967.18.camel@w100>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-11-03 at 22:00 +0300, Sergey Vlasov wrote: 
> On Fri, 03 Nov 2006 12:02:53 -0600 Alberto Alonso wrote:
> 
> > I have a Pacific Digital qstor card on irq 193. I am using kernel
> > 2.6.17.13 SMP
> > 
> > 
> > irq 193: nobody cared (try booting with the "irqpoll" option)
> 
> Did you try this option?  It may decrease performance, but in some cases
> IRQ routing is so screwed that only irqpoll helps.

I have now switched to using that option. Will kick in after I reboot.

> [...]
> > handlers:
> > [<c0301300>] (qs_intr+0x0/0x220)
> > Disabling IRQ #193
> [..]
> > If there is any other info that I should provide to help 
> > troubleshoot please let me know.
> 
> The "nobody cared" error is often caused by some other device which
> shares the same interrupt, but Linux does not know about it (either due
> to broken IRQ routing tables in BIOS, or because the driver for that
> device is not loaded, but the device really is active and asserts its
> IRQ line - sometimes this also happens due to a broken BIOS).
> 
> Please post complete /proc/interrupts and lspci -v output, and also
> information about the motherboard model and BIOS version.
> 

The system is an old Gateway 6400 server w/ dual P3 1 GHz PCUs. It is
my NFS/samba file server.

Here is the rest of the requested info:

w100:/usr/src/linux-2.6.17.13# cat /proc/interrupts
           CPU0       CPU1
  0:    1398199    1412518    IO-APIC-edge  timer
  1:          1          8    IO-APIC-edge  i8042
  2:          0          0          XT-PIC  cascade
  8:          3          1    IO-APIC-edge  rtc
 14:       8163       8710    IO-APIC-edge  ide0
 15:          5          7    IO-APIC-edge  ide1
145:          0          0   IO-APIC-level  ivtv0
153:      94715     121999   IO-APIC-level  ide2, ide3, ide4, ide5
161:       6909      18301   IO-APIC-level  ide8, ide9
169:       8323      17288   IO-APIC-level  ide6, ide7
185:    1216892         92   IO-APIC-level  eth0
193:       2281       1954   IO-APIC-level  libata
NMI:          0          0
LOC:    2810842    2810841
ERR:          0
MIS:          0
w100:/usr/src/linux-2.6.17.13# lspci -v
0000:00:00.0 Host bridge: ServerWorks CNB20LE Host Bridge (rev 06)
        Flags: bus master, medium devsel, latency 32

0000:00:00.1 Host bridge: ServerWorks CNB20LE Host Bridge (rev 06)
        Flags: bus master, medium devsel, latency 16

0000:00:02.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 08)
        Subsystem: Intel Corp. 82559 Fast Ethernet LAN on Motherboard
        Flags: bus master, medium devsel, latency 64, IRQ 177
        Memory at feaff000 (32-bit, non-prefetchable) [size=4K]
        I/O ports at b000 [size=64]
        Memory at fe800000 (32-bit, non-prefetchable) [size=1M]
        Expansion ROM at fe700000 [disabled] [size=1M]
        Capabilities: [dc] Power Management version 2

0000:00:03.0 Multimedia video controller: Internext Compression Inc iTVC16 (CX23416) MPEG-2 Encoder (rev 01)
        Subsystem: Hauppauge computer works Inc.: Unknown device 0001
        Flags: bus master, medium devsel, latency 64, IRQ 145
        Memory at f8000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [44] Power Management version 2

0000:00:04.0 RAID bus controller: Triones Technologies, Inc. HPT374 (rev 07)
        Subsystem: Triones Technologies, Inc.: Unknown device 0001
        Flags: bus master, 66MHz, medium devsel, latency 120, IRQ 153
        I/O ports at bf60 [size=8]
        I/O ports at bf7c [size=4]
        I/O ports at bf58 [size=8]
        I/O ports at bf54 [size=4]
        I/O ports at b400 [size=256]
        Expansion ROM at fe960000 [disabled] [size=128K]
        Capabilities: [60] Power Management version 2

0000:00:04.1 RAID bus controller: Triones Technologies, Inc. HPT374 (rev 07)
        Subsystem: Triones Technologies, Inc.: Unknown device 0001
        Flags: bus master, 66MHz, medium devsel, latency 120, IRQ 153
        I/O ports at bf88 [size=8]
        I/O ports at bf84 [size=4]
        I/O ports at bf68 [size=8]
        I/O ports at bf80 [size=4]
        I/O ports at b800 [size=256]
        Capabilities: [60] Power Management version 2

0000:00:05.0 Unknown mass storage controller: Triones Technologies, Inc. HPT366/368/370/370A/372 (rev 03)
        Subsystem: Triones Technologies, Inc. HPT370 UDMA100
        Flags: bus master, medium devsel, latency 120, IRQ 161
        I/O ports at bfa0 [size=8]
        I/O ports at bf9c [size=4]
        I/O ports at bf90 [size=8]
        I/O ports at bf98 [size=4]
        I/O ports at c000 [size=256]
        Expansion ROM at fe980000 [disabled] [size=128K]

0000:00:06.0 Unknown mass storage controller: Triones Technologies, Inc. HPT366/368/370/370A/372 (rev 03)
        Subsystem: Triones Technologies, Inc. HPT370 UDMA100
        Flags: bus master, medium devsel, latency 120, IRQ 169
        I/O ports at bff0 [size=8]
        I/O ports at bfe4 [size=4]
        I/O ports at bfa8 [size=8]
        I/O ports at bfe0 [size=4]
        I/O ports at c400 [size=256]
        Expansion ROM at fe9a0000 [disabled] [size=128K]

0000:00:07.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27) (prog-if 00 [VGA])
        Subsystem: Gateway 2000: Unknown device 6400
        Flags: bus master, stepping, medium devsel, latency 64
        Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
        I/O ports at c800 [size=256]
        Memory at fe9ff000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at fe9c0000 [disabled] [size=128K]
        Capabilities: [5c] Power Management version 2

0000:00:0f.0 ISA bridge: ServerWorks OSB4 South Bridge (rev 50)
        Subsystem: ServerWorks OSB4 South Bridge
        Flags: bus master, medium devsel, latency 0

0000:00:0f.1 IDE interface: ServerWorks OSB4 IDE Controller (prog-if 8a [Master SecP PriP])
        Flags: bus master, medium devsel, latency 64
        I/O ports at ffa0 [size=16]

0000:00:0f.2 USB Controller: ServerWorks OSB4/CSB5 OHCI USB Controller (rev 04) (prog-if 10 [OHCI])
        Subsystem: ServerWorks OSB4/CSB5 OHCI USB Controller
        Flags: bus master, medium devsel, latency 64, IRQ 10
        Memory at fe9fe000 (32-bit, non-prefetchable) [size=4K]

0000:01:02.0 Ethernet controller: Intel Corp. 82543GC Gigabit Ethernet Controller (Copper) (rev 02)
        Subsystem: Intel Corp. PRO/1000 T Server Adapter
        Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 185
        Memory at febc0000 (32-bit, non-prefetchable) [size=128K]
        Memory at febb0000 (32-bit, non-prefetchable) [size=64K]
        Expansion ROM at feba0000 [disabled] [size=64K]
        Capabilities: [dc] Power Management version 2

0000:01:03.0 0106: Pacific Digital Corp: Unknown device 2068 (rev 01)
        Subsystem: Pacific Digital Corp: Unknown device 2068
        Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 193
        I/O ports at eff0 [size=8]
        I/O ports at efe0 [size=8]
        I/O ports at efa8 [size=8]
        I/O ports at efa0 [size=8]
        Memory at febf0000 (64-bit, non-prefetchable) [size=64K]
        Expansion ROM at febe0000 [disabled] [size=64K]
        Capabilities: [40] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
        Capabilities: [50] Power Management version 2
        Capabilities: [58] PCI-X non-bridge device.

0000:01:05.0 SCSI storage controller: LSI Logic / Symbios Logic 53c1010 Ultra3 SCSI Adapter (rev 01)
        Subsystem: Gateway 2000: Unknown device 1040
        Flags: medium devsel
        I/O ports at 1000 [disabled] [size=256]
        Memory at <ignored> (64-bit, non-prefetchable) [disabled]
        Memory at <ignored> (64-bit, non-prefetchable) [disabled]
        Capabilities: [40] Power Management version 2

0000:01:05.1 SCSI storage controller: LSI Logic / Symbios Logic 53c1010 Ultra3 SCSI Adapter (rev 01)
        Subsystem: Gateway 2000: Unknown device 1040
        Flags: medium devsel
        I/O ports at 1400 [disabled] [size=256]
        Memory at <ignored> (64-bit, non-prefetchable) [disabled]
        Memory at <ignored> (64-bit, non-prefetchable) [disabled]
        Capabilities: [40] Power Management version 2


Thanks,

Alberto

-- 
Alberto Alonso                        Global Gate Systems LLC.
(512) 351-7233                        http://www.ggsys.net
Hardware, consulting, sysadmin, monitoring and remote backups

