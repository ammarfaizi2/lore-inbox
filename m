Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281599AbRKMKrh>; Tue, 13 Nov 2001 05:47:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281602AbRKMKr3>; Tue, 13 Nov 2001 05:47:29 -0500
Received: from smtpldntd.tdsec.co.uk ([193.130.51.254]:48292 "HELO
	smtpldntd.tdbank.ca") by vger.kernel.org with SMTP
	id <S281599AbRKMKrX>; Tue, 13 Nov 2001 05:47:23 -0500
Message-ID: <D7D58F90994FD51195120002A56095E53E3182@tdsi-exch-ldn01.cibg.tdbank.ca>
From: "Taylor, Billy" <Billy.Taylor@mark-it.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Adding NIC for Compaq Evo laptop
Date: Tue, 13 Nov 2001 10:44:39 -0000
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have 2.4.15-pre2 on this laptop.

I added the integrated network port with this patch:

--- eepro100.c.old      Tue Nov 13 10:35:46 2001
+++ eepro100.c  Sat Nov 10 16:25:44 2001
@@ -168,6 +168,9 @@
 #ifndef PCI_DEVICE_ID_INTEL_ID1030
 #define PCI_DEVICE_ID_INTEL_ID1030 0x1030
 #endif
+#ifndef PCI_DEVICE_ID_INTEL_ID1038
+#define PCI_DEVICE_ID_INTEL_ID1038 0x1038
+#endif
 
 
 static int speedo_debug = 1;
@@ -2262,6 +2265,8 @@
        { PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ID1029,
                PCI_ANY_ID, PCI_ANY_ID, },
        { PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ID1030,
+               PCI_ANY_ID, PCI_ANY_ID, },
+       { PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ID1038,
                PCI_ANY_ID, PCI_ANY_ID, },
        { PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_7,
                PCI_ANY_ID, PCI_ANY_ID, },           

And force it to 100/full for my LAN.

dmesg shows:
	eepro100.c:v1.09j-t 9/29/99 Donald Becker
http://cesdis.gsfc.nasa.gov/linux/drivers/eepro100.html
	eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V.
Savochkin <saw@saw.sw.com.sg> and others
	eth0: OEM i82557/i82558 10/100 Ethernet, 00:02:A5:B4:02:60, IRQ 11.
  	  Board assembly 000000-000, Physical connectors present: RJ45
  	  Primary interface chip i82555 PHY #1.
  	  Forcing 100Mbs full-duplex operation.
  	  General self-test: passed.
  	  Serial sub-system self-test: passed.
  	  Internal registers self-test: passed.
  	  ROM checksum self-test: passed (0x04f4518b).

And lspci -v -v -v -x:

	02:08.0 Ethernet controller: Intel Corporation: Unknown device 1038
(rev 41)
        Subsystem: Compaq Computer Corporation: Unknown device 0098
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 66 (2000ns min, 14000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at 40100000 (32-bit, non-prefetchable) [size=4K]
        Region 1: I/O ports at 2800 [size=64]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-
	00: 86 80 38 10 07 00 90 02 41 00 00 02 08 42 00 00
	10: 00 00 10 40 01 28 00 00 00 00 00 00 00 00 00 00
	20: 00 00 00 00 00 00 00 00 00 00 00 00 11 0e 98 00
	30: 00 00 00 00 dc 00 00 00 00 00 00 00 0b 01 08 38          

My problem is that I get quite a lot of frame errors (no other errors). I
wondered
if one of you gurus could suggest a better patch, to add this NIC.

Regards,
Billy Taylor

                                                  
----------------------------------------------------------------------------
This e-mail and the information it contains may be confidential and is for
the intended addressee(s) only. If you have received it in error, please do
not disclose the contents to anyone. Notify the sender immediately and
delete the transmission from your files. If you are not the intended
addressee, any review, distribution, copying or use of this information is
strictly prohibited and may be unlawful.  We do not guarantee the accuracy
or completeness of this communication, expression of views or
recommendations, save and except for the benefit of the intended
addressee(s) and subject to the terms of any other documentation with the
intended addressee(s).
----------------------------------------------------------------------------
