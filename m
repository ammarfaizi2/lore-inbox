Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264669AbUDVUxn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264669AbUDVUxn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 16:53:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264672AbUDVUxn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 16:53:43 -0400
Received: from acentral.co.uk ([213.232.83.29]:22178 "HELO
	eddie.acentral.co.uk") by vger.kernel.org with SMTP id S264669AbUDVUx2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 16:53:28 -0400
From: Gavin Hamill <gdh@acentral.co.uk>
To: linux-kernel@vger.kernel.org
Subject: 3Com 905C running very slow.
Date: Thu, 22 Apr 2004 21:59:00 +0100
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404222159.00111.gdh@acentral.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hullo...

This is my first post in the Big Playground, so be gentle with me =) I'm 
following up from the thread earlier this month ( 
http://www.uwsg.iu.edu/hypermail/linux/kernel/0404.0/0927.html ) to basically  
say "me too".

I'm using Debian's 2.6.5 kernel-source and I have a 3c905C thusly:

0000:00:09.0: 3Com PCI 3c905C Tornado at 0xe800. Vers LK1.1.19

$ lspci -vvvx
00:09.0 Ethernet controller: 3Com Corporation 3c905C-TX [Fast Etherlink] (rev 
6c)
        Subsystem: 3Com Corporation 3C905C-TX Fast Etherlink for PC Management 
NIC
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR+
        Latency: 32 (2500ns min, 2500ns max), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at e800 [size=128]
        Region 1: Memory at e8000000 (32-bit, non-prefetchable) [size=128]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-
00: b7 10 00 92 07 00 10 82 6c 00 00 02 08 20 00 00
10: 01 e8 00 00 00 00 00 e8 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 b7 10 00 10
30: 00 00 00 00 dc 00 00 00 00 00 00 00 0b 01 0a 0a

This is a recent Gigabyte-brand P3 motherboard using the APIC, and IRQ11 is 
being shared between the 3Com and the onboard Realtek 8139.

(I/O APIC #2 Version 17 at 0xFEC00000.
Enabling APIC mode:  Flat.  Using 1 I/O APICs)

Everything ran at full speed on my previous 2.4.23 (this is my first adventure 
into 2.6), but TX out of the 3Com is running at a maximum of 200kbit/sec... I 
never guessed my WAN connection would ever be faster than my LAN one!

Interestingly, RX on the 3Com is seemingly unaffected - I got 10Mbit on an FTP 
test (I'm guessing the slower-than-usual response is due to the low TX speed 
causing latency on the ACKs)

The other thing I've noticed is the card does not now respond to probing with 
'mii-tool' which it always did previously, so I have no way to get / set the 
half/full duplex settings.

eddie:~# mii-tool  eth0
SIOCGMIIPHY on 'eth0' failed: Operation not supported

Any advice / suggestions warmly welcomed :)

Cheers,
Gavin.

