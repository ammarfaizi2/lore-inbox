Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261904AbVBIT5F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261904AbVBIT5F (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 14:57:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261905AbVBIT5F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 14:57:05 -0500
Received: from pop-a065d19.pas.sa.earthlink.net ([207.217.121.253]:47036 "EHLO
	pop-a065d19.pas.sa.earthlink.net") by vger.kernel.org with ESMTP
	id S261904AbVBIT4W convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 14:56:22 -0500
From: Eric Bambach <eric@cisu.net>
Reply-To: eric@cisu.net
To: linux-kernel@vger.kernel.org
Subject: High Interrupt load crashes SMP Athlon MPs
Date: Wed, 9 Feb 2005 13:54:43 -0600
User-Agent: KMail/1.7.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200502091354.43348.eric@cisu.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
 After doing much research I have come to the conclusion that the kernel might 
be at fault (in conjuction with the mobo) for hard-locking my box. Please 
read below to see if you can help me.
 I am coming to wits end with this MSI K7D Master-L board. I have narrowed it 
down to find that anything that causes alot of interrupts will lock the box. 
By lock I mean a HARD lock, no ping, no mouse, no oops, no sysrq, no nothing. 
It is a sudden and TOTAL lockup. A ping -f and playing xmms at the same time 
will cause the box to lock in minutes while as if there is very little 
activity I can run for perhaps an hour or so maybe more (havent had the time 
or the patience to baby-sit an idle box for more than an hour. This is my 
main box.)

 When I ran this box as a single-cpu system with an athlon mp2400 it ran fine. 
Perhaps something with SMP is triggering a nasty bug.

The motherboard was bought to replace another motherboard and so I could go 
SMP. The ram, powersupply,ALL cards, basically all the hardware are known 
good and have been used for months in another system. The LCD here is the 
mobo.

I have googled extensivly and have tried many things to see if I can alleviate 
the problem, so far nothing. Does anyone have any ideas to see if this is a 
kernel problem?

Is this a known problem? Is there a patch to fix this? I am trying to avoid 
replacing/returning such a beautiful and expensive motherboard.

Here is excerpt from a Redhat mailing list
>If your motherboard's using the AMD-768 chipset for the Southbridge, you
>may have run afoul of a bug in interrupt masking which can hang the
>system.  The reports thus far on the linux kernel list imply that plugging
>in a PS/2 mouse seems to work around the problem; it's worked for me (MSI
>K7D Master board with dual Athlons), though I've only had a few days'
>trial so far.

So it seems to suggest something in the kernel has something in part to do 
with the lockup. Anyone have any suggestions? Any info I can provide?

Here is a non-exhaustive unordered list of various things I've tried.

-Combonations of noapic nolapic acpi=off
-Increasing the vcore slightly
-Downloading and compiling the latest kernel (see uname -a output)
-Recompiled the kernel, ran make clean
-turning DMA off in the bios
-turning DMS off via hdparm
-running without a PATA drive at all (all scsi)
-Removing ALL unneccesary cards
-Removing ALL unnecesary devices (to recude power consumption)
-Disabling USB and removing USB support from the kernel
-Installing sensors and making sure voltages/temps are nominal (they are)
-installed and used irqbalance
-Disable preempt
-Try the onboard lan and a 64bit pci gigabit lan card mutually exclusively
-Removed side-panel and verified heat is not an issue
-Updated to latest BIOS version

---------------hardware and kernel specs--------------
bot403@eric bot403 $ su
Password:
</home/bot403:13:32:45>
root@eric >uname -a
Linux eric 2.6.10-gentoo-r6 #2 SMP Tue Feb 8 17:12:59 CST 2005 i686 AMD 
Athlon(tm) MP 2600+ AuthenticAMD GNU/Linux
</home/bot403:13:32:47>
root@eric >lspci -v
0000:00:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] 
System Controller (rev 11)
        Flags: bus master, 66Mhz, medium devsel, latency 32
        Memory at e8000000 (32-bit, prefetchable)
        Memory at fd005000 (32-bit, prefetchable) [size=4K]
        I/O ports at ec00 [disabled] [size=4]
        Capabilities: [a0] AGP version 2.0

0000:00:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] AGP 
Bridge (prog-if 00 [Normal decode])
        Flags: bus master, 66Mhz, medium devsel, latency 32
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
        Memory behind bridge: f8000000-f9ffffff
        Prefetchable memory behind bridge: f0000000-f7ffffff

0000:00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] ISA (rev 
05)
        Flags: bus master, 66Mhz, medium devsel, latency 0

