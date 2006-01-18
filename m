Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030361AbWARVba@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030361AbWARVba (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 16:31:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030473AbWARVba
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 16:31:30 -0500
Received: from mail.kroah.org ([69.55.234.183]:10148 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1030361AbWARVb3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 16:31:29 -0500
Date: Wed, 18 Jan 2006 13:29:01 -0800
From: Greg KH <greg@kroah.com>
To: David Brownell <david-b@pacbell.net>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: ehci calling put_device from irq handler
Message-ID: <20060118212901.GA8923@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We can not call put_device() from irq context :(

I added a "might_sleep()" to the driver core and get the following from
the ehci driver.  Any thoughts?

thanks,

greg k-h


Debug: sleeping function called from invalid context at drivers/base/core.c:343
in_atomic():1, irqs_disabled():0
 [<c012006d>] __might_sleep+0x9e/0xa6
 [<c0270400>] put_device+0x1c/0x35
 [<f883ebde>] usb_hcd_giveback_urb+0x23/0x84 [usbcore]
 [<f8820f40>] ehci_urb_done+0x8d/0xcf [ehci_hcd]
 [<f8821138>] qh_completions+0x1b6/0x359 [ehci_hcd]
 [<f882208d>] scan_async+0x8a/0x13f [ehci_hcd]
 [<f8824e77>] ehci_work+0x59/0xd2 [ehci_hcd]
 [<f88255d7>] ehci_irq+0x185/0x336 [ehci_hcd]
 [<c0106a10>] do_gettimeofday+0x1e/0xbf
 [<c0127ae5>] getnstimeofday+0x14/0x2a
 [<c0139f6c>] ktime_get_ts+0x5e/0x66
 [<c0139ea3>] ktime_get+0x1b/0x43
 [<c013a521>] hrtimer_run_queues+0x50/0xf9
 [<f883ec6f>] usb_hcd_irq+0x30/0x68 [usbcore]
 [<c0144b18>] handle_IRQ_event+0x39/0x6d
 [<c0144bd4>] __do_IRQ+0x88/0xfc
 [<c0105789>] do_IRQ+0x19/0x24
 [<c0103b82>] common_interrupt+0x1a/0x20
 [<c01012a5>] mwait_idle+0x2a/0x34
 [<c0101103>] cpu_idle+0x7f/0xb4
 [<c041e898>] start_kernel+0x166/0x17f
 [<c041e2b6>] unknown_bootoption+0x0/0x1e0
