Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262008AbUEAMJv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262008AbUEAMJv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 May 2004 08:09:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261766AbUEAMJv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 May 2004 08:09:51 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:2294 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262008AbUEAMIt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 May 2004 08:08:49 -0400
Date: Sat, 1 May 2004 14:08:43 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: "Heilmann, Oliver" <Oliver.Heilmann@drkw.com>, benh@kernel.crashing.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, davej@redhat.com
Subject: Crash in 2.6.6-rc3-mm1 (SiS/Radeon)
Message-ID: <20040501120843.GG2541@fs.tum.de>
References: <20040426082159.90513.qmail@web10102.mail.yahoo.com> <1082971956.24569.2.camel@pandora> <1083063853.24569.88.camel@pandora>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1083063853.24569.88.camel@pandora>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oliver,

2.6.6-rc3-mm1 contains your patch.

My computer is usually very stable, but I had the following strange 
crash [1]:

- running XFree86 4.3.0 (from Debian unstable) with FVWM and 3x3 virtual 
  terminals
- in one xterm a kernel compile that was most likely at the final
  linking (IOW: medium cpu and IO load - I heard my HD working)

I suddenly saw in my virtual terminal the outlines of a xclock in a 
different virtual terminal (but not the content).

After a Ctrl-Alt-F5 and Alt-F5 I'm also in 2.6.6-rc3-mm1 seeing for 
a short time the following:
- in the lower half of the window the lower half of the X window
- in the left upper half and the right upper half of the window
  two copies of tty5

But in the case of the crash, this didn't vanish any more.

At boot time, the kernel said:
May  1 12:07:01 r063144 kernel: agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
May  1 12:07:01 r063144 kernel: agpgart: Putting AGP V3 device at 0000:00:00.0 into 4x mode
May  1 12:07:01 r063144 kernel: agpgart: SiS delay workaround: giving bridge time to recover.
May  1 12:07:01 r063144 kernel: agpgart: Putting AGP V3 device at 0000:01:00.0 into 4x mode

My hardware is:

0000:00:00.0 Host bridge: Silicon Integrated Systems [SiS] 746 Host (rev 10)
        Subsystem: Unknown device 1849:0746
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Region 0: Memory at d0000000 (32-bit, non-prefetchable)
        Capabilities: [c0] AGP version 2.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
                Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x1

0000:01:00.0 VGA compatible controller: ATI Technologies Inc Radeon 
RV100 QY [Radeon 7000/VE] (prog-if 00 [VGA])
        Subsystem: C.P. Technology Co. Ltd: Unknown device 2072
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR+ FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min), Cache Line Size: 0x08 (32 bytes)
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at c0000000 (32-bit, prefetchable)
        Region 1: I/O ports at b800 [size=256]
        Region 2: Memory at cfef0000 (32-bit, non-prefetchable) [size=64K]
        Capabilities: [58] AGP version 2.0
                Status: RQ=48 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
                Command: RQ=32 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x1
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-


Radeon framebuffer support is compiled into the kernel, but X is 
configured not to use it.


cu
Adrian

[1] the SiS AGP patch is first possible suspect, but it might be 
    unrelated

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

