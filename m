Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264192AbUFCPAn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264192AbUFCPAn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 11:00:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264266AbUFCO6H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 10:58:07 -0400
Received: from imap.gmx.net ([213.165.64.20]:53126 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264192AbUFCOxl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 10:53:41 -0400
X-Authenticated: #8834078
From: Dominik Karall <dominik.karall@gmx.net>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.7-rc2-mm2
Date: Thu, 3 Jun 2004 17:03:34 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <20040603015356.709813e9.akpm@osdl.org>
In-Reply-To: <20040603015356.709813e9.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406031703.38722.dominik.karall@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 03 June 2004 10:53, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.7-rc2/2.6
>.7-rc2-mm2/

SiS framebuffer works here. But my kernel does not boot, it stops at

Starting hotplug subsystem:
   input
   net
   pci
     sis900: already loaded
     8139too: already loaded
     ignore pci display device on 01:00.0
   usb

and right here it stops.

Normally it looks this way:

Starting hotplug subsystem:
   input
   net
   pci
     sis900: already loaded
     8139too: already loaded
     ignore pci display device on 01:00.0
   usb
done

Here is my lspci -vvv output of the USB controllers:

0000:00:03.0 USB Controller: Silicon Integrated Systems [SiS] USB 1.0 
Controller (rev 0f) (prog-if 10 [OHCI])
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 7010
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (20000ns max), Cache Line Size: 0x08 (32 bytes)
        Interrupt: pin A routed to IRQ 20
        Region 0: Memory at e2420000 (32-bit, non-prefetchable)

0000:00:03.1 USB Controller: Silicon Integrated Systems [SiS] USB 1.0 
Controller (rev 0f) (prog-if 10 [OHCI])
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 7010
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (20000ns max), Cache Line Size: 0x08 (32 bytes)
        Interrupt: pin B routed to IRQ 21
        Region 0: Memory at e2421000 (32-bit, non-prefetchable)

0000:00:03.2 USB Controller: Silicon Integrated Systems [SiS] USB 1.0 
Controller (rev 0f) (prog-if 10 [OHCI])
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 7010
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (20000ns max), Cache Line Size: 0x08 (32 bytes)
        Interrupt: pin C routed to IRQ 22
        Region 0: Memory at e2422000 (32-bit, non-prefetchable)

0000:00:03.3 USB Controller: Silicon Integrated Systems [SiS] USB 2.0 
Controller (prog-if 20 [EHCI])
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 7010
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (20000ns max)
        Interrupt: pin D routed to IRQ 23
        Region 0: Memory at e2423000 (32-bit, non-prefetchable)
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-



By the way, with 2.6.6-mm5 (the last working -mm patch on my machine), I get 
only following PHY messages:

eth0: Realtek RTL8201 PHY transceiver found at address 1.
eth0: Using transceiver found at address 1 as default
eth0: SiS 900 PCI Fast Ethernet at 0xdc00, IRQ 19, 00:10:dc:8f:a9:ac.

with the current 2.6.7-rc2-mm2 patch, I get

eth0: Unknown PHY transceiver found at address 0.
eth0: Realtek RTL8201 PHY transceiver found at address 1.
eth0: Unknown PHY transceiver found at address 2.
eth0: Unknown PHY transceiver found at address 3.
eth0: Unknown PHY transceiver found at address 4.
eth0: Unknown PHY transceiver found at address 5.
eth0: Unknown PHY transceiver found at address 6.
eth0: Unknown PHY transceiver found at address 7.
eth0: Unknown PHY transceiver found at address 8.
eth0: Unknown PHY transceiver found at address 9.
eth0: Unknown PHY transceiver found at address 10.
eth0: Unknown PHY transceiver found at address 11.
eth0: Unknown PHY transceiver found at address 12.
eth0: Unknown PHY transceiver found at address 13.
eth0: Unknown PHY transceiver found at address 14.
eth0: Unknown PHY transceiver found at address 15.
eth0: Unknown PHY transceiver found at address 16.
eth0: Unknown PHY transceiver found at address 17.
eth0: Unknown PHY transceiver found at address 18.
eth0: Unknown PHY transceiver found at address 19.
eth0: Unknown PHY transceiver found at address 20.
eth0: Unknown PHY transceiver found at address 21.
eth0: Unknown PHY transceiver found at address 22.
eth0: Unknown PHY transceiver found at address 23.
eth0: Unknown PHY transceiver found at address 24.
eth0: Unknown PHY transceiver found at address 25.
eth0: Unknown PHY transceiver found at address 26.
eth0: Unknown PHY transceiver found at address 27.
eth0: Unknown PHY transceiver found at address 28.
eth0: Unknown PHY transceiver found at address 29.
eth0: Unknown PHY transceiver found at address 30.
eth0: Unknown PHY transceiver found at address 31.
eth0: Using transceiver found at address 1 as default
eth0: SiS 900 PCI Fast Ethernet at 0xdc00, IRQ 19, 00:10:dc:8f:a9:ac.

It works ok, as the address 1 is used as default, but I just wanted to mention 
that.

greets dominik
