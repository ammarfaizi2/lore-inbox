Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277290AbRJLJ2I>; Fri, 12 Oct 2001 05:28:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277616AbRJLJ2A>; Fri, 12 Oct 2001 05:28:00 -0400
Received: from destructo.gearboxsoftware.com ([12.37.36.2]:38150 "HELO
	gearboxsoftware.com") by vger.kernel.org with SMTP
	id <S277614AbRJLJ1r>; Fri, 12 Oct 2001 05:27:47 -0400
From: "Sean Cavanaugh" <seanc@gearboxsoftware.com>
To: <linux-kernel@vger.kernel.org>
Subject: P4 SMP load balancing
Date: Fri, 12 Oct 2001 04:28:19 -0500
Message-ID: <002601c15300$3a9f0510$150a10ac@gearboxsoftware.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2616
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I posted this a while back in linux-smp (which seems like a dead list?)

I have several P4 Xeon SMP systems (Supermicro P4DCE, Intel i860
chipset)

ovendev:~# cat /proc/interrupts 
           CPU0       CPU1       
  0:    6348212          0    IO-APIC-edge  timer
  1:          2          0    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  8:          1          0    IO-APIC-edge  rtc
  9:          0          0    IO-APIC-edge  acpi
 16:      92620          0   IO-APIC-level  eth0
 18:       5085          0   IO-APIC-level  aic7xxx, aic7xxx
NMI:          0          0 
LOC:    6348388    6348427 
ERR:          0
MIS:          0


	How much of a problem is this really?  The program's I am
running on these systems (I have 9 of them) seem do ok right now.
Currently the jobs running on them are heavily CPU bound and don't do
any I/O, but this is going to change when I link them up over a private
network so they can work together on some distributable jobs).  I am
running 2.4.10 on most of them, and 2.4.10-ac10 on my developer system
in the farm.  The only difference this newer kernel seems to have made
from older ones is that there is only one 'warning unexpected IO-APIC'
message in my startup instead of two.


Snippet from dmesg:

CPU1: Intel(R) Xeon(TM) CPU 1700MHz stepping 0a
Total of 2 processors activated (6723.99 BogoMIPS).
ENABLING IO-APIC IRQs
...changing IO-APIC physical APIC ID to 2 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-5, 2-10, 2-11, 2-12, 2-17, 2-20, 2-21, 2-22
not connected.
..TIMER: vector=0x31 pin1=2 pin2=0
number of MP IRQ sources: 18.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................

IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.... register #01: 00178020
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0020
 WARNING: unexpected IO-APIC, please mail
          to linux-smp@vger.kernel.org
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table: 
<snip>



	- Sean

