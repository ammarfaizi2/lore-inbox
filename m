Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030260AbWALJtm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030260AbWALJtm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 04:49:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030281AbWALJtl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 04:49:41 -0500
Received: from neptune.fsa.ucl.ac.be ([130.104.233.21]:6649 "EHLO
	neptune.fsa.ucl.ac.be") by vger.kernel.org with ESMTP
	id S1030260AbWALJtl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 04:49:41 -0500
Message-ID: <43C625F5.8070602@246tNt.com>
Date: Thu, 12 Jan 2006 10:48:37 +0100
From: Sylvain Munaut <tnt@246tnt.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050610)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrey Volkov <avolkov@varma-el.com>
CC: ML linuxppc-embedded <linuxppc-embedded@ozlabs.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [kernel-2.6.15] Fix PCI irq mapping for lite5200
References: <43C614A5.6030703@varma-el.com>
In-Reply-To: <43C614A5.6030703@varma-el.com>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: 7bit
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrey,

Andrey Volkov wrote:
> Hi Sylvain,
> 
> This patch fix problem of PCI boards irq mapping on lite5200

What problem is that patch supposed to fix ?
The Lite5200 has a single PCI port, assigned to idsel 24 (afair) and its
INTA is connected to the IRQ0 pin of the 5200 so that looks correct to me.

> (raised after your changes of MPC52xx_IRQ0 number)

I'm not sure I get this either.
Do you mean that change provoked the bug you're talking about or that
before that change the bug was there but just not visible because masked
by the interrupt number being 0 problem ?


	Sylvain

> 
> --
> Regards
> Andrey Volkov
> 
> 
> ------------------------------------------------------------------------
> 
> 	lite5200_map_irq: Fix irq mapping for external PCI boards
> 
> Signed-off-by: Andrey Volkov <avolkov@varma-el.com>
> ---
> 
>  arch/ppc/platforms/lite5200.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/ppc/platforms/lite5200.c b/arch/ppc/platforms/lite5200.c
> index 7ed52dc..cd4acb3 100644
> --- a/arch/ppc/platforms/lite5200.c
> +++ b/arch/ppc/platforms/lite5200.c
> @@ -73,7 +73,8 @@ lite5200_show_cpuinfo(struct seq_file *m
>  static int
>  lite5200_map_irq(struct pci_dev *dev, unsigned char idsel, unsigned char pin)
>  {
> -	return (pin == 1) && (idsel==24) ? MPC52xx_IRQ0 : -1;
> +	/* Only INTA supported */
> +	return (pin == 1) ? MPC52xx_IRQ0 : -1;
>  }
>  #endif
>  

