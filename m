Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030587AbWAGV04@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030587AbWAGV04 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 16:26:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752591AbWAGV0z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 16:26:55 -0500
Received: from h-66-166-126-70.lsanca54.covad.net ([66.166.126.70]:10902 "EHLO
	myri.com") by vger.kernel.org with ESMTP id S1752590AbWAGV0z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 16:26:55 -0500
Message-ID: <43C03214.5080201@ens-lyon.org>
Date: Sat, 07 Jan 2006 16:26:44 -0500
From: Brice Goglin <Brice.Goglin@ens-lyon.org>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>
CC: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.15-mm2
References: <20060107052221.61d0b600.akpm@osdl.org> <43C0172E.7040607@ens-lyon.org> <20060107210413.GL9402@redhat.com>
In-Reply-To: <20060107210413.GL9402@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:

>Are you sure you actually this device ...
>
> > 0000:01:00.0 VGA compatible controller: ATI Technologies Inc M22 [Radeon Mobility M300] (prog-if 00 [VGA])
> > 	Subsystem: IBM: Unknown device 056e
> > 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
> > 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> > 	Latency: 0, Cache Line Size: 0x08 (32 bytes)
> > 	Interrupt: pin A routed to IRQ 169
> > 	Region 0: Memory at c0000000 (32-bit, prefetchable) [size=128M]
> > 	Region 1: I/O ports at 2000 [size=256]
> > 	Region 2: Memory at a8100000 (32-bit, non-prefetchable) [size=64K]
> > 	Expansion ROM at a8120000 [disabled] [size=128K]
> > 	Capabilities: <available only to root>
> > 00: 02 10 60 54 07 01 10 00 00 00 00 03 08 00 00 00
> > 10: 08 00 00 c0 01 20 00 00 00 00 10 a8 00 00 00 00
> > 20: 00 00 00 00 00 00 00 00 00 00 00 00 14 10 6e 05
> > 30: 00 00 00 00 50 00 00 00 00 00 00 00 0b 01 00 00
>
>is actually AGP ? (lspci -vvv of that device [as root] will tell you)
>
>		Dave
>
>  
>

Hi Dave,

It might be a PCI Express, I'm not sure. Here's lspci -vvv as root.
Where am I supposed to look ?

0000:01:00.0 VGA compatible controller: ATI Technologies Inc M22 [Radeon
Mobility M300] (prog-if 00 [VGA])
        Subsystem: IBM: Unknown device 056e
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, Cache Line Size: 0x08 (32 bytes)
        Interrupt: pin A routed to IRQ 169
        Region 0: Memory at c0000000 (32-bit, prefetchable) [size=128M]
        Region 1: I/O ports at 2000 [size=256]
        Region 2: Memory at a8100000 (32-bit, non-prefetchable) [size=64K]
        Expansion ROM at a8120000 [disabled] [size=128K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [58] #10 [0001]
        Capabilities: [80] Message Signalled Interrupts: 64bit+
Queue=0/0 Enable-
                Address: 0000000000000000  Data: 0000

Assuming this is a PCI Express card, then what is the proper fix ?
Should I prevent my initscript from loading agpgart (actually intel_agp)
at all ? (I guess udev or hotplug is trying to load it here). Is there
something like agpgart for PCI express ? Or is it useless ?

Brice

