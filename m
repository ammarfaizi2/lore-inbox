Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750759AbVHXI3g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750759AbVHXI3g (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 04:29:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750761AbVHXI3g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 04:29:36 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:17122 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S1750759AbVHXI3f
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 04:29:35 -0400
Message-ID: <430C31CE.2030308@aitel.hist.no>
Date: Wed, 24 Aug 2005 10:37:34 +0200
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Dave Airlie <airlied@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Subject: Re: rc6 keeps hanging and blanking displays
References: <20050815221109.GA21279@aitel.hist.no>  <21d7e99705081516241197164a@mail.gmail.com>  <20050816165242.GA10024@aitel.hist.no>  <Pine.LNX.4.58.0508160955270.3553@g5.osdl.org>  <20050816211424.GA14367@aitel.hist.no>  <21d7e99705081616504d28cca5@mail.gmail.com>  <43031A12.8020301@aitel.hist.no>  <21d7e997050817040523a1bf46@mail.gmail.com>  <Pine.LNX.4.58.0508170815370.3553@g5.osdl.org>  <20050822214453.GA31266@aitel.hist.no> <21d7e9970508221607bb74cc7@mail.gmail.com> <Pine.LNX.4.58.0508221628140.3317@g5.osdl.org> <Pine.LNX.4.58.0508232302370.3317@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0508232302370.3317@g5.osdl.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

>On Mon, 22 Aug 2005, Linus Torvalds wrote:
>  
>
>>But disabling the ROM assignment might be a good idea. Almost nobody ever 
>>really wants to assign the ROM anyway, and there are cards where there are 
>>some strange rules about ROM alignment (read: doesn't follow spec).
>>    
>>
>
>Here's an even better idea.
>
>Let's do the assignment internally in the kernel, but just not write it to 
>the device unless it's actually enabled. IOW, we'll be doing all the 
>resource allocation, but devices won't be affected. Modern lspci versions 
>will show this as a "[virtual] Expansion ROM".
>
>The patch might look something like this. Helge, does this make any 
>difference?
>  
>
Tried it.  (More risky than it sounds, I am at work, the machine is at home,
and if it didn't come up again I'd get an angry phonecall . . .)

But it came up fine, and the xservers came up too. :-)

lspci -vvx shows the disabled ROMs too:

0000:01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G550 
AGP (rev 01) (prog-if 00 [VGA])
        Subsystem: Matrox Graphics, Inc. Millennium G550 Dual Head DDR 32Mb
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (4000ns min, 8000ns max), Cache Line Size: 0x08 (32 
bytes)
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at f0000000 (32-bit, prefetchable) [size=32M]
        Region 1: Memory at f2000000 (32-bit, non-prefetchable) [size=16K]
        Region 2: Memory at f3000000 (32-bit, non-prefetchable) [size=8M]
        Expansion ROM at f2020000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [f0] AGP version 2.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- 
HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
                Command: RQ=32 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- 
FW- Rate=x1
00: 2b 10 27 25 07 00 90 02 01 00 00 03 08 20 00 00
10: 08 00 00 f0 00 00 00 f2 00 00 00 f3 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 2b 10 84 0f
30: 00 00 00 00 dc 00 00 00 00 00 00 00 0b 01 10 20


0000:00:08.0 VGA compatible controller: ATI Technologies Inc RV280 
[Radeon 9200 SE] (rev 01) (prog-if 00 [VGA])
        Subsystem: PC Partner Limited: Unknown device 7c25
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min), Cache Line Size: 0x08 (32 bytes)
        Interrupt: pin A routed to IRQ 19
        Region 0: Memory at e0000000 (32-bit, prefetchable) [size=128M]
        Region 1: I/O ports at 9800 [size=256]
        Region 2: Memory at f6000000 (32-bit, non-prefetchable) [size=64K]
        Expansion ROM at 1ff00000 [disabled] [size=128K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 02 10 64 59 07 00 90 02 01 00 00 03 08 20 80 00
10: 08 00 00 e0 01 98 00 00 00 00 00 f6 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 4b 17 25 7c
30: 00 00 00 00 50 00 00 00 00 00 00 00 05 01 08 00

0000:00:08.1 Display controller: ATI Technologies Inc RV280 [Radeon 9200 
SE] (Secondary) (rev 01)
        Subsystem: PC Partner Limited: Unknown device 7c24
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Region 0: Memory at e8000000 (32-bit, prefetchable) [disabled] 
[size=128M]
        Region 1: Memory at f6010000 (32-bit, non-prefetchable) 
[disabled] [size=64K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 02 10 44 5d 00 00 90 02 01 00 80 03 08 20 00 00
10: 08 00 00 e8 00 00 01 f6 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 4b 17 24 7c
30: 00 00 00 00 50 00 00 00 00 00 00 00 ff 00 08 00

Helge Hafting
