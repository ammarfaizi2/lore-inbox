Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291913AbSBTPPE>; Wed, 20 Feb 2002 10:15:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291908AbSBTPO4>; Wed, 20 Feb 2002 10:14:56 -0500
Received: from gw-nl4.philips.com ([212.153.190.6]:16139 "EHLO
	gw-nl4.philips.com") by vger.kernel.org with ESMTP
	id <S291906AbSBTPOn>; Wed, 20 Feb 2002 10:14:43 -0500
From: fabrizio.gennari@philips.com
To: linux-kernel@vger.kernel.org
Cc: rmk@arm.linux.org.uk
Subject: Oxford Semiconductor's OXCB950 UART not recognized by serial.c
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OF89F1C10D.9DA9C831-ONC1256B66.0052BC8A@diamond.philips.com>
Date: Wed, 20 Feb 2002 16:14:03 +0100
X-MIMETrack: Serialize by Router on hbg001soh/H/SERVER/PHILIPS(Release 5.0.5 |September
 22, 2000) at 20/02/2002 16:33:22,
	Serialize complete at 20/02/2002 16:33:22
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We have 32-bit CardBus cards with OXCB950 CardBus (PCI ID 1415:950b) UART 
chips on them (OXCB950 is the CardBus version of 16C950) . The module 
serial_cb in the pcmcia-cs package recognizes them correctly. But, when 
not using serial_cb, the function serial_pci_guess_board in serial.c 
doesn't (kernel 2.4.17 tested). The problem is that the card advertises 3 
i/o memory regions and 2 ports. If one replaces the line

if (num_iomem <= 1 && num_port == 1) {

with

if (num_port >= 1) {

in the function serial_pci_guess_board(), the card is detected and works 
perfectly. Only, when inserting it, the kernel displays the message:

Redundant entry in serial pci_table.  Please send the output of
lspci -vv, this message (1415,950b,1415,0001)
and the manufacturer and name of serial board or modem board
to serial-pci-info@lists.sourceforge.net.  

And this is the output of lspci -vv, only the part relevant to the Oxford 
card:

03:00.0 Serial controller: Oxford Semiconductor Ltd CardBus Device 
(prog-if 06 [16950])
        Subsystem: Oxford Semiconductor Ltd: Unknown device 0001
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at 4800 [size=8]
        Region 1: Memory at 10c00000 (32-bit, non-prefetchable) [size=4K]
        Region 2: I/O ports at 4810 [size=16]
        Region 3: Memory at 10c01000 (32-bit, non-prefetchable) [size=4K]
        Region 4: Memory at 10c02000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [40] Power Management version 1
                Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA 
PME(D0+,D1-,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-


Fabrizio Gennari
Philips Research Monza
via G.Casati 23, 20052 Monza (MI), Italy
tel. +39 039 2037816, fax +39 039 2037800
