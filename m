Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262416AbVE0KLn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262416AbVE0KLn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 06:11:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262418AbVE0KLn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 06:11:43 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:22454 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S262416AbVE0KLk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 06:11:40 -0400
Subject: Re: [ACPI] [PATCH] VIA IRQ quirk for 2.6.12-rc5
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Len Brown <lenb@toshiba.hsd1.ma.comcast.net>
Cc: torvalds@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       acpi-devel@lists.sourceforge.net, bjorn.helgaas@hp.com
In-Reply-To: <20050527082150.GA24428@toshiba.hsd1.ma.comcast.net>
References: <20050527082150.GA24428@toshiba.hsd1.ma.comcast.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1117188546.5730.175.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 27 May 2005 11:09:17 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-05-27 at 09:21, Len Brown wrote:
> Delete quirk_via_bridge(), restore quirk_via_irqpic() --
> but now improved to be invoked upon device ENABLE, and
> now only for VIA devices -- not all devices behind VIA bridges.

Properly you should apply the fixup to all VBUS devices. I've not seen a
clean way to identify which devices fall into that category but there
are public 
data sheets for many of the chips.

> +		printk(KERN_INFO "PCI: Via PIC IRQ fixup for %s, from %d to %d\n",
> +			pci_name(dev), irq, new_irq);
> +		udelay(15);	/* unknown if delay really needed */
> +		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, new_irq);

It isn't

