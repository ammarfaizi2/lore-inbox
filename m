Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318030AbSGWLmt>; Tue, 23 Jul 2002 07:42:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318032AbSGWLmt>; Tue, 23 Jul 2002 07:42:49 -0400
Received: from [196.26.86.1] ([196.26.86.1]:49580 "HELO
	infosat-gw.realnet.co.sz") by vger.kernel.org with SMTP
	id <S318030AbSGWLms>; Tue, 23 Jul 2002 07:42:48 -0400
Date: Tue, 23 Jul 2002 14:03:42 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@linux-box.realnet.co.sz
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, James Cleverdon <jamesclv@us.ibm.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: 2.4.19-rc3-ac2 SMP
In-Reply-To: <200207222121.04788.jamesclv@us.ibm.com>
Message-ID: <Pine.LNX.4.44.0207231355230.32636-100000@linux-box.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan, James

	This is what i have so far, i'll probably have time to really 
debug it when i get home later today. The problem persists with Jame's 
Summit patch applied too (just in case there were other fixes there).

Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: OEM00000 Product ID: 0.1          APIC at: 0xFEE00000
Processor #0 Pentium(tm) Pro APIC version 17
Processor #1 Pentium(tm) Pro APIC version 17
Processor #2 Pentium(tm) Pro APIC version 17
Processor #3 Pentium(tm) Pro APIC version 17
I/O APIC #4 Version 17 at 0xFEC00000.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Processors: 4
[...]
ENABLING IO-APIC IRQs
Setting 4 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 4 ... ok.
..TIMER: vector=0x31 pin1=0 pin2=-1
<dead>

Around here the machine gets a vector 0x31 (timer) interrupt on CPU0 then 
locks up since the destination cpu bitmask is 0, It also seems that the 
code is trying to use logical apic id in places instead of the physical 
apic id, i saw attempted deliveries to physical apic id 4 and 8, this can 
possibly explain the APIC receive errors people were reporting? 

Unfortunately this is the only info i have right now, i thought i'd be 
able to gather more but looks like i'll have to wait till i get home.

As a control, the machine boots and runs 2.4.19-rc2

Regards,
	Zwane Mwaikambo

Alan on a side note, would you like a patch to bring around some fixes 
from 2.5 irq_balance? Your kernel can't boot UP w/ IOAPIC

-- 
function.linuxpower.ca

