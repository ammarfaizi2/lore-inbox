Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264321AbUEDVDU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264321AbUEDVDU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 17:03:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264349AbUEDVDT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 17:03:19 -0400
Received: from pD95F30BB.dip.t-dialin.net ([217.95.48.187]:48907 "EHLO
	Marvin.DL8BCU.ampr.org") by vger.kernel.org with ESMTP
	id S264321AbUEDVDS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 17:03:18 -0400
Date: Tue, 4 May 2004 21:03:05 +0000
From: Thorsten Kranzkowski <dl8bcu@dl8bcu.de>
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org, akpm@osdl.org, ralf@linux-mips.org
Subject: [PATCH] sort out CLOCK_TICK_RATE usage take 3 [0/3]
Message-ID: <20040504210305.A6663@Marvin.DL8BCU.ampr.org>
Reply-To: dl8bcu@dl8bcu.de
Mail-Followup-To: linux-kernel@vger.kernel.org, torvalds@osdl.org,
	akpm@osdl.org, ralf@linux-mips.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello!

The calculation of the counter values in drivers/input/misc/pcspkr.c is
incorrectly based on CLOCK_TICK_RATE. This goes unnoticed in i386
because there the system clock is driven by the same Programmable
Interval Timer chip as the speaker. But this doesn't hold true on
other archs, e.g. Alpha.

To solve this problem I made these patches:

1/3:    introduce asm-*/8253pit.h, #define PIT_TICK_RATE constant.
        It seems this is not always the same value.
2/3:    use PIT_TICK_RATE in *spkr.c 
3/3:    use CLOCK_TICK_RATE where 1193180 was used in general timing
        calculations. (optional)

There are still some places where the magic number is used instead of
the #define (vt_ioctl.c, gameport.c) but I left them as-is. I got some
responses from arch maintainers to specifically not touch their 
respective architectures so changing these places would mean breakage 
for them.

Tested on Alpha and i386, ack'ed by Ralf Baechle for MIPS.
Please apply.

Bye,
Thorsten
-- 
| Thorsten Kranzkowski        Internet: dl8bcu@dl8bcu.de                      |
| Mobile: ++49 170 1876134       Snail: Kiebitzstr. 14, 49324 Melle, Germany  |
| Ampr: dl8bcu@db0lj.#rpl.deu.eu, dl8bcu@marvin.dl8bcu.ampr.org [44.130.8.19] |
