Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129808AbRBYV5M>; Sun, 25 Feb 2001 16:57:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129809AbRBYV5B>; Sun, 25 Feb 2001 16:57:01 -0500
Received: from [216.184.166.130] ([216.184.166.130]:55410 "EHLO
	scsoftware.sc-software.com") by vger.kernel.org with ESMTP
	id <S129808AbRBYV4q>; Sun, 25 Feb 2001 16:56:46 -0500
Date: Sun, 25 Feb 2001 13:53:51 +0000 (   )
From: John Heil <kerndev@sc-software.com>
To: A E Lawrence <adrian.lawrence@computing-services.oxford.ac.uk>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, ian@wehrman.com, mhaque@haque.net,
        adilger@turbolinux.com, linux-kernel@vger.kernel.org
Subject: Re: EXT2-fs error
In-Reply-To: <3A99708A.679079C7@computing-services.oxford.ac.uk>
Message-ID: <Pine.LNX.3.95.1010225130723.28631C-100000@scsoftware.sc-software.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Feb 2001, A E Lawrence wrote:
> A E Lawrence wrote:
> > 
> > A E Lawrence wrote:
> > >
> > > Alan Cox wrote:
> > > >
> > > > > I have seen similar problems on stock 2.4.2 a machine which has not run
> > > > > 2.4.1.
> > > >
> > > > What disk controllers ? We really need that sort of info in order to see the
> > > > pattern in the odd reports of corruption we get
> > 
> > Problems have just started to show up under 2.2.18, so it is likely that
> > the hardware has become flakey. Bit of a coincidence, unless it is a
> > side effect of upgrading one of the packages for 2.4.2 :-( or a damaged
> > library.
> > 
> > So you had better discount this report. Apologies.
> 
> Now investigated: the hardware has not changed. Rather the corruption
> under 2.2.18 only happens when hdparm -d1 is executed. I guess that is
> well reported, but I had forgotten if I ever knew :-(
> 
> In contrast 2.4.2 corruptions happen whether dma is explicitly turned on
> by hdparm or not.
> 
> [IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 10)]
> 

The corruption I got seemed to be non-chipset related.

The 2.4.1 corruption I experienced spanned 2.2.14 (RH 6.2)... 

The 2.4.1 IDE support was in an ALI 1535 south bridge in a Crusoe based
embedded system...  

00:0f.0 IDE interface: Acer Laboratories Inc. [ALi] M5229 IDE (rev c3)
(prog-if b4)
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 1000ns max)
	Interrupt: pin A routed to IRQ 0
	Region 0: I/O ports at 01f0 [size=16]
	Region 1: I/O ports at 03f4
	Region 2: I/O ports at 0170 [size=8]
	Region 3: I/O ports at 0374
	Region 4: I/O ports at 1400 [size=16]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

Disk was...

/dev/hdb:

 Model=HITACHI_DK23AA-60, FwRev=00XEA0A0, SerialNo=F77166
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=12416/15/63, TrkSize=36477, SectSize=579, ECCbytes=4
 BuffType=3(DualPortCache), BuffSize=512kB, MaxMultSect=16, MultSect=off
 DblWordIO=no, OldPIO=2, DMA=yes, OldDMA=2
 CurCHS=12416/15/63, CurSects=142606515, LBA=yes, LBAsects=11733120
 tDMA={min:120,rec:120}, DMA modes: sword0 sword1 sword2 mword0 mword1
mword2 
 IORDY=yes, tPIO={min:400,w/IORDY:120}, PIO modes: mode3 mode4 
 UDMA modes: mode0 mode1 *mode2 mode3 mode4 


When the above system couldn't adequately repair itself,
I fsck'd it on the following....

2.2.14-5.0 RH 6.2 desktop PII w PIIX4 IDE...
 
00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01)
(prog-if 80 [Master])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 set
	Region 4: I/O ports at 1460

Initially, the  2.2.14  RH 6.2 had e2fsprogs 1.18, but I ugraded it to 
e2fsck 1.19,  thinking that might be the problem but it did _not_ help.

The 2 systems, both with e2fsck 1.19, would do fsck repairs 
after the other had touched it. It seemed impossible to keep it 
error free.  

This cross-system disk transfering was error free in 2.4.0-test10-pre3. 

2.4.1-final was the first post 2.4.0-final kernel after t10p3, that
saw any significant activity.

I've since upgraded the RH to 2.2.18 and the embedded to -ac19.

So far, no more problems but I still haven't used the ac19's disk  
on 2.2.18 very much yet but it will have to happen soon... 
I am a bit gun-shy of it still.

I didn't/don't have much time to spend on this and I'm hoping ac19
is bug free is this regard... but I'm interested in how this 
turns out.  

My guess was that I may have hit the bug Russel King fixed for his ARM
system.  IRC, that fix hit the -ac tree from Linus's 2.4.2-pre2. 


-----------------------------------------------------------------
John Heil
South Coast Software
Custom systems software for UNIX and IBM MVS mainframes
1-714-774-6952
johnhscs@sc-software.com
http://www.sc-software.com
-----------------------------------------------------------------

