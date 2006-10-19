Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946649AbWJSXII@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946649AbWJSXII (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 19:08:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946651AbWJSXIH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 19:08:07 -0400
Received: from lixom.net ([66.141.50.11]:50133 "EHLO mail.lixom.net")
	by vger.kernel.org with ESMTP id S1946632AbWJSXIF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 19:08:05 -0400
Date: Thu, 19 Oct 2006 18:06:59 -0500
From: Olof Johansson <olof@lixom.net>
To: Peter Korsgaard <jacmet@sunsite.dk>
Cc: rmk+serial@arm.linux.org.uk, linux-serial@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] Xilinx uartlite serial driver
Message-ID: <20061019180659.200d7763@pb15>
In-Reply-To: <871wqfyjgi.fsf@slug.be.48ers.dk>
References: <87ac9o3ak3.fsf@sleipner.barco.com>
	<878xlgercm.fsf@slug.be.48ers.dk>
	<20060912093301.77f75bfb@localhost.localdomain>
	<87ejugxqbw.fsf@slug.be.48ers.dk>
	<871wqfyjgi.fsf@slug.be.48ers.dk>
X-Mailer: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.10.6; powerpc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Sep 2006 15:39:09 +0200 Peter Korsgaard <jacmet@sunsite.dk> wrote:

> +static int __devinit ulite_probe(struct platform_device *pdev)
[...]
> +	port = &ports[pdev->id];
> +
> +	port->fifosize	= 16;
> +	port->regshift	= 2;
> +	port->iotype	= UPIO_MEM;
> +	port->iobase	= 1; /* mark port in use */
> +	port->mapbase	= res->start;
> +	port->membase	= 0;
> +	port->ops	= &ulite_ops;
> +	port->irq	= res2->start;
> +	port->flags	= UPF_BOOT_AUTOCONF;
> +	port->dev	= &pdev->dev;
> +	port->type	= PORT_UNKNOWN;

Hi Peter,

You never fill in the 'line' member here, so probing of a second
uartlite port will fail.

Add:
	port->line	 = pdev->id;


-Olof
