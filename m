Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261729AbUKIWXQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261729AbUKIWXQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 17:23:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261717AbUKIWXQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 17:23:16 -0500
Received: from smtp07.auna.com ([62.81.186.17]:61363 "EHLO smtp07.retemail.es")
	by vger.kernel.org with ESMTP id S261711AbUKIWWy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 17:22:54 -0500
Date: Tue, 09 Nov 2004 22:22:30 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: [patch] e100 and shared interrupts [was: Spurious interrupts
 when SCI shared with e100]
To: linux-kernel@vger.kernel.org
References: <20041108115955.1c8bf10f.us15@os.inf.tu-dresden.de>
	<418FDD0A.5010308@akamai.com>
In-Reply-To: <418FDD0A.5010308@akamai.com> (from pswain@akamai.com on Mon
	Nov  8 21:54:34 2004)
X-Mailer: Balsa 2.2.5
Message-Id: <1100038950l.6523l.0l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2004.11.08, peter swain wrote:
> Udo A. Steinberg wrote:
> 
> >My laptop has IRQ9 configured as ACPI SCI. When IRQ9 is shared between ACPI
> >and e100 an IRQ9 storm occurs when e100 is enabled, as can be seen in the
> >dmesg output below. The kernel then disables IRQ9, thus preventing e100 from
> >working properly. The problem does not occur, if I override the default PCI
> >steering in the BIOS, e.g. by routing LNKA to IRQ11.
> >
> >Nonetheless it would be good if someone could figure out why sharing IRQ9 
> >is problematic.
> >  
> >
> Udo, please try the attached 2.6.9 patch.
> 

With this patch, I still get things like this:

Nov  9 22:24:14 nada kernel: e100: Intel(R) PRO/100 Network Driver, 3.2.3-k2-NAPI
Nov  9 22:24:14 nada kernel: e100: Copyright(c) 1999-2004 Intel Corporation
Nov  9 22:24:14 nada kernel: ACPI: PCI interrupt 0000:00:0d.0[A] -> GSI 19 (level, low) -> IRQ 185
Nov  9 22:24:14 nada kernel: e100: eth0: e100_probe: addr 0xf7161000, irq 185, MAC addr 00:30:48:41:22:9F
Nov  9 22:24:14 nada kernel: Badness in enable_irq at kernel/irq/manage.c:106
Nov  9 22:24:14 nada kernel:  [enable_irq+178/256] enable_irq+0xb2/0x100
Nov  9 22:24:14 nada kernel:  [<b0136aa2>] enable_irq+0xb2/0x100
Nov  9 22:24:14 nada kernel:  [pg0+1078951656/1337152512] e100_up+0xe8/0x1f0 [e100]
Nov  9 22:24:14 nada kernel:  [<f09c0ee8>] e100_up+0xe8/0x1f0 [e100]
Nov  9 22:24:14 nada kernel:  [pg0+1078955962/1337152512] e100_open+0x2a/0x90 [e100]
Nov  9 22:24:14 nada kernel:  [<f09c1fba>] e100_open+0x2a/0x90 [e100]
Nov  9 22:24:14 nada kernel:  [dev_open+116/144] dev_open+0x74/0x90
Nov  9 22:24:14 nada kernel:  [<b02f1b74>] dev_open+0x74/0x90
Nov  9 22:24:14 nada kernel:  [dev_change_flags+86/304] dev_change_flags+0x56/0x130
Nov  9 22:24:14 nada kernel:  [<b02f3056>] dev_change_flags+0x56/0x130
Nov  9 22:24:14 nada kernel:  [devinet_ioctl+1522/1696] devinet_ioctl+0x5f2/0x6a0
Nov  9 22:24:14 nada kernel:  [<b032cd72>] devinet_ioctl+0x5f2/0x6a0
Nov  9 22:24:14 nada kernel:  [inet_ioctl+223/256] inet_ioctl+0xdf/0x100
Nov  9 22:24:14 nada kernel:  [<b032ec7f>] inet_ioctl+0xdf/0x100
Nov  9 22:24:14 nada kernel:  [sock_ioctl+435/624] sock_ioctl+0x1b3/0x270
Nov  9 22:24:14 nada kernel:  [<b02e9163>] sock_ioctl+0x1b3/0x270
Nov  9 22:24:14 nada kernel:  [fget+73/96] fget+0x49/0x60
Nov  9 22:24:14 nada kernel:  [<b0156f59>] fget+0x49/0x60
Nov  9 22:24:14 nada kernel:  [sys_ioctl+517/624] sys_ioctl+0x205/0x270
Nov  9 22:24:14 nada kernel:  [<b0168185>] sys_ioctl+0x205/0x270
Nov  9 22:24:14 nada kernel:  [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
Nov  9 22:24:14 nada kernel:  [<b0105add>] sysenter_past_esp+0x52/0x71
Nov  9 22:24:14 nada kernel: e100: eth0: e100_watchdog: link up, 100Mbps, full-duplex


--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandrakelinux release 10.2 (Cooker) for i586
Linux 2.6.9-jam1 (gcc 3.4.1 (Mandrakelinux 10.1 3.4.1-4mdk)) #10


