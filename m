Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750742AbWBSCzG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750742AbWBSCzG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 21:55:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750746AbWBSCzG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 21:55:06 -0500
Received: from krusty.pcisys.net ([216.229.32.178]:50333 "EHLO
	krusty.pcisys.net") by vger.kernel.org with ESMTP id S1750742AbWBSCzF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 21:55:05 -0500
Date: Sat, 18 Feb 2006 19:55:12 -0700
From: Brian Hall <brihall@pcisys.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Help: DGE-560T not recognized by Linux
Message-Id: <20060218195512.6bed967b.brihall@pcisys.net>
In-Reply-To: <20060217234841.5f2030ec.akpm@osdl.org>
References: <20060217222720.a08a2bc1.brihall@pcisys.net>
	<20060217222428.3cf33f25.akpm@osdl.org>
	<20060218003622.30a2b501.brihall@pcisys.net>
	<20060217234841.5f2030ec.akpm@osdl.org>
X-Mailer: Sylpheed version 2.2.0beta8 (GTK+ 2.8.12; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For the benefit of anyone searching later:

The problem was the current linux Marvell drivers (2.6.15/16rc4) not
detecting my Dlink card. After trying and failing to compile with the
linux driver (2.6.13-based) supplied on the retail CD (suprised, didn't
even think to look there at first!), I went to the Marvell site
directly and downloaded their version of the sk98lin driver, which
comes with a script to create a patch against whatever your current
linux version is in /usr/src/linux. That was found at:

http://www.marvell.com/drivers/driverDisplay.do?dId=107&pId=10

Yukon GigE Linux driver, Jan 12 2006, install-8_30.tar.bz2

After applying the generated patch against 2.6.15-ck4, I now have a
version of sk98lin that works with my DGE-560T.

Feb 18 16:59:31 syrinx sk98lin: Network Device Driver v8.30.2.3
Feb 18 16:59:31 syrinx (C)Copyright 1999-2005 Marvell(R).
Feb 18 16:59:31 syrinx ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 30
(level, low) -> IRQ 19 
Feb 18 16:59:31 syrinx PCI: Setting latency timer of device
0000:02:00.0 to 64 Feb 18 16:59:31 syrinx eth0: DGE-560T Gigabit
PCI-Express Ethernet Adapter 
Feb 18 16:59:31 syrinx PrefPort:A RlmtMode:Check Link State
Feb 18 16:59:35 syrinx eth0: network connection up using port A
Feb 18 16:59:35 syrinx speed:           1000
Feb 18 16:59:35 syrinx autonegotiation: yes
Feb 18 16:59:35 syrinx duplex mode:     full
Feb 18 16:59:35 syrinx flowctrl:        symmetric
Feb 18 16:59:35 syrinx role:            slave
Feb 18 16:59:35 syrinx irq moderation:  disabled
Feb 18 16:59:35 syrinx tcp offload:     enabled
Feb 18 16:59:35 syrinx scatter-gather:  enabled
Feb 18 16:59:35 syrinx tx-checksum:     enabled
Feb 18 16:59:35 syrinx rx-checksum:     enabled
Feb 18 16:59:35 syrinx rx-polling:      enabled

I'll try the kernel sk* drivers again when >=2.6.16 is released.

A further note, neither the Yukon DOS diagnostics that came with the
card (v6.27.1.3), nor the newer diagnostics that I downloaded from
Marvell (v6.30.x.y) could properly detect my card. Kept getting the
error "Board register check failed". Just in case anyone might think
that would indicate a bad card, in my case it didn't. This was with an
Opteron 165 on an Asrock 939Dual-SATA2.

--
Brian Hall
Linux Consultant
http://pcisys.net/~brihall
