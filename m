Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129903AbRAJVbL>; Wed, 10 Jan 2001 16:31:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136576AbRAJVbB>; Wed, 10 Jan 2001 16:31:01 -0500
Received: from e56090.upc-e.chello.nl ([213.93.56.90]:32275 "EHLO unternet.org")
	by vger.kernel.org with ESMTP id <S129903AbRAJVap>;
	Wed, 10 Jan 2001 16:30:45 -0500
Date: Wed, 10 Jan 2001 22:30:15 +0100
From: Frank de Lange <frank@unternet.org>
To: linux-kernel@vger.kernel.org
Subject: QUESTION: Network hangs with BP6 and 2.4.x kernels, hardware related?
Message-ID: <20010110223015.B18085@unternet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi'all,

Ever since I put two ethernet-cards (cheap Winbond W89C940 based PCI NE2K
clones) in my BP-6 system, I've been experiencing intermittent network hangs. A
hang manifests itself as a total failure to communicate through either network
card, and can only be solved by rebooting. Removing and reloading the modules
does not fix the problem, only a reboot works.

I have searched high and low for possible causes, but I found no definite
answer. I suspect the problem may be hardware-related (the BP-6 can be tricky
sometimes), but I want to rule out software issues before I take the system
apart. So, my question: does anyone else experience these network-related
problems with a BP-6 based system? Or maybe other similar problems, where a
specific subsystem hangs an can only be revived by rebooting the box? The
network cards are currently in PCI4 and PCI5 (which should work, they are
NON-busmastering cards after all...), but relocating the cards does not solve
the problem. This problem has been nagging me ever since I moved to 2.3.x
(somewhere around 2.3.30). As it is intermittent, it is very difficult to pin
down. I suspect the APIC in not completely sane, or some timing on the bus is
out of spec, but that's no more than a suspicion. And since I do not have
access to a logic analyzer it is somewhat hard to prove...

Here's a lspci for the box:

00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge (rev 03)
00:01.0 PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge (rev 03)
00:07.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01)
00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01)
00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 02)
00:09.0 Ethernet controller: Winbond Electronics Corp W89C940
00:0b.0 Multimedia video controller: Brooktree Corporation Bt878 (rev 02)
00:0b.1 Multimedia controller: Brooktree Corporation Bt878 (rev 02)
00:0d.0 SCSI storage controller: Symbios Logic Inc. (formerly NCR) 53c875 (rev 26)
00:0f.0 Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97] (rev 06)
00:11.0 Ethernet controller: Winbond Electronics Corp W89C940 (rev 0b)
00:13.0 Unknown mass storage controller: Triones Technologies, Inc. HPT366 (rev 01)
00:13.1 Unknown mass storage controller: Triones Technologies, Inc. HPT366 (rev 01)
01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 04)

and here's a cat /proc/<interesting_file>

/proc/cpuinfo shows this box contains dual Celeron 466's (non-overclocked)

/proc/interrupts:
           CPU0       CPU1       
  0:   10003353    9483961    IO-APIC-edge  timer
  1:      85449      84279    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  3:        167        249    IO-APIC-edge  serial
  4:     380807     381140    IO-APIC-edge  serial
 14:     136991     132077    IO-APIC-edge  ide0
 15:      25836      24605    IO-APIC-edge  ide1
 16:      42510      42482   IO-APIC-level  es1371, mga@PCI:1:0:0
 17:         26         26   IO-APIC-level  sym53c8xx
 18:       9287       8837   IO-APIC-level  bttv
 19:     205294     205191   IO-APIC-level  eth0, eth1, usb-uhci
NMI:   19487238   19487238 
LOC:   19488621   19488620 
ERR:          0

/proc/meminfo:
        total:    used:    free:  shared: buffers:  cached:
Mem:  261984256 260354048  1630208        0 12873728 99012608
Swap: 511926272 14245888 497680384
...
...

# network cards share IRQ with USB, which hosts...
/proc/bus/usb/devices:
T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc= 11/900 us ( 1%), #Int=  1, #Iso=  0
D:  Ver= 1.00 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 0.00
S:  Product=USB UHCI Root Hub
S:  SerialNumber=c000
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=255ms
T:  Bus=01 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=  2 Spd=12  MxCh= 0
D:  Ver= 1.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=03f0 ProdID=0401 Rev= 1.00
S:  Product=HP ScanJet 5200C
S:  SerialNumber=SG95D1720ZHT
C:* #Ifs= 1 Cfg#= 1 Atr=60 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 3 Cls=00(>ifc ) Sub=00 Prot=00 Driver=usbscanner
E:  Ad=81(I) Atr=02(Bulk) MxPS=  64 Ivl=  0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  16 Ivl=  0ms
E:  Ad=83(I) Atr=03(Int.) MxPS=   1 Ivl=250ms

uname -a:
Linux behemoth.localnet 2.4.0 #1 SMP Fri Jan 5 15:41:39 CET 2001 i686 unknown

Cheers//Frank

-- 
  WWWWW      _______________________
 ## o o\    /     Frank de Lange     \
 }#   \|   /                          \
  ##---# _/     <Hacker for Hire>      \
   ####   \      +31-320-252965        /
           \    frank@unternet.org    /
            -------------------------
 [ "Omnis enim res, quae dando non deficit, dum habetur
    et non datur, nondum habetur, quomodo habenda est."  ]
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
