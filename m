Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261934AbVF0WEi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261934AbVF0WEi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 18:04:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261905AbVF0WEW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 18:04:22 -0400
Received: from zproxy.gmail.com ([64.233.162.198]:60710 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261921AbVF0WDj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 18:03:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JIjUP9XttaVljOIfn0YVWJe5M5IDY8BPSFH4VZkPvT1UtFzAfUUan+IAtn85+OS/H2FB8ZV/fhl4wXCP4TMf4BSvsV5d6VSijRH2Q3Dc35UzbZJY6qAJM8S+Tt9DZycsrpT/ktUfwPSWVSJoAPbMIyNO3LrTV5n+Bn0N842yz6k=
Message-ID: <4789af9e0506271503bc7a52f@mail.gmail.com>
Date: Mon, 27 Jun 2005 16:03:35 -0600
From: Jim Ramsay <jim.ramsay@gmail.com>
Reply-To: Jim Ramsay <jim.ramsay@gmail.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: USB ohci vs ehci
In-Reply-To: <4789af9e05062714493e18fe0b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4789af9e05062714493e18fe0b@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have an NEC-based 'UP215-N101' USB 2.0 PCI card which can apparently
appear as a device under ohci-hcd or ehci-hcd, depending on which one
is loaded.  If both modules are loaded, the device doesn't seem to
work, as it is detected by both

I would just load the ehci-hcd device, except that the on-board USB is
only detected by ohci-hcd.

Is there some way to make ohci-hcd ignore a specific PCI device or
devices?  Or is there a way ehci-hcd can tell ohci-hcd to 'forget'
about a particular device if it exists in ehci-hcd as well?

Output of `dmesg` after loading ohci-hcd.  The card in question is at
pci 0000:00:10

ohci_hcd 0000:00:01.3: PCI device 1283:1234 (Integrated Technology Express, Inc.
)
ohci_hcd 0000:00:01.3: irq 35, pci mem 0xd020000
ohci_hcd 0000:00:01.3: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ohci_hcd 0000:00:10.0: NEC Corporation USB
ohci_hcd 0000:00:10.0: irq 40, pci mem 0xd021000
ohci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 3 ports detected
ohci_hcd 0000:00:10.1: NEC Corporation USB (#2)
ohci_hcd 0000:00:10.1: irq 40, pci mem 0xd022000
ohci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected

Output of `dmesg` after loading ehci-hcd:

ehci_hcd 0000:00:10.2: NEC Corporation USB 2.0
ehci_hcd 0000:00:10.2: irq 40, pci mem 0xd024000
ehci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 4
ehci_hcd 0000:00:10.2: park 0
ehci_hcd 0000:00:10.2: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 5 ports detected

Output of `lspci -vv -s 10`:

00:10.0 Class 0c03: 1033:0035 (rev 43) (prog-if 10)
        Subsystem: 3083:0035
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Step
ping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort
- <MAbort- >SERR- <PERR-
        Latency: 252 (250ns min, 10500ns max), cache line size 08
        Interrupt: pin A routed to IRQ 40
        Region 0: Memory at 0d021000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot
+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.1 Class 0c03: 1033:0035 (rev 43) (prog-if 10)
        Subsystem: 3083:0035
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Step
ping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort
- <MAbort- >SERR- <PERR-
        Latency: 252 (250ns min, 10500ns max), cache line size 08
        Interrupt: pin B routed to IRQ 40
        Region 0: Memory at 0d022000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot
+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.2 Class 0c03: 1033:00e0 (rev 04) (prog-if 20)
        Subsystem: 3083:00e0
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Step
ping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort
- <MAbort- >SERR- <PERR-
        Latency: 252 (4000ns min, 8500ns max), cache line size 08
        Interrupt: pin C routed to IRQ 40
        Region 0: Memory at 0d024000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot
+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

-- 
Jim Ramsay
"Me fail English?  That's unpossible!"
