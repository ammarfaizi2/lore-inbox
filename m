Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267299AbTABVqC>; Thu, 2 Jan 2003 16:46:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267290AbTABVnl>; Thu, 2 Jan 2003 16:43:41 -0500
Received: from mailout07.sul.t-online.com ([194.25.134.83]:5594 "EHLO
	mailout07.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S267283AbTABVmr> convert rfc822-to-8bit; Thu, 2 Jan 2003 16:42:47 -0500
Content-Type: text/plain; charset=US-ASCII
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: WOLK - Working Overloaded Linux Kernel
To: Neil Brown <neilb@cse.unsw.edu.au>
Subject: Re: RAID0 problems with 2.4.21-BK current
Date: Thu, 2 Jan 2003 22:50:51 +0100
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
References: <200212292012.11556.m.c.p@wolk-project.de> <200301021651.59376.m.c.p@wolk-project.de> <15892.45056.772569.433906@notabene.cse.unsw.edu.au>
In-Reply-To: <15892.45056.772569.433906@notabene.cse.unsw.edu.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200301022242.16739.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 02 January 2003 22:32, Neil Brown wrote:

Hi Neil,

> Hmmm...  Can you tell me anything else about your set up that might be
> different to mine?
> What drives are you using? Which driver do they use?  i386? anything
> else?

Data captured while 2.4.20 running (I cannot boot into .21-BK now)

1. root@codeman:[/] # hdparm -i /dev/hde
/dev/hde:
 Model=FUJITSU MPG3409AT E, FwRev=82B5, SerialNo=VH46T1702WRC
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=4
 BuffType=DualPortCache, BuffSize=2048kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=80063424
 IORDY=yes, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4 
 DMA modes:  mdma0 mdma1 mdma2 
 UDMA modes: udma0 udma1 udma2 udma3 udma4 *udma5 
 AdvancedPM=yes: disabled (255) WriteCache=enabled
 Drive conforms to: ATA/ATAPI-5 T13 1321D revision 1:  1 2 3 4 5

2. Quantum Fireball 40GB (no more info because drive died yesterday)

... connected to:

01:01.0 RAID bus controller: Promise Technology, Inc. 20268R (rev 02) (prog-if 
85)
        Subsystem: Promise Technology, Inc.: Unknown device 4d68
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (1000ns min, 4500ns max), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at a400 [size=8]
        Region 1: I/O ports at a000 [size=4]
        Region 2: I/O ports at 9c00 [size=8]
        Region 3: I/O ports at 9800 [size=4]
        Region 4: I/O ports at 9400 [size=16]
        Region 5: Memory at efc00000 (32-bit, non-prefetchable) [size=64K]
        Expansion ROM at efdd0000 [disabled] [size=64K]
        Capabilities: [60] Power Management version 1
                Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-



root@codeman:[/] # cat /proc/cpuinfo 
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 11
model name      : Intel(R) Celeron(TM) CPU                1300MHz
stepping        : 1
cpu MHz         : 1295.709
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 mmx fxsr sse
bogomips        : 2588.67




Kernel Config:
--------------
[*] Multiple devices driver support (RAID and LVM)
<M>  RAID support
<M>   RAID-0 (striping) mode

- everything else from that submenu disabled!



/etc/raidtab:
-------------
raiddev /dev/md0
       raid-level              0
       nr-raid-disks           2
       nr-spare-disks          0
       chunk-size              4
       persistent-superblock   1
       device                  /dev/hde2
       raid-disk               0
       device                  /dev/hdf2
       raid-disk               1

hde2 and hdf2 are type fd. Made with mkraid /dev/md0.

mkraid /dev/md0 hangs with the mentioned patch some time ago.
RAID detection hangs at boot with the mentioned patch ... bla ^ ;)

w/o all works. Anything else you need?

ciao, Marc
