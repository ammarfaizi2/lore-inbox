Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265422AbTFSIWl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 04:22:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265492AbTFSIWl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 04:22:41 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:62985 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S265422AbTFSIWi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 04:22:38 -0400
Date: Thu, 19 Jun 2003 09:36:32 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Adam Belay <ambx1@neo.rr.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PnP Changes for 2.5.72
Message-ID: <20030619093632.A29602@flint.arm.linux.org.uk>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	linux-kernel@vger.kernel.org
References: <20030618234418.GC333@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030618234418.GC333@neo.rr.com>; from ambx1@neo.rr.com on Wed, Jun 18, 2003 at 11:44:18PM +0000
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 18, 2003 at 11:44:18PM +0000, Adam Belay wrote:
> diff -Nru a/drivers/serial/8250_pnp.c b/drivers/serial/8250_pnp.c
> --- a/drivers/serial/8250_pnp.c	Wed Jun 18 23:02:24 2003
> +++ b/drivers/serial/8250_pnp.c	Wed Jun 18 23:02:24 2003
> @@ -315,19 +315,6 @@
>  
>  MODULE_DEVICE_TABLE(pnp, pnp_dev_table);
>  
> -static inline void avoid_irq_share(struct pnp_dev *dev)
> -{
> -	unsigned int map = 0x1FF8;
> -	struct pnp_irq *irq;
> -	struct pnp_resources *res = dev->possible;
> -
> -	serial8250_get_irq_map(&map);
> -
> -	for ( ; res; res = res->dep)
> -		for (irq = res->irq; irq; irq = irq->next)
> -			irq->map = map;
> -}
> -
>  static char *modem_names[] __devinitdata = {
>  	"MODEM", "Modem", "modem", "FAX", "Fax", "fax",
>  	"56K", "56k", "K56", "33.6", "28.8", "14.4",
> @@ -395,8 +391,6 @@
>  		if (ret < 0)
>  			return ret;
>  	}
> -	if (flags & SPCI_FL_NO_SHIRQ)
> -		avoid_irq_share(dev);
>  	memset(&serial_req, 0, sizeof(serial_req));
>  	serial_req.irq = pnp_irq(dev,0);
>  	serial_req.port = pnp_port_start(dev, 0);

Why did you remove this?  I'd like this to go to Linus as a separate cset
so it can easily be backed out again if needed.

It's purpose is trying to ensure that we don't use an interrupt which
another serial port is using.  Presumably this is because the card does
not work, for whatever reason, when it shares interrupts with other serial
ports.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

