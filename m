Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292610AbSBPX0T>; Sat, 16 Feb 2002 18:26:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292611AbSBPX0J>; Sat, 16 Feb 2002 18:26:09 -0500
Received: from jive.SoftHome.net ([66.54.152.27]:12166 "EHLO softhome.net")
	by vger.kernel.org with ESMTP id <S292610AbSBPXZu>;
	Sat, 16 Feb 2002 18:25:50 -0500
From: Raphael Derosso Pereira - DephiNit <dephinit@softhome.net>
To: linux-kernel@vger.kernel.org
Subject: Changing PCI board's IRQ
Date: Sat, 16 Feb 2002 21:25:27 -0200
X-Mailer: KMail [version 1.3.2]
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Message-Id: <E16cECu-0000Lh-00@mushroom>
X-Mime-Autoconverted: from 8bit to 7bit by courier 0.36.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

One computer that I administer have a IRQ conflict between a sound card and a 
ethernet card. Both share the IRQ 11.
I don't have physical access to the computer, so I tried to change the IRQ 
using the 'setpci' command.

# setpci -v -s 0:7.5 INTERRUPT_LINE=08
00:07.5:3c 08
#

But, after that, when I did a 

# lspci -vv -s 0:7.5
00:07.5 Multimedia audio controller: VIA Technologies, Inc. AC97 Audio 
Controller (rev 50)
        Subsystem: Biostar Microtech Int'l Corp: Unknown device 0032
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin C routed to IRQ 11
        Region 0: I/O ports at dc00 [size=256]
        Region 1: I/O ports at e000 [size=4]
        Region 2: I/O ports at e400 [size=4]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-


After some experience (like rebooting... arg!) i tried:

# lspci -vv -H1 -s 0:7.5
<cut>
        Interrupt: pin C routed to IRQ 8
        Region 0: I/O ports at dc00
<cut>

So, it seems that either I cannot change the Interrupt line number throught 
software (and the -H1 is tricky) or the /proc/pci (and /proc/bus/pci) is not 
getting updated.

Is that a problem or am I missing the point?

P.S.: Please Reply direct to me (or send me a copy) because I can not 
"afford" the traffic of linux-kernel. :)

-- 
 Raphael Derosso Pereira - DephiNit

     *-=-*-=--=-*-=-*-=--=*=-*
    / dephinit@softhome.net /
   *-=-*-=--=-*-=-*-=--=*=-*

 -=*=--=*=--=*=--=*=--=*=--=*=--=*=-
|  Debian GNU/Linux Addicted User   |
|  Use it, Abuse it. It's Free!!!   |
 -=*=--=*=--=*=--=*=--=*=--=*=--=*=-
