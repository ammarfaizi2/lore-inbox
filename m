Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129145AbRBFFaX>; Tue, 6 Feb 2001 00:30:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129177AbRBFFaO>; Tue, 6 Feb 2001 00:30:14 -0500
Received: from hoochie.linux-support.net ([216.207.245.2]:6406 "EHLO
	hoochie.linux-support.net") by vger.kernel.org with ESMTP
	id <S129145AbRBFF34>; Tue, 6 Feb 2001 00:29:56 -0500
Date: Mon, 5 Feb 2001 23:29:39 -0600 (CST)
From: Mark Spencer <markster@linux-support.net>
To: linux-kernel@vger.kernel.org
cc: jim@lambdatel.com
Subject: Linux interrupt latency
Message-ID: <Pine.LNX.4.21.0102052304170.13906-100000@hoochie.linux-support.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm working on the Linux driver for the Tormenta public domain dual T1
card (see http://www.bsdtelephony.com.mx).  This card is a controllerless
ISA T1 card with no memory, meaning the host CPU must load the next 48
outgoing bytes and read the previous 48 incoming bytes off the ISA bus
8000 times per second (every 125 microseconds).  Further, because the
buffers are constantly being overwritten by the card, the actual interrupt
handler must run within 4-28 microseconds from when the card issues the
interrupt.


On my primary test machine, a Pentium II, 450Mhz, with Intel 430BX
chipset, the board runs fine with both IDE and SCSI drives (note: DMA must
be turned on for the IDE drives).  However, on other chipsets, like VIA,
the card misses 2-3 interrupts every 7989-7991 samples (almost exactly*
one second).  Further, even with DMA turned on, the IDE disk definitely
kills the interrupt latency entirely.  

Oh, and as a side note...  The card works flawlessly in FreeBSD (although
only with SCSI) and definitely does not have 7989 sample problem.  The
problem occurs with both Linux 2.2.16 and 2.4.0...

Can anyone suggest what might be causing the problem on non-Intel
chipsets, particularly what event might be occuring once per second and
disabling interrupts for a couple of hundred microseconds?  Thanks!

Mark


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
