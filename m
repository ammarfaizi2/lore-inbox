Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965379AbWJCHTp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965379AbWJCHTp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 03:19:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965354AbWJCHTp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 03:19:45 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:26292 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965308AbWJCHTn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 03:19:43 -0400
Subject: Re: [RFC PATCH] move tg3 to pci_request_irq
From: Arjan van de Ven <arjan@infradead.org>
To: Frederik Deweerdt <deweerdt@free.fr>
Cc: Matthew Wilcox <matthew@wil.cx>, linux-scsi@vger.kernel.org,
       "Linux-Kernel," <linux-kernel@vger.kernel.org>,
       "J.A. Magall??n" <jamagallon@ono.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       Jeff Garzik <jeff@garzik.org>
In-Reply-To: <20061002201134.GE3003@slug>
References: <1159550143.13029.36.camel@localhost.localdomain>
	 <20060929235054.GB2020@slug>
	 <1159573404.13029.96.camel@localhost.localdomain>
	 <20060930140946.GA1195@slug> <451F049A.1010404@garzik.org>
	 <20061001142807.GD16272@parisc-linux.org>
	 <1159729523.2891.408.camel@laptopd505.fenrus.org>
	 <20061001193616.GF16272@parisc-linux.org>
	 <1159755141.2891.434.camel@laptopd505.fenrus.org>
	 <20061002200048.GC3003@slug>  <20061002201134.GE3003@slug>
Content-Type: text/plain
Organization: Intel International BV
Date: Tue, 03 Oct 2006 09:18:27 +0200
Message-Id: <1159859907.2891.513.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-10-02 at 20:11 +0000, Frederik Deweerdt wrote:
> Hi,
> 
> This proof-of-concept patch converts the tg3 driver to use the
> pci_request_irq() function.
> 
> Regards,
> Frederik
> 
> 
> diff --git a/drivers/net/tg3.c b/drivers/net/tg3.c
> index c25ba27..23660c6 100644
> --- a/drivers/net/tg3.c
> +++ b/drivers/net/tg3.c
> @@ -6838,9 +6838,9 @@ restart_timer:
>  
>  static int tg3_request_irq(struct tg3 *tp)
>  {
> +	struct net_device *dev = tp->dev;
>  	irqreturn_t (*fn)(int, void *, struct pt_regs *);
>  	unsigned long flags;
> -	struct net_device *dev = tp->dev;
>  
>  	if (tp->tg3_flags2 & TG3_FLG2_USING_MSI) {
>  		fn = tg3_msi;
> @@ -6853,7 +6853,7 @@ static int tg3_request_irq(struct tg3 *t
>  			fn = tg3_interrupt_tagged;
>  		flags = IRQF_SHARED | IRQF_SAMPLE_RANDOM;
>  	}
> -	return (request_irq(tp->pdev->irq, fn, flags, dev->name, dev));
> +	return pci_request_irq(tp->pdev, fn, flags, dev->name);

since pci_request_irq sets IRQF_SHARED... might as well drop that above.


