Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266473AbUHSBnS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266473AbUHSBnS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 21:43:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267808AbUHSBnS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 21:43:18 -0400
Received: from smtp102.rog.mail.re2.yahoo.com ([206.190.36.80]:32148 "HELO
	smtp102.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S266473AbUHSBnQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 21:43:16 -0400
From: Shawn Starr <shawn.starr@rogers.com>
Organization: sh0n.net
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: 2.6.8.1-mm1 broke USB driver with ACPI pci irq routing... info follows
Date: Wed, 18 Aug 2004 21:43:10 -0400
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org, Cyrille Ch?p?lov <cyrille@chepelov.org>,
       akpm@osdl.org
References: <200408170257.26712.shawn.starr@rogers.com> <200408172104.30280.shawn.starr@rogers.com> <200408181740.15310.bjorn.helgaas@hp.com>
In-Reply-To: <200408181740.15310.bjorn.helgaas@hp.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408182143.10531.shawn.starr@rogers.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Confirmed, this fixes the oops for USB for me.

Thanks

Shawn.

On August 18, 2004 19:40, Bjorn Helgaas wrote:
> Shawn and Cyrille, can you try the attached patch, please?  We were using
> __initdata from a function that is no longer used only at boot-time.
> I'm pretty sure this will fix Shawn's problem.  I don't know whether
> it'll fix yours, Cyrille, but it might.
>
> Andrew, I think this is clearly a bug independent of my other patches
> in -mm, so could you apply this as well?
>
>
> Make acpi_irq_penalty non-initdata, since it's used by the
> non_init acpi_pci_link_allocate().  And make acpi_irq_penalty_init()
> __init, since it is used only by the __init pci_acpi_init().
>
> Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
>
> ===== drivers/acpi/pci_link.c 1.31 vs edited =====
> --- 1.31/drivers/acpi/pci_link.c	2004-08-04 13:55:16 -06:00
> +++ edited/drivers/acpi/pci_link.c	2004-08-18 17:26:48 -06:00
> @@ -448,7 +448,7 @@
>  #define PIRQ_PENALTY_ISA_USED		(16*16*16*16*16)
>  #define PIRQ_PENALTY_ISA_ALWAYS		(16*16*16*16*16*16)
>
> -static int __initdata acpi_irq_penalty[ACPI_MAX_IRQS] = {
> +static int acpi_irq_penalty[ACPI_MAX_IRQS] = {
>  	PIRQ_PENALTY_ISA_ALWAYS,	/* IRQ0 timer */
>  	PIRQ_PENALTY_ISA_ALWAYS,	/* IRQ1 keyboard */
>  	PIRQ_PENALTY_ISA_ALWAYS,	/* IRQ2 cascade */
> @@ -468,7 +468,7 @@
>  			/* >IRQ15 */
>  };
>
> -int
> +int __init
>  acpi_irq_penalty_init(void)
>  {
>  	struct list_head	*node = NULL;
