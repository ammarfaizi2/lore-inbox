Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750802AbVKLBlf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750802AbVKLBlf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 20:41:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750839AbVKLBlf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 20:41:35 -0500
Received: from smtp-vbr4.xs4all.nl ([194.109.24.24]:38162 "EHLO
	smtp-vbr4.xs4all.nl") by vger.kernel.org with ESMTP
	id S1750802AbVKLBle (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 20:41:34 -0500
From: Mark Hurenkamp <mark.hurenkamp@xs4all.nl>
To: linux-kernel@vger.kernel.org
Subject: CM8738 audio hampering while playing video on G450 PCI graphic card
Date: Sat, 12 Nov 2005 02:41:53 +0100
User-Agent: KMail/1.8.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511120241.54383.mark.hurenkamp@xs4all.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


I'm experiencing a strange problem with my audio, not sure when
it started to appear, since it's been a while (probably across several
hardware changes & distro upgrades ago) since I've been playing
serious audio on my system.

My hardware consists of a Asus A7M 266-D mainboard with two MP2600
CPU's, two Graphics cards: a G550 AGP and a G450 PCI. My current installed
distro is Fedora Core 4.

Now whenever there's a lot of activety (like scrolling down when I'm
browsing on a news site like slashdot, or playing video) on the G450 (both in 
accelerated mode, as well as in unaccelerated framebuffer mode), the audio 
(onboard CMedia) starts to hamper. This happens regardless wether I'm using
alsa, or oss. (using mplayer to play an mp3, but also with DivX movies
the same problem occurs).

Well, ever since I first noticed, I have tried a great number of things:
1) Move around my G450, to get a unique IRQ (although it does not seem to
be used at all by any drivers listed in /proc/interrupts). This does not
improve the situation.

2) Move the G450 from the bottom PCI bus (where also the onboard CMedia
is connected to) to the top PCI-X bus so that it defenately has enough
bandwith, but that too did not solve the problem.

3) Switched to USB audio, but here too, the problem still persists.

4) Switched from alsa to oss, but still no improvements.

5) Tried with -noapic and -nolapic and acpi=off, but no improvements.

6) Switched from fedora (2.6.13-1.1532_FC4smp) to plain vanilla 2.6.14,
but this too did not improve the situation.

7) Tried the rt6 and rt9 patches for 2.6.14, problem seemed to get worse...
(Switched on full preemption and used HZ_1000 as opposed to HZ_250).

8) Installing matrox proprietary mga drivers; but binary doesn't work & 
sources don't build for FC4.

9) Switch from Fedora Core 4 back to Ubuntu Hoary (5.04), but still the
problem exists.

Now I'm running out of ideas... I could try yet another audio card, but
since I've tried two different devices on both alsa and oss already,
I am not so sure that a third device will behave better...


Any hints/tips as to what I can do, are very very welcome.
Also patches to tryout or debug something, I'd be glad to test.
And if you think I should take this problem to a different list, please do
point me to the appropriate place.


Warm regards,
Mark.



Here's the relevant parts of the lspci -vvx output (please let me know if you 
need more info):


01:05.0 VGA compatible controller: Matrox Graphics, Inc. MGA G550 AGP (rev 01) 
(prog-if 00 [VGA])
        Subsystem: Matrox Graphics, Inc. Millennium G550 Dual Head DDR 32Mb
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (4000ns min, 8000ns max), Cache Line Size 08
        Interrupt: pin A routed to IRQ 217
        Region 0: Memory at f4000000 (32-bit, prefetchable) [size=32M]
        Region 1: Memory at ef000000 (32-bit, non-prefetchable) [size=16K]
        Region 2: Memory at ee800000 (32-bit, non-prefetchable) [size=8M]
        Expansion ROM at f3fe0000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [f0] AGP version 2.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 
64bit- FW- AGP3- Rate=x1,x2,x4
                Command: RQ=32 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- 
Rate=x1
00: 2b 10 27 25 07 00 90 02 01 00 00 03 08 40 00 00
10: 08 00 00 f4 00 00 00 ef 00 00 80 ee 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 2b 10 84 0f
30: 00 00 fe f3 dc 00 00 00 00 00 00 00 0b 01 10 20

03:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 85) 
(prog-if 00 [VGA])
        Subsystem: Matrox Graphics, Inc. Millennium G450 32Mb Dual Head PCI
        Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 185
        Region 0: Memory at f0000000 (32-bit, prefetchable) [size=32M]
        Region 1: Memory at eb000000 (32-bit, non-prefetchable) [size=16K]
        Region 2: Memory at ea800000 (32-bit, non-prefetchable) [size=8M]
        [virtual] Expansion ROM at effe0000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [f0] AGP version 2.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 
64bit- FW- AGP3- Rate=x1,x2
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- 
Rate=<none>
00: 2b 10 25 05 02 00 90 02 85 00 00 03 08 20 00 00
10: 08 00 00 f0 00 00 00 eb 00 00 80 ea 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 2b 10 43 0d
30: 00 00 00 00 dc 00 00 00 00 00 00 00 0a 01 10 20

04:04.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 10)
        Subsystem: ASUSTeK Computer Inc. CMI8738 6-channel audio controller
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (500ns min, 6000ns max)
        Interrupt: pin A routed to IRQ 177
        Region 0: I/O ports at b800 [size=256]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: f6 13 11 01 85 00 10 02 10 00 01 04 00 20 00 00
10: 01 b8 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 77 80
30: 00 00 00 00 c0 00 00 00 00 00 00 00 ff 01 02 18


