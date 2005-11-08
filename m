Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932467AbVKHQcQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932467AbVKHQcQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 11:32:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932465AbVKHQcQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 11:32:16 -0500
Received: from mail.gmx.de ([213.165.64.20]:47555 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932479AbVKHQcQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 11:32:16 -0500
X-Authenticated: #222435
From: Jonas Diemer <diemer@gmx.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Network Card dies
Date: Tue, 8 Nov 2005 17:32:13 +0100
User-Agent: KMail/1.8.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511081732.14083.diemer@gmx.de>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I am experiencing a wierd problem that I assume may be a kernel problem: One 
of my network cards (eth1, realtek rtl 8139c) keeps dieing every couple of 
days. The concerning server has two NICs (internal network: eth0 and external 
network: eth1). The internal NW-connection is not affected at all (eth0, via 
rhine).

I can put the broken NIC back to live by issueing

ifdown eth1
ifup eth1

I have already changed the NIC with another rtl8139x - same problem.

ifconfig shows lots of errors on the external NIC:

eth0      Link encap:Ethernet  HWaddr 00:E0:18:E8:E4:27
          inet addr:192.168.2.99  Bcast:192.168.2.255  Mask:255.255.255.0
          inet6 addr: fe80::2e0:18ff:fee8:e427/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:2597328 errors:0 dropped:52 overruns:0 frame:0
          TX packets:2828733 errors:2 dropped:0 overruns:2 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:818665978 (780.7 MiB)  TX bytes:2106925062 (1.9 GiB)
          Interrupt:177 Base address:0xe800

eth1      Link encap:Ethernet  HWaddr 00:E0:4C:03:1D:6D
          inet addr:134.169.xx.xx  Bcast:134.169.255.255  Mask:255.255.0.0
          inet6 addr: fe80::2e0:4cff:fe03:1d6d/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:18934122 errors:47 dropped:0 overruns:0 frame:17
          TX packets:720131 errors:0 dropped:0 overruns:0 carrier:0
          collisions:14756 txqueuelen:1000
          RX bytes:1534286605 (1.4 GiB)  TX bytes:419733715 (400.2 MiB)
          Interrupt:169 Base address:0xec00

The error occurs (round about) since I upgraded to debian sarge and kernel 
2.6.x

I also noticed, that both NICs got quite high IRQs and the affected NIC 
generates quite a large amount of interrupts:

cat /proc/interrupts
           CPU0
  0:  441607130    IO-APIC-edge  timer
  1:          9    IO-APIC-edge  i8042
  9:          0   IO-APIC-level  acpi
 14:    1543310    IO-APIC-edge  ide0
169: 2437895008   IO-APIC-level  eth1
177:    5390393   IO-APIC-level  eth0
NMI:          0
LOC:  441635565
ERR:          0
MIS:          0

This seems to be pointing at the problem, but I don't really know how to fix 
it or what to do to work around it. Maybe someone can help!

regards, and thanks in advance,
Jonas

PS: Please CC me in replies, I am not on the list!
