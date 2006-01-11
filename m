Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932520AbWAKSlS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932520AbWAKSlS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 13:41:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751723AbWAKSlR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 13:41:17 -0500
Received: from h-66-166-126-70.lsanca54.covad.net ([66.166.126.70]:41710 "EHLO
	myri.com") by vger.kernel.org with ESMTP id S1751720AbWAKSlQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 13:41:16 -0500
Message-ID: <43C55148.4010706@ens-lyon.org>
Date: Wed, 11 Jan 2006 13:41:12 -0500
From: Brice Goglin <Brice.Goglin@ens-lyon.org>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.15-mm2
References: <20060107052221.61d0b600.akpm@osdl.org> <43C0172E.7040607@ens-lyon.org> <20060107210413.GL9402@redhat.com> <43C03214.5080201@ens-lyon.org>
In-Reply-To: <43C03214.5080201@ens-lyon.org>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brice Goglin wrote:

>>>0000:01:00.0 VGA compatible controller: ATI Technologies Inc M22 [Radeon Mobility M300] (prog-if 00 [VGA])
>>>	Subsystem: IBM: Unknown device 056e
>>>	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
>>>	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>>>	Latency: 0, Cache Line Size: 0x08 (32 bytes)
>>>	Interrupt: pin A routed to IRQ 169
>>>	Region 0: Memory at c0000000 (32-bit, prefetchable) [size=128M]
>>>	Region 1: I/O ports at 2000 [size=256]
>>>	Region 2: Memory at a8100000 (32-bit, non-prefetchable) [size=64K]
>>>	Expansion ROM at a8120000 [disabled] [size=128K]
>>>	Capabilities: <available only to root>
>>>00: 02 10 60 54 07 01 10 00 00 00 00 03 08 00 00 00
>>>10: 08 00 00 c0 01 20 00 00 00 00 10 a8 00 00 00 00
>>>20: 00 00 00 00 00 00 00 00 00 00 00 00 14 10 6e 05
>>>30: 00 00 00 00 50 00 00 00 00 00 00 00 0b 01 00 00
>>>      
>>>
>Assuming this is a PCI Express card, then what is the proper fix ?
>Should I prevent my initscript from loading agpgart (actually intel_agp)
>at all ? (I guess udev or hotplug is trying to load it here). Is there
>something like agpgart for PCI express ? Or is it useless ?
>  
>

Hi Dave,

I'm coming back on this topic since I managed to get DRI to work with
the open source driver on 2.6.15 (I mean drivers/char/drm/radeon).
And it does not work on -mm (actually I only tried -mm3) since
apparently radeon loads drm, and drm needs some agp symbols. Both radeon
and drm (and agpgart) and built as module here.
How are we supposed to get DRM to work on PCI Express cards if DRM needs
AGP and agpgart does not load when no AGP card is found ? :)

drm: Unknown symbol agp_bind_memory
...
drm: Unknown symbol agp_backend_release
radeon: Unknown symbol drm_open
...
radeon: Unknown symbol drm_release

thanks,
Brice

