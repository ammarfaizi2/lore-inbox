Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315300AbSENILm>; Tue, 14 May 2002 04:11:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315332AbSENILl>; Tue, 14 May 2002 04:11:41 -0400
Received: from [128.178.121.34] ([128.178.121.34]:3716 "EHLO ltspc67.epfl.ch")
	by vger.kernel.org with ESMTP id <S315300AbSENILk>;
	Tue, 14 May 2002 04:11:40 -0400
Subject: Re: PROBLEM: `modprobe agpgart` locks machine badly
From: Diego SANTA CRUZ <Diego.SantaCruz@epfl.ch>
To: linux-kernel@vger.kernel.org
Cc: Alex Brotman <atbrotman@earthlink.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 14 May 2002 10:11:23 +0200
Message-Id: <1021363885.2781.10.camel@ltspc67>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

> 1. 
>  `modprobe agpgart` locks machine badly 

I experience the exact same problem on my machine (an HP Omnibook 4150
laptop): a hard-lock in the initalization of the agpgart module, with
the same chipset (440BX/ZX).

> 7.500:00.0 Host bridge: Intel Corp. 440BX/ZX - 82443BX/ZX Host bridge
> (rev 03) 
>        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Step 
> ping- SERR+ FastB2B- 
>       Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
> <TAbort 
> - <MAbort+ >SERR- <PERR- 
>         Latency: 64 
>         Region 0: Memory at <unassigned> (32-bit, prefetchable)
> [size=256M] 
>         Capabilities: [a0] AGP version 1.0 
>                 Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2 
>                 Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

I did a bit of debugging some time ago with the datasheets from intel.
If i remember well, the problem was that the base of the aperture is not
initialized by the BIOS (i.e. the APBASE register of the AGP bridge).

This is visible in the lspci listing above, in that the Region 0 memory
is "<unassigned>". On the machines that I have seen with agpgart
working, the address of Region 0 is the address that appears in the
APBASE register.

I did not find any solution for my machine. Maybe there is a BIOS
upgrade that solves the problem for you? If you find any solution please
let me know.

Best regards,

Diego
-- 
-------------------------------------------------------
Diego Santa Cruz
PhD. student
Publications available at http://ltswww.epfl.ch/~dsanta
Signal Processing Institute (ITS) -- formerly LTS
Swiss Federal Institute of Technology (EPFL)
EPFL - STI - ITS, CH-1015 Lausanne, Switzerland
E-mail:     Diego.SantaCruz@epfl.ch
Phone:      +41 - 21 - 693 26 57
Fax:        +41 - 21 - 693 76 00
-------------------------------------------------------

