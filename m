Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267306AbRGKNBo>; Wed, 11 Jul 2001 09:01:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267308AbRGKNBe>; Wed, 11 Jul 2001 09:01:34 -0400
Received: from mail.teraport.de ([195.143.8.72]:50304 "EHLO mail.teraport.de")
	by vger.kernel.org with ESMTP id <S267306AbRGKNBW>;
	Wed, 11 Jul 2001 09:01:22 -0400
Message-ID: <3B4C4E19.5586AFAC@TeraPort.de>
Date: Wed, 11 Jul 2001 15:01:13 +0200
From: Martin Knoblauch <Martin.Knoblauch@TeraPort.de>
Organization: TeraPort GmbH
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7-pre6 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
CC: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Patrick Mochel <mochel@transmeta.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        saw@saw.sw.com.sg
Subject: Re: 2.4.6.-ac2: Problems with eepro100
In-Reply-To: <Pine.LNX.4.33.0107111413380.19006-100000@chaos.tp1.ruhr-uni-bochum.de>
X-MIMETrack: Itemize by SMTP Server on lotus/Teraport/de(Release 5.0.7 |March 21, 2001) at
 07/11/2001 03:01:06 PM,
	Serialize by Router on lotus/Teraport/de(Release 5.0.7 |March 21, 2001) at
 07/11/2001 03:01:17 PM,
	Serialize complete at 07/11/2001 03:01:17 PM
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kai Germaschewski wrote:
> 
> On Wed, 11 Jul 2001, Martin Knoblauch wrote:
> 
> > > Do a register dump of working and dead-after-PM-transition, including
> > > PCI config registers, and look for differences.  Also look for
> > > differences in your host and PCI-PCI bridge PCI config registers.
> >
> >  Instructions on how to do the dumps? Sorry, I have not been that deep
> > into these matters until now :-)
> 
> For the PCI things: Do a lspci -vvxxx at the various stages of working /
> not working and diff them. For the chip registers - well, I didn't look
> into this yet, but it'll be a bit harder, I suppose. (Maybe the maintainer
> has some hints?)
> 
> --Kai

 So, I tested  2.4.7pre6 with eepro100 build as a module and the problem
(network broken after ifconfig down/up cycle) persists.

 "lspci -vvxxx" output between the good "D0" state and the bad one is
identical. Output for the D2 state just differs in the "e0:" line, which
seems to be OK.

martink@laplin22:/boot > diff eep-D0-1 eep-D2-4
13c13
<               Status: D0 PME-Enable- DSel=0 DScale=0 PME-
---
>               Status: D2 PME-Enable- DSel=0 DScale=0 PME-
28c28
< e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
---
> e0: 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
martink@laplin22:/boot > more eep-D2-4
02:01.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100]
(rev 05)
        Subsystem: IBM: Unknown device 00d8
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 66 (2000ns min, 14000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at fc000000 (32-bit, prefetchable) [size=4K]
        Region 1: I/O ports at 3000 [size=32]
        Region 2: Memory at dc600000 (32-bit, non-prefetchable)
[size=1M]
        Expansion ROM at <unassigned> [disabled] [size=1M]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D2 PME-Enable- DSel=0 DScale=0 PME-
00: 86 80 29 12 17 00 90 02 05 00 00 02 08 42 00 00
10: 08 00 00 fc 01 30 00 00 00 00 60 dc 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 14 10 d8 00
30: 00 00 00 00 dc 00 00 00 00 00 00 00 0b 01 08 38
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 01 00 31 fe
e0: 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

 I will see that I can make the "eepro-diag" working.

Martin
-- 
------------------------------------------------------------------
Martin Knoblauch         |    email:  Martin.Knoblauch@TeraPort.de
TeraPort GmbH            |    Phone:  +49-89-510857-309
C+ITS                    |    Fax:    +49-89-510857-111
http://www.teraport.de   |    Mobile: +49-170-4904759
