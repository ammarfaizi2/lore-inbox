Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265085AbUFAPXP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265085AbUFAPXP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 11:23:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262279AbUFAPXB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 11:23:01 -0400
Received: from bhhdoa.org.au ([216.17.101.199]:3088 "EHLO bhhdoa.org.au")
	by vger.kernel.org with ESMTP id S262106AbUFAPW1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 11:22:27 -0400
Message-ID: <1086094667.40bc7d4b63f91@vds.kolivas.org>
Date: Tue,  1 Jun 2004 22:57:47 +1000
From: Con Kolivas <kernel@kolivas.org>
To: linux-kernel@vger.kernel.org
Subject: ICH5 irq fails in 100% native mode
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



While recently setting up a new machine with 2.6.3 and then 2.6.7-rc2 I
discovered this over and over again causing system stalls:

disabling IRQ18

syslog showed:

Jun  2 00:31:28 localhost kernel: irq 18: nobody cared!
Jun  2 00:31:28 localhost kernel:  [__report_bad_irq+42/121] 
[note_interrupt+145/175]  [do_IRQ+279/321]  [common_interrupt+24/32] 
[__do_softirq+66/177]
[do_softirq+45/47]  [do_IRQ+286/321]  [common_interrupt+24/32] 
[default_idle+0/44]  [default_idle+41/44]  [cpu_idle+46/60] 
[start_kernel+407/467]  [unkno
wn_bootoption+0/294]

dmesg revealed this:
ICH5: 100%% native mode on irq 18

Adding "noapic" to boot options simply moved the error to IRQ5 and occurred
routinely during boot at the ICH5 definition.


A quick google revealed the IDE settings in BIOS might be related so I disabled
the "ENHANCED" option for the ide controller which is both P-ATA and S-ATA and
chose the "COMPATIBLE" option.

The error went away, and now dmesg shows this:

ICH5: not 100%% native mode: will probe irqs later


While I am not able to determine whether there is any performance penalty for
this it seems that the probing of irqs at this point is responsible.

The hardware is an ASUS P4P800S motherboard with i848 chipset + ICH5 and a 2.8C
P4HT.

While this is a workaround I wonder what I/we need to do to make it work in
native mode.

Advice?

Con
