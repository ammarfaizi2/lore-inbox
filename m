Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275271AbTHMPnn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 11:43:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275267AbTHMPmF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 11:42:05 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:9454 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S275266AbTHMPlq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 11:41:46 -0400
Date: Wed, 13 Aug 2003 17:40:23 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linux Kernel Development <linux-kernel@vger.kernel.org>
cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Bogus serial port ttyS02
Message-ID: <Pine.GSO.4.21.0308131601070.11378-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linux always finds 3 serial ports instead of 2:

| ttyS00 at 0x03f8 (irq = 4) is a 16550A
| ttyS01 at 0x02f8 (irq = 3) is a 16550A
| ttyS02 at 0x03e8 (irq = 4) is a 16450

The last one is bogus.

This is not exactly a new problem, and it happens with (and is not limited to)
both 2.4.21 and 2.6.0-test3. System is a PPC box (CHRP LongTrail) with a
National Semiconductor PC78308VUL SuperI/O, which has 2 internal 16550As.

Anyone with a clue? I know nothing about serial chip probing.


Ah, I still have some old dmesg outputs for that machine in my local CVS repo:

2.2.7: OK
2.3.18: OK
2.3.22: OK
2.3.42: not OK
2.3.47: not OK
2.3.48: not OK
2.3.50: not OK
2.3.51: not OK
2.3.99-pre3: not OK
2.4.0-test1: not OK
2.4.0-test1-ac7: OK
2.4.0-test1-ac10: OK
2.4.0-test11: not OK
2.4.0-test13-pre3: not OK
2.4.0-prerelease-ac5: not OK
2.4.0: not OK
2.4.1-pre2: not OK
2.4.1-pre10: not OK
2.4.1: not OK

So the problem was introduced between 2.3.22 and 2.3.42, and temporarily solved
in 2.4.0-test1-ac7 and 2.4.0-test1-ac10.

2.4.0-test1 has serial driver version 4.93 (2000-03-20)
2.4.0-test1-ac7 and 2.4.0-test1-ac10 have version 5.01 (2000-05-29)
2.4.0-test11 has version 5.02 (2000-08-09)

All are with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled. Looking at the diffs
between 2.4.0-test1 and 2.4.0-test1-ac7, and 2.4.0-test1-ac7 and 2.4.0-test11
I couldn't find anything suspicious.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

