Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261708AbSIXQ6z>; Tue, 24 Sep 2002 12:58:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261710AbSIXQ6z>; Tue, 24 Sep 2002 12:58:55 -0400
Received: from fwextcnus.controlnet.com ([12.44.181.130]:28627 "HELO
	vivaldi.controlnet.com") by vger.kernel.org with SMTP
	id <S261708AbSIXQ6y>; Tue, 24 Sep 2002 12:58:54 -0400
From: "Mark Knecht" <mknecht@controlnet.com>
To: <linux-kernel@vger.kernel.org>
Subject: SMP machines - IRQ Priorities
Date: Tue, 24 Sep 2002 10:00:22 -0700
Message-ID: <000101c263eb$df8adfc0$b50aa8c0@mknecht>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
   Excuse me for interrupting you guys too much. I hope you can find a
minute to answer these two questions for me:

***  When APIC IRQs are used (IRQs higher than 15) what is the IRQ serviced
first? ***

(17 before 18 before 19?)
(19 before 18 before 17?)

*** Is the order continuous from 0-23, or are any IRQ numbers handled out of
order?

   A number of Ardour users (http://ardour.sourceforge.net) are using SMP
machines. Some are working better than others. On UMP machines I've shown
that IRQ settings are important for recording audio, both under Linux and
Windows. I'm doing some legwork to understand their Linux IRQ
configurations. We're all using 2.4.19 with low latency patches.

   There seem to be two configurations for SMP X86 type machines. The edited
results for lspci -v and cat /proc/interrupts is shown below:

1) Traditional IRQ numbering:
IRQ Priority
0, 1, 8, 9, 10, 11, 12, 13, 14, 15, 3, 4, 5, 6, 7

00:00.0 Host bridge:
00:01.0 PCI bridge:
00:07.0 ISA bridge:
00:07.1 IDE interface:
00:07.2 USB Controller: IRQ 10
00:07.3 USB Controller: IRQ 10
00:07.4 Bridge: IRQ 11
00:0b.0 Multimedia audio controller: IRQ 11
00:0c.0 Ethernet controller: IRQ 10
00:0e.0 Unknown mass storage controller: IRQ 11
01:00.0 VGA compatible controller: IRQ 9


2) APIC IRQ numbering
IRQ Priority

00:00.0 Host bridge:
00:01.0 PCI bridge:
00:07.0 ISA bridge:
00:07.1 IDE interface:
00:07.3 Bridge:
00:09.0 USB Controller: IRQ 17
00:09.1 USB Controller: IRQ 18
00:09.2 USB Controller: IRQ 19
00:10.0 PCI bridge:
01:05.0 VGA compatible controller: IRQ 16
02:00.0 USB Controller: IRQ 19
02:04.0 Multimedia audio: IRQ 17
02:05.0 Multimedia audio: IRQ 18
02:06.0 Serial controller: IRQ 17
02:08.0 Ethernet controller: IRQ 19

   I assume, but am not sure, that the traditional numbering is on machines
where people either did not compile in APIC support or used the noapic
option. On the second set of IRQ settings we need to know what numbers to
get the audio devices on for the best low-latency performance.

Thanks,
Mark

