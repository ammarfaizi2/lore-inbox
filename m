Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289737AbSAOXN5>; Tue, 15 Jan 2002 18:13:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289735AbSAOXNs>; Tue, 15 Jan 2002 18:13:48 -0500
Received: from 203-79-66-98.adsl-wns.paradise.net.nz ([203.79.66.98]:45698
	"HELO volcano.kiwa.co.nz") by vger.kernel.org with SMTP
	id <S289724AbSAOXNg>; Tue, 15 Jan 2002 18:13:36 -0500
Date: Wed, 16 Jan 2002 12:13:33 +1300
From: Nicholas Lee <nj.lee@plumtree.co.nz>
To: Ed Sweetman <ed.sweetman@wmich.edu>
Cc: Ville Herva <vherva@niksula.hut.fi>, linux-kernel@vger.kernel.org
Subject: Re: Disk corruption - Abit KT7, 2.2.19+ide patches
Message-ID: <20020115231333.GI598@inktiger.kiwa.co.nz>
Mail-Followup-To: Nicholas Lee <nj.lee@plumtree.co.nz>,
	Ed Sweetman <ed.sweetman@wmich.edu>,
	Ville Herva <vherva@niksula.hut.fi>, linux-kernel@vger.kernel.org
In-Reply-To: <20020115202302.GA598@inktiger.kiwa.co.nz> <20020115205116.GH51648@niksula.cs.hut.fi> <20020115211032.GC598@inktiger.kiwa.co.nz> <20020115214049.GI51648@niksula.cs.hut.fi> <20020115220211.GE598@inktiger.kiwa.co.nz> <000f01c19e18$469a3700$0501a8c0@psuedogod>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000f01c19e18$469a3700$0501a8c0@psuedogod>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2002 at 05:59:19PM -0500, Ed Sweetman wrote:

> sounds like you're using the shared irq slot, might want to verify that with
> lspci -vvv to see if anything else is using an irq at the time that's the
> same as the card in that slot.  Also some places will do various special
> things to one of the last pci slots, you should be able to find out by
> looking in the manual.  Some cards just dont play nicely with shared irqs.

Nope:

nic@hoppa:~$ sudo lspci -vvv  | grep IRQ
	Interrupt: pin D routed to IRQ 10
	Interrupt: pin D routed to IRQ 10
	Interrupt: pin A routed to IRQ 11

IRQ 10 is USB
IRQ 11 is the NIC

00:0d.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RT8139 (rev 10)
        Subsystem: Realtek Semiconductor Co., Ltd. RT8139
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 min, 64 max, 32 set
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at ec00
        Region 1: Memory at e6800000 (32-bit, non-prefetchable)


nic@hoppa:~$ dmesg | grep -i irq
VP_IDE: not 100% native mode: will probe irqs later
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
eth0: RealTek RTL8139 Fast Ethernet at 0xec00, IRQ 11, 00:50:bf:04:61:e1.

IDE channel on IRQ 14.


> Then there's always the locality to some other device in the case possibly
> causing your problem.   many reasons could cause the problem you're
> describing.   I'm not really sure how this is a linux problem though since
> you mention it's occuring only in a certain physical slot.

I'm not sure about the 'certain' slot. I'll have to test that myself.

-- 
Nicholas Lee - nj.lee at plumtree.co dot nz, somewhere on the fish Maui caught.
gpg. 8072 4F86 EDCD 4FC1 18EF  5BDD 07B0 9597 6D58 D70C            icq. 1612865 

                         Quixotic Eccentricity
