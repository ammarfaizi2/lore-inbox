Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266845AbUGLOYV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266845AbUGLOYV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 10:24:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266847AbUGLOYV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 10:24:21 -0400
Received: from charme.mynetix.de ([80.190.251.41]:25050 "EHLO
	charme.mynetix.de") by vger.kernel.org with ESMTP id S266845AbUGLOYM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 10:24:12 -0400
Subject: suspend to disk breaks e100 driver kernel 2.6.7 and 2.6.8-rc1
From: Andreas Kotowicz <koto-lkml@mynetix.de>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1089641949.13037.5.camel@saturn.koto.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 12 Jul 2004 16:23:10 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

whenever I put my notebook into suspend to disk by calling "echo -n disk
> /sys/power/state" my network connection dies.
this is what I get in the logs:

ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 11 (level, low) -> IRQ 11
 ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 11 (level, low) -> IRQ 11
 ACPI: PCI interrupt 0000:00:1f.6[B] -> GSI 11 (level, low) -> IRQ 11
  [<c010741a>] __report_bad_irq+0x2a/0x90
  [<c0107510>] note_interrupt+0x70/0xb0
  [<c01077f0>] do_IRQ+0x120/0x130
  [<c0105a48>] common_interrupt+0x18/0x20
  [<c012007b>] do_sysctl_strategy+0x11b/0x180
  [<e08a7fe5>] e100_xmit_frame+0x1c5/0x2d0 [e100]
  [<c02cb762>] qdisc_restart+0x62/0x130
  [<c02c106f>] net_tx_action+0x9f/0xf0
  [<c011ee9b>] __do_softirq+0x7b/0x80
  [<c011eec7>] do_softirq+0x27/0x30
  [<c01077cb>] do_IRQ+0xfb/0x130
  [<c0105a48>] common_interrupt+0x18/0x20
  [<c0110f04>] delay_pmtmr+0x14/0x20
  [<c01cc6e2>] __delay+0x12/0x20
  [<e08a607d>] e100_hw_reset+0x7d/0xa0 [e100]
  [<e08a6db3>] e100_hw_init+0x13/0x690 [e100]
  [<c0139e4f>] __get_free_pages+0x1f/0x40
  [<c010bdba>] dma_alloc_coherent+0x4a/0x80
  [<e08a8250>] e100_alloc_cbs+0x70/0x160 [e100]
  [<e08a8da1>] e100_up+0x51/0x1d0 [e100]
  [<e08aa858>] e100_resume+0xa8/0xd0 [e100]
  [<c01d0c6a>] pci_device_resume+0x2a/0x30
  [<c022f9f9>] resume_device+0x29/0x30
  [<c022fa6e>] dpm_resume+0x6e/0x70
  [<c022fa89>] device_resume+0x19/0x30
  [<c0133568>] finish+0x8/0x40
  [<c0134545>] pmdisk_free+0x5/0x10
  [<c01336de>] pm_suspend_disk+0x7e/0xc0
  [<c0132b45>] enter_state+0xa5/0xb0
  [<c0132c84>] state_store+0xc4/0xdb
  [<c0187f0a>] subsys_attr_store+0x3a/0x40
  [<c018817b>] flush_write_buffer+0x3b/0x50
  [<c01881f0>] sysfs_write_file+0x60/0x70
  [<c0152e68>] vfs_write+0xb8/0x130
  [<c0152f92>] sys_write+0x42/0x70
  [<c01050db>] syscall_call+0x7/0xb
 e100: eth0: e100_watchdog: link up, 100Mbps, full-duplex
 Restarting tasks... done
 NETDEV WATCHDOG: eth0: transmit timed out
 e100: eth0: e100_watchdog: link up, 100Mbps, full-duplex

Message from syslogd@saturn at Mon Jul 12 16:09:19 2004 ...
saturn kernel: Disabling IRQ #11
 NETDEV WATCHDOG: eth0: transmit timed out
 e100: eth0: e100_watchdog: link up, 100Mbps, full-duplex
 NETDEV WATCHDOG: eth0: transmit timed out

taking the network connection down, removing the modules and reinserting
it, doesn't help. I have to reboot the notebook for the network to work
again.

this didn't happen with kernel 2.6.6 and prior versions.

maybe someone can help,
andreas

