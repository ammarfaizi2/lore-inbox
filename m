Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264941AbTLKNZa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 08:25:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264935AbTLKNZ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 08:25:28 -0500
Received: from anor.ics.muni.cz ([147.251.4.35]:18378 "EHLO anor.ics.muni.cz")
	by vger.kernel.org with ESMTP id S264937AbTLKNZT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 08:25:19 -0500
Date: Thu, 11 Dec 2003 14:25:08 +0100
From: Jan Kasprzak <kas@informatics.muni.cz>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PPP over ttyUSB (visor.o, Treo)
Message-ID: <20031211142508.X26728@fi.muni.cz>
References: <20031210165540.B26394@fi.muni.cz> <20031210212807.GA8784@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20031210212807.GA8784@kroah.com>; from greg@kroah.com on Wed, Dec 10, 2003 at 01:28:07PM -0800
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
: 
: Can you try the patch below?  I think it will fix the problem.
: 
	Well, it fixes the problem (pppd connects, and works OK),
but the kernel complains about badness in local_bh_enable.

	Full syslog is at http://www.fi.muni.cz/~kas/tmp/visor-mesages.txt,
kernel config is at http://www.fi.muni.cz/~kas/tmp/visor-kconfig.txt.
Any other info I should add?

	Thanks?

-Yenya

Dec 11 13:04:21 nisus kernel: PPP generic driver version 2.4.2
Dec 11 13:04:21 nisus pppd[1943]: pppd 2.4.1 started by root, uid 0
Dec 11 13:04:21 nisus pppd[1943]: Using interface ppp0
Dec 11 13:04:21 nisus pppd[1943]: Connect: ppp0 <--> /dev/ttyUSB1
Dec 11 13:04:21 nisus kernel: Badness in local_bh_enable at kernel/softirq.c:121Dec 11 13:04:21 nisus kernel: Call Trace:
Dec 11 13:04:21 nisus kernel:  [<c011e8b4>] local_bh_enable+0x70/0x72
Dec 11 13:04:21 nisus kernel:  [<de9e9ee2>] ppp_async_input+0x2de/0x583 [ppp_async]
Dec 11 13:04:21 nisus kernel:  [<de9e9396>] ppp_asynctty_receive+0x4b/0x8a [ppp_async]
Dec 11 13:04:21 nisus kernel:  [<c01c1924>] flush_to_ldisc+0x7d/0xce
Dec 11 13:04:21 nisus kernel:  [<de9dd7f5>] visor_read_bulk_callback+0x131/0x2a7 [visor]
Dec 11 13:04:21 nisus kernel:  [<c021e785>] usb_hcd_giveback_urb+0x25/0x39
Dec 11 13:04:21 nisus kernel:  [<de9d08a3>] uhci_finish_completion+0x48/0x5f [uhci_hcd]
Dec 11 13:04:21 nisus kernel:  [<c021e7cf>] usb_hcd_irq+0x36/0x5f
Dec 11 13:04:21 nisus kernel:  [<c010a6be>] handle_IRQ_event+0x3a/0x64
Dec 11 13:04:21 nisus kernel:  [<c010a97e>] do_IRQ+0x6f/0xdf
Dec 11 13:04:21 nisus kernel:  [<c0105000>] rest_init+0x0/0x27
Dec 11 13:04:21 nisus kernel:  [<c0109140>] common_interrupt+0x18/0x20
Dec 11 13:04:21 nisus kernel:  [<c0105000>] rest_init+0x0/0x27
Dec 11 13:04:21 nisus kernel:  [<de89d23e>] acpi_processor_idle+0xd5/0x1c7 [processor]
Dec 11 13:04:21 nisus kernel:  [<c0105000>] rest_init+0x0/0x27
Dec 11 13:04:21 nisus kernel:  [<c010709f>] cpu_idle+0x2c/0x35
Dec 11 13:04:21 nisus kernel:  [<c036a64d>] start_kernel+0x13f/0x14a
Dec 11 13:04:21 nisus kernel:  [<c036a3ea>] unknown_bootoption+0x0/0xfd
Dec 11 13:04:21 nisus kernel:
-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/   Czech Linux Homepage: http://www.linux.cz/ |
|  I actually have a lot of admiration and respect for the PATA knowledge  |
| embedded in drivers/ide. But I would never call it pretty:) -Jeff Garzik |
