Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261246AbTIKPC7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 11:02:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261288AbTIKPC7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 11:02:59 -0400
Received: from sol.cobite.com ([208.222.80.183]:23680 "EHLO sol.cobite.com")
	by vger.kernel.org with ESMTP id S261246AbTIKPC5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 11:02:57 -0400
Date: Thu, 11 Sep 2003 11:02:41 -0400 (EDT)
From: David Mansfield <lkml@dm.cobite.com>
X-X-Sender: david@sol.cobite.com
To: Andi Kleen <ak@suse.de>
cc: acpi-devel@lists.sourceforge.net, <linux-kernel@vger.kernel.org>,
       <akpm@osdl.org>
Subject: Re: ACPI kernel panic at boot on 2.6.0-test5-mm1
In-Reply-To: <p734qzlkcn3.fsf@oldwotan.suse.de>
Message-ID: <Pine.LNX.4.44.0309111101580.1410-100000@sol.cobite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> David Mansfield <lkml@dm.cobite.com> writes:
> 
> > at acpi_pci_link_calc_penalties
> 
> Try this (untested) patch

Sorry for the delay.  This patch fixes my problems.  I can now boot 
without any command line options.

David


> 
> (2.6 version untested, I tested a similar patch on the 2.4 backport of
> ACPI):
> 
> --- linux-2.6.0test5-work/arch/i386/pci/acpi.c-o	2003-08-23 13:03:09.000000000 +0200
> +++ linux-2.6.0test5-work/arch/i386/pci/acpi.c	2003-09-09 21:01:49.000000000 +0200
> @@ -15,10 +15,11 @@
>  
>  static int __init pci_acpi_init(void)
>  {
> +	extern int acpi_disabled;
>  	if (pcibios_scanned)
>  		return 0;
>  
> -	if (!(pci_probe & PCI_NO_ACPI_ROUTING)) {
> +	if (!(pci_probe & PCI_NO_ACPI_ROUTING) && !acpi_disabled) {
>  		if (!acpi_pci_irq_init()) {
>  			printk(KERN_INFO "PCI: Using ACPI for IRQ routing\n");
>  			printk(KERN_INFO "PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'\n");
> 
> 
> -Andi
> 

-- 
/==============================\
| David Mansfield              |
| lkml@dm.cobite.com           |
\==============================/


