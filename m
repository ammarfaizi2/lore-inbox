Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262991AbTCSNcq>; Wed, 19 Mar 2003 08:32:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262997AbTCSNcq>; Wed, 19 Mar 2003 08:32:46 -0500
Received: from tentacle.s2s.msu.ru ([193.232.119.109]:43714 "EHLO
	tentacle.sectorb.msk.ru") by vger.kernel.org with ESMTP
	id <S262991AbTCSNcp>; Wed, 19 Mar 2003 08:32:45 -0500
Date: Wed, 19 Mar 2003 16:43:41 +0300
From: "Vladimir B. Savkin" <savkin@shade.msu.ru>
To: Martin Josefsson <gandalf@wlug.westbo.se>
Cc: fxzhang@ict.ac.cn, linux-kernel@vger.kernel.org
Subject: Re: eepro100+NAPI failure
Message-ID: <20030319134341.GA26128@tentacle.sectorb.msk.ru>
References: <20030318202728.GA15796@tentacle.sectorb.msk.ru> <1048020884.1521.60.camel@tux.rsn.bth.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <1048020884.1521.60.camel@tux.rsn.bth.se>
User-Agent: Mutt/1.3.28i
X-Organization: Moscow State Univ., Dept. of Mechanics and Mathematics
X-Operating-System: Linux 2.4.21-pre2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 18, 2003 at 09:54:44PM +0100, Martin Josefsson wrote:
> > Can anyone help me to make NAPI work? Does anyone even use NAPI
> > with eepro100, I guess not many people since the patch is pretty old
> > and I could not find it ported to 2.4.21-pre.
> 
> I havn't heard of anyone using it. I've understood that the recieve path
> in the eepro100 chip can be quite fragile and has to be treated right or
> it'll hang... maybe the NAPI patch changes things too much...
> 
> Anyway, please let me know if you manage to get it working

It seems to work with this one:

02:03.0 Ethernet controller: Intel Corp. 82557 [Ethernet Pro 100] (rev
02)
        Subsystem: IBM 82558B Ethernet Pro 10/100
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min, 14000ns max)
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at e0000000 (32-bit, prefetchable) [size=4K]
        Region 1: I/O ports at a400 [size=32]
        Region 2: Memory at df000000 (32-bit, non-prefetchable)
[size=1M]
        Expansion ROM at <unassigned> [disabled] [size=1M]


No problem with more than 10^7 packets
It just drops packets under heavy load, without live-locking, 
so NAPI kinda works :)

Unfortunally, I could not get this NIC to work with oversized frames
to implement 802.1q, both with eepro100 and e100 drivers :(

:wq
                                        With best regards, 
                                           Vladimir Savkin. 

