Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266838AbUIDIHj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266838AbUIDIHj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 04:07:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269832AbUIDIHj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 04:07:39 -0400
Received: from chello080109220025.1.graz.surfer.at ([80.109.220.25]:27522 "EHLO
	matrix.suit.at") by vger.kernel.org with ESMTP id S266838AbUIDIH3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 04:07:29 -0400
From: "Axel Suppantschitsch" <as@suit.at>
To: <linux-kernel@vger.kernel.org>
Subject: Serious e1000 timeout problem with kernel 2.6.8-1.521
Date: Sat, 4 Sep 2004 10:07:05 +0200
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0098_01C49266.EE5E8D70"
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Thread-Index: AcSSViqeeBReQAnpSue6/jS3vetQwA==
Message-Id: <20040904080718.42F2D5C0060@matrix.suit.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0098_01C49266.EE5E8D70
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit

Hiya,

	I recently upgraded my network infrastructure to Gigabit Ethernet,
but now I run into serious network problems. At high loads the e1000 driver
times out, resets itself several times per minute. I already read about this
problem with the same and other network drivers, tried out a lot of possible
solutions (acpi=off), but nothing worked out for me. I also tried the latest
NAPI driver from Intel, no success.

At first the specs (details: dmesg.gz)

Fedora Core 2, latest patchlevel (kernel 2.6.8-1.521)
Athlon 1800+ XP (133MHz FSB)
512MB RAM (DDR 233MHz)
Diamond FireGL (Permedia2) PCI VGA Card
MSI KT6 Delta FISR Motherboard (VIA KT600 chipset) with Broadcom Gigabit
onboard
Intel Pro 1000/MT PCI Desktop Adapter (82541GI)
Realtek 8139 PCI Adapter
D-Link DGS-1008D Gigabit Switch
Cat 5 cables (checked with Fluke for compliance)

Following kernel messages are in the messages log:

Sep  3 23:52:26 matrix kernel: NETDEV WATCHDOG: eth1: transmit timed out
Sep  3 23:52:29 matrix kernel: e1000: eth1: e1000_watchdog: NIC Link is Up
1000 Mbps Full Duplex
Sep  3 23:53:04 matrix kernel: NETDEV WATCHDOG: eth1: transmit timed out
Sep  3 23:53:07 matrix kernel: e1000: eth1: e1000_watchdog: NIC Link is Up
1000 Mbps Full Duplex

Following ethtool information for the e1000 driver (eth1):

driver: e1000
version: 5.2.52-k4
firmware-version: N/A
bus-info: 0000:00:06.0

Settings for eth1:
        Supported ports: [ TP ]
        Supported link modes:   10baseT/Half 10baseT/Full
                                100baseT/Half 100baseT/Full
                                1000baseT/Full
        Supports auto-negotiation: Yes
        Advertised link modes:  10baseT/Half 10baseT/Full
                                100baseT/Half 100baseT/Full
                                1000baseT/Full
        Advertised auto-negotiation: Yes
        Speed: 1000Mb/s
        Duplex: Full
        Port: Twisted Pair
        PHYAD: 0
        Transceiver: internal
        Auto-negotiation: on
        Supports Wake-on: umbg
        Wake-on: g
        Current message level: 0x00000007 (7)
        Link detected: yes

NIC statistics:
     rx_packets: 410244
     tx_packets: 1054111
     rx_bytes: 400272468
     tx_bytes: 1442819261
     rx_errors: 0
     tx_errors: 0
     rx_dropped: 0
     tx_dropped: 0
     multicast: 0
     collisions: 0
     rx_length_errors: 0
     rx_over_errors: 0
     rx_crc_errors: 0
     rx_frame_errors: 0
     rx_fifo_errors: 0
     rx_missed_errors: 0
     tx_aborted_errors: 0
     tx_carrier_errors: 0
     tx_fifo_errors: 0
     tx_heartbeat_errors: 0
     tx_window_errors: 0
     tx_abort_late_coll: 0
     tx_deferred_ok: 0
     tx_single_coll_ok: 0
     tx_multi_coll_ok: 0
     rx_long_length_errors: 0
     rx_short_length_errors: 0
     rx_align_errors: 0
     tx_tcp_seg_good: 0
     tx_tcp_seg_failed: 0
     rx_flow_control_xon: 0
     rx_flow_control_xoff: 0
     tx_flow_control_xon: 0
     tx_flow_control_xoff: 0
     rx_csum_offload_good: 409990
     rx_csum_offload_errors: 0
     rx_long_byte_count: 400272468

Following information is from /proc/interrupts:

           CPU0
  0:   36642685          XT-PIC  timer
  1:         18          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  5:    1287758          XT-PIC  ehci_hcd, eth0, VIA8233
  8:          1          XT-PIC  rtc
  9:          0          XT-PIC  acpi
 10:     297076          XT-PIC  uhci_hcd, uhci_hcd, ohci1394, eth1
 11:          0          XT-PIC  uhci_hcd, uhci_hcd
 12:        735          XT-PIC  i8042
 14:     366735          XT-PIC  ide0
 15:     385804          XT-PIC  ide1
NMI:          0
ERR:          0

Please help me out, 

Axel.

------=_NextPart_000_0098_01C49266.EE5E8D70
Content-Type: application/octet-stream;
	name="dmesg.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="dmesg.gz"

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

------=_NextPart_000_0098_01C49266.EE5E8D70--

