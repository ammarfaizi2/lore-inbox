Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317059AbSF1IaE>; Fri, 28 Jun 2002 04:30:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317068AbSF1IaD>; Fri, 28 Jun 2002 04:30:03 -0400
Received: from lapd.cj.edu.ro ([193.231.142.101]:46477 "HELO lapd.cj.edu.ro")
	by vger.kernel.org with SMTP id <S317059AbSF1IaC>;
	Fri, 28 Jun 2002 04:30:02 -0400
Date: Fri, 28 Jun 2002 11:32:18 +0300 (EEST)
From: "Lists (lst)" <linux@lapd.cj.edu.ro>
To: linux-kernel@vger.kernel.org
Subject: IRQ sharing problem - 2.4.18 kernel
Message-ID: <Pine.LNX.4.43L0.0206281119490.14586-100000@lapd.cj.edu.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
I have a TYAN Tiger 200T M/B with 2xIntel PIII CPUs at 1GHz and 1,3GB RAM. 
I'm using RadHat up to date and 2.4.18 vanilla kernel. On heavy load on 
ethernet interfaces (eth1,2,3,4) and scsi controller which are on the same 
IRQ (11) my server stops responding.

Thease are the erros given by kernel:
Jun 27 21:56:27 lapd eth3: Promiscuous mode enabled.
Jun 27 21:56:27 lapd NETDEV WATCHDOG: eth4: transmit timed out
Jun 27 21:56:27 lapd eth4: Tx queue start entry 4  dirty entry 0.
Jun 27 21:56:27 lapd eth4:  Tx descriptor 0 is 00002000. (queue head)
Jun 27 21:56:27 lapd eth4:  Tx descriptor 1 is 00002000.
Jun 27 21:56:27 lapd eth4:  Tx descriptor 2 is 00002000.
Jun 27 21:56:27 lapd eth4:  Tx descriptor 3 is 00002000.
Jun 27 21:56:27 lapd eth4: Setting half-duplex based on auto-negotiated partner ability 0000.
Jun 27 21:56:27 lapd eth4: Promiscuous mode enabled.
Jun 27 21:56:39 lapd NETDEV WATCHDOG: eth3: transmit timed out
Jun 27 21:56:39 lapd eth3: Tx queue start entry 4  dirty entry 0.
Jun 27 21:56:39 lapd eth3:  Tx descriptor 0 is 00002000. (queue head)
Jun 27 21:56:39 lapd eth3:  Tx descriptor 1 is 00002000.
Jun 27 21:56:39 lapd eth3:  Tx descriptor 2 is 00002000.
Jun 27 21:56:39 lapd eth3:  Tx descriptor 3 is 00002000.
Jun 27 21:56:39 lapd eth3: Setting 100mbps full-duplex based on auto-negotiated partner ability 45e1

How  can I put the eths on different IRQs?
This is the IRQ router MAP table:
PCI->APIC IRQ transform: (B0,I6,P0) -> 5
PCI->APIC IRQ transform: (B0,I7,P3) -> 5
PCI->APIC IRQ transform: (B0,I7,P3) -> 5
PCI->APIC IRQ transform: (B0,I13,P0) -> 11
PCI->APIC IRQ transform: (B0,I14,P0) -> 11
PCI->APIC IRQ transform: (B0,I15,P0) -> 11
PCI->APIC IRQ transform: (B0,I16,P0) -> 11
PCI->APIC IRQ transform: (B0,I17,P0) -> 5
PCI->APIC IRQ transform: (B0,I18,P0) -> 11
PCI->APIC IRQ transform: (B0,I19,P0) -> 10

# cat /proc/interrupts
           CPU0       CPU1
  0:      51399      64321    IO-APIC-edge  timer
  1:       1981       2474    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  3:          1          0    IO-APIC-edge  serial
  5:        444        551   IO-APIC-level  eth0
  9:          0          1    IO-APIC-edge  acpi
 11:       8984       9458   IO-APIC-level  ncr53c8xx, eth1, eth2, eth3, eth4
 Here is my problem			    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 12:       7375       9158    IO-APIC-edge  PS/2 Mouse
 14:      10644       8483    IO-APIC-edge  ide0
 15:         10         13    IO-APIC-edge  ide1
NMI:          0          0
LOC:     115618     115638
ERR:          3
MIS:          2

I tried to change the IRQs with pirq and ether at the boot time but it 
dosen't work.

Thanx,
Cosmin
-- 
NetAdm at "Alexandru Papiu Ilarian" Highschool Dej
       e-mail: <doom@lapd.cj.edu.ro> LRU:  #192084
     phone: +40-264.211.421 int 25 +40-723.514.225
It's nice to be important
But is more important to be nice
---

---
Pentru dezabonare, trimiteti mail la 
listar@lug.ro cu subiectul 'unsubscribe rlug'.
REGULI, arhive si alte informatii: http://www.lug.ro/mlist/





