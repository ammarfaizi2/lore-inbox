Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262006AbVCATbP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262006AbVCATbP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 14:31:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262029AbVCATbP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 14:31:15 -0500
Received: from alog0342.analogic.com ([208.224.222.118]:50048 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262006AbVCATak
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 14:30:40 -0500
Date: Tue, 1 Mar 2005 14:29:24 -0500 (EST)
From: linux-os <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Network speed Linux-2.6.10
Message-ID: <Pine.LNX.4.61.0503011426180.578@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Conditions:

Intel NIC e100 device driver. Two identical machines.
Private network, no other devices. Connected using a Netgear switch.
Test data is the same thing sent from memory on one machine
to a discard server on another, using TCP/IP SOCK_STREAM.

If I set both machines to auto-negotiation OFF and half duplex,
I get about 9 to 9.5 megabytes/second across the private wire
network.

If I set one machine to full duplex and the other to half-duplex
I get 10 to 11 megabytes/second transfer across the network,
regardless of direction.

If I set both machines to auto-negotiation OFF and full duplex,
I get 300 to 400 kilobytes/second regardless of the direction.

I thought the problem must be the switch so I substituted a
cross-over wire. The problem gets worse, maybe 50 to 100
kilobytes (random bursts) per second.

`lspci`

00:00.0 Host bridge: Intel Corp. 82865G/PE/P DRAM Controller/Host-Hub Interface (rev 02)
00:01.0 PCI bridge: Intel Corp. 82865G/PE/P PCI to AGP Controller (rev 02)
00:1d.0 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #1 (rev 02)
00:1d.1 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #2 (rev 02)
00:1d.2 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #3 (rev 02)
00:1d.3 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #4 (rev 02)
00:1d.7 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB2 EHCI Controller (rev 02)
00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB/EB/ER Hub interface to PCI Bridge (rev c2)
00:1f.0 ISA bridge: Intel Corp. 82801EB/ER (ICH5/ICH5R) LPC Bridge (rev 02)
00:1f.1 IDE interface: Intel Corp. 82801EB/ER (ICH5/ICH5R) Ultra ATA 100 Storage Controller (rev 02)
00:1f.2 IDE interface: Intel Corp. 82801EB (ICH5) Serial ATA 150 Storage Controller (rev 02)
00:1f.3 SMBus: Intel Corp. 82801EB/ER (ICH5/ICH5R) SMBus Controller (rev 02)
00:1f.5 Multimedia audio controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) AC'97 Audio Controller (rev 02)
01:00.0 VGA compatible controller: nVidia Corporation NV17 [GeForce4 MX 440] (rev a3)
02:00.0 SCSI storage controller: Adaptec AHA-2940U/UW/D / AIC-7881U (rev 01)
02:01.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] (rev 30)
02:04.0 Class 02b0: Analogic Corp: Unknown device 8004 (rev 07)
02:07.0 FireWire (IEEE 1394): Lucent Microelectronics FW323 (rev 61)
02:08.0 Ethernet controller: Intel Corp. 82562EZ 10/100 Ethernet Controller (rev 01)

proc/interrupts

            CPU0
   0:  507789786    IO-APIC-edge  timer
   1:     459692    IO-APIC-edge  i8042
   7:          0    IO-APIC-edge  parport0
   8:          1    IO-APIC-edge  rtc
   9:          0   IO-APIC-level  acpi
  12:         66    IO-APIC-edge  i8042
  14:     381384    IO-APIC-edge  ide0
  16:          0   IO-APIC-level  uhci_hcd, uhci_hcd
  17:          0   IO-APIC-level  Intel ICH5
  18:          0   IO-APIC-level  libata, uhci_hcd
  19:          0   IO-APIC-level  uhci_hcd
  20:    5748440   IO-APIC-level  eth0
  21:     278400   IO-APIC-level  aic7xxx
  23:          0   IO-APIC-level  ehci_hcd
NMI:          0 
LOC:  507803974 
ERR:          0
MIS:          0


These are identical machines/motherboards. Anybody have a clue
why full-duplex sucks and mismatching FD/HD actually makes
things faster? Is it possible that full-duplex is actually
half-duplex of something strange like that?


Ethtool statistics:

NIC statistics:
      rx_packets: 1732112
      tx_packets: 3612310
      rx_bytes: 162571267
      tx_bytes: 4119843621
      rx_errors: 1094
      tx_errors: 0
      rx_dropped: 0
      tx_dropped: 0
      multicast: 0
      collisions: 50986
      rx_length_errors: 933
      rx_over_errors: 0
      rx_crc_errors: 84
      rx_frame_errors: 77
      rx_fifo_errors: 0
      rx_missed_errors: 0
      tx_aborted_errors: 0
      tx_carrier_errors: 0
      tx_fifo_errors: 0
      tx_heartbeat_errors: 0
      tx_window_errors: 0
      tx_deferred: 298989
      tx_single_collisions: 34534
      tx_multi_collisions: 6779
      tx_flow_control_pause: 122901
      rx_flow_control_pause: 0
      rx_flow_control_unsupported: 0
      tx_tco_packets: 0
      rx_tco_packets: 0

Cheers,
Dick Johnson
Penguin : Linux version 2.6.10 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
