Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932144AbVIGOkj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932144AbVIGOkj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 10:40:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751226AbVIGOkj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 10:40:39 -0400
Received: from mailhub.lss.emc.com ([168.159.2.31]:11706 "EHLO
	mailhub.lss.emc.com") by vger.kernel.org with ESMTP
	id S1751211AbVIGOki (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 10:40:38 -0400
Message-ID: <431EFBD0.1040509@emc.com>
Date: Wed, 07 Sep 2005 10:40:16 -0400
From: Brett Russ <russb@emc.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, hch@infradead.org
Subject: Re: [PATCH 2.6.13] libata: Marvell SATA support (PIO mode)
References: <20050830183625.BEE1520F4C@lns1058.lss.emc.com> <4314C604.4030208@pobox.com> <20050901142754.B93BF27137@lns1058.lss.emc.com> <20050901144038.GA25830@infradead.org> <20050901222617.2455520F96@lns1058.lss.emc.com> <431E8104.2090100@pobox.com>
In-Reply-To: <431E8104.2090100@pobox.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-PMX-Version: 4.7.1.128075, Antispam-Engine: 2.1.0.0, Antispam-Data: 2005.9.7.12
X-PerlMx-Spam: Gauge=, SPAM=7%, Reasons='EMC_FROM_00+ 0, __CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __SANE_MSGID 0, __USER_AGENT 0'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> applied
> 

There are some issues with this.  One of which I fixed and the other is 
a bit confusing.  The one I fixed concerned the 5xxx chips not 
supporting the master reset functionality.  The other problem has been 
reported by 2 people so far.  I have a stack trace from each of them:

Stack 1: (from http://article.gmane.org/gmane.linux.ide/5280)


  PCI: Found IRQ 5 for device 0000:02:08.0
  PCI: Sharing IRQ 5 with 0000:00:1d.0
  IRQ routing conflict for 0000:02:08.0, have irq 9, want irq 5
  ata1: SATA max PIO4 cmd 0x0 ctl 0xF8A22120 bmdma 0x0 irq 9
  ata2: SATA max PIO4 cmd 0x0 ctl 0xF8A24120 bmdma 0x0 irq 9
  ata3: SATA max PIO4 cmd 0x0 ctl 0xF8A26120 bmdma 0x0 irq 9
  ata4: SATA max PIO4 cmd 0x0 ctl 0xF8A28120 bmdma 0x0 irq 9
  Badness in __sata_phy_reset at drivers/scsi/libata-core.c:1413
   [<f88e8f0c>] __sata_phy_reset+0x75/0x12e [libata]
   [<f883f62f>] mv_phy_reset+0xbf/0x11e [sata_mv]
   [<c0250f16>] end_that_request_last+0x6c/0x7e
   [<f883f3bf>] mv_host_intr+0xd6/0x142 [sata_mv]
   [<f883f500>] mv_interrupt+0xd5/0x145 [sata_mv]
   [<c0107e2b>] handle_IRQ_event+0x25/0x4f
   [<c01087d3>] do_IRQ+0x18a/0x2bf
   =======================
   [<c030fb7c>] common_interrupt+0x18/0x20
   [<f883f618>] mv_phy_reset+0xa8/0x11e [sata_mv]
   [<c01091d8>] setup_irq+0x179/0x181
   [<f883f42b>] mv_interrupt+0x0/0x145 [sata_mv]
   [<f88e8e25>] ata_bus_probe+0xe/0x7b [libata]
   [<f88eb34d>] ata_device_add+0x186/0x202 [libata]
   [<f883f97a>] mv_init_one+0x197/0x1d5 [sata_mv]
   [<c01ec15d>] pci_device_probe_static+0x2a/0x3d
   [<c01ec18b>] __pci_device_probe+0x1b/0x2c
   [<c01ec1b7>] pci_device_probe+0x1b/0x2d
   [<c024a33b>] bus_match+0x27/0x45
   [<c024a404>] driver_attach+0x37/0x66
   [<c024a7b9>] bus_add_driver+0x77/0x97
   [<c024abd4>] driver_register+0x51/0x58
   [<c01ec375>] pci_register_driver+0x85/0xa1
   [<f881a00a>] mv_init+0xa/0x15 [sata_mv]
   [<c013d5a3>] sys_init_module+0x1f1/0x2d9
   [<c030fa37>] syscall_call+0x7/0xb
  bad: scheduling while atomic!
   [<c030d515>] schedule+0x2d/0x552
   [<c0107e2b>] handle_IRQ_event+0x25/0x4f
   [<c030e40e>] schedule_timeout+0xf1/0x10c
   [<c012ad7e>] process_timeout+0x0/0x5
   [<f883f082>] mv_scr_read+0xf/0x54 [sata_mv]
   [<c012b498>] msleep+0x4e/0x54
   [<f88e8f3f>] __sata_phy_reset+0xa8/0x12e [libata]
   [<f883f62f>] mv_phy_reset+0xbf/0x11e [sata_mv]
   [<c0250f16>] end_that_request_last+0x6c/0x7e
   [<f883f3bf>] mv_host_intr+0xd6/0x142 [sata_mv]
   [<f883f500>] mv_interrupt+0xd5/0x145 [sata_mv]
   [<c0107e2b>] handle_IRQ_event+0x25/0x4f
   [<c01087d3>] do_IRQ+0x18a/0x2bf
   =======================
   [<c030fb7c>] common_interrupt+0x18/0x20
   [<f883f618>] mv_phy_reset+0xa8/0x11e [sata_mv]
   [<c01091d8>] setup_irq+0x179/0x181
   [<f883f42b>] mv_interrupt+0x0/0x145 [sata_mv]
   [<f88e8e25>] ata_bus_probe+0xe/0x7b [libata]
   [<f88eb34d>] ata_device_add+0x186/0x202 [libata]
   [<f883f97a>] mv_init_one+0x197/0x1d5 [sata_mv]
   [<c01ec15d>] pci_device_probe_static+0x2a/0x3d
   [<c01ec18b>] __pci_device_probe+0x1b/0x2c
   [<c01ec1b7>] pci_device_probe+0x1b/0x2d
   [<c024a33b>] bus_match+0x27/0x45
   [<c024a404>] driver_attach+0x37/0x66
   [<c024a7b9>] bus_add_driver+0x77/0x97
   [<c024abd4>] driver_register+0x51/0x58
   [<c01ec375>] pci_register_driver+0x85/0xa1
   [<f881a00a>] mv_init+0xa/0x15 [sata_mv]
   [<c013d5a3>] sys_init_module+0x1f1/0x2d9
   [<c030fa37>] syscall_call+0x7/0xb



Stack 2: (from off list email)


scheduling while atomic: klogd/0x00010000/1572
  [<c0343524>] schedule+0xab4/0xbf0
  [<c01200bf>] scheduler_tick+0x15f/0x380
  [<c012dbe0>] lock_timer_base+0x20/0x50
  [<c012dcb8>] __mod_timer+0xa8/0xd0
  [<c0343eee>] schedule_timeout+0x4e/0xc0
  [<c012e790>] process_timeout+0x0/0x10
  [<c012ebb0>] msleep+0x30/0x40
  [<f89d914a>] __sata_phy_reset+0x4a/0x120 [libata]
  [<c0114b72>] delay_pmtmr+0x12/0x20
  [<f899051a>] mv_phy_reset+0x7a/0x140 [sata_mv]
  [<c02857f2>] ide_end_request+0x92/0xb0
  [<f899035e>] mv_host_intr+0xce/0x120 [sata_mv]
  [<f8990457>] mv_interrupt+0xa7/0xf0 [sata_mv]
  [<c0149fe3>] handle_IRQ_event+0x33/0x70
  [<c014a0f9>] __do_IRQ+0xd9/0x150
  [<c0106847>] do_IRQ+0x57/0xa0
  =======================
  [<c0104c4a>] common_interrupt+0x1a/0x20
  [<c013007b>] __group_send_sig_info+0x2b/0xd0
  [<c01247f8>] do_syslog+0xe8/0x3e0
  [<c0104cd8>] apic_timer_interrupt+0x1c/0x24
  [<c013a0c0>] autoremove_wake_function+0x0/0x50
  [<c013a0c0>] autoremove_wake_function+0x0/0x50
  [<c01a8090>] kmsg_read+0x0/0x50
  [<c016c368>] vfs_read+0xb8/0x170
  [<c016c701>] sys_read+0x41/0x70
  [<c01041bb>] sysenter_past_esp+0x54/0x75



So it looks like mv_phy_reset() is getting called from interrupt level, 
and it calls __sata_phy_reset() which sleeps.

I only call mv_phy_reset() as part of fatal error interrupt cleanup. 
The chip does take an "error" interrupt upon drive connection but that's 
not fatal.  Either way, mv_phy_reset() is called from mv_err_intr() 
which doesn't appear in either of the stack dumps above.

Possible solutions:
-change __sata_phy_reset() to do a mdelay rather than msleep?
-do the phy_reset part of error recovery after returning from interrupt 
handler?

Thoughts?
BR
