Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265127AbUA2JvP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 04:51:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265164AbUA2JvO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 04:51:14 -0500
Received: from haneman.dialup.fu-berlin.de ([160.45.224.9]:31621 "EHLO
	haneman.hacenet") by vger.kernel.org with ESMTP id S265127AbUA2JvM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 04:51:12 -0500
Message-ID: <4018D74A.1000107@convergence.de>
Date: Thu, 29 Jan 2004 10:50:02 +0100
From: Enver Haase <enver@convergence.de>
Organization: convergence GmbH
User-Agent: Mozilla/5.0 (X11; U; Linux i586; de-AT; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: en-us, de, fr
MIME-Version: 1.0
To: Roger Luethi <rl@hellgate.ch>, Ingo Molnar <mingo@redhat.com>,
       Rokas Masiulis <roma1390@uosis.mif.vu.lt>, linux-kernel@vger.kernel.org
Subject: IO-APIC/VIA-RHINE problem on 2.4.x
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello Roger,
Hello Ingo,
Hello Rokas,
Hello World,

I experienced a strange problem when buying an Athlon from a friend;
I just re-configured and re-compiled the kernel when the NIC stopped
working. It was possible to ifconfig it, but it would not talk to the
world, just as if there would be no interrupts signalling data was there.

Googling I found

  http://www.scyld.com/pipermail/netdrivers/2003-May/000022.html

where Rokas gives a lot of debug output about the problem, although
he switched from 2.2.x to 2.4.x, not from one config to another.

Finally, I think I found the problem:
on Rokas' 2.2.x the card is configured on a standard interrupt
(see /proc/interrupts), while on 2.4 it's on some special (?)
interrupt 16 (must be something "new" (not IBM-AT-386) with APIC stuff).

Here's output from my machine; it's a VIA-based one.

lspci -n
00:00.0 Class 0600: 1106:3099
00:01.0 Class 0604: 1106:b099
00:0e.0 Class 0100: 1000:0001 (rev 23)
00:10.0 Class 0c03: 1106:3038 (rev 80)
00:10.1 Class 0c03: 1106:3038 (rev 80)
00:10.2 Class 0c03: 1106:3038 (rev 80)
00:10.3 Class 0c03: 1106:3104 (rev 82)
00:11.0 Class 0601: 1106:3177
00:11.1 Class 0101: 1106:0571 (rev 06)
00:11.5 Class 0401: 1106:3059 (rev 50)
00:12.0 Class 0200: 1106:3065 (rev 74)
01:00.0 Class 0300: 10de:0110 (rev b2)

cat /proc/interrupts
This (IO-APIC configured) does not work:
  CPU0
   0:      47654    IO-APIC-edge  timer
   1:       1577    IO-APIC-edge  keyboard
   2:          0          XT-PIC  cascade
   8:          4    IO-APIC-edge  rtc
  12:       2908    IO-APIC-edge  PS/2 Mouse
  14:      22993    IO-APIC-edge  ide0
  15:          7    IO-APIC-edge  ide1
  16:          0   IO-APIC-level  eth0
  17:         14   IO-APIC-level  sym53c8xx
  19:          0   IO-APIC-level  ehci_hcd
  21:        522   IO-APIC-level  usb-uhci, usb-uhci, usb-uhci
  22:      13752   IO-APIC-level  via82cxxx
NMI:          0
LOC:      47606
ERR:          0
MIS:          0

This, however, DOES work (IO APIC NOT configured)
CPU0
   0:      73916          XT-PIC  timer
   1:        135          XT-PIC  keyboard
   2:          0          XT-PIC  cascade
   5:        991          XT-PIC  ehci_hcd, usb-uhci, eth0
   8:          4          XT-PIC  rtc
  11:       5141          XT-PIC  sym53c8xx, via82cxxx, usb-uhci, usb-uhci
  12:       4280          XT-PIC  PS/2 Mouse
  14:       9576          XT-PIC  ide0
  15:          5          XT-PIC  ide1
NMI:          0
ERR:          0

I'd be glad to assist you in tracking this darn bug down; I'll even
go for a 2.6.x soon.

Greetings+thanks,
Enver

