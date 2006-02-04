Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932386AbWBDWOc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932386AbWBDWOc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 17:14:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932519AbWBDWOc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 17:14:32 -0500
Received: from sorrow.cyrius.com ([65.19.161.204]:38930 "EHLO
	sorrow.cyrius.com") by vger.kernel.org with ESMTP id S932386AbWBDWOb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 17:14:31 -0500
Date: Sat, 4 Feb 2006 22:14:17 +0000
From: Martin Michlmayr <tbm@cyrius.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: jgarzik@pobox.com, linux-kernel@vger.kernel.org
Subject: Re: Bad interaction between uhci_hcd and de2104x
Message-ID: <20060204221416.GA11491@deprecation.cyrius.com>
References: <20060204111521.GB18806@deprecation.cyrius.com> <Pine.LNX.4.44L0.0602041101130.757-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0602041101130.757-100000@netrider.rowland.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Alan Stern <stern@rowland.harvard.edu> [2006-02-04 11:09]:
> It sure looks as though the ethernet interface is generating an
> interrupt request before the de2104x driver has registered its
> interrupt handler.  When uhci-hcd isn't already loaded the IRQ is
> unused, hence disabled, and so nothing bad happens.  If uhci-hcd is
> already loaded then the IRQ is enabled (because uhci-hcd is using
> it), so you get the problem -- an interrupt occurs with no
> registered handler.

Jeff, should I resend my report to the netdev list?

By the way, http://bugs.debian.org/288821 looks like a related issue.
There the traceback indicates interrupts too:

eth0: set link 10baseT auto
eth0:    mode 0x7ffc0040, sia 0x10c4,0xffffef01,0xffffffff,0xffff0008
eth0:    set mode 0x7ffc0040, set sia 0xef01,0xffff,0x8
 [__report_bad_irq+42/144] __report_bad_irq+0x2a/0x90
 [note_interrupt+108/160] note_interrupt+0x6c/0xa0
 [do_IRQ+289/304] do_IRQ+0x121/0x130
 [common_interrupt+24/32] common_interrupt+0x18/0x20
 [__do_softirq+48/128] __do_softirq+0x30/0x80
 [acpi_irq+0/22] acpi_irq+0x0/0x16
 [do_softirq+38/48] do_softirq+0x26/0x30
 [do_IRQ+253/304] do_IRQ+0xfd/0x130
 [common_interrupt+24/32] common_interrupt+0x18/0x20
 [__crc_do_softirq+25311/208152] de_set_rx_mode+0x26/0x50 [de2104x]
 [__crc_do_softirq+28277/208152] de_init_hw+0x8c/0x90 [de2104x]
 [__crc_do_softirq+29105/208152] de_open+0x68/0x140 [de2104x]
 [profile_hook+45/75] profile_hook+0x2d/0x4b
 [dev_open+203/256] dev_open+0xcb/0x100
 [dev_mc_upload+36/80] dev_mc_upload+0x24/0x50
 [dev_change_flags+81/288] dev_change_flags+0x51/0x120
 [devinet_ioctl+582/1424] devinet_ioctl+0x246/0x590
 [inet_ioctl+94/160] inet_ioctl+0x5e/0xa0
 [sock_ioctl+249/688] sock_ioctl+0xf9/0x2b0
 [sys_ioctl+269/656] sys_ioctl+0x10d/0x290
 [syscall_call+7/11] syscall_call+0x7/0xb
eth0: link up, media 10baseT auto

-- 
Martin Michlmayr
http://www.cyrius.com/
