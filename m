Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263269AbUDPP5X (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 11:57:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263371AbUDPP5X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 11:57:23 -0400
Received: from chaos.analogic.com ([204.178.40.224]:1152 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263269AbUDPPzY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 11:55:24 -0400
Date: Fri, 16 Apr 2004 11:55:28 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Kernel writes to RAM it doesn't own on 2.4.24
Message-ID: <Pine.LNX.4.53.0404161150450.542@chaos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello again,

If I start a system that has 1 Gb of memory with mem=500m,
the value of the kernel's num_physpages is 0x20000 as would
be expected. If I multiply that by PAGE_SIZE, I get 0x20000000,
also as expected. If I observe that memory region, I note
that somebody has written something there!

This is not good. The kernel touches RAM it doesn't own. I have
booted the system with only the internal floppy controller
and no other modules installed. I see the same thing.

Script started on Fri Apr 16 11:33:39 2004
# monitor
                  TMD Platinum(tm) Control System Version 2.0
                 Copyright(c) 1999-2003, Analogic Corporation

  Enter "help" for commands

PLATINUM> dump=20000000
20000000  78 56 34 12 21 43 65 87-FF FF FF FF FF FF FF FF   xV4.!Ce.........
20000010  FF FF FF FF FF FF FF FD-FF FF FF FF FF FF FF FF   ................
20000020  FF FF FF FF FF FE FF FF-FF FF FE FF FF FF FF FF   ................
[SNIPPED...]

My temporary work around for the kernel's destroying a
precious DMA buffer is to start one page higher. However,
whomever is writing to that RAM is likely writing other
places it doesn't belong also. This could lead to some
very interesting bugs.

Note that the value written there is 0x12345678, twice, once
in little endian and another in swap-nibble big endian, like
a mirror. This is evil.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (5596.77 BogoMips).
            Note 96.31% of all statistics are fiction.
