Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264269AbUEDIlx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264269AbUEDIlx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 04:41:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264268AbUEDIlx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 04:41:53 -0400
Received: from mail1.drkw.com ([62.129.121.35]:53499 "EHLO mail1.drkw.com")
	by vger.kernel.org with ESMTP id S264271AbUEDIlp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 04:41:45 -0400
From: "Heilmann, Oliver" <Oliver.Heilmann@drkw.com>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, davej@redhat.com,
       benh@kernel.crashing.org
Subject: Re: Crash in 2.6.6-rc3-mm1 (SiS/Radeon)
In-Reply-To: <20040501120843.GG2541@fs.tum.de>
References: <20040426082159.90513.qmail@web10102.mail.yahoo.com> 
    <1082971956.24569.2.camel@pandora> <1083063853.24569.88.camel@pandora> 
    <20040501120843.GG2541@fs.tum.de>
Content-Type: text/plain
Message-Id: <1083660105.9822.186.camel@pandora>
Mime-Version: 1.0
Date: Tue, 04 May 2004 09:41:45 +0100
Content-Transfer-Encoding: 7bit
X-SA-Exim-Mail-From: Oliver.Heilmann@drkw.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's possible that this is indeed an AGP problem (the 746 hasn't
received a lot of testing yet).
However, I don't think it's related to the patch. The only change it
introduces for your chip is the delay-hack, which I don't think could
adversely affect stability.
_If_ it is an AGP problem it might be a GART screw-up.
Here's a bunch of things you can do/try:

1. Run testgart.

2. Tell me which kernel version you were running when you thought your
system was stable. (Are you sure you were even using agp?)

3. Send me the output of lspci -s0 -vvv -xxx and lspci -s1 -vvv -xxx
   preferably when X is up.

Thanks for testing,

Oliver

On Sat, 2004-05-01 at 13:08, Adrian Bunk wrote:
> Hi Oliver,
> 
> 2.6.6-rc3-mm1 contains your patch.
> 
> My computer is usually very stable, but I had the following strange 
> crash [1]:
> 
> - running XFree86 4.3.0 (from Debian unstable) with FVWM and 3x3 virtual 
>   terminals
> - in one xterm a kernel compile that was most likely at the final
>   linking (IOW: medium cpu and IO load - I heard my HD working)
> 
> I suddenly saw in my virtual terminal the outlines of a xclock in a 
> different virtual terminal (but not the content).
> 
> After a Ctrl-Alt-F5 and Alt-F5 I'm also in 2.6.6-rc3-mm1 seeing for 
> a short time the following:
> - in the lower half of the window the lower half of the X window
> - in the left upper half and the right upper half of the window
>   two copies of tty5
> 
> But in the case of the crash, this didn't vanish any more.
> 
> At boot time, the kernel said:
> May  1 12:07:01 r063144 kernel: agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
> May  1 12:07:01 r063144 kernel: agpgart: Putting AGP V3 device at 0000:00:00.0 into 4x mode
> May  1 12:07:01 r063144 kernel: agpgart: SiS delay workaround: giving bridge time to recover.
> May  1 12:07:01 r063144 kernel: agpgart: Putting AGP V3 device at 0000:01:00.0 into 4x mode
> 
> My hardware is:
> 
> 0000:00:00.0 Host bridge: Silicon Integrated Systems [SiS] 746 Host (rev 10)
>         Subsystem: Unknown device 1849:0746
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
>         Latency: 0
>         Region 0: Memory at d0000000 (32-bit, non-prefetchable)
>         Capabilities: [c0] AGP version 2.0
>                 Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
>                 Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x1
> 
> 0000:01:00.0 VGA compatible controller: ATI Technologies Inc Radeon 
> RV100 QY [Radeon 7000/VE] (prog-if 00 [VGA])
>         Subsystem: C.P. Technology Co. Ltd: Unknown device 2072
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR+ FastB2B-
>         Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 32 (2000ns min), Cache Line Size: 0x08 (32 bytes)
>         Interrupt: pin A routed to IRQ 11
>         Region 0: Memory at c0000000 (32-bit, prefetchable)
>         Region 1: I/O ports at b800 [size=256]
>         Region 2: Memory at cfef0000 (32-bit, non-prefetchable) [size=64K]
>         Capabilities: [58] AGP version 2.0
>                 Status: RQ=48 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
>                 Command: RQ=32 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x1
>         Capabilities: [50] Power Management version 2
>                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> 
> Radeon framebuffer support is compiled into the kernel, but X is 
> configured not to use it.
> 
> 
> cu
> Adrian
> 
> [1] the SiS AGP patch is first possible suspect, but it might be 
>     unrelated


--------------------------------------------------------------------------------
The information contained herein is confidential and is intended solely for the
addressee. Access by any other party is unauthorised without the express
written permission of the sender. If you are not the intended recipient, please
contact the sender either via the company switchboard on +44 (0)20 7623 8000, or
via e-mail return. If you have received this e-mail in error or wish to read our
e-mail disclaimer statement and monitoring policy, please refer to 
http://www.drkw.com/disc/email/ or contact the sender.
--------------------------------------------------------------------------------

