Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266107AbTLaEJi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 23:09:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266108AbTLaEJi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 23:09:38 -0500
Received: from law11-f36.law11.hotmail.com ([64.4.17.36]:48652 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S266107AbTLaEJf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 23:09:35 -0500
X-Originating-IP: [24.200.19.49]
X-Originating-Email: [mberg24@hotmail.com]
From: "Martin Bergeron" <mberg24@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Bug in radeonfb (2.6.0)?
Date: Wed, 31 Dec 2003 04:09:34 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <Law11-F36EhXTwpb1iT0000d4bf@hotmail.com>
X-OriginalArrivalTime: 31 Dec 2003 04:09:34.0499 (UTC) FILETIME=[E6077730:01C3CF53]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I just upgraded from kernel 2.6.0-test10 to 2.6.0 without changing anything 
to my  existing configuration (make oldconfig, etc.).  After rebooting, the 
console was completely unreadable, with garbage all over the screen.  It was 
working correctly in 1024x768 before and X still worked correctly.

Here some infos:

I have a Mobility Radeon M7 on a Clevo 5600 laptop running Slackware 9.1.

Here is the output of lspci for my AGP card:

01:00.0 VGA compatible controller: ATI Technologies Inc Radeon Mobility M7 
LW [Radeon Mobility 7500] (prog-if 00 [VGA])
        Subsystem: CLEVO/KAPOK Computer: Unknown device 5600
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping+ SERR+ FastB2B+
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 66 (2000ns min), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at f0000000 (32-bit, prefetchable) [size=128M]
        Region 1: I/O ports at 3000 [size=256]
        Region 2: Memory at e8100000 (32-bit, non-prefetchable) [size=64K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [58] AGP version 2.0
                Status: RQ=48 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- 
HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
                Command: RQ=32 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- 
Rate=x1
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-



Here is a diff of drivers/video/radeonfb.c between 2.6.0-test10 and 2.6.0

# diff linux-2.6.0-test10/drivers/video/radeonfb.c 
linux-2.6.0/drivers/video/radeonfb.c
2093,2094c2093
<         /* info->fix.line_length = rinfo->pitch*64; */
<       info->fix.line_length = mode->xres_virtual*(mode->bits_per_pixel/8);
---
>         info->fix.line_length = rinfo->pitch*64;


-----------------------

I replaced the new radeonfb.c with the old from 2.6.0-test10 and my problem 
was solved.

Is this new 'feature' of radeonfb was supposed to solve anything?  It sure 
have ain't for me.

Am I the only one who had experienced this kind of behavior?

Thanks

_________________________________________________________________
Help STOP SPAM with the new MSN 8 and get 2 months FREE*   
http://join.msn.com/?page=dept/bcomm&pgmarket=en-ca&RU=http%3a%2f%2fjoin.msn.com%2f%3fpage%3dmisc%2fspecialoffers%26pgmarket%3den-ca

