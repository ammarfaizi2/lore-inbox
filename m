Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262467AbVC3Wry@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262467AbVC3Wry (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 17:47:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262470AbVC3Wry
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 17:47:54 -0500
Received: from sccrmhc11.comcast.net ([204.127.202.55]:22661 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S262467AbVC3Wrs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 17:47:48 -0500
From: Ron Gage <ron@rongage.org>
To: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: Continuing woes - Yenta PCMCIA and USB 2.0 Cardbus Card
Date: Wed, 30 Mar 2005 17:42:45 -0500
User-Agent: KMail/1.6.1
Cc: linux-kernel@vger.kernel.org, daniel.ritz@gmx.ch, jonas.oreland@mysql.com
References: <200503291906.19890.ron@rongage.org> <aec7e5c30503300202446ac0e1@mail.gmail.com>
In-Reply-To: <aec7e5c30503300202446ac0e1@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200503301742.45509.ron@rongage.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 30 March 2005 05:02, Magnus Damm wrote:
> I recently realized that there are no firewire pccards on the market
> today that can power my firewire-powered cd-burner without using an
> external ac adapter. My Apple G4 Mac can power the darn thing over
> firewire though. Maybe the same thing goes for USB2 host controllers
> on pccard? Maybe you need an external ac adapter?

Ok, I have eliminated power as a possibility by routing the secondary USB 
connector for the drive to a powered USB hub.  No difference, the drive still 
spins up, and the system still can not read the partition table (the drive is 
known to have a good EXT3 partition on it).

Here are the specifics on the USB card I am using from dmesg:

PCI: Enabling device 0000:06:00.0 (0000 -> 0002)
ohci_hcd 0000:06:00.0: ALi Corporation USB 1.1 Controller (#2)
ohci_hcd 0000:06:00.0: irq 11, pci mem e0858000
ohci_hcd 0000:06:00.0: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
PCI: Enabling device 0000:06:00.3 (0000 -> 0002)
ehci_hcd 0000:06:00.3: ALi Corporation USB 2.0 Controller (#2)
ehci_hcd 0000:06:00.3: irq 11, pci mem e087e000
ehci_hcd 0000:06:00.3: new USB bus registered, assigned bus number 3
ehci_hcd 0000:06:00.3: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 6 ports detected

The output from lspci -vv:

06:00.0 USB Controller: ALi Corporation USB 1.1 Controller (rev 03) (prog-if 
10 [OHCI])
        Subsystem: ALi Corporation USB 1.1 Controller
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 16 (20000ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at 21000000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1+,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

06:00.3 USB Controller: ALi Corporation USB 2.0 Controller (rev 01) (prog-if 
20 [EHCI])
        Subsystem: ALi Corporation USB 2.0 Controller
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (20000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at 21001000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [58] #0a [2090]



And of course, here is the dmesg output showing the drive not being read:

usb 3-1: new high speed USB device using address 2
scsi1 : SCSI emulation for USB Mass Storage devices
  Vendor: IC25N040  Model: ATCX04-0          Rev: CA4O
  Type:   Direct-Access                      ANSI SCSI revision: 02
SCSI device sda: 78140160 512-byte hdwr sectors (40008 MB)
sda: assuming drive cache: write through
 sda:SCSI error : <1 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 0
Buffer I/O error on device sda, logical block 0
SCSI error : <1 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 0
Buffer I/O error on device sda, logical block 0
 unable to read partition table
Attached scsi disk sda at scsi1, channel 0, id 0, lun 0
USB Mass Storage device found at 2



HELP!!!!!




-- 
Ron Gage - Pontiac, Michigan
(MCP, LPIC1, A+, Net+)
