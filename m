Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293591AbSCKE6j>; Sun, 10 Mar 2002 23:58:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293606AbSCKE63>; Sun, 10 Mar 2002 23:58:29 -0500
Received: from tmhoyle.gotadsl.co.uk ([195.149.46.162]:65031 "EHLO
	mail.cvsnt.org") by vger.kernel.org with ESMTP id <S293591AbSCKE6O>;
	Sun, 10 Mar 2002 23:58:14 -0500
Mailbox-Line: From tmh@nothing-on.tv  Mon Mar 11 04:58:11 2002
Mailbox-Line: From tmh@nothing-on.tv  Mon Mar 11 04:58:08 2002
From: Tony Hoyle <tmh@nothing-on.tv>
Subject: New motherboard...  not a lot works yet :-)
Date: Mon, 11 Mar 2002 04:56:49 +0000
Organization: cvsnt.org news server
Message-ID: <3C8C3911.9030206@nothing-on.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: sisko.my.home 1015822687 7601 192.168.2.3 (11 Mar 2002 04:58:07 GMT)
X-Complaints-To: abuse@cvsnt.org
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020214
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just got a new motherboard (asus dual athlon).  It has a
couple of issues...

There isn't a BIOS upgrade for this board availale yet so I
expect some of it is just BIOS bugs.

Note for anyone purchasing this board in the future: You *must* set 'PnP
aware OS' to 'No' otherwise nothing works at all (all the devices try to 
claim IRQ0)... that one stumped me for a couple of hours.

1.  The APIC doesn't work.  It gets as far printing '..TIMER: xxxx'
(io_apic.c line 1507 in my tree) then hangs.  Using 'noapic' gets
around this.

2.  'halt -p' doesn't power off, it only suspends, and the power button 
doesn't do anything.  /proc/acpi/button has two directories called 
'power' in it and one called 'sleep'.  All 3 directories are empty.
I guess this is just a dodgy BIOS but surely ACPI shouldn't create two 
identical directories???

None of the devices are listed in the PCI database yet... AFAIK this 
board is AMD 762MP based.  Without ripping apart the machine I can't 
tell you the exact chip numbers, though.

(lspci -v output)
00:00.0 Host bridge: Advanced Micro Devices [AMD]: Unknown device 700c 
(rev 11)
	Flags: bus master, 66Mhz, medium devsel, latency 32
	Memory at fc000000 (32-bit, prefetchable) [size=32M]
	Memory at fb800000 (32-bit, prefetchable) [size=4K]
	I/O ports at e800 [disabled] [size=4]
	Capabilities: <available only to root>

00:01.0 PCI bridge: Advanced Micro Devices [AMD]: Unknown device 700d 
(prog-if 00 [Normal decode])
	Flags: bus master, 66Mhz, medium devsel, latency 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: ef000000-efdfffff
	Prefetchable memory behind bridge: eff00000-fb7fffff

00:07.0 ISA bridge: Advanced Micro Devices [AMD]: Unknown device 7440 
(rev 04)
	Subsystem: Asustek Computer, Inc.: Unknown device 8044
	Flags: bus master, 66Mhz, medium devsel, latency 0

00:07.1 IDE interface: Advanced Micro Devices [AMD]: Unknown device 7441 
(rev 04) (prog-if 8a [Master SecP PriP])
	Subsystem: Advanced Micro Devices [AMD]: Unknown device 7441
	Flags: bus master, medium devsel, latency 32
	I/O ports at b800 [size=16]

00:07.3 Bridge: Advanced Micro Devices [AMD]: Unknown device 7443 (rev 03)
	Subsystem: Asustek Computer, Inc.: Unknown device 8044
	Flags: medium devsel

I'm using kernel 2.4.18-pre7 if it helps.

Tony

