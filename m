Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261473AbTJHM7o (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 08:59:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261476AbTJHM7o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 08:59:44 -0400
Received: from ookhoi.xs4all.nl ([213.84.114.66]:13208 "EHLO
	favonius.humilis.net") by vger.kernel.org with ESMTP
	id S261473AbTJHM7l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 08:59:41 -0400
Date: Wed, 8 Oct 2003 14:59:40 +0200
From: Ookhoi <ookhoi@humilis.net>
To: linux-kernel@vger.kernel.org
Subject: disable ACPI as a solution for "NETDEV WATCHDOG: eth0: transmit timed out"?
Message-ID: <20031008125940.GQ18928@favonius>
Reply-To: ookhoi@humilis.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Uptime: 17:11:30 up 120 days, 17:14, 34 users,  load average: 2.35, 2.41, 2.33
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi LKML,

During the end of the afternoon of every day our server goes offline (no
ping) for up to a minute now and then (seems random) with the following
message in the logs:

NETDEV WATCHDOG: eth0: transmit timed out

It recovers by itself:

e1000: eth0 NIC Link is Up 100 Mbps Full Duplex

A google search and grep on LKML mails suggest that disabling ACPI might
help, so I'll try that on friday (server is co-located, and I like to be
on site this time when it reboots while playing with the network config).

What I wonder:
o  Would it hurt in a way to disable ACPI in the kernel? (advantage,
   disadvantage)
o  Is this due to the hardware (and/or bios) combination, or is it a bug
   in the kernel?
o  Could there be any other reason for the transmit time-out, not
   related to the server or kernel? (eg, due to something on the
   network).
o  Would somebody be interested in more specific info? (if so, what?)

Kernel is 2.6.0-test6
The machine is a dell poweredge 650, with a dual-port intel 82546EB
Gigabit Ethernet Controller. e1000 is a module right now. On friday I
want to change that to in-kernel.
lspci:
00:00.0 Host bridge: ServerWorks GCNB-LE Host Bridge (rev 32)
00:00.1 Host bridge: ServerWorks GCNB-LE Host Bridge
00:03.0 SCSI storage controller: Adaptec AHA-3960D / AIC-7899A U160/m (rev 01)
00:03.1 SCSI storage controller: Adaptec AHA-3960D / AIC-7899A U160/m (rev 01)
00:04.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27)
00:05.0 IDE interface: CMD Technology Inc PCI0680 (rev 02)
00:0f.0 Host bridge: ServerWorks CSB6 South Bridge (rev a0)
00:0f.1 IDE interface: ServerWorks CSB6 RAID/IDE Controller (rev a0)
00:0f.3 ISA bridge: ServerWorks GCLE-2 Host Bridge
00:10.0 Host bridge: ServerWorks: Unknown device 0110 (rev 12)
00:10.2 Host bridge: ServerWorks: Unknown device 0110 (rev 12)
01:03.0 Ethernet controller: Intel Corp. 82546EB Gigabit Ethernet Controller (Copper) (rev 01)
01:03.1 Ethernet controller: Intel Corp. 82546EB Gigabit Ethernet Controller (Copper) (rev 01)

/proc/interrupts
           CPU0
  0:  430682080    IO-APIC-edge  timer
  1:        881    IO-APIC-edge  i8042
  2:          0          XT-PIC  cascade
  9:          0   IO-APIC-level  acpi
 14:          9    IO-APIC-edge  ide2
 17:    7610364   IO-APIC-level  aic7xxx
 18:         30   IO-APIC-level  aic7xxx
 19:   15110701   IO-APIC-level  eth0
NMI:          0
LOC:  430700555
ERR:          0
MIS:          0


FWIW, I see the same on my shuttle system. It seems related to network
load. It is quite rare, so I don't care. And besides, the kernel is very
old, so an upgrade might solve this. Again, FWIW:

Kernel 2.5.70
Despite its age, the system is rock solid with this kernel, so I feel no
need to upgrade (yet):
14:51:19 up 121 days, 15:01, 37 users,  load average: 4.36, 3.96, 3.71