0000:00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-768 [Opus] IDE 
(rev 04) (prog-if 8a [Master SecP PriP])
        Subsystem: Advanced Micro Devices [AMD] AMD-768 [Opus] IDE
        Flags: bus master, medium devsel, latency 32
        I/O ports at e000 [size=16]

0000:00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] ACPI (rev 03)
        Subsystem: Advanced Micro Devices [AMD] AMD-768 [Opus] ACPI
        Flags: medium devsel

0000:00:09.0 SCSI storage controller: LSI Logic / Symbios Logic 53c1010 Ultra3 
SCSI Adapter (rev 01)
        Subsystem: LSI Logic / Symbios Logic: Unknown device 1030
        Flags: bus master, medium devsel, latency 72, IRQ 153
        I/O ports at e400
        Memory at fd006000 (64-bit, non-prefetchable) [size=1K]
        Memory at fd002000 (64-bit, non-prefetchable) [size=8K]
        Capabilities: [40] Power Management version 2

0000:00:09.1 SCSI storage controller: LSI Logic / Symbios Logic 53c1010 Ultra3 
SCSI Adapter (rev 01)
        Subsystem: LSI Logic / Symbios Logic: Unknown device 1030
        Flags: bus master, medium devsel, latency 72, IRQ 161
        I/O ports at e800
        Memory at fd004000 (64-bit, non-prefetchable) [size=1K]
        Memory at fd000000 (64-bit, non-prefetchable) [size=8K]
        Capabilities: [40] Power Management version 2

0000:00:10.0 PCI bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] PCI (rev 
05) (prog-if 00 [Normal decode])
        Flags: bus master, 66Mhz, medium devsel, latency 32
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
        I/O behind bridge: 0000d000-0000dfff
        Memory behind bridge: fb000000-fcffffff
        Expansion ROM at 0000d000 [disabled] [size=4K]

0000:01:05.0 VGA compatible controller: nVidia Corporation NV28 [GeForce4 Ti 
4200 AGP 8x] (rev a1) (prog-if 00 [VGA])
        Flags: bus master, 66Mhz, medium devsel, latency 248, IRQ 153
        Memory at f8000000 (32-bit, non-prefetchable)
        Memory at f0000000 (32-bit, prefetchable) [size=128M]
        Capabilities: [60] Power Management version 2
        Capabilities: [44] AGP version 3.0

0000:02:09.0 Ethernet controller: Intel Corp. 82559ER (rev 09)
        Subsystem: Intel Corp.: Unknown device 3000
        Flags: bus master, medium devsel, latency 32, IRQ 153
        Memory at fc020000 (32-bit, non-prefetchable)
        I/O ports at d000 [size=64]
        Memory at fc000000 (32-bit, non-prefetchable) [size=128K]
        Capabilities: [dc] Power Management version 2

</home/bot403:13:32:49>
root@eric >cat /proc/interrupts
           CPU0       CPU1
  0:     315584     309379    IO-APIC-edge  timer
  1:        638        724    IO-APIC-edge  i8042
  2:          0          0          XT-PIC  cascade
  8:          2          0    IO-APIC-edge  rtc
 12:       8054      11784    IO-APIC-edge  i8042
 14:       1879       1247    IO-APIC-edge  ide0
153:    1174407    1153144   IO-APIC-level  sym53c8xx, eth0, nvidia
161:          0          0   IO-APIC-level  sym53c8xx
NMI:          0          0
LOC:     624860     624868
ERR:          0
MIS:          0
</home/bot403:13:32:52>
root@eric >cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 10
model name      : AMD Athlon(tm) MP 2600+
stepping        : 0
cpu MHz         : 1999.946
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmovpat pse36 mmx fxsr sse pni syscall mp mmxext 3dnowext 3dnow
bogomips        : 3932.16

processor       : 1
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 10
model name      : AMD Athlon(tm) MP
stepping        : 0
cpu MHz         : 1999.946
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmovpat pse36 mmx fxsr sse pni syscall mp mmxext 3dnowext 3dnow
bogomips        : 3989.50

</home/bot403:13:32:55>
root@eric >  
---------------EOF hardware and kernel specs EOF--------------


----------------------------------------
--EB

> All is fine except that I can reliably "oops" it simply by trying to read
> from /proc/apm (e.g. cat /proc/apm).
> oops output and ksymoops-2.3.4 output is attached.
> Is there anything else I can contribute?

The latitude and longtitude of the bios writers current position, and
a ballistic missile.

                --Alan Cox LKML-December 08,2000 

----------------------------------------
