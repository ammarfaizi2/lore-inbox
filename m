Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262007AbUEaJ7S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262007AbUEaJ7S (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 05:59:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261181AbUEaJ7S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 05:59:18 -0400
Received: from aun.it.uu.se ([130.238.12.36]:56476 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S262007AbUEaJ7L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 05:59:11 -0400
Date: Mon, 31 May 2004 11:55:18 +0200 (MEST)
Message-Id: <200405310955.i4V9tI7Z025408@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: dctucker@hotmail.com, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: network driver causes kernel panic
Cc: jgarzik@pobox.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 May 2004 06:18:30 +0000, Casey Tucker wrote:
[only the relevent fragments]
>1. Kernel panic when connector removed from eth1
>
>2. When i remove the RJ-45 connector from the input jack of eth1 on my 
>machine, kernel panics. Unfortunately, I cannot give the specific output of 
>the crash. I believe the driver is tulip, however not being able to remember 
>which card is which, it may indeed be the natsemi driver.
...
>4. Linux version 2.6.6 (root@whiteguy) (gcc version 3.2.3) #1 Mon May 10 
...
>d400-d41f : 0000:00:07.2
>d800-d87f : 0000:00:0f.0
>  d800-d87f : de2104x
>dc00-dc1f : 0000:00:10.0
>  dc00-dc1f : EMU10K1
>e000-e007 : 0000:00:10.1
>e400-e4ff : 0000:00:13.0
>  e400-e4ff : eth0
...
>00:0f.0 Ethernet controller: Digital Equipment Corporation DECchip 21041 
>[Tulip Pass 3] (rev 21)
>        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
>Stepping- SERR- FastB2B-
>        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
><TAbort- <MAbort- >SERR- <PERR-
>        Latency: 32
>        Interrupt: pin A routed to IRQ 11
>        Region 0: I/O ports at d800 [size=128]
...
>00:13.0 Ethernet controller: National Semiconductor Corporation DP83815 
>(MacPhyter) Ethernet Controller
>        Subsystem: Netgear: Unknown device f311
>        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
>Stepping- SERR- FastB2B-
>        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
><TAbort- <MAbort- >SERR- <PERR-
>        Latency: 32 (2750ns min, 13000ns max)
>        Interrupt: pin A routed to IRQ 5
>        Region 0: I/O ports at e400 [size=256]

This confirms that eth1 is a 21041 driven by the de2104x driver.

I've seen something very similar to Casey's problem, on a PowerMac
with a built-in 21041. Booting it with no network cable connected
causes a timer to hit a BUG() in de2104x about a second after
the device is ifup:d.

The 2.4 kernel's tulip driver works just fine.

I reported this last year, but nothing happened.

A workaround is to use the de4x5 driver instead.
