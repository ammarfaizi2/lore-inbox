Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266831AbUHCUAn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266831AbUHCUAn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 16:00:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266825AbUHCUAg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 16:00:36 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:45764 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S266810AbUHCUAe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 16:00:34 -0400
Date: Tue, 3 Aug 2004 21:57:44 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Andrew Morton <akpm@osdl.org>, ecd@atecom.com, chas@cmf.nrl.navy.mil,
       linux-atm-general@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] idt77252.c: add missing pci_enable_device()
Message-ID: <20040803215744.A11997@electric-eye.fr.zoreil.com>
References: <200408031350.21349.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200408031350.21349.bjorn.helgaas@hp.com>; from bjorn.helgaas@hp.com on Tue, Aug 03, 2004 at 01:50:21PM -0600
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bjorn Helgaas <bjorn.helgaas@hp.com> :
[...]
> ===== drivers/atm/idt77252.c 1.24 vs edited =====
> --- 1.24/drivers/atm/idt77252.c	2004-07-12 02:01:05 -06:00
> +++ edited/drivers/atm/idt77252.c	2004-07-30 13:45:42 -06:00
> @@ -3684,6 +3684,11 @@
>  	int i;
>  
>  
> +	if (pci_enable_device(pcidev)) {
> +		printk("idt77252: can't enable PCI device at %s\n", pci_name(pcidev));
> +		return -ENODEV;
> +	}
> +
>  	if (pci_read_config_word(pcidev, PCI_REVISION_ID, &revision)) {
>  		printk("idt77252-%d: can't read PCI_REVISION_ID\n", index);
>  		return -ENODEV;

It should be balanced by pci_disable_device() on close + error path.

--
Ueimor
