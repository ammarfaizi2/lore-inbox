Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263749AbTFDRxb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 13:53:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263752AbTFDRxa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 13:53:30 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:58558 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S263749AbTFDRxQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 13:53:16 -0400
Date: Wed, 04 Jun 2003 10:55:44 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: linux-kernel <linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 774] New: ACPI interrupt storm when ACPI operates in IO-APIC-level mode 
Message-ID: <157730000.1054749344@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=774

           Summary: ACPI interrupt storm when ACPI operates in IO-APIC-level
                    mode
    Kernel Version: 2.5.70 (earlier versions as well)
            Status: NEW
          Severity: normal
             Owner: andrew.grover@intel.com
         Submitter: us15@os.inf.tu-dresden.de


Distribution: Slackware 9.0

Hardware Environment: Tyan Tiger S2723GNN mainboard, 1 GB RAM, two Xeon 2.66 GHz
CPU with Hyperthreading, Bios Version 1.02 (newest)

Software Environment: Unmodified monolithic 2.5.70 Linux kernel, booted with
Lilo 22.5

Problem Description:
During ACPI initialization I get 100 times the following output:

ACPI: Subsystem revision 20030522
 irq 9: nobody cared!
 Call Trace:
  [<c010b4a2>] handle_IRQ_event+0x87/0xf7
  [<c010b758>] do_IRQ+0xbe/0x17b
  [<c0109b78>] common_interrupt+0x18/0x20
  [<c010be45>] setup_irq+0xc3/0xff
  [<c022bb36>] acpi_irq+0x0/0x16
  [<c022bb36>] acpi_irq+0x0/0x16
  [<c010b8be>] request_irq+0xa9/0xde
  [<c022bb86>] acpi_os_install_interrupt_handler+0x3a/0x59
  [<c022bb36>] acpi_irq+0x0/0x16
  [<c022bb36>] acpi_irq+0x0/0x16
  [<c022fb49>] acpi_ev_install_sci_handler+0x1a/0x1e
  [<c022fb0c>] acpi_ev_sci_xrupt_handler+0x0/0x18
  [<c022f58b>] acpi_ev_handler_initialize+0x6/0x6e
  [<c024056e>] acpi_enable_subsystem+0x2b/0x58
  [<c03e964c>] acpi_bus_init+0x7a/0x115
  [<c03e973d>] acpi_init+0x56/0xa6
  [<c03d685a>] do_initcalls+0x28/0x94
  [<c0130660>] init_workqueues+0xf/0x26
  [<c01050c9>] init+0x5a/0x1d1
  [<c010506f>] init+0x0/0x1d1
  [<c0107075>] kernel_thread_helper+0x5/0xb

 handlers:
 [<c022bb36>] (acpi_irq+0x0/0x16)

Additionally the number of ACPI interrupts is excessive, nearly 4.5 million ACPI
interrupts per minute. The machine does not have this problem when running
2.4.21-rc7, where the ACPI interrupt is configured in XT-PIC mode, whereas
2.5.70 configures it to operate in IO-APIC-level mode.

robert.moore@intel.com says it may be due to a missing interrupt source
override for the ACPI SCI interrupt.

The ACPI backport in 2.4.21-ac seems to have a similar problem (see Bug #370)

Steps to reproduce:
Run 2.5.70 on aforementioned board. Alternatively send me patches to try or ask
me for additional information.

