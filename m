Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261206AbVDMWC6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261206AbVDMWC6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 18:02:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261207AbVDMWC6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 18:02:58 -0400
Received: from fmr21.intel.com ([143.183.121.13]:9173 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S261206AbVDMWCv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 18:02:51 -0400
Date: Wed, 13 Apr 2005 15:02:43 -0700
From: Ashok Raj <ashok.raj@intel.com>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: pc300@cyclades.com, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PC300 pci_enable_device fix
Message-ID: <20050413150243.A26360@unix-os.sc.intel.com>
References: <1113427903.21308.3.camel@eeyore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1113427903.21308.3.camel@eeyore>; from bjorn.helgaas@hp.com on Wed, Apr 13, 2005 at 02:31:43PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2005 at 02:31:43PM -0700, Bjorn Helgaas wrote:
> 
>    Call pci_enable_device() before looking at IRQ and resources.
>    The driver requires this fix or the "pci=routeirq" workaround
>    on 2.6.10 and later kernels.


the failure cases dont seem to worry about pci_disable_device()?

in err_release_ram: etc?

> 
>    Reported and tested by Artur Lipowski.
> 
>    Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
> 
>    ===== drivers/net/wan/pc300_drv.c 1.24 vs edited =====
>    --- 1.24/drivers/net/wan/pc300_drv.c    2004-12-29 12:25:16 -07:00
>    +++ edited/drivers/net/wan/pc300_drv.c  2005-04-13 13:35:21 -06:00
>    @@ -3439,6 +3439,9 @@
>     #endif
>            }
> 
>    +       if ((err = pci_enable_device(pdev)) != 0)
>    +               return err;
>    +
>            card = (pc300_t *) kmalloc(sizeof(pc300_t), GFP_KERNEL);
>            if (card == NULL) {
>                    printk("PC300 found at RAM 0x%08lx, "
>    @@ -3526,9 +3529,6 @@
>                    err = -ENODEV;
>                    goto err_release_ram;
>            }
>    -
>    -       if ((err = pci_enable_device(pdev)) != 0)
>    -               goto err_release_sca;
> 
>                  card->hw.plxbase       =       ioremap(card->hw.plxphys,
>    card->hw.plxsize);
>                  card->hw.rambase       =       ioremap(card->hw.ramphys,
>    card->hw.alloc_ramsize);
> 
>    -
>    To   unsubscribe   from   this   list:   send  the  line  "unsubscribe
>    linux-kernel" in
>    the body of a message to majordomo@vger.kernel.org
>    More majordomo info at  [1]http://vger.kernel.org/majordomo-info.html
>    Please read the FAQ at  [2]http://www.tux.org/lkml/
> 
> References
> 
>    1. http://vger.kernel.org/majordomo-info.html
>    2. http://www.tux.org/lkml/

-- 
Cheers,
Ashok Raj
- Open Source Technology Center
