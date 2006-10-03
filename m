Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030630AbWJCWhr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030630AbWJCWhr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 18:37:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030633AbWJCWhr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 18:37:47 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:8582 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030630AbWJCWhq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 18:37:46 -0400
Message-ID: <4522E637.9090103@garzik.org>
Date: Tue, 03 Oct 2006 18:37:43 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Frederik Deweerdt <deweerdt@free.fr>
CC: linux-kernel@vger.kernel.org, arjan@infradead.org, matthew@wil.cx,
       alan@lxorguk.ukuu.org.uk, akpm@osdl.org, rdunlap@xenotime.net,
       gregkh@suse.de
Subject: Re: [RFC PATCH] move tg3 to pci_request_irq
References: <20061003220732.GE2785@slug> <20061003222223.GH2785@slug>
In-Reply-To: <20061003222223.GH2785@slug>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frederik Deweerdt wrote:
> Hi,
> 
> This proof-of-concept patch converts the tg3 driver to use the
> pci_request_irq() function.
> 
> Please note that I'm not submitting the driver changes, they're there
> only for illustration purposes. I'll CC the appropriate maintainers
> when/if an API is agreed upon.
> 
> Regards,
> Frederik 
> 
> diff --git a/drivers/net/tg3.c b/drivers/net/tg3.c
> index c25ba27..23660c6 100644
> Index: 2.6.18-mm3/drivers/net/tg3.c
> ===================================================================
> --- 2.6.18-mm3.orig/drivers/net/tg3.c
> +++ 2.6.18-mm3/drivers/net/tg3.c
> @@ -6853,7 +6853,7 @@ static int tg3_request_irq(struct tg3 *t
>  			fn = tg3_interrupt_tagged;
>  		flags = IRQF_SHARED | IRQF_SAMPLE_RANDOM;
>  	}
> -	return (request_irq(tp->pdev->irq, fn, flags, dev->name, dev));
> +	return pci_request_irq(tp->pdev, fn, flags, dev->name);
>  }
>  
>  static int tg3_test_interrupt(struct tg3 *tp)
> @@ -6866,10 +6866,10 @@ static int tg3_test_interrupt(struct tg3
>  
>  	tg3_disable_ints(tp);
>  
> -	free_irq(tp->pdev->irq, dev);
> +	pci_free_irq(tp->pdev);
>  
> -	err = request_irq(tp->pdev->irq, tg3_test_isr,
> -			  IRQF_SHARED | IRQF_SAMPLE_RANDOM, dev->name, dev);
> +	err = pci_request_irq(tp->pdev, tg3_test_isr,
> +			      IRQF_SHARED | IRQF_SAMPLE_RANDOM, dev->name);

IRQF_SHARED flags are still left hanging around...


