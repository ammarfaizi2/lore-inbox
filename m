Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265245AbUHWPeH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265245AbUHWPeH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 11:34:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265053AbUHWPbW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 11:31:22 -0400
Received: from fw.osdl.org ([65.172.181.6]:11477 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265211AbUHWP02 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 11:26:28 -0400
Date: Mon, 23 Aug 2004 08:24:39 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Alexander Nyberg <alexn@telia.com>
Cc: linux-kernel@vger.kernel.org, bjorn.helgaas@hp.com
Subject: Re: 2.6.8.1-mm IRQ routing problems
Message-Id: <20040823082439.46c3c57b.rddunlap@osdl.org>
In-Reply-To: <1093088008.777.13.camel@boxen>
References: <1093088008.777.13.camel@boxen>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Aug 2004 13:33:28 +0200 Alexander Nyberg wrote:

| Using 2.6.8.1-mm3 I ran into some problems on x86_64. This
| only happens when fsck runs at bootup because in my case
| of the max-mount-count being reached (I use ext3). Booting 
| with pci=routeirq makes problem go away.
| 
| Do I win the weird problem prize?

Oops is fixed by this simple patch:

http://marc.theaimsgroup.com/?l=linux-kernel&m=109313574928853&w=2


| Loading modules...
|     e1000
| e1000: Ignoring new-style parameters in presence of obsolete ones
| Intel(R) PRO/1000 Network Driver - version 5.3.19-k2-NAPI
| Copyright (c) 1999-2004 Intel Corporation.
| Unable to handle kernel paging request at 0000000000002000 RIP: 
| <ffffffff8035f090>{add_pin_to_irq+0}
| PML4 3f55d067 PGD 3f77e067 PMD 0 
| Oops: 0002 [1] SMP 
| CPU 0 
| Modules linked in: e1000
| Pid: 121, comm: modprobe Not tainted 2.6.8.1-mm3
| RIP: 0010:[<ffffffff8035f090>] <ffffffff8035f090>{add_pin_to_irq+0}
| RSP: 0018:000001003eff1d40  EFLAGS: 00010216
| RAX: 0000000000002000 RBX: 0000000000000012 RCX: 0000000000008000
| RDX: 0000000000000012 RSI: 0000000000000000 RDI: 0000000000000012
| RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
| R10: 0000000000000000 R11: ffffffff80232fa0 R12: 0000000000000001
| R13: 0000000000000001 R14: 0000000000000012 R15: 0000000000508b70
| FS:  0000002a95ac8380(0000) GS:ffffffff80351d40(0000) knlGS:0000000000000000
| CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
| CR2: 0000000000002000 CR3: 0000000000101000 CR4: 00000000000006e0
| Process modprobe (pid: 121, threadinfo 000001003eff0000, task 000001003f44aa50)
| Stack: ffffffff8011ac90 0000000000010000 0000000000000046 0000000000010000 
|        010000000001a900 000001003ffda200 ffffffffa00115e8 0000000000000012 
|        0000000000000001 0000000000000001 
| Call Trace:<ffffffff8011ac90>{io_apic_set_pci_routing+160} <ffffffff80118b68>{acpi_register_gsi+104} 
|        <ffffffff801e8688>{acpi_pci_irq_enable+413} <ffffffff801cbe26>{pci_enable_device_bars+38} 
|        <ffffffff801cbe55>{pci_enable_device+21} <ffffffffa001408a>{:e1000:e1000_probe+42} 
|        <ffffffff80185346>{d_rehash+118} <ffffffff801cca8f>{pci_device_probe+111} 
|        <ffffffff8020afd7>{bus_match+71} <ffffffff8020b0fb>{driver_attach+75} 
|        <ffffffff8020b490>{bus_add_driver+144} <ffffffff801cc8ce>{pci_register_driver+62} 
|        <ffffffffa001403e>{:e1000:e1000_init_module+62} <ffffffff8014abb9>{sys_init_module+281} 
|        <ffffffff8010e25e>{system_call+126} 
| 
| Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
| RIP <ffffffff8035f090>{add_pin_to_irq+0} RSP <000001003eff1d40>
| CR2: 0000000000002000


--
~Randy
