Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311871AbSENHzd>; Tue, 14 May 2002 03:55:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314394AbSENHzc>; Tue, 14 May 2002 03:55:32 -0400
Received: from 12-238-198-51.client.attbi.com ([12.238.198.51]:27008 "EHLO
	ledzep.dyndns.org") by vger.kernel.org with ESMTP
	id <S311871AbSENHzb>; Tue, 14 May 2002 03:55:31 -0400
Message-ID: <3CE0C2EA.2090107@attbi.com>
Date: Tue, 14 May 2002 02:55:22 -0500
From: Jordan Breeding <jordan.breeding@attbi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc2) Gecko/20020510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Status of nmi_watchdog on AMD SMP systems
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

   I have a dual AMD SMP system, until recently I only had two real 
problems with it, rebooting and not getting the nmi_watchdog to work at 
all.  I have finally figured out that using "reboot=warm" as a kernel 
parameter solves the problem of rebooting not working.  I have still yet 
to figure out why the nmi_watdog will not work when nmi_watchdog=1 is 
set.  Here is a relevant section of my dmesg:

POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: Before vendor init, caps: 0383fbff c1cbfbff 00000000, vendor = 2
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After vendor init, caps: 0383fbff c1cbfbff 00000000 00000000
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff c1cbfbff 00000000 00000000
CPU:             Common caps: 0383fbff c1cbfbff 00000000 00000000
CPU0: AMD Athlon(tm) MP 1900+ stepping 02
per-CPU timeslice cutoff: 731.57 usecs.
task migration cache decay timeout: 10 msecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/0 eip 3000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 3185.04 BogoMIPS
CPU: Before vendor init, caps: 0383fbff c1cbfbff 00000000, vendor = 2
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After vendor init, caps: 0383fbff c1cbfbff 00000000 00000000
Intel machine check reporting enabled on CPU#1.
CPU:     After generic, caps: 0383fbff c1cbfbff 00000000 00000000
CPU:             Common caps: 0383fbff c1cbfbff 00000000 00000000
CPU1: AMD Athlon(tm) Processor stepping 02
Total of 2 processors activated (6363.54 BogoMIPS).
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
init IO_APIC IRQs
  IO-APIC (apicid-pin) 2-0, 2-5, 2-7, 2-10, 2-11, 2-20, 2-21, 2-22, 2-23 
not connected.
..TIMER: vector=0x31 pin1=2 pin2=0
activating NMI Watchdog ... done.
testing NMI watchdog ... CPU#0: NMI appears to be stuck!
number of MP IRQ sources: 19.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................

I booted that instance of linux using "nmi_watchdog=1" as a kernel 
parameter and here is what my /proc/interrupts looks like:

            CPU0       CPU1
   0:     179006     178070    IO-APIC-edge  timer
   1:          3         20    IO-APIC-edge  i8042
   2:          0          0          XT-PIC  cascade
   8:          0          1    IO-APIC-edge  rtc
   9:          0          0    IO-APIC-edge  acpi
  14:      36571      36768    IO-APIC-edge  ide0
  16:      77386      80349   IO-APIC-level  aic7xxx, EMU10K1
  17:          8          8   IO-APIC-level  aic7xxx
  18:     947537     948208   IO-APIC-level  eth0
  19:      15906      16397   IO-APIC-level  usb-ohci
NMI:          0          0
LOC:     356981     356995
ERR:          0
MIS:          0

Any ideas as to what would cause the nmi_watchdog to not set itself up 
and work properly?  Thanks.

Jordan Breeding

