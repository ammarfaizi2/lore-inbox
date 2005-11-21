Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932276AbVKUMmD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932276AbVKUMmD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 07:42:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932279AbVKUMmD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 07:42:03 -0500
Received: from pxy2nd.nifty.com ([202.248.175.14]:999 "HELO pxy2nd.nifty.com")
	by vger.kernel.org with SMTP id S932276AbVKUMmB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 07:42:01 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=pxy2nd-default; d=nifty.com;
  b=b8A9LUzyeon1sj6HO6OjzCI6yAMKlZJAT+YmDzUGJlqouaA+i9w5Ec2IdeObeUTvrHPLKtg1ityMJc7GqXA6yA==  ;
Message-ID: <1988091.1132576919549.komurojun-mbn@nifty.com>
Date: Mon, 21 Nov 2005 21:41:59 +0900 (JST)
From: Komuro <komurojun-mbn@nifty.com>
To: Matthew Wilcox <matthew@wil.cx>
Subject: Re: [PATCH 3/5] Fix pd6729.c on architectures which define NO_IRQ
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E1Ee0G0-0004CL-5E@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: @nifty Webmail 2.0
References: <E1Ee0G0-0004CL-5E@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks for pointing this out!
I have misused the NO_IRQ definition.

Best Regards
Komuro

>
>Use pci_valid_irq() instead of a custom NO_IRQ definition.
>
>Signed-off-by: Matthew Wilcox <matthew@wil.cx>
>Acked-by: Ingo Molnar <mingo@elte.hu>
>
>---
>
> drivers/pcmcia/pd6729.c |    6 +-----
> 1 files changed, 1 insertions(+), 5 deletions(-)
>
>applies-to: 26750e45f268b109d418c91b01a55e124bd879e1
>fd1b59b22f926ee7daa097166d9e7ac6005b1284
>diff --git a/drivers/pcmcia/pd6729.c b/drivers/pcmcia/pd6729.c
>index 20642f0..72720f2 100644
>--- a/drivers/pcmcia/pd6729.c
>+++ b/drivers/pcmcia/pd6729.c
>@@ -39,10 +39,6 @@ MODULE_AUTHOR("Jun Komuro <komurojun-mbn
>  */
> #define to_cycles(ns)	((ns)/120)
> 
>-#ifndef NO_IRQ
>-#define NO_IRQ	((unsigned int)(0))
>-#endif
>-
> /*
>  * PARAMETERS
>  *  irq_mode=n
>@@ -733,7 +729,7 @@ static int __devinit pd6729_pci_probe(st
> 		goto err_out_disable;
> 	}
> 
>-	if (dev->irq == NO_IRQ)
>+	if (!pci_valid_irq(dev->irq))
> 		irq_mode = 0;	/* fall back to ISA interrupt mode */
> 
> 	mask = pd6729_isa_scan();
>---
>0.99.8.GIT

