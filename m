Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290593AbSC0Vl2>; Wed, 27 Mar 2002 16:41:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291102AbSC0VlT>; Wed, 27 Mar 2002 16:41:19 -0500
Received: from harddata.com ([216.123.194.198]:19716 "EHLO mail.harddata.com")
	by vger.kernel.org with ESMTP id <S290593AbSC0VlG>;
	Wed, 27 Mar 2002 16:41:06 -0500
Date: Wed, 27 Mar 2002 14:40:56 -0700
From: Michal Jaegermann <michal@harddata.com>
To: linux-kernel@vger.kernel.org
Subject: more eepro100 + 2.2.18 + laptop problems
Message-ID: <20020327144056.A9939@mail.harddata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the second decade of February there was a thread, started by
posting by CaT <cat@zip.com.au> with a subject "eepro100 + 2.2.18 +
laptop problems" which pretty well explains what it was about. :-)

Andrey Savochkin replied with a patch which added a few delays
and which apparently took care about that case.  Just as an extra
data point I have now here another laptop for which dmi dump starts
like that:

Handle 0x0000
	DMI type 0, 19 bytes.
	BIOS Information Block
		Vendor: ACER
		Version: V3.3 R01-A2j  EN                        
		Release: 08/10/2001
		BIOS base: 0xF0000
		ROM size: 448K
		Capabilities:
			Flags: 0x000000007F399F90
Handle 0x0100
	DMI type 1, 25 bytes.
	System Information Block
		Vendor: Acer            
		Product: TravelMate 740  
		Version: -1

and which has built-in ethernet card with a PCI id '8086:1031' for
which 'lspci -vv' has this to say:

02:08.0 Ethernet controller: Intel Corporation: Unknown device 1031 (rev 41)
	Subsystem: Acer Incorporated [ALI]: Unknown device 1017
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 66 (2000ns min, 14000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at 80100000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at 7000 [size=64]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable+ DSel=0 DScale=2 PME-

but this is some variant of eepro100. :-)

I tried this card with a driver from "kernel-2.4.18-0.4".  This is
latest "public beta" kernel from Red Hat and eepro100 driver there
incorporates the whole patch in question with an exception (for some
reasons other than forgetfulness?) of one "inl(ioaddr + SCBPort);" in
speedo_tx_timeout() function right after
"outl(PortReset, ioaddr + SCBPort);"

Although this version is quite an improvement over earlier ones which
were plain unusuable it is still quite easy to lock a network by doing
simply ssh to the laptop and doing "normal things" for a while.  OTOH
I did copies over NFS of directories with a size of a gig and a half
and that was ok.  Once a network is gone only 'ifup eth0; ifdown eth0'
seems to be a way to wake it up again.

With 'e100' driver compiled from Intel sources this card "just works".
The only possible clue I see is "Sleep mode is enabled.  This is not
recommended." line from 'eepro100-diag -ee ....' but this shows up
with both drivers and 'e100' does not seem to mind.

  Michal
