Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261817AbUB0MZr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 07:25:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261810AbUB0MZr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 07:25:47 -0500
Received: from freedom.icomedias.com ([62.99.232.79]:27917 "EHLO
	freedom.grz.icomedias.com") by vger.kernel.org with ESMTP
	id S261817AbUB0MWz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 07:22:55 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: Network error with Intel E1000 Adapter on update 2.4.25 ==> 2.6.3
Date: Fri, 27 Feb 2004 13:22:54 +0100
Message-ID: <FA095C015271B64E99B197937712FD020B01BB@freedom.grz.icomedias.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Network error with Intel E1000 Adapter on update 2.4.25 ==> 2.6.3
Thread-Index: AcP9LGy9DCYDtwk0RnOTuLLUfxW6jQ==
From: "Martin Bene" <martin.bene@icomedias.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When trying to update the kernel from 2.4.25 to 2.6.3 I run into a probelm:

While the driver for the onboard Intel E1000 network adapter loads OK, it doesn't seem to find an interrupt for the interface - ifconfig shows:

eth0      Link encap:Ethernet  HWaddr 00:0E:A6:2D:7A:64
          BROADCAST MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)
          Base address:0x9000 Memory:fc000000-fc020000

Trying to configure the infterface results in a frozen system.

Running the system with 2.4.25 kernel works OK and shows 

eth0      Link encap:Ethernet  HWaddr 00:0E:A6:2D:7A:64
          BROADCAST MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)
          Interrupt:18 Base address:0x9000 Memory:fc000000-fc020000

and works OK. 

/proc/interrupts for 2.4.25

           CPU0       CPU1
  0:      19341          0    IO-APIC-edge  timer
  1:          2          0    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  3:          0          0    IO-APIC-edge  serial
  8:          1          0    IO-APIC-edge  rtc
  9:          0          0   IO-APIC-level  acpi
 14:       1591          0    IO-APIC-edge  ide0
 15:       1823          1    IO-APIC-edge  ide1
 18:         57          0   IO-APIC-level  eth0
 22:       2888          0   IO-APIC-level  eth1
 23:          2          0   IO-APIC-level  libata
NMI:          0          0
LOC:      19270      19268
ERR:          0
MIS:          0

/proc/interrupts for 2.6.3
           CPU0       CPU1
  0:     640029          0    IO-APIC-edge  timer
  1:          9          0    IO-APIC-edge  i8042
  2:          0          0          XT-PIC  cascade
  3:          0          0    IO-APIC-edge  serial
  8:          1          0    IO-APIC-edge  rtc
  9:          0          0   IO-APIC-level  acpi
 12:         84          0    IO-APIC-edge  i8042
 14:       1368          0    IO-APIC-edge  ide0
 15:       1316          0    IO-APIC-edge  ide1
 22:       3212          0   IO-APIC-level  eth1
 23:          2          0   IO-APIC-level  libata
NMI:          0          0
LOC:     640020     640019
ERR:          0
MIS:          0

Board is an Asus PC-DL, Intel 875P Chipset, one Xeon 2.8Ghz CPU, Onboard e1000 Network interface. Any idea how I can get the onboard NIC to work?

Thanks, Martin
