Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262636AbVBYHUN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262636AbVBYHUN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 02:20:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262639AbVBYHUN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 02:20:13 -0500
Received: from main.gmane.org ([80.91.229.2]:8395 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S262636AbVBYHUA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 02:20:00 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Mark McPherson <mark@mahonia.com>
Subject: 2.6.5-rc2-mm5 -- Some
Date: Thu, 24 Feb 2005 23:19:47 -0800
Message-ID: <pan.2004.03.30.06.06.42.430786@mahonia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: mahonia.com
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table (Debian	GNU/Linux))
X-Gmane-MailScanner: Found to be clean
X-Gmane-MailScanner: Found to be clean
X-MailScanner-From: glk-linux-kernel@m.gmane.org
X-MailScanner-To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I have a Shuttle XPC with an nForce2 chipset.

Here's something which shows up in dmesg after booting
2.6.5-rc2-mm5; it does not appear in the Linux tree up through
2.6.5-rc2-bk9. 

My external IEEE1394 drive attaches and detaches and
transfers data without apparent complaint.

Badness in get_phy_reg at drivers/ieee1394/ohci1394.c:238
Call Trace:
 [<f9aab109>] get_phy_reg+0x109/0x110 [ohci1394]
 [<c0109eec>] do_IRQ+0x10c/0x1b0
 [<f9aabe72>] ohci_devctl+0x52/0x5c0 [ohci1394]
 [<c029ba42>] apic_timer_interrupt+0x1a/0x20
 [<f9aadd68>] ohci_irq_handler+0x528/0x7d0 [ohci1394]
 [<c0117abb>] scheduler_tick+0x1b/0x590
 [<c0109b20>] handle_IRQ_event+0x30/0x60
 [<c0109eb0>] do_IRQ+0xd0/0x1b0
 =======================
 [<c0109eec>] do_IRQ+0x10c/0x1b0
 [<c029ba20>] common_interrupt+0x18/0x20
 [<f9aab175>] set_phy_reg+0x65/0x110 [ohci1394]
 [<f9b44a00>] delayed_reset_bus+0x0/0xc0 [ieee1394]
 [<f9aabe86>] ohci_devctl+0x66/0x5c0 [ohci1394]
 [<f9b4c56b>] csr1212_fill_cache+0x8b/0xf0 [ieee1394]
 [<f9b44a00>] delayed_reset_bus+0x0/0xc0 [ieee1394]
 [<f9b4216e>] hpsb_reset_bus+0x1e/0x30 [ieee1394]
 [<c0123613>] run_timer_softirq+0xd3/0x1b0
 [<c011f739>] __do_softirq+0x79/0x80
 [<c010a75f>] do_softirq+0x4f/0x60
 =======================
 [<c0109f35>] do_IRQ+0x155/0x1b0
 [<c029ba20>] common_interrupt+0x18/0x20
 [<c0106593>] default_idle+0x23/0x30
 [<c01065fc>] cpu_idle+0x2c/0x40
 [<c035f8b2>] start_kernel+0x152/0x170
 [<c035f4a0>] unknown_bootoption+0x0/0x110

Badness in set_phy_reg at drivers/ieee1394/ohci1394.c:267
Call Trace:
 [<f9aab212>] set_phy_reg+0x102/0x110 [ohci1394]
 [<f9aabe86>] ohci_devctl+0x66/0x5c0 [ohci1394]
 [<c029ba42>] apic_timer_interrupt+0x1a/0x20
 [<f9aadd68>] ohci_irq_handler+0x528/0x7d0 [ohci1394]
 [<c0117abb>] scheduler_tick+0x1b/0x590
 [<c0109b20>] handle_IRQ_event+0x30/0x60
 [<c0109eb0>] do_IRQ+0xd0/0x1b0
 =======================
 [<c0109eec>] do_IRQ+0x10c/0x1b0
 [<c029ba20>] common_interrupt+0x18/0x20
 [<f9aab175>] set_phy_reg+0x65/0x110 [ohci1394]
 [<f9b44a00>] delayed_reset_bus+0x0/0xc0 [ieee1394]
 [<f9aabe86>] ohci_devctl+0x66/0x5c0 [ohci1394]
 [<f9b4c56b>] csr1212_fill_cache+0x8b/0xf0 [ieee1394]
 [<f9b44a00>] delayed_reset_bus+0x0/0xc0 [ieee1394]
 [<f9b4216e>] hpsb_reset_bus+0x1e/0x30 [ieee1394]
 [<c0123613>] run_timer_softirq+0xd3/0x1b0
 [<c011f739>] __do_softirq+0x79/0x80
 [<c010a75f>] do_softirq+0x4f/0x60
 =======================
 [<c0109f35>] do_IRQ+0x155/0x1b0
 [<c029ba20>] common_interrupt+0x18/0x20
 [<c0106593>] default_idle+0x23/0x30
 [<c01065fc>] cpu_idle+0x2c/0x40
 [<c035f8b2>] start_kernel+0x152/0x170
 [<c035f4a0>] unknown_bootoption+0x0/0x110

ohci1394: fw-host0: SelfID received outside of bus reset sequence


