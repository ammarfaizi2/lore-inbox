Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267435AbUJOIh1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267435AbUJOIh1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 04:37:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267186AbUJOIh1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 04:37:27 -0400
Received: from NEUROSIS.MIT.EDU ([18.95.3.133]:5760 "EHLO neurosis.jim.sh")
	by vger.kernel.org with ESMTP id S266611AbUJOIhY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 04:37:24 -0400
Date: Fri, 15 Oct 2004 04:37:22 -0400
From: Jim Paris <jim@jtan.com>
To: linux-kernel@vger.kernel.org
Subject: PCI IRQ problems: "nobody cared!"
Message-ID: <20041015083722.GA3315@jim.sh>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm having some strange PCI IRQ problems on my new laptop (Panasonic
Toughbook CF-M34UTVZKM) under 2.6.8-1-686 (Debian).  I'm at a loss to
figure out their source, other than the fact that Toughbooks seem to
have a particularly crappy BIOS.

The errors are something like this (taken from default.txt, link below):
irq 9: nobody cared!
 [<c010841a>] __report_bad_irq+0x2a/0x90
 [<c0108510>] note_interrupt+0x70/0xb0
 [<c01087f0>] do_IRQ+0x120/0x130
 [<c0106a20>] common_interrupt+0x18/0x20
 [<c01200fe>] __do_softirq+0x2e/0x80
 [<c01b3b60>] acpi_irq+0x0/0x16
 [<c0120177>] do_softirq+0x27/0x30
 [<c01087cb>] do_IRQ+0xfb/0x130
 [<c0106a20>] common_interrupt+0x18/0x20
 [<c02124a2>] pci_conf1_write+0x92/0xf0
 [<c01b3e86>] acpi_os_write_pci_configuration+0x69/0x76
...

It seems that once some particular piece of PCI hardware gets
initialized, it causes a flood of unexpected interrupts.  The kernel
then disables IRQ 9, which basically breaks most of my devices because
that's the one they all share.

I captured the following boots for different command lines.  The ACPI
and non-ACPI cases die at different points, but with the same result.

root=/dev/hda1 ro console=ttyS0,115200n8
   https://jim.sh/svn/jim/devl/toughbook/log/default.txt

root=/dev/hda1 ro console=ttyS0,115200n8 acpi=off
   https://jim.sh/svn/jim/devl/toughbook/log/acpioff.txt

root=/dev/hda1 ro console=ttyS0,115200n8 acpi=off pci=usepirqmask
   https://jim.sh/svn/jim/devl/toughbook/log/usepirqmask.txt

lspci, lspci -vxxxn, and /proc/interrupts:
   https://jim.sh/svn/jim/devl/toughbook/log/lspci.txt

Could someone who knows more than me about PCI IRQs take a quick look
at those dumps and tell me if there's anything obvious that I'm
missing, or some way to work around the problem?

-jim
