Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268168AbTAKV7S>; Sat, 11 Jan 2003 16:59:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268169AbTAKV7S>; Sat, 11 Jan 2003 16:59:18 -0500
Received: from dhcp-209-54-75-71.ct.dsl.ntplx.com ([209.54.75.71]:24192 "EHLO
	stinkfoot.org") by vger.kernel.org with ESMTP id <S268168AbTAKV7K>;
	Sat, 11 Jan 2003 16:59:10 -0500
Message-ID: <3E2095BB.4070207@stinkfoot.org>
Date: Sat, 11 Jan 2003 17:07:55 -0500
From: Ethan Weinstein <lists@stinkfoot.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021212
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org, linux-kernel@vger.kernel.org
Subject: ongoing SCSI issues with aic7xxx and sym53c8xx
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

These issues have been posted to linux-scsi and linux-kernel on several 
occasions with no response.  I apologize for reposting them, but I feel this is 
a serious error that should be addressed.

I'm absolutely certain that this is an issue with the PPC kernel's scsi core (or 
perhaps the st driver, but I cannot be sure), as these adapters attached to the 
same devices do not exhibit these problems on an intel machine with a similar 
kernel series (2.4.2x)

Ben H. suggested I attempt to reproduce these errors on kernels without SMP 
and/or HIMEM.  The errors occured on all kernels I tested, exactly.

Oddly, the sym53c8xx card that has one channel and is a 32-bit card functions 
well with the tape drive attached.  The 39160 card also functions well with one 
channel populated.. after attaching the SEAGATE ULTRIUM drive to the second 
channel, all hell breaks loose.  As I stated before, installing either of these 
cards in my intel machine (UP P4 2.4ghz, 1024M) and attaching both hard drives 
and the tape to each one, and utilizing both channels of each works flawlessly.
I'm currently using 2.4.20-ben1, SMP (2 G4s @533), 1280M of RAM, HIMEM enabled.
(yes, termination and cabling are correct, I'm absolutely certain of that)

Here is the problem with the symbios card, posted to linux-scsi 
(http://marc.theaimsgroup.com/?l=linux-scsi&m=104200177221137&w=2)


We recently changed out this card (32-bit card, one channel):

10:14.0 SCSI storage controller: LSI Logic / Symbios Logic (formerly NCR) 53c895
(rev 02)
          Subsystem: LSI Logic / Symbios Logic (formerly NCR): Unknown device 1020
          Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
          Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
          Latency: 16 (7500ns min, 16000ns max), cache line size 08
          Interrupt: pin A routed to IRQ 54
          Region 0: I/O ports at 0400 [size=256]
          Region 1: Memory at 80081000 (32-bit, non-prefetchable) [size=256]
          Region 2: Memory at 80084000 (32-bit, non-prefetchable) [size=4K]
          Expansion ROM at 800c0000 [disabled] [size=128K]

sym.16.20.0: setting PCI_COMMAND_PARITY...
sym0: <895> rev 0x2 on pci bus 16 device 20 function 0 irq 54
sym0: No NVRAM, ID 7, Fast-40, LVD, parity checking
sym0: SCSI BUS has been reset.
scsi2 : sym-2.1.17a

For this one (64-bit PCI card, with 2 channels)

10:14.0 SCSI storage controller: LSI Logic / Symbios Logic (formerly NCR)
53c1010 Ultra3 SCSI Adapter (rev 01)
          Subsystem: LSI Logic / Symbios Logic (formerly NCR): Unknown device 1030
          Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+
Stepping- SERR- FastB2B-
          Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
          Latency: 16 (4250ns min, 4500ns max), cache line size 08
          Interrupt: pin A routed to IRQ 54
          Region 0: I/O ports at 0800 [size=256]
          Region 1: Memory at 80082000 (64-bit, non-prefetchable) [size=1K]
          Region 3: Memory at 8008a000 (64-bit, non-prefetchable) [size=8K]
          Expansion ROM at 800e0000 [disabled] [size=128K]
          Capabilities: [40] Power Management version 2
                  Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                  Status: D0 PME-Enable- DSel=0 DScale=0 PME-

10:14.1 SCSI storage controller: LSI Logic / Symbios Logic (formerly NCR)
53c1010 Ultra3 SCSI Adapter (rev 01)
          Subsystem: LSI Logic / Symbios Logic (formerly NCR): Unknown device 1030
          Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+
Stepping- SERR- FastB2B-
          Status: Cap+ 66Mhz- UDF- FastB2B- ParErr+ DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR+
          Latency: 16 (4250ns min, 4500ns max), cache line size 08
          Interrupt: pin B routed to IRQ 54
          Region 0: I/O ports at 0400 [size=256]
          Region 1: Memory at 80081000 (64-bit, non-prefetchable) [size=1K]
          Region 3: Memory at 80088000 (64-bit, non-prefetchable) [size=8K]
          Expansion ROM at 800c0000 [disabled] [size=128K]
          Capabilities: [40] Power Management version 2
                  Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                  Status: D0 PME-Enable- DSel=0 DScale=0 PME-

sym.16.20.0: setting PCI_COMMAND_PARITY...
sym.16.20.1: setting PCI_COMMAND_PARITY...
sym0: <1010-33> rev 0x1 on pci bus 16 device 20 function 0 irq 54
sym0: No NVRAM, ID 7, Fast-80, LVD, parity checking
sym0: SCSI BUS has been reset.
sym1: <1010-33> rev 0x1 on pci bus 16 device 20 function 1 irq 54
sym1: No NVRAM, ID 7, Fast-80, SE, parity checking
sym1: SCSI BUS has been reset.
sym1: SCSI BUS mode change from SE to SE.
scsi2 : sym-2.1.17a
scsi3 : sym-2.1.17a

The old card was attached to our SEAGATE   Model: ULTRIUM06242-XXX  Rev: 1470
for nightly backups.  The backups ran fine.
After attaching the tape drive to the new card, during the backup we get this:

sym0:6: ERROR (40:0) (0-20-0) (1f/18/0) @ (scripta ad8:10001e00).
sym0: script cmd = 10000000
sym0: regdump: da 10 c0 18 47 1f 06 0a 00 00 86 20 80 01 08 01 00 ac c7 1e 08 00
00 00.
sym0: PCI STATUS = 0x8100
sym0: SCSI BUS reset detected.
sym0: SCSI BUS has been reset.
st0: Error 80000 (sugg. bt 0x0, driver bt 0x0, host bt 0x8).
st0: Error with sense data: Current st09:00: sense key Unit Attention
Additional sense indicates Power on,reset,or bus device reset occurred
st0: Error on write filemark.

The system is a powerpc G4 SMP @533mhz, with 1G of ram.  We're using
kernel-2.4.20, SMP, and HIMEM enabled.  Termination and cabling are definately
correct.  We tried the sym53c8xx module with both 32 and 40 bit DMA addressing..
same results.. the old card works fine, the new card causes these errors and the
backup aborts.
We'd definately rather use the new 2 channel card, as we'd like to attach a disk
to the other channel.. but this is preventing us from doing it.  Any ideas? I'm
up for trying anything here to get this to work.


[ Here is the report I sent to linux-kernel sometime ago regarding the AIC7XXX 
issues ] (http://marc.theaimsgroup.com/?l=linux-scsi&m=103782013026731&w=2)


I recently attempted to add an additional adaptec-29160 card to my dual
G4 (rootfs boots off one already).  It failed miserably to say the
least.  Using an older card (adaptec 2940uw) instead does work however.
   The kernels in question are: 2.4.20-pre11-ben0 and 2.4.20-pre7-ben0,
and stock kernels 2.4.19-2.4.20-rc2 (didn't try anything older)
Also, using a 39160 card with active devices attached to both channels
causes this, using just one of the channels works fine.  This is most
certainly a problem with PPC, as using multiple (3|2)9120's in ix86
works fine.

Here's what happens with two 29160 cards:
.....
ct 26 16:19:24 spicymeatball kernel: SCSI subsystem driver Revision: 1.00
Oct 26 16:19:24 spicymeatball kernel: PCI: Enabling bus mastering for
device 10:14.0
Oct 26 16:19:24 spicymeatball kernel: scsi0 : Adaptec AIC7XXX
EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.8
Oct 26 16:19:24 spicymeatball kernel:         <Adaptec 29160 Ultra160
SCSI adapter>
Oct 26 16:19:24 spicymeatball kernel:         aic7892: Ultra160 Wide
Channel A, SCSI Id=7, 32/253 SCBs
Oct 26 16:19:24 spicymeatball kernel:
Oct 26 16:19:24 spicymeatball kernel: scsi1 : Adaptec AIC7XXX
EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.8
Oct 26 16:19:24 spicymeatball kernel:         <Adaptec 29160 Ultra160
SCSI adapter>
Oct 26 16:19:24 spicymeatball kernel:         aic7892: Ultra160 Wide
Channel A, SCSI Id=7, 32/253 SCBs
Oct 26 16:19:24 spicymeatball kernel:
Oct 26 16:19:24 spicymeatball kernel: blk: queue c1770e18, I/O limit
4095Mb (mask 0xffffffff)
Oct 26 16:19:24 spicymeatball kernel: scsi0:0:6:0: Attempting to queue
an ABORT message
Oct 26 16:19:24 spicymeatball kernel: scsi0: Dumping Card State in
Command phase, at SEQADDR 0xbc
Oct 26 16:19:24 spicymeatball kernel: ACCUM = 0x80, SINDEX = 0xa0,
DINDEX = 0xe4, ARG_2 = 0x0
Oct 26 16:19:24 spicymeatball kernel: HCNT = 0x0 SCBPTR = 0x0
Oct 26 16:19:24 spicymeatball kernel: SCSISEQ = 0x12, SBLKCTL = 0xa
Oct 26 16:19:24 spicymeatball kernel:  DFCNTRL = 0x4, DFSTATUS = 0x88
Oct 26 16:19:24 spicymeatball kernel: LASTPHASE = 0x80, SCSISIGI = 0x86,
SXFRCTL0 = 0x88
Oct 26 16:19:24 spicymeatball kernel: SSTAT0 = 0x7, SSTAT1 = 0x1
Oct 26 16:19:24 spicymeatball kernel: SCSIPHASE = 0x10
Oct 26 16:19:24 spicymeatball kernel: STACK == 0x0, 0x0, 0x175, 0x34
Oct 26 16:19:24 spicymeatball kernel: SCB count = 4
Oct 26 16:19:24 spicymeatball kernel: Kernel NEXTQSCB = 2
Oct 26 16:19:24 spicymeatball kernel: Card NEXTQSCB = 0
Oct 26 16:19:24 spicymeatball kernel: QINFIFO entries:
Oct 26 16:19:24 spicymeatball kernel: Waiting Queue entries:
Oct 26 16:19:24 spicymeatball kernel: Disconnected Queue entries:
Oct 26 16:19:24 spicymeatball kernel: QOUTFIFO entries:
Oct 26 16:19:24 spicymeatball kernel: Sequencer Free SCB List: 1 2 3 4 5
6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31
Oct 26 16:19:24 spicymeatball kernel: Sequencer SCB Info: 0(c 0x40, s
0x67, l 0, t 0x3) 1(c 0x0, s 0xff, l 255, t 0xff) 2(c 0x0, s 0xff, l
255, t 0xff) 3(c 0x0, s 0xff, l 255, t 0xff) 4(c 0x0, s 0xff, l 255, t
0xff) 5(c 0x0, s 0xff, l 255, t 0xff) 6(c 0x0, s 0xff, l 255, t 0xff)
7(c 0x0, s 0xff, l 255, t 0xff) 8(c 0x0, s 0xff, l 255, t 0xff) 9(c 0x0,
s 0xff, l 255, t 0xff) 10(c 0x0, s 0xff, l 255, t 0xff) 11(c 0x0, s
0xff, l 255, t 0xff) 12(c 0x0, s 0xff, l 255, t 0xff) 13(c 0x0, s 0xff,
l 255, t 0xff) 14(c 0x0, s 0xff, l 255, t 0xff) 15(c 0x0, s 0xff, l 255,
t 0xff) 16(c 0x0, s 0xff, l 255, t 0xff) 17(c 0x0, s 0xff, l 255, t
0xff) 18(c 0x0, s 0xff, l 255, t 0xff) 19(c 0x0, s 0xff, l 255, t 0xff)
20(c 0x0, s 0xff, l 255, t 0xff) 21(c 0x0, s 0xff, l 255, t 0xff) 22(c
0x0, s 0xff, l 255, t 0xff) 23(c 0x0, s 0xff, l 255, t 0xff) 24(c 0x0, s
0xff, l 255, t 0xff) 25(c 0x0, s 0xff, l 255, t 0xff) 26(c 0x0, s 0xff,
l 255, t 0xff) 27(c 0x0, s 0xff, l 255, t 0xff) 28(c 0x0, s 0xff, l 255,
t 0xff) 29(c 0x0, s 0xff, l 255, t 0xf
Oct 26 16:19:24 spicymeatball kernel: ) 30(c 0x0, s 0xff, l 255, t 0xff)
31(c 0x0, s 0xff, l 255, t 0xff)
Oct 26 16:19:24 spicymeatball kernel: Pending list: 3(c 0x40, s 0x67, l 0)
Oct 26 16:19:24 spicymeatball kernel: Kernel Free SCB list: 1 0
Oct 26 16:19:24 spicymeatball kernel: Untagged Q(6): 3
Oct 26 16:19:24 spicymeatball kernel: DevQ(0:6:0): 0 waiting
Oct 26 16:19:24 spicymeatball kernel: scsi0:0:6:0: Device is active,
asserting ATN
Oct 26 16:19:24 spicymeatball kernel: Recovery code sleeping
Oct 26 16:19:24 spicymeatball kernel: Recovery code awake
Oct 26 16:19:24 spicymeatball kernel: Timer Expired
Oct 26 16:19:24 spicymeatball kernel: aic7xxx_abort returns 0x2003
Oct 26 16:19:24 spicymeatball kernel: scsi0:0:6:0: Attempting to queue a
TARGET RESET message
Oct 26 16:19:24 spicymeatball kernel: aic7xxx_dev_reset returns 0x2003
Oct 26 16:19:24 spicymeatball kernel: Recovery SCB completes
Oct 26 16:19:24 spicymeatball kernel: scsi0:0:6:0: Attempting to queue
an ABORT message
Oct 26 16:19:24 spicymeatball kernel: scsi0: Dumping Card State in
Command phase, at SEQADDR 0x36
Oct 26 16:19:24 spicymeatball kernel: ACCUM = 0x80, SINDEX = 0xa0,
DINDEX = 0xe4, ARG_2 = 0x0
Oct 26 16:19:24 spicymeatball kernel: HCNT = 0x0 SCBPTR = 0x0
Oct 26 16:19:24 spicymeatball kernel: SCSISEQ = 0x12, SBLKCTL = 0xa
Oct 26 16:19:24 spicymeatball kernel:  DFCNTRL = 0x4, DFSTATUS = 0x88
Oct 26 16:19:24 spicymeatball kernel: LASTPHASE = 0x80, SCSISIGI = 0x86,
SXFRCTL0 = 0x88
Oct 26 16:19:24 spicymeatball kernel: SSTAT0 = 0x7, SSTAT1 = 0x1
Oct 26 16:19:24 spicymeatball kernel: SCSIPHASE = 0x10
Oct 26 16:19:24 spicymeatball kernel: STACK == 0x0, 0x0, 0x175, 0x34
Oct 26 16:19:24 spicymeatball kernel: SCB count = 4
Oct 26 16:19:24 spicymeatball kernel: Kernel NEXTQSCB = 3
Oct 26 16:19:24 spicymeatball kernel: Card NEXTQSCB = 0
Oct 26 16:19:24 spicymeatball kernel: QINFIFO entries:
Oct 26 16:19:24 spicymeatball kernel: Waiting Queue entries:
Oct 26 16:19:24 spicymeatball kernel: Disconnected Queue entries:
Oct 26 16:19:24 spicymeatball kernel: QOUTFIFO entries:
...
this continues for quite a few cycles until:
Oct 26 16:19:25 spicymeatball kernel: scsi: device set offline - not
ready or command retry failed after bus reset: host 0 channel 0 id 8 lun 0
And the system finally boots (without the second card available of
course).  As I said earlier, using a 2940UW as the second card works, I
also tested with a sym53c8xx (2nd driver revision) without troubles.
but is unacceptable for this setup. A 64-bit PCI LSI logic ultra160 card with 
two channels also fails with the tape attached (on PPC)
Any ideas here?  I'm baffled.
Please cc me any replies, as I don't subscribe to the list.
thanks,

Ethan Weinstein


