Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266137AbUI0XAm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266137AbUI0XAm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 19:00:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267424AbUI0XAm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 19:00:42 -0400
Received: from smtp06.auna.com ([62.81.186.16]:51159 "EHLO smtp06.retemail.es")
	by vger.kernel.org with ESMTP id S266137AbUI0XA3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 19:00:29 -0400
Date: Mon, 27 Sep 2004 23:00:28 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: 2.6.9-rc2-mm4 e100 enable_irq unbalanced from
To: linux-kernel@vger.kernel.org
References: <1096313095.2601.20.camel@deimos.microgate.com>
In-Reply-To: <1096313095.2601.20.camel@deimos.microgate.com> (from
	paulkf@microgate.com on Mon Sep 27 21:24:55 2004)
X-Mailer: Balsa 2.2.4
Message-Id: <1096326028l.5222l.0l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2004.09.27, Paul Fulghum wrote:
> The e100 module is generating a warning:
> 
> Sep 27 13:30:29 deimos kernel: e100: Intel(R) PRO/100 Network Driver, 3.1.4-NAPI
> Sep 27 13:30:29 deimos kernel: e100: Copyright(c) 1999-2004 Intel Corporation
> Sep 27 13:30:29 deimos kernel: e100: eth0: e100_probe: addr 0xfecfc000, irq 16, MAC addr 00:90:27:3A:C5:E3
> Sep 27 13:30:29 deimos kernel: enable_irq(16) unbalanced from ec83ff33
> Sep 27 13:30:29 deimos kernel:  [<c010923f>] enable_irq+0xcf/0xe0
> Sep 27 13:30:29 deimos kernel:  [<ec83ff33>] e100_up+0xf3/0x1f0 [e100]
> Sep 27 13:30:29 deimos kernel:  [<ec83ff33>] e100_up+0xf3/0x1f0 [e100]
> Sep 27 13:30:29 deimos kernel:  [<ec83f410>] e100_intr+0x0/0x140 [e100]
> Sep 27 13:30:29 deimos kernel:  [<ec841131>] e100_open+0x31/0x80 [e100]
> Sep 27 13:30:29 deimos kernel:  [<c0318d4c>] dev_open+0x8c/0xa0
> Sep 27 13:30:29 deimos kernel:  [<c031cc74>] dev_mc_upload+0x24/0x40
> Sep 27 13:30:29 deimos kernel:  [<c031a4ea>] dev_change_flags+0x12a/0x150
> Sep 27 13:30:29 deimos kernel:  [<c0318c0d>] dev_load+0x2d/0x80
> Sep 27 13:30:29 deimos kernel:  [<c0355b37>] devinet_ioctl+0x277/0x730
> 

Just a 'me-too', with a slightly different oops:

e100: Intel(R) PRO/100 Network Driver, 3.1.4-NAPI
e100: Copyright(c) 1999-2004 Intel Corporation
ACPI: PCI interrupt 0000:00:0d.0[A] -> GSI 19 (level, low) -> IRQ 185
e100: eth0: e100_probe: addr 0xf7161000, irq 185, MAC addr 00:30:48:41:22:9F
enable_irq(185) unbalanced from f89b3e25
 [<c0108973>] enable_irq+0xa3/0xf0
 [<f89b3e25>] e100_up+0xd5/0x1e0 [e100]
 [<f89b3e25>] e100_up+0xd5/0x1e0 [e100]
 [<f89b4e9a>] e100_open+0x2a/0x90 [e100]
 [<c0368a24>] dev_open+0x74/0x90
 [<c0369f66>] dev_change_flags+0x56/0x130
 [<c03a2f42>] devinet_ioctl+0x5f2/0x6a0
 [<c03a4e5f>] inet_ioctl+0xdf/0x100
 [<c0360563>] sock_ioctl+0x1b3/0x270
 [<c015a709>] fget+0x49/0x60
 [<c016b905>] sys_ioctl+0x205/0x270
 [<c0105b0d>] sysenter_past_esp+0x52/0x71
e100: eth0: e100_watchdog: link up, 100Mbps, full-duplex

--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandrakelinux release 10.1 (Community) for i586
Linux 2.6.9-rc2-mm4 (gcc 3.4.1 (Mandrakelinux (Alpha 3.4.1-3mdk)) #2


