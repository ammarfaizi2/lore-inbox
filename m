Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266509AbUHIMXn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266509AbUHIMXn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 08:23:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266522AbUHIMXU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 08:23:20 -0400
Received: from chaos.analogic.com ([204.178.40.224]:42126 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S266509AbUHIMWe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 08:22:34 -0400
Date: Mon, 9 Aug 2004 08:22:28 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: ix86 Atomic ops during DMA...
Message-ID: <Pine.LNX.4.53.0408090809520.7612@chaos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

A piece of hardware needs its interrupt status written back
to its status register to "clear" interrupts and thus enable
more.. This is in an uninterruptible ISR. This, of course
can be readily accomplished by using the standard readl() and
writel() macros.........but! If a DMA is in progress, a hardware
debugger shows many milliseconds between the read and the write.

This allows a race condition to exist. So, how do I lock the bus
during the read and write?  A lock on ix86 locks only the
next instruction, not the next plus time for another lock
which appears to be needed.

	I need...

	movl (%ebx), %eax	# Read status from register in ebx
	movl %eax, (%ebx)	# Write it back

..to occur together without the bus being taken away by a DMA
 operation until these two instructions are complete.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5570.56 BogoMips).
            Note 96.31% of all statistics are fiction.


