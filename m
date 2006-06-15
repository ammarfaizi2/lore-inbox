Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030379AbWFOOf2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030379AbWFOOf2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 10:35:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965058AbWFOOf2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 10:35:28 -0400
Received: from anchor-post-31.mail.demon.net ([194.217.242.89]:56075 "EHLO
	anchor-post-31.mail.demon.net") by vger.kernel.org with ESMTP
	id S965056AbWFOOf1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 10:35:27 -0400
Message-ID: <4491702D.2040107@onelan.co.uk>
Date: Thu, 15 Jun 2006 15:35:25 +0100
From: Barry Scott <barry.scott@onelan.co.uk>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc6 does not boot on HP dc7600u - MCFG area is not E820-reserved
References: <44915098.3070404@onelan.co.uk>
In-Reply-To: <44915098.3070404@onelan.co.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Barry Scott wrote:
> I'm trying to boot 2.6.17-rc6 with Mismatched section patches applied.
>
> On my HP dc7600U the last messages printed are:
>
> PCI: BUIS Bug: MCFG area is not E820-reserved
> PCI: Not using MMCONFIG
>
> Googling I found a message about a IBM laptop reporting this message
> but that it did go on to boot. THere was a suggestion that the test 
> should be
> removed. I commented out the code and I can boot further.
>
> Here is the code I patched.
>
> --- arch/i386/pci/mmconfig.c~   2006-06-15 13:04:58.000000000 +0100
> +++ arch/i386/pci/mmconfig.c    2006-06-15 13:04:58.000000000 +0100
> @@ -194,17 +194,19 @@
>        if ((pci_mmcfg_config_num == 0) ||
>            (pci_mmcfg_config == NULL) ||
>            (pci_mmcfg_config[0].base_address == 0))
>                return;
>
> +/* qqq
>        if (!e820_all_mapped(pci_mmcfg_config[0].base_address,
>                        pci_mmcfg_config[0].base_address + 
> MMCONFIG_APER_SIZE,
>                        E820_RESERVED)) {
>                printk(KERN_ERR "PCI: BIOS Bug: MCFG area is not 
> E820-reserved\n");
>                printk(KERN_ERR "PCI: Not using MMCONFIG.\n");
>                return;
>        }
> +qqq */
>
>        printk(KERN_INFO "PCI: Using MMCONFIG\n");
>        raw_pci_ops = &pci_mmcfg;
>        pci_probe = (pci_probe & ~PCI_PROBE_MASK) | PCI_PROBE_MMCONF;
>
> Barry
>
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
Chuck Ebbert's MMCONFIG patch fixes this problem for me.

Barry


