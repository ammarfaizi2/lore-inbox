Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932354AbWIAIrz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932354AbWIAIrz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 04:47:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932399AbWIAIrz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 04:47:55 -0400
Received: from smtp.osdl.org ([65.172.181.4]:3503 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932354AbWIAIry (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 04:47:54 -0400
Date: Fri, 1 Sep 2006 01:47:45 -0700
From: Andrew Morton <akpm@osdl.org>
To: Johnny Strom <johnny.strom@osp.fi>
Cc: linux-kernel@vger.kernel.org, Chris Wedgwood <cw@f00f.org>
Subject: Re: Patch to make VIA sata board bootable again.
Message-Id: <20060901014745.750e69d1.akpm@osdl.org>
In-Reply-To: <44F7EC15.8040800@osp.fi>
References: <44F7EC15.8040800@osp.fi>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 01 Sep 2006 11:15:17 +0300
Johnny Strom <johnny.strom@osp.fi> wrote:

> 
> 
> Hello
> 
> The quirks.c update that went into 2.6.16.17 made an VIA machine here 
> non bootable from an sata drive (via_sata), the error is:
> 
> "ATA1 qc timout"
> "Failed to set xfermode".

argh.

Does 2.6.18-rc5 work?

> And later kernel panic becouse no sata disk was found.
> I tracked it down to the quirk update in 2.6.16.17. Below is a patch 
> against 2.6.17.11 that reverses the uppdate and makse the system 
> bootable again.
> 
> Another option is to find out the PCI_DEVICE_ID_VIA for the motherboard 
> in question but I could not get that info. Dose someone have an idea how 
> to find that info? then I can provide an patch that adds the right 
> PCI_DEVICE_ID_VIA for my motherboard.
> 
> 
> 
> diff -ur linux-2.6.17.11-org/drivers/pci/quirks.c 
> linux-2.6.17.11/drivers/pci/quirks.c
> --- linux-2.6.17.11-org/drivers/pci/quirks.c	2006-09-01 
> 10:38:31.135747500 +0300
> +++ linux-2.6.17.11/drivers/pci/quirks.c	2006-09-01 10:42:28.870605000 +0300
> @@ -652,13 +652,7 @@
>   		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, new_irq);
>   	}
>   }
> -DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_0, 
> quirk_via_irq);
> -DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_1, 
> quirk_via_irq);
> -DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_2, 
> quirk_via_irq);
> -DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_3, 
> quirk_via_irq);
> -DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686, 
> quirk_via_irq);
> -DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686_4, 
> quirk_via_irq);
> -DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686_5, 
> quirk_via_irq);
> +DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_ANY_ID, quirk_via_irq);
> 

That's wordwrapped.
