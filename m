Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263528AbTFJQrq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 12:47:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263542AbTFJQrp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 12:47:45 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:46304 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S263528AbTFJQrh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 12:47:37 -0400
Date: Tue, 10 Jun 2003 19:01:17 +0200 (MEST)
Message-Id: <200306101701.h5AH1HDS023535@harpo.it.uu.se>
From: mikpe@csd.uu.se
To: jgarzik@pobox.com
Subject: [BUG] de2104x oops in 2.5.70
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff,

de2104x in 2.5.70 oopses on me if I bring the device up
while the NIC (a 21041) is disconnected from my local network.
The oops text is roughly as follows:

<ifup eth0>
<approx one to two seconds later:>
eth0: timeout expired stopping DMA
kernel BUG at drivers/net/tulip/de2104x.c:927!
Oops: Exception in kernel mode, sig: 4 [#1]
<register dump not captured>
Call trace:
 [c00bc728] de21041_media_timer+0x1f4/0x2e0
 [c001f56c] run_timer_softirq+0xe4/0x198
 [c001aa40] do_softirq+0x10c/0x110
 [c0007c78] timer_interrupt+0x270/0x2a4
 [c0006084] ret_from_except+0x0/0x14
Kernel panic: Aiee, killing interrupt handler
In interrupt handler - not syncing

A few more data points:
- This is on 32-bit PowerPC configured for UP with PREEMPT disabled.
  I'm unable to capture the oops except by manually copying what's on
  the hung console. I hope the BUG location and call trace are sufficient.
- This happens regardless of whether de2104x is built-in or module.
- This does not happen if the NIC is connected at ifup time.
  And if I disconnect the NIC sometime after ifup, it detects the
  link down state and switches from 10baseT to AUI w/o oopsing.
- The old de4x5 driver handles ifup-while-disconnected w/o problems.
- The 2.4.21-rc7 tulip driver also survives ifup-while-disconnected.

/Mikael
