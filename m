Return-Path: <linux-kernel-owner+w=401wt.eu-S1751207AbXANJmS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751207AbXANJmS (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 04:42:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbXANJmS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 04:42:18 -0500
Received: from www.osadl.org ([213.239.205.134]:52603 "EHLO mail.tglx.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751184AbXANJmR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 04:42:17 -0500
Subject: Re: 2.6.20-rc4-mm1
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com, linux-ide@vger.kernel.org
In-Reply-To: <20070111222627.66bb75ab.akpm@osdl.org>
References: <20070111222627.66bb75ab.akpm@osdl.org>
Content-Type: text/plain
Date: Sun, 14 Jan 2007 10:48:23 +0100
Message-Id: <1168768104.2941.53.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2007-01-11 at 22:26 -0800, Andrew Morton wrote:
> - Merged the "filesystem AIO patches".

Hotfixes alreday applied.

BUG: at /home/tglx/work/kernel/vanilla/linux-2.6.20-rc4-mm1/arch/i386/mm/highmem.c:60 kmap_atomic()
 [<c0105fba>] show_trace_log_lvl+0x1a/0x2f
 [<c01065ff>] show_trace+0x12/0x14
 [<c01066b1>] dump_stack+0x16/0x18
 [<c011fad8>] kmap_atomic+0x12f/0x1c8
 [<f88db29c>] ata_scsi_rbuf_get+0x22/0x37 [libata]
 [<f88db773>] atapi_qc_complete+0x1ee/0x240 [libata]
 [<f88d666b>] __ata_qc_complete+0x86/0x8d [libata]
 [<f88d670a>] ata_qc_complete+0x98/0x9e [libata]
 [<f88d98f4>] ata_qc_complete_multiple+0x8a/0xa4 [libata]
 [<f88b3a2c>] ahci_interrupt+0x2bd/0x3b9 [ahci]
 [<c0154a2d>] handle_IRQ_event+0x21/0x48
 [<c0155971>] handle_edge_irq+0xd1/0x115
 [<c01071af>] do_IRQ+0x6c/0x89
 [<c0105a0b>] common_interrupt+0x23/0x28
 [<c01031c2>] mwait_idle+0xd/0xf
 [<c010343f>] cpu_idle+0xb7/0xf1
 [<c010141d>] rest_init+0x37/0x3a
 [<c04629bd>] start_kernel+0x3cc/0x3ef
 [<00000000>] 0x0

ata_scsi_rbuf_get requests KM_IRQ0 type memory and calls kmap_atomic
with interrupts enabled.

Boot proceeds, but gets stuck hard at:
"Remounting root filesystem in read-write mode:"

No SysRq-T, nothing.

The above BUG seems unrelated to that. Investigating further.

	tglx


