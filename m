Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263540AbUGFGz2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263540AbUGFGz2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 02:55:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263413AbUGFGyO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 02:54:14 -0400
Received: from hauptpostamt.charite.de ([193.175.66.220]:50061 "EHLO
	hauptpostamt.charite.de") by vger.kernel.org with ESMTP
	id S263555AbUGFGtp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 02:49:45 -0400
Date: Tue, 6 Jul 2004 08:49:42 +0200
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: linux-usb-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: USB Lockups with 2.6.7-mm6, was Re: 2.6.7-mm6
Message-ID: <20040706064942.GD19374@charite.de>
Mail-Followup-To: linux-usb-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040705023120.34f7772b.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton <akpm@osdl.org>:
 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.7/2.6.7-mm6/
> 
> - Added the DVD-RW/CD-RW packet writing patches.  These need more work.
> 
> - The USB update seems deadlocky.  I fixed one bug but it still causes my
>   ia64 test box to lock up on boot.  If it goes bad, please revert
>   usb-locking-fix.patch and then revert bk-usb.patch.  Retest and send a report
>   to linux-kernel and linux-usb-devel@lists.sourceforge.net.

Yes, I also encountered these lockups on two of my laptops:

Toshiba Satellite Pro 6100:
0000:00:1d.0 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #1) (rev 02) (prog-if 00 [UHCI])
        Subsystem: Toshiba America Info Systems: Unknown device 0001
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 11
        Region 4: I/O ports at efe0 [size=32]
		
0000:00:1d.1 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #2) (rev 02) (prog-if 00 [UHCI])
        Subsystem: Toshiba America Info Systems: Unknown device 0001
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 11
        Region 4: I/O ports at ef80 [size=32]
			
0000:00:1d.2 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #3) (rev 02) (prog-if 00 [UHCI])
        Subsystem: Toshiba America Info Systems: Unknown device 0001
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin C routed to IRQ 11
        Region 4: I/O ports at ef60 [size=32]

HP pavilion zv5000:


0000:00:02.0 USB Controller: nVidia Corporation nForce3 USB 1.1 (reva5) (prog-if 10 [OHCI])
        Subsystem: nVidia Corporation: Unknown device 0c80
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (750ns min, 250ns max)
        Interrupt: pin A routed to IRQ 11
	Region 0: Memory at e8000000 (32-bit, non-prefetchable)
        Capabilities: [44] Power Management version 2
        Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-
		
0000:00:02.1 USB Controller: nVidia Corporation nForce3 USB 1.1 (rev a5) (prog-if 10 [OHCI])
        Subsystem: nVidia Corporation: Unknown device 0c80
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (750ns min, 250ns max)
        Interrupt: pin B routed to IRQ 10
        Region 0: Memory at e8001000 (32-bit, non-prefetchable)
        Capabilities: [44] Power Management version 2
        Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-
		
0000:00:02.2 USB Controller: nVidia Corporation nForce3 USB 2.0 (rev a2) (prog-if 20 [EHCI])
        Subsystem: nVidia Corporation: Unknown device 0c80
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (750ns min, 250ns max)
        Interrupt: pin C routed to IRQ 10
        Region 0: Memory at e8004000 (32-bit, non-prefetchable)
        Capabilities: [80] Power Management version 2
        Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-
		
-- 
Ralf Hildebrandt (Im Auftrag des Referat V a)   Ralf.Hildebrandt@charite.de
Charite - Universitätsmedizin Berlin            Tel.  +49 (0)30-450 570-155
Gemeinsame Einrichtung von FU- und HU-Berlin    Fax.  +49 (0)30-450 570-916
IT-Zentrum Standort Campus Mitte                          AIM.  ralfpostfix
