Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261687AbVBOLlj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261687AbVBOLlj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 06:41:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261691AbVBOLlj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 06:41:39 -0500
Received: from hornet.berlios.de ([195.37.77.140]:13514 "EHLO
	hornet.berlios.de") by vger.kernel.org with ESMTP id S261687AbVBOLlg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 06:41:36 -0500
Date: Tue, 15 Feb 2005 12:41:35 +0100
From: mhf@berlios.de
To: linux-kernel@vger.kernel.org
Subject: [BUG] 2.6.11-rc[234] setfont fails on i810 after resume from 
 ACPI-S3
Message-ID: <4211DFEF.nailM9Q14C1G0@berlios.de>
User-Agent: nail 10.5 4/27/03
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

HW info

Hardware Celeron 433 with i810 chipset:

0000:00:00.0 Host bridge: Intel Corp. 82810E DC-133 GMCH [Graphics Memory C=
ontroller Hub] (rev 03)
=A0 =A0 =A0 =A0 Subsystem: Intel Corp. 82810E DC-133 GMCH [Graphics Memory =
Controller Hub]
=A0 =A0 =A0 =A0 Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-=
 ParErr- Stepping- SERR+ FastB2B-
=A0 =A0 =A0 =A0 Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TA=
bort- <TAbort-<MAbort+ >SERR- <PERR-
=A0 =A0 =A0 =A0 Latency: 0

0000:00:01.0 VGA compatible controller: Intel Corp. 82810E DC-133 CGC [Chip=
set Graphics Controller] (rev 03) (prog-if 00 [VGA])
=A0 =A0 =A0 =A0 Subsystem: FIRST INTERNATIONAL Computer Inc: Unknown device=
 9980
=A0 =A0 =A0 =A0 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-=
 ParErr- Stepping- SERR- FastB2B-
=A0 =A0 =A0 =A0 Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >=
TAbort- <TAbort- <MAbort- >SERR- <PERR-
=A0 =A0 =A0 =A0 Latency: 0
=A0 =A0 =A0 =A0 Interrupt: pin A routed to IRQ 9
=A0 =A0 =A0 =A0 Region 0: Memory at e8000000 (32-bit, prefetchable) [size=
=3D64M]
=A0 =A0 =A0 =A0 Region 1: Memory at eff80000 (32-bit, non-prefetchable) [si=
ze=3D512K]
=A0 =A0 =A0 =A0 Capabilities: [dc] Power Management version 1
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0m=
A PME(D0-,D1-,D2-,D3hot-,D3cold-)
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Status: D0 PME-Enable- DSel=3D0 DScale=3D0 =
PME-

Software:

Gentoo current.

Using vga=3D0xf07, default8x16 font, display has 30 lines

On powerup from S3 console has only 25 lines but still scrolls=20
at 30 lines. Setfont historically fixes it.=20

Tested with 2.6.10, 2.6.11-rc1: OK

Tested with 2.6.11-rc2-Vanilla and 2.6.11-rc[234]+swsusp2.
When using setfont, screen goes blank. Power up after S3
returns console in 25 lines mode with 30 lines scroll.=20
Several attempts - same result.

Another bug I see only on this HW and only with 2.6 is that
when - and only when - using gentoo emerge --usepackage in
text console, scroll area resets to _25_ when portage=20
"dumps" the (binary) package contents which scrolls pretty
fast. I was unable to reproduce this in any other way.=20
Tried also echo loop in bash but perhaps it is too slow
or not random enough. Note that 2.4.2[789] no problem.

Regards
Michael
