Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267588AbTBLQFg>; Wed, 12 Feb 2003 11:05:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267573AbTBLQFf>; Wed, 12 Feb 2003 11:05:35 -0500
Received: from CPEdeadbeef0000-CM400026342639.cpe.net.cable.rogers.com ([24.114.185.204]:3844
	"HELO coredump.sh0n.net") by vger.kernel.org with SMTP
	id <S267569AbTBLQE0>; Wed, 12 Feb 2003 11:04:26 -0500
Date: Wed, 12 Feb 2003 11:15:10 -0500 (EST)
From: Shawn Starr <spstarr@sh0n.net>
To: Paul Laufer <paul@laufernet.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: OSS Sound Blaster sb_card.c rewrite (PnP, module options, etc)
In-Reply-To: <Pine.LNX.4.44.0302101301260.851-100000@coredump.sh0n.net>
Message-ID: <Pine.LNX.4.44.0302121043260.167-100000@coredump.sh0n.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


To update you all:

Last night Adam and I were debugging the PnP and Adam squashed two bugs.
The Sound driver WORKS however, there are serious IRQ/DMA conflicts


serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
sb: Init: Starting Probe...
pnp: the card driver 'OSS SndBlstr' has been registered
pnp: pnp: match found with the PnP card '01:01' and the driver 'OSS SndBlstr'
pnp: dma 0
pnp: dma 1
pnp: res: the device '01:01.00' has been activated.
sb: PnP: Found Card Named = "Creative SB32 PnP", Card PnP id = CTL0048, Device PnP id = CTL0031
sb: PnP:      Detected at: io=0x220, irq=5, dma=1, dma16=5
sb: Interrupt test on IRQ5 failed - Probable IRQ conflict
<Sound Blaster 16 (4.13)> at 0x220 irq 5 dma 1,5
sb: Turning on MPU
<Sound Blaster 16> at 0x330 irq 5
sb: Init: Done
YM3812 and OPL-3 driver Copyright (C) by Hannu Savolainen, Rob Hooft
1993-1996


2.5 uses TWO irqs for the i8042 2.4 didn't which gives me 0 irq's free.

The problem is, the ISA Modem wants to use IRQ 5

So i have multiple conflicts at the same time ;-(

