Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280970AbRKOSO1>; Thu, 15 Nov 2001 13:14:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280971AbRKOSOR>; Thu, 15 Nov 2001 13:14:17 -0500
Received: from air-1.osdl.org ([65.201.151.5]:27799 "EHLO segfault.osdlab.org")
	by vger.kernel.org with ESMTP id <S280970AbRKOSOH>;
	Thu, 15 Nov 2001 13:14:07 -0500
Date: Thu, 15 Nov 2001 10:16:53 -0800 (PST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@segfault.osdlab.org>
To: Faux Pas III <fauxpas@temp123.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Maestro 2E vs. Power mgmt
In-Reply-To: <20011115124311.C11236@temp123.org>
Message-ID: <Pine.LNX.4.33.0111151011370.21985-100000@segfault.osdlab.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 15 Nov 2001, Faux Pas III wrote:

> On Thu, Nov 15, 2001 at 09:29:27AM -0800, Patrick Mochel wrote:
>
> > Could you do a lspci -vv as root on that device both with AC and without?

Sorry, I meant something like 'lspci -vv -s 00:0c.0' :)

>
> On AC:
>
> frabjous:~# lspci -vv
	...
> 00:0c.0 Multimedia audio controller: ESS Technology ES1978 Maestro 2E (rev 10)
>         Subsystem: Toshiba America Info Systems ES1978 Maestro-2E Audiodrive
>         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 64 (500ns min, 6000ns max)
>         Interrupt: pin A routed to IRQ 11
>         Region 0: I/O ports at ee00 [size=256]
>         Capabilities: [c0] Power Management version 2
>                 Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold-)
>                 Status: D2 PME-Enable- DSel=0 DScale=0 PME-
                         ^^^^
>
> frabjous:~#
>
> And on battery:
>
> frabjous:~# lspci -vv
	...
> 00:0c.0 Multimedia audio controller: ESS Technology ES1978 Maestro 2E (rev 10)
>         Subsystem: Toshiba America Info Systems ES1978 Maestro-2E Audiodrive
>         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 64 (500ns min, 6000ns max)
>         Interrupt: pin A routed to IRQ 11
>         Region 0: I/O ports at ee00 [size=256]
>         Capabilities: [c0] Power Management version 2
>                 Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold-)
>                 Status: D2 PME-Enable- DSel=0 DScale=0 PME-
                         ^^^^

It says in both cases that the device is in D2; ah yes, the device is not
open and the driver cuts the power on ess_release().

Are you noticing any performance degradation for any other devices?

(On a side note, it looks like the driver is manually touching a lot of
PCI config space rather than using the pci_ wrappers...)

	-pat

