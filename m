Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261566AbUKSVHm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261566AbUKSVHm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 16:07:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261567AbUKSVHb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 16:07:31 -0500
Received: from fmr99.intel.com ([192.55.52.32]:32422 "EHLO
	hermes-pilot.fm.intel.com") by vger.kernel.org with ESMTP
	id S261566AbUKSVG4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 16:06:56 -0500
Subject: Re: 2.6.10-rc2 doesn't boot (if no floppy device)
From: Len Brown <len.brown@intel.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Chris Wright <chrisw@osdl.org>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20041119191156.GA2754@stusta.de>
References: <F7DC2337C7631D4386A2DF6E8FB22B30020B7225@hdsmsx401.amr.corp.intel.com>
	 <20041119155705.GA2766@stusta.de>
	 <Pine.LNX.4.58.0411190935210.2222@ppc970.osdl.org>
	 <20041119191156.GA2754@stusta.de>
Content-Type: text/plain
Organization: 
Message-Id: <1100898339.993.136.camel@d845pe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 19 Nov 2004 16:05:39 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-11-19 at 14:11, Adrian Bunk wrote:

> Kernel command line: BOOT_IMAGE=test ro root=301 mode=1280x1024@760
> apic=debug acpi_dbg_level=1

> ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 *6 7 10 11 12 14 15)

> elevator: using cfq as default io scheduler
> irq 6: nobody cared!
>  ...
>  =======================
>  [<c012ba55>] irq_exit+0x35/0x40
>  [<c01040d5>] do_IRQ+0x45/0x60
>  [<c010271a>] common_interrupt+0x1a/0x20
>  [<c012be74>] setup_irq+0x94/0x110
>  [<c0258300>] floppy_hardint+0x0/0x120
>  [<c012c07c>] request_irq+0x7c/0xb0
>  [<c02584df>] fd_request_irq+0x2f/0x60
>  [<c025edab>] floppy_grab_irq_and_dma+0x4b/0x3b0
>  [<c044ec5c>] floppy_init+0x1ec/0x5b0
>  [<c025ece0>] floppy_find+0x0/0x80
>  [<c043c813>] do_initcalls+0x53/0xb0
>  [<c0100400>] init+0x0/0x110
>  [<c0100400>] init+0x0/0x110
>  [<c010042a>] init+0x2a/0x110
>  [<c0100818>] kernel_thread_helper+0x0/0x18
>  [<c010081d>] kernel_thread_helper+0x5/0x18
> handlers:
> [<c0258300>] (floppy_hardint+0x0/0x120)
> Disabling IRQ #6
> floppy0: no floppy controllers found
> loop: loaded (max 8 devices)
> sis900.c: v1.08.07 11/02/2003
> ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 6
> PCI: setting IRQ 6 as level-triggered
> ACPI: PCI interrupt 0000:00:04.0[A] -> GSI 6 (level, low) -> IRQ 6
> eth0: Realtek RTL8201 PHY transceiver found at address 1.
> eth0: Using transceiver found at address 1 as default
> eth0: SiS 900 PCI Fast Ethernet at 0xdc00, IRQ 6, 00:00:00:00:00:00.
...


Please verify that the patch is applied and working by
excluding acpi_dbg_level=1 from the cmdline and verifying
that you get some new "NOT disabled" lines in the dmesg.

Please restore the IOAPIC support so we get the print_PIC
lines back per the original debug patch, and boot with
"nolapic" "apic=debug" "pci=routeirq"
and send along the dmesg.  This will tell us about
the state of IRQ6 when we get it from the BIOS
and how Linux changes it.

Also, if you can send or point me the output from acpidmp,
available in /usr/sbin or in pmtools:
http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/utils/
I'd like to examine the ASL associated with the
interrupt link that is camped on IRQ6.

thanks,
-Len

ps. In addition to soft-power-off, I expect that ACPI is required
to enable IOAPIC support on this system.



