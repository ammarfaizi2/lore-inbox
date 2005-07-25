Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261416AbVGYSGV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261416AbVGYSGV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 14:06:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261417AbVGYSGV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 14:06:21 -0400
Received: from totor.bouissou.net ([82.67.27.165]:52099 "EHLO
	totor.bouissou.net") by vger.kernel.org with ESMTP id S261416AbVGYSGU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 14:06:20 -0400
From: Michel Bouissou <michel@bouissou.net>
Organization: Me, Myself and I
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: VIA KT400 + Kernel 2.6.12 + IO-APIC + uhci_hcd = IRQ trouble
Date: Mon, 25 Jul 2005 20:06:16 +0200
User-Agent: KMail/1.7.2
Cc: bjorn.helgaas@hp.com,
       "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44L0.0507171606320.30920-100000@netrider.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0507171606320.30920-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200507252006.17330@totor.bouissou.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le Dimanche 17 Juillet 2005 22:36, Alan Stern a écrit :
>
> To start out, try to determine whether each of the UHCI controllers really
> is mapped to IRQ 21.

I performed the tests you described, and here are the results I got.

First an exact description of my USB hardware.

My Gigabyte GA7-VAXP motherboard has 6 USB connectors.

- 2 integrated within the MB connectors plate (close to the PS/2 kbd/mouse 
connectors). Those have no cables and aren't prone to cable problems...

- 2 on a supplementary plate on the back. The plate and cables were provided 
with the MB.

- 2 on the front of my (good quality) Antec case, connectors and cables 
provided with the Antec case.

- The connectors on the supplementary plate and those on the case are 
connected to corresponding connectors on the motherboard.

All these connectors used to work perfectly in kernel 2.4, and I choose them 
only for ergonomic/position reasons, usually:

1/ The mouse (low-speed) connected to one of the MB integrated connectors

2/ The scanner (full-speed) connected to the supplementary plate on the back

3/ Removable devices (Camera, Flashdisks, full-speed or high-speed) usually 
connected to the case front-panel connectors.


Regarding USB, the output of "lspci -vv" says :

00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller (rev 80) (prog-if 00 [UHCI])
        Subsystem: Giga-byte Technology GA-7VAX Mainboard
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin A routed to IRQ 10
        Region 4: I/O ports at cc00 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME+

00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller (rev 80) (prog-if 00 [UHCI])
        Subsystem: Giga-byte Technology GA-7VAX Mainboard
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin B routed to IRQ 10
        Region 4: I/O ports at d000 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME+

00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller (rev 80) (prog-if 00 [UHCI])
        Subsystem: Giga-byte Technology GA-7VAX Mainboard
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin C routed to IRQ 10
        Region 4: I/O ports at d400 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME+

00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82) (prog-if 20 
[EHCI])
        Subsystem: Giga-byte Technology GA-7VAX Mainboard
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 10
        Interrupt: pin D routed to IRQ 11
        Region 0: Memory at e3009000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-


> Do this by booting with no USB devices plugged in, 
> and then plugging a full- or low-speed device (like a USB mouse) into each
> of the ports in turn.  Check to make sure it works in each port and that
> that counts for IRQ 21 in /proc/interrupts increase each time.  To make
> this even more reliable you should run the test twice -- you don't have to
> reboot in between.  The first time, rmmod ehci-hcd before plugging in
> anything; the second time modprobe ehci-hcd before plugging.

I've booted without any USB devices and did the following:

1/ rmmod ehci-hcd

2/ Plugged the mouse in each and every USB connector I have, in turn. The 
mouse was working good on each of them. IRQ 21 showed nicely incrementing 
each time I plugged / unplugged or moved the plugged mouse. System was happy 
and didn't log anything abnormal.

3/ Unplugged the mouse

4/ modprobe ehci-hcd

5/ Plugged the mouse. Immediately got "IRQ21: Nobody cared" and "Disabling IRQ 
21" messages.
=> Noticed IRQ21 count has suddenly been set to exactly 200000
After this, the mouse was now behaving slowly and erratically (USB polled 
without interrupts ?)

6/ Unplugged the mouse, then:
- rmmod ehci-hcd
- rmmod uhci-hcd
- modprobe ehci-hcd

7/ Plugged the mouse back. It was working happily again.

8/ Keeping the mouse plugged:
- modprobe ehci-hcd
=> Immediately got the IRQ21 insults again.
=> Noticed IRQ21 count has suddenly been set to exactly 400000
Mouse behaviour was slow and erratical again.

Repeated steps 6-8 using another USB socket, with the exact same results.

What do you think about this ?

Thanks again for your help.

Cheers.

-- 
Michel Bouissou <michel@bouissou.net> OpenPGP ID 0xDDE8AC6E
