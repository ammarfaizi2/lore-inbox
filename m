Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290797AbSDQPcF>; Wed, 17 Apr 2002 11:32:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290818AbSDQPcE>; Wed, 17 Apr 2002 11:32:04 -0400
Received: from glade.nmd.msu.ru ([193.232.112.67]:37135 "HELO glade.nmd.msu.ru")
	by vger.kernel.org with SMTP id <S290797AbSDQPcD>;
	Wed, 17 Apr 2002 11:32:03 -0400
Date: Wed, 17 Apr 2002 19:31:57 +0400
From: Andrey Slepuhin <pooh@msu.ru>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: aic7xxx driver v6.2.5 freezes the kernel
Message-ID: <20020417153157.GH7342@glade.nmd.msu.ru>
In-Reply-To: <20020417111515.GE7342@glade.nmd.msu.ru> <200204171454.g3HEsB904317@aslan.scsiguy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2002 at 08:54:11AM -0600, Justin T. Gibbs wrote:
> >All other changes were successfully merged without any problems.
> >BTW, version 6.2.6 of the driver from 2.4.19-pre7 freezes the system too.
> 
> What motherboard is this again?

P3TDER with dual channel U160 aic7899 controller onboard:

00:05.0 SCSI storage controller: Adaptec 7899P (rev 01)
        Subsystem: Unknown device 9d15:0001
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 40 min, 25 max, 64 set, cache line size 04
        Interrupt: pin A routed to IRQ 26
        BIST result: 00
        Region 0: I/O ports at d000 [disabled] [size=256]
        Region 1: Memory at feafc000 (64-bit, non-prefetchable) [size=4K]
        Expansion ROM at feaa0000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- AuxPwr- DSI- D1- D2- PME-
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:05.1 SCSI storage controller: Adaptec 7899P (rev 01)
        Subsystem: Unknown device 9d15:0001
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 40 min, 25 max, 64 set, cache line size 04
        Interrupt: pin B routed to IRQ 27
        BIST result: 00
        Region 0: I/O ports at d800 [disabled] [size=256]
        Region 1: Memory at feaff000 (64-bit, non-prefetchable) [size=4K]
        Expansion ROM at feac0000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- AuxPwr- DSI- D1- D2- PME-
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-



>  Perhaps your PCI bus is running just
> a hair bit faster than 66MHz?

I doubt it. 

>  A similar issue was discovered with the
> U320 controllers running at 133MHz PCI-X where some amount of delay is
> required prior to accessing chip registers again after setting
> CHIPRST.
> 
> The code was flipped so that the delay was acurate.  In PCI, you
> are only guaranteed that the write has been flushed all the way to the
> device by performing a read to that device.  I guess we'll just have to
> hope that our write transaction isn't stalled.
> 
> I'll make a 6.2.7 <sigh> drop later today.

Ok, I'll test it.

Andrey.

-- 
A right thing should be simple (tm)
