Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264279AbTEaLga (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 07:36:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264283AbTEaLga
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 07:36:30 -0400
Received: from platane.lps.ens.fr ([129.199.121.28]:61327 "EHLO
	platane.lps.ens.fr") by vger.kernel.org with ESMTP id S264279AbTEaLg3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 07:36:29 -0400
Date: Sat, 31 May 2003 13:49:24 +0200
From: =?iso-8859-1?Q?=C9ric?= Brunet <Eric.Brunet@lps.ens.fr>
To: Michael Frank <mflt1@micrologica.com.hk>, acpi-devel@sourceforge.net
Cc: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.70 freezes when running hwclock
Message-ID: <20030531114924.GA14158@lps.ens.fr>
References: <20030531080544.GA13848@lps.ens.fr> <200305311841.47238.mflt1@micrologica.com.hk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200305311841.47238.mflt1@micrologica.com.hk>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 31, 2003 at 06:41:47PM +0800, Michael Frank wrote:
> > I have tried 2.5.70 on an intel chipset based pc, and I
> > got a reproductible complete freeze during the boot
> > process when hwclock is run. Even Caps Lock wouldn't lit
> > the little led.
> This seems to be an ACPI related problem on ALI 1533/1535 
> compatible implementations frequently seen on Toshiba's.
> 
> As a workaround, Boot with ACPI=off and add --directisa to 
> hwclock lines in rc.sysinit and halt (or their equivalents)
> 
> If this is really an Intel chipset it would be a first 
> 
> Please post your problem, solution and system info and lspci 
> to ACPI list.

hwclock --directisa works indeed. ACPI is indeed configured in, and 
I haven't tried to boot with ACPI=off.

Computer is a shuttle SB51G with an intel 845G/845GL chipset.

-------------------- lspci ----------------------------------
00:00.0 Host bridge: Intel Corp. 82845G/GL [Brookdale-G] Chipset Host Bridge (rev 03)
00:02.0 VGA compatible controller: Intel Corp. 82845G/GL [Brookdale-G] Chipset Integrated Graphics Device (rev 03)
00:1d.0 USB Controller: Intel Corp. 82801DB USB (Hub #1) (rev 02)
00:1d.1 USB Controller: Intel Corp. 82801DB USB (Hub #2) (rev 02)
00:1d.2 USB Controller: Intel Corp. 82801DB USB (Hub #3) (rev 02)
00:1d.7 USB Controller: Intel Corp. 82801DB USB EHCI Controller (rev 02)
00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB PCI Bridge (rev 82)
00:1f.0 ISA bridge: Intel Corp. 82801DB ISA Bridge (LPC) (rev 02)
00:1f.1 IDE interface: Intel Corp. 82801DB ICH4 IDE (rev 02)
00:1f.3 SMBus: Intel Corp. 82801DB SMBus (rev 02)
00:1f.5 Multimedia audio controller: Intel Corp. 82801DB AC'97 Audio (rev 02)
01:06.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
01:07.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host Controller (rev 46)
01:08.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8029(AS)
------------------------------------------------------------------------------

I am not sure what is relevant about the RTC. Let's try this:

------------------ lspci -vvv -s 00:1f.0 -----------------------------
00:1f.0 ISA bridge: Intel Corp. 82801DB ISA Bridge (LPC) (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
------------------------------------------------------------------------

------------------- lspci -vvv -s 00:1f.3---------------------------
00:1f.3 SMBus: Intel Corp. 82801DB SMBus (rev 02)
        Subsystem: Holco Enterprise Co, Ltd/Shuttle Computer: Unknown device fb50
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin B routed to IRQ 5
        Region 4: I/O ports at 0500 [size=32]
--------------------------------------------------------------------

2.5.67 was working fine, with the same configuration.

Regards,

	Éric Brunet
