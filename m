Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750989AbWIDNwA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750989AbWIDNwA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 09:52:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750873AbWIDNwA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 09:52:00 -0400
Received: from imf19aec.mail.bellsouth.net ([205.152.59.67]:40547 "EHLO
	imf19aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S1750985AbWIDNv6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 09:51:58 -0400
Message-ID: <44FC2F7C.6040301@bellsouth.net>
Date: Mon, 04 Sep 2006 08:51:56 -0500
From: Jay Cliburn <jacliburn@bellsouth.net>
User-Agent: Thunderbird 1.5.0.5 (X11/20060803)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.18-rc5-mm1 unusual IRQ number for VIA device
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Running 2.6.18-rc5.mm1 on an Asus M2V mainboard with dual-core Athlon 
cpu, the onboard audio device gets assigned and IRQ of 8410.  Under 
2.6.18-rc4-mm3, the same device gets assigned IRQ 17.  Is this a way to 
get around this?

/proc/interrupts:
            CPU0       CPU1
   0:     525177          0   IO-APIC-edge     timer
   1:       3016          0   IO-APIC-edge     i8042
   6:          5          0   IO-APIC-edge     floppy
   7:          0          0   IO-APIC-edge     parport0
   8:          0          0   IO-APIC-edge     rtc
   9:          0          0   IO-APIC-fasteoi  acpi
  12:          4          0   IO-APIC-edge     i8042
  14:      18433          0   IO-APIC-edge     ide0
  20:      16017          0   IO-APIC-fasteoi  uhci_hcd:usb1
  21:      66080          0   IO-APIC-fasteoi  uhci_hcd:usb3, 
ehci_hcd:usb5, libata
  22:          0          0   IO-APIC-fasteoi  uhci_hcd:usb2
  23:          0          0   IO-APIC-fasteoi  uhci_hcd:usb4
  36:       4600          0   IO-APIC-fasteoi  eth0
8410:        193          0   PCI-MSI-<NULL>  HDA Intel
NMI:        180         91
LOC:     525078     525029
ERR:          0

And here's the lspci output for the audio device:
08:01.0 Audio device: VIA Technologies, Inc. VIA High Definition Audio 
Controller (rev 10)
         Subsystem: ASUSTeK Computer Inc. Unknown device 81e7
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0, Cache Line Size: 64 bytes
         Interrupt: pin A routed to IRQ 8410
         Region 0: Memory at fbffc000 (64-bit, non-prefetchable) [size=16K]
         Capabilities: [50] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
         Capabilities: [60] Message Signalled Interrupts: 64bit+ 
Queue=0/0 Enable+
                 Address: 00000000fee00000  Data: 406a
         Capabilities: [70] Express Unknown type IRQ 0
                 Device: Supported: MaxPayload 128 bytes, PhantFunc 0, 
ExtTag-
                 Device: Latency L0s <64ns, L1 <1us
                 Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
                 Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                 Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
                 Link: Supported Speed unknown, Width x0, ASPM unknown, 
Port 0
                 Link: Latency L0s <64ns, L1 <1us
                 Link: ASPM Disabled CommClk- ExtSynch-
                 Link: Speed unknown, Width x0
         Capabilities: [100] Virtual Channel
00: 06 11 88 32 06 04 10 00 10 00 03 04 10 00 00 00
10: 04 c0 ff fb 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 e7 81
30: 00 00 00 00 50 00 00 00 00 00 00 00 01 01 00 00
40: 00 30 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 01 60 42 c8 00 00 00 00 00 00 00 00 00 00 00 00
60: 05 70 81 00 00 00 e0 fe 00 00 00 00 6a 40 00 00
70: 10 00 91 00 00 00 00 00 00 00 30 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
