Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264002AbTIITDz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 15:03:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263968AbTIITDz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 15:03:55 -0400
Received: from ns.suse.de ([195.135.220.2]:27607 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264252AbTIITDc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 15:03:32 -0400
To: David Mansfield <lkml@dm.cobite.com>
Cc: acpi-devel@lists.sourceforge.net, <linux-kernel@vger.kernel.org>,
       akpm@osdl.org
Subject: Re: ACPI kernel panic at boot on 2.6.0-test5-mm1
References: <Pine.LNX.4.44.0309091420000.1412-100000@sol.cobite.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 09 Sep 2003 21:03:28 +0200
In-Reply-To: <Pine.LNX.4.44.0309091420000.1412-100000@sol.cobite.com.suse.lists.linux.kernel>
Message-ID: <p734qzlkcn3.fsf@oldwotan.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Mansfield <lkml@dm.cobite.com> writes:

> at acpi_pci_link_calc_penalties

Try this (untested) patch

(2.6 version untested, I tested a similar patch on the 2.4 backport of
ACPI):

--- linux-2.6.0test5-work/arch/i386/pci/acpi.c-o	2003-08-23 13:03:09.000000000 +0200
+++ linux-2.6.0test5-work/arch/i386/pci/acpi.c	2003-09-09 21:01:49.000000000 +0200
@@ -15,10 +15,11 @@
 
 static int __init pci_acpi_init(void)
 {
+	extern int acpi_disabled;
 	if (pcibios_scanned)
 		return 0;
 
-	if (!(pci_probe & PCI_NO_ACPI_ROUTING)) {
+	if (!(pci_probe & PCI_NO_ACPI_ROUTING) && !acpi_disabled) {
 		if (!acpi_pci_irq_init()) {
 			printk(KERN_INFO "PCI: Using ACPI for IRQ routing\n");
 			printk(KERN_INFO "PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'\n");


-Andi
