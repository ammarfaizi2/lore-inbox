Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262316AbUCMHSp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 02:18:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262329AbUCMHSp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 02:18:45 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:16655 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S262316AbUCMHSn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 02:18:43 -0500
Date: Sat, 13 Mar 2004 08:02:30 +0100
From: Willy Tarreau <willy@w.ods.org>
To: juerep@gmx.at
Cc: linux-kernel@vger.kernel.org, len.brown@intel.com
Subject: Re: ALSA via82xx fails since 2.6.2
Message-ID: <20040313070230.GC14537@alpha.home.local>
References: <200403122134.21542.juerep@gmx.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200403122134.21542.juerep@gmx.at>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2004 at 09:34:11PM +0100, J?rgen Repolusk wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> I see this in dmesg on 2.6.4-rc1:
> 
> VIA 82xx Audio: probe of 0000:00:07.5 failed with error -16
> 
> this is on a sony vaio pcg-fx505

Please retry without sonypi. I have nearly the same crappy notebook (fx705)
and when I tried sonypi, I discovered that it prevented the VIA audio from
registering because the IO controller was within the audio's IO space.
And it seems you've got the same problem: sonypi @1080-1084 and VIA @1000-10FF :

> sonypi: Sony Programmable I/O Controller Driver v1.21.
> sonypi: detected type2 model, verbose = 0, fnkeyinit = off, camera = off,
> compat = off, mask = 0xffffffff, useinput = on
> sonypi: enabled at irq=11, port1=0x1080, port2=0x1084
> sonypi: device allocated minor is 63

.../...

> unable to grab ports 0x1000-0x10ff
> VIA 82xx Audio: probe of 0000:00:07.5 failed with error -16

.../...

> lspci -vvxxx (via 82xx only)
> 
> 00:07.5 Multimedia audio controller: VIA Technologies, Inc. VT82C686 AC97
> Audio Controller (rev 50)
>         Subsystem: Sony Corporation: Unknown device 80f6
>         Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Interrupt: pin C routed to IRQ 5
>         Region 0: I/O ports at 1000 [size=256]
>         Region 1: I/O ports at 1c54 [size=4]
>         Region 2: I/O ports at 1c50 [size=4]


Cheers,
Willy

