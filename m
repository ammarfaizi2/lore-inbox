Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287048AbSASTPT>; Sat, 19 Jan 2002 14:15:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287115AbSASTPJ>; Sat, 19 Jan 2002 14:15:09 -0500
Received: from hirogen.kabelfoon.nl ([62.45.45.69]:37901 "HELO
	hirogen.kabelfoon.nl") by vger.kernel.org with SMTP
	id <S287048AbSASTPA>; Sat, 19 Jan 2002 14:15:00 -0500
Message-ID: <3C49C548.6040507@kabelfoon.nl>
Date: Sat, 19 Jan 2002 20:13:12 +0100
From: Nick Martens <nickm@kabelfoon.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
To: "Nix N. Nix" <nix@go-nix.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: hangs using opengl
In-Reply-To: <3C4712DB.6090201@kabelfoon.nl> <1011292729.12873.27.camel@tux>	<1011294257.13517.1.camel@tux> 	<200201171926.g0HJQUE19410@Port.imtp.ilyichevsk.odessa.ua> <1011303569.14984.3.camel@tux>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nix N. Nix wrote:

> On Thu, 2002-01-17 at 18:26, Denis Vlasenko wrote:
> 
>>On 17 January 2002 17:03, Nix N. Nix wrote:
>>
>>>>Via has recently released a patch to Via-chipset based boards that
>>>>addresses issues Windows XP users have been experiencing (BSODs and
>>>>friends) while playing OpenGL games, especially with NVidia chips.  The
>>>>problem and the description of the fix (as taken from the Readme.txt
>>>>from Via's patch) are as follow:
>>>>
>>>>So what does it do? It closes the RX55 memory register in BIOS. The RX55
>>>>register's official name and function is Memory Write Queue (MWQ) timer.
>>>>The MWQ timer is actually a timing device included in the memory host
>>>>controller to prevent write data being held in the memory queue too
>>>>long. After the data has been in the queue too long it times out. This
>>>>timed out data is then given a higher write request priority. Now that
>>>>might sound nice a bit of extra performance BUT the procedure fails when
>>>>overloaded. 3D games and Win XP put too much load on the memory queuing
>>>>timer procedure. The nVidia new driver exaggerates the problem even more
>>>>as the driver enables nVidia cards to use even more memory than previous
>>>>driver versions.
>>>>
>>[snip]
>>
>>
>>>>In light of VIAs discoveries, and the fact that the patch that they now
>>>>have available for Windows is not available for Linux also, I was
>>>>wondering if somebody on this list may be kind enough to help us with
>>>>what may very well be the symptoms of the same problem, but on Linux.
>>>>Could the code that accomplishes the above (turn off the RX55 register)
>>>>be made into a patch that can be applied to the kernel, thus providing
>>>>an equivalent patch for Linux systems ?
>>>>
>>Athlon bug stomper is already in mainline. If latest kernel does not work for 
>>you, check that register (man lspci) and 0x95 also. Try to disable them (man 
>>
> 
> I did lspci -vv -xxx
> Each entry is followed by a table of hex.  Is it entries 0x55 and 0x95
> in that table that you're referring to ? If so, well, they're both 0:
> 
> 01:00.0 VGA compatible controller: nVidia Corporation NV11 (rev a1)
> (prog-if 00 [VGA])
>         Subsystem: Asustek Computer, Inc.: Unknown device 4015
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 248 (1250ns min, 250ns max)
>         Interrupt: pin A routed to IRQ 11
>         Region 0: Memory at ee000000 (32-bit, non-prefetchable)
> [size=16M]
>         Region 1: Memory at f0000000 (32-bit, prefetchable) [size=128M]
>         Expansion ROM at efff0000 [disabled] [size=64K]
>         Capabilities: [60] Power Management version 2
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>         Capabilities: [44] AGP version 2.0
>                 Status: RQ=31 SBA- 64bit- FW+ Rate=x1,x2
>                 Command: RQ=31 SBA- AGP+ 64bit- FW- Rate=x2
> 00: de 10 10 01 07  00  b0 02 a1 00 00 03 00 f8 00 00
> 10: 00 00 00 ee 08  00  00 f0 00 00 00 00 00 00 00 00
> 20: 00 00 00 00 00  00  00 00 00 00 00 00 43 10 15 40
> 30: 00 00 00 00 60  00  00 00 00 00 00 00 0b 01 05 01
> 40: 43 10 15 40 02  00  20 00 17 00 00 1f 02 01 00 1f
> 50: 01 00 00 00 01 [00] 00 00 ce d6 23 00 0f 00 00 00
> 60: 01 44 02 00 00  00  00 00 00 00 00 00 00 00 00 00
> 70: 00 00 00 00 00  00  00 00 00 00 00 00 00 00 00 00
> 80: 00 00 00 00 00  00  00 00 00 00 00 00 00 00 00 00
> 90: 00 00 00 00 00 [00] 00 00 00 00 00 00 00 00 00 00
> a0: 00 00 00 00 00  00  00 00 00 00 00 00 00 00 00 00
> b0: 00 00 00 00 00  00  00 00 00 00 00 00 00 00 00 00
> c0: 00 00 00 00 00  00  00 00 00 00 00 00 00 00 00 00
> d0: 00 00 00 00 00  00  00 00 00 00 00 00 00 00 00 00
> e0: 00 00 00 00 00  00  00 00 00 00 00 00 00 00 00 00
> f0: 00 00 00 00 00  00  00 00 00 00 00 00 00 00 00 00
> 
> 
>>setpci). Report back - we may need to further improve stomper.
>>--
>>vda
>>


Mine sais:

01:00.0 VGA compatible controller: nVidia Corporation NV15 (Geforce2 GTS) (rev a
4) (prog-if 00 [VGA])
        Subsystem: CardExpert Technology: Unknown device 012c
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Step
ping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort
- <MAbort- >SERR- <PERR-
        Latency: 248 (1250ns min, 250ns max)
        Interrupt: pin A routed to IRQ 5
        Region 0: Memory at e2000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: Memory at d0000000 (32-bit, prefetchable) [size=128M]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [60] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot
-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [44] AGP version 2.0
                Status: RQ=31 SBA- 64bit- FW+ Rate=x1,x2
                Command: RQ=31 SBA- AGP+ 64bit- FW- Rate=<none>
00: de 10 50 01 07 00 b0 02 a4 00 00 03 00 f8 00 00
10: 00 00 00 e2 08 00 00 d0 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 b0 10 2c 01
30: 00 00 00 00 60 00 00 00 00 00 00 00 05 01 05 01
40: b0 10 2c 01 02 00 20 00 17 00 00 1f 04 01 00 1f
50: 01 00 00 00 01 00 00 00 ce d6 23 00 0f 00 00 00
60: 01 44 01 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

I am now going to test hat nvagp option,I can't download a new kernel from 

here connection is far too slow





