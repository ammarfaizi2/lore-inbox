Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130076AbQLSVbW>; Tue, 19 Dec 2000 16:31:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130078AbQLSVbN>; Tue, 19 Dec 2000 16:31:13 -0500
Received: from [213.237.20.108] ([213.237.20.108]:18030 "EHLO ns.geekboy.dk")
	by vger.kernel.org with ESMTP id <S130076AbQLSVbI>;
	Tue, 19 Dec 2000 16:31:08 -0500
Date: Tue, 19 Dec 2000 22:05:30 +0100
From: Torben Mathiasen <torben@kernel.dk>
To: Francois Romieu <romieu@cogenit.fr>
Cc: Rasmus Andersen <rasmus@jaquet.dk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] Converting drivers/net/rcpci45.c to new PCI API
Message-ID: <20001219220530.A1643@torben>
In-Reply-To: <20001219004604.B761@jaquet.dk> <20001219095906.A5764@se1.cogenit.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001219095906.A5764@se1.cogenit.fr>; from romieu@cogenit.fr on Tue, Dec 19, 2000 at 09:59:06AM +0100
X-OS: Linux 2.4.0-test13-pre2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 19 2000, Francois Romieu wrote:

[deleted]

> > -	if (pci_enable_device(pdev))
> > -		break;
> > -	pci_set_master(pdev);
> > +	unregister_netdev(dev);
> > +	iounmap((void *)dev->base_addr);
> > +        free_irq(dev->irq, dev);
> 
> I'd rather inhibit irq first then release the ressources.
> +       free_irq(dev->irq, dev);
> +	iounmap((void *)dev->base_addr);
> +	unregister_netdev(dev);
>

You should release the irq when the adapter is closed, not removed,
unless there's some special case that can't be handled if you take
ints during init.

And why would you unregister your netdev after releasing resources?



-- 
Torben Mathiasen <torben@kernel.dk>
Linux ThunderLAN maintainer 
http://tlan.kernel.dk
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