NETDEV WATCHDOG: eth0: transmit timed out
eth0: transmit timed out, tx_status 00 status e601.
  diagnostics: net 0cfc media 8880 dma 0000003a fifo 8000
eth0: Interrupt posted but not delivered -- IRQ blocked by another
device?
  Flags; bus-master 1, dirty 61764525(13) current 61764525(13)
  Transmit list 00000000 vs. f7dcfa20.
  0: @f7dcf200  length 8000004e status 0001004e
  1: @f7dcf2a0  length 8000004e status 0001004e
  2: @f7dcf340  length 8000004e status 0001004e
  3: @f7dcf3e0  length 8000004e status 0001004e
  4: @f7dcf480  length 8000004e status 0001004e
  5: @f7dcf520  length 8000004e status 0001004e
  6: @f7dcf5c0  length 800000aa status 000100aa
  7: @f7dcf660  length 800000aa status 000100aa
  8: @f7dcf700  length 800000aa status 000100aa
  9: @f7dcf7a0  length 800000aa status 000100aa
  10: @f7dcf840  length 800000aa status 000100aa
  11: @f7dcf8e0  length 800000aa status 800100aa
  12: @f7dcf980  length 800000aa status 800100aa
  13: @f7dcfa20  length 80000052 status 00010052
  14: @f7dcfac0  length 8000004e status 0001004e
  15: @f7dcfb60  length 8000004e status 0001004e
eth0: Resetting the Tx ring pointer.

lspci:
00:00.0 Host bridge: nVidia Corporation: Unknown device 01e0 (rev a2)
00:00.1 RAM memory: nVidia Corporation: Unknown device 01eb (rev a2)
00:00.2 RAM memory: nVidia Corporation: Unknown device 01ee (rev a2)
00:00.3 RAM memory: nVidia Corporation: Unknown device 01ed (rev a2)
00:00.4 RAM memory: nVidia Corporation: Unknown device 01ec (rev a2)
00:00.5 RAM memory: nVidia Corporation: Unknown device 01ef (rev a2)
00:01.0 ISA bridge: nVidia Corporation nForce2 ISA Bridge (rev a3)
00:01.1 SMBus: nVidia Corporation nForce2 SMBus (MCP) (rev a2)
00:02.0 USB Controller: nVidia Corporation nForce2 USB Controller (rev a3)
00:02.1 USB Controller: nVidia Corporation nForce2 USB Controller (rev a3)
00:02.2 USB Controller: nVidia Corporation nForce2 USB Controller (rev a3)
00:04.0 Ethernet controller: nVidia Corporation nForce2 Ethernet Controller (rev a1)
00:05.0 Multimedia audio controller: nVidia Corporation nForce MultiMedia audio [Via VT82C686B] (rev a2)
00:06.0 Multimedia audio controller: nVidia Corporation nForce2 AC97 Audio Controler (MCP) (rev a1)
00:08.0 PCI bridge: nVidia Corporation: Unknown device 006c (rev a3)
00:09.0 IDE interface: nVidia Corporation nForce2 IDE (rev a2)
00:0d.0 FireWire (IEEE 1394): nVidia Corporation nForce2 FireWire (IEEE 1394) Controller (rev a3)
00:1e.0 PCI bridge: nVidia Corporation nForce2 AGP (rev a2)
01:06.0 Ethernet controller: 3Com Corporation 3c980-TX 10/100baseTX NIC [Python-T] (rev 78)
02:00.0 VGA compatible controller: nVidia Corporation NV18 [GeForce4 MX - nForce GPU] (rev a3)

/proc/interrupts
           CPU0
  0: 1918692128    IO-APIC-edge  timer
  1:    3397768    IO-APIC-edge  i8042
  2:          0          XT-PIC  cascade
  3: 1969607482    IO-APIC-edge  NVidia NForce2
  9:          0   IO-APIC-level  acpi
 11:  127934187    IO-APIC-edge  eth0
 12:   95839554    IO-APIC-edge  i8042
 14:   27125149    IO-APIC-edge  ide0
NMI:          0
LOC: 1854644890
ERR:          0
MIS:          0
