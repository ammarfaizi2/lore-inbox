Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265198AbTLFPft (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 10:35:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265200AbTLFPfs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 10:35:48 -0500
Received: from mx2.mail.ru ([194.67.23.22]:62218 "EHLO mx2.mail.ru")
	by vger.kernel.org with ESMTP id S265198AbTLFPfo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 10:35:44 -0500
Message-ID: <3FD1F74E.3010105@list.ru>
Date: Sat, 06 Dec 2003 10:35:42 -0500
From: Vladimir Grebinskiy <v_lkm@list.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: Catching NForce2 lockup with NMI watchdog - found
References: <DCB9B7AA2CAB7F418919D7B59EE45BAF49F87E@mail-sc-6.nvidia.com> <20031206081848.GA4023@localnet> <3FD1CA81.9010708@gmx.de> <200312061411.37795.bzolnier@elka.pw.edu.pl>
In-Reply-To: <200312061411.37795.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam: Not detected
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I hope you nailed the problem! I applied the "timer APIC-IO-edge" change 
and "athcool off" patch and the box seemed to be working with APIC/LAPIC 
(for the first time) !!! The board is the Leadtek K7nCR18G-Pro, BIOS 
9/30/2003, kernel 2.6.0-test11 and Debian/Sid (all debug turned on, 
preempt off).

The box used to lock up in seconds when running "md5sum bigfile" unless 
booted with "noapic nolapic". Now it survived parallel read from two 
drives + "ping -f router" + glxgears (with nvidia video driver). I'll 
keep testing it for a while.

Vladimir

lspci:
00:00.0 Host bridge: nVidia Corporation nForce2 AGP (different version?) 
(rev a2)
00:00.1 RAM memory: nVidia Corporation nForce2 Memory Controller 1 (rev a2)
00:00.2 RAM memory: nVidia Corporation nForce2 Memory Controller 4 (rev a2)
00:00.3 RAM memory: nVidia Corporation nForce2 Memory Controller 3 (rev a2)
00:00.4 RAM memory: nVidia Corporation nForce2 Memory Controller 2 (rev a2)
00:00.5 RAM memory: nVidia Corporation nForce2 Memory Controller 5 (rev a2)
00:01.0 ISA bridge: nVidia Corporation nForce2 ISA Bridge (rev a3)
00:01.1 SMBus: nVidia Corporation nForce2 SMBus (MCP) (rev a2)
00:02.0 USB Controller: nVidia Corporation nForce2 USB Controller (rev a3)
00:02.1 USB Controller: nVidia Corporation nForce2 USB Controller (rev a3)
00:05.0 Multimedia audio controller: nVidia Corporation nForce 
MultiMedia audio [Via VT82C686B] (rev a2)
00:06.0 Multimedia audio controller: nVidia Corporation nForce2 AC97 
Audio Controler (MCP) (rev a1)
00:08.0 PCI bridge: nVidia Corporation nForce2 External PCI Bridge (rev a3)
00:09.0 IDE interface: nVidia Corporation nForce2 IDE (rev a2)
00:0d.0 FireWire (IEEE 1394): nVidia Corporation nForce2 FireWire (IEEE 
1394) Controller (rev a3)
00:1e.0 PCI bridge: nVidia Corporation nForce2 AGP (rev a2)
01:09.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado] 
(rev 6c)
03:00.0 VGA compatible controller: nVidia Corporation NV18 [GeForce4 MX 
- nForce GPU] (rev a3)

Interrupts:


*         CPU0
  0:    2865299    IO-APIC-edge  timer
  1:       3017    IO-APIC-edge  i8042
  2:          0          XT-PIC  cascade
  8:          4    IO-APIC-edge  rtc
  9:          0   IO-APIC-level  acpi
 12:      13046    IO-APIC-edge  i8042
 14:     223268    IO-APIC-edge  ide0
 15:         49    IO-APIC-edge  ide1
 16:     616405   IO-APIC-level  nvidia
 17:    2333041   IO-APIC-level  eth0
 20:      22450   IO-APIC-level  ohci_hcd
 21:       2621   IO-APIC-level  NVidia nForce2
 22:          0   IO-APIC-level  ohci_hcd
NMI:          0
LOC:    2864269
ERR:          0
MIS:          0



