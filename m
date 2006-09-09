Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965016AbWIIXrv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965016AbWIIXrv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 19:47:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965023AbWIIXrv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 19:47:51 -0400
Received: from mxsf21.cluster1.charter.net ([209.225.28.221]:32410 "EHLO
	mxsf21.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S965016AbWIIXrt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 19:47:49 -0400
X-IronPort-AV: i="4.09,137,1157342400"; 
   d="scan'208"; a="670832982:sNHT6250271400"
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17667.21152.289262.612141@smtp.charter.net>
Date: Sat, 9 Sep 2006 19:47:44 -0400
From: "John Stoffel" <john@stoffel.org>
To: "John Stoffel" <john@stoffel.org>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Andrew Morton <akpm@osdl.org>,
       "Miles Lane" <miles.lane@gmail.com>,
       LKML <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org,
       "Brown, Len" <len.brown@intel.com>
Subject: Re: 2.6.18-rc4-mm3 -- ACPI Error (utglobal-0125): Unknown exception code: 0xFFFFFFEA [20060707]
In-Reply-To: <17665.44656.416523.331809@smtp.charter.net>
References: <a44ae5cd0608262356j29c0234cl198fb207bcad383d@mail.gmail.com>
	<20060827001437.ec4f7a7a.akpm@osdl.org>
	<17649.47572.627874.371564@stoffel.org>
	<200609081009.01662.bjorn.helgaas@hp.com>
	<17665.44656.416523.331809@smtp.charter.net>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "John" == John Stoffel <john@stoffel.org> writes:

>>>>> "Bjorn" == Bjorn Helgaas <bjorn.helgaas@hp.com> writes:
Bjorn> On Sunday 27 August 2006 09:27, John Stoffel wrote:
>>> >>>>> "Andrew" == Andrew Morton <akpm@osdl.org> writes:
>>> 
Andrew> On Sat, 26 Aug 2006 23:56:09 -0700
Andrew> "Miles Lane" <miles.lane@gmail.com> wrote:
>>> 
>>> >> PCI: Using ACPI for IRQ routing
>>> >> PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
>>> >> ACPI Error (utglobal-0125): Unknown exception code: 0xFFFFFFEA [20060707]
>>> >> [dump_trace+100/418] dump_trace+0x64/0x1a2
>>> >> [show_trace_log_lvl+18/37] show_trace_log_lvl+0x12/0x25
>>> >> [show_trace+13/16] show_trace+0xd/0x10
>>> >> [dump_stack+23/25] dump_stack+0x17/0x19
>>> >> [acpi_format_exception+162/175] acpi_format_exception+0xa2/0xaf
>>> >> [acpi_ut_status_exit+43/88] acpi_ut_status_exit+0x2b/0x58
>>> >> [acpi_walk_resources+269/281] acpi_walk_resources+0x10d/0x119
>>> >> [acpi_motherboard_add+34/52] acpi_motherboard_add+0x22/0x34
>>> >> [acpi_bus_driver_init+42/122] acpi_bus_driver_init+0x2a/0x7a
>>> >> [acpi_bus_register_driver+137/248] acpi_bus_register_driver+0x89/0xf8
>>> >> [acpi_motherboard_init+23/249] acpi_motherboard_init+0x17/0xf9
>>> >> [init+136/512] init+0x88/0x200
>>> >> [kernel_thread_helper+7/16] kernel_thread_helper+0x7/0x10
>>> >> DWARF2 unwinder stuck at kernel_thread_helper+0x7/0x10

>>> Thanks Andrew.  I just tried doing this with 2.6.18-rc4-mm3 and it
>>> hung again.  I also tried booting with irqpoll and pci=routeirq but it
>>> made no difference at all.  I got the following with irqpoll:
>>> 
>>> irq 17: nobody cared (try booting with the "irqpoll" option)
>>> [<c013e834>] __report_bad_irq+0x24/0x90
>>> [<c013eab8>] note_interrupt+0x218/0x250
>>> [<c013dd43>] handle_IRQ_event+0x33/0x70
>>> [<c013f3ea>] handle_fasteoi_irq+0xca/0xe0
>>> [<c013f320>] handle_fasteoi_irq+0x0/0xe0
>>> [<c01059dd>] do_IRQ+0x8d/0xf0
>>> [<c0554250>] unknown_bootoption+0x0/0x270
>>> [<c01039da>] common_interrupt+0x1a/0x20
>>> [<c0101c40>] default_idle+0x0/0x60
>>> [<c0554250>] unknown_bootoption+0x0/0x270
>>> [<c0101c71>] default_idle+0x31/0x60
>>> [<c0101d0c>] cpu_idle+0x6c/0x90
>>> [<c05547b9>] start_kernel+0x2f9/0x400
>>> [<c0554250>] unknown_bootoption+0x0/0x270
>>> =======================
>>> handlers:
>>> [<c0303890>] (ata_interrupt+0x0/0x190)
>>> [<c03115b0>] (usb_hcd_irq+0x0/0x60)
>>> Disabling IRQ #17

Bjorn> Let's disentangle these two issues.  The ACPI unknown exception in
Bjorn> the acpi_motherboard_init() path is understood and being resolved.

Bjorn, just to let you know, when booting 2.6.18-rc6-mm1, I don't get
this oops any more.  Thanks for your fix!

John
