Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265112AbUELPab@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265112AbUELPab (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 11:30:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265113AbUELPaa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 11:30:30 -0400
Received: from email-out1.iomega.com ([147.178.1.82]:13793 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S265114AbUELP3V
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 11:29:21 -0400
Subject: oops ACPI in Linux-2.6.6-bk1
From: Pat LaVarre <p.lavarre@ieee.org>
To: kernelnewbies@nl.linux.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1084375733.3077.2.camel@patibmrh9>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 12 May 2004 09:28:53 -0600
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 May 2004 15:29:17.0791 (UTC) FILETIME=[E3B4B6F0:01
	C43835]
X-imss-version: 2.0
X-imss-result: Passed
X-imss-scores: Clean:5.46240 C:20 M:1 S:5 R:5
X-imss-settings: Baseline:1 C:1 M:1 S:1 R:1 (0.0000 0.0000)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux-2.6.6-bk1 boot chokes here.  Transcribed by hand, with conscious
omissions shown as ... ellipses:

// Trial 5:

schedule+0x608/0x60d
[<c01eef72>] acpi_ev_save_method_info+0x44/0x75
[<c01e94a2>] acpi_os_allocate+0xe/0x11
[<c01f7f59>] acpi_ns_get_next_node+x15/0x4e
... preempt_schedule...
... setup_irq...
... acpi_irq...
... acpi_irq...
... request_irq...
... acpi_os_install_interrupt_handler...
... acpi_irq...
... acpi_irq...
... acpi_ev_install_sci_handler...
... acpi_ev_sci_xrupt_handler...
... acpi_ev_handler_initialize...
... acpi_enable_subsystem...
... acpi_bus_init...
... acpi_init...
... do_initcalls...
... init_workqueues...
[<c0100363>] init+0x62/0x193
[<c0100301>] init+0x0/0x193
[<c01042a9>] kernel_thread_helper+0x5/0xb

// Trial 4:

ACPI: Subsystem revision 20040326
Unable to handle kernel NULL pointer dereferencec01e1194
*pde = 00000000

// Trial 3:

ACPI: Subsystem revision 20040326
Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing

// Trial 2:

ACPI: Subsystem revision 20040326
Unable <o ha1dleUn kernel NULL pointer dereferenceer dereferenceOoops: 
49a0 [#1]

// Trial 1:

ACPI: Subsystem revision 20040326
Unable to handle kernel NULL pointer dereference at virtual address 
00000038
  printing eip:
c0118857
*pde = 00000000
Unable to handle kernel NULL pointer dereference at virtual address 
00000034
  printing eip:
C0107137
*pde = 00000000

// Often before the ACPI line I see:

...
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xf0031, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)

// This is my first experience of any -bk release,
// risked for the sake of the new code of drivers/scsi/libata*

Enjoy, Pat LaVarre


