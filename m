Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932313AbWFWFty@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932313AbWFWFty (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 01:49:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751246AbWFWFty
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 01:49:54 -0400
Received: from xenotime.net ([66.160.160.81]:43486 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751245AbWFWFtx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 01:49:53 -0400
Date: Thu, 22 Jun 2006 22:52:39 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: mgross@linux.intel.com
Cc: arjan@infradead.org, linux-kernel@vger.kernel.org, mark.gross@intel.com
Subject: Re: [PATCH] riport LADAR driver
Message-Id: <20060622225239.bf0ccab2.rdunlap@xenotime.net>
In-Reply-To: <20060622231604.GA5208@linux.intel.com>
References: <20060622144120.GA5215@linux.intel.com>
	<1151000401.3120.55.camel@laptopd505.fenrus.org>
	<20060622231604.GA5208@linux.intel.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jun 2006 16:16:04 -0700 mark gross wrote:

a.  still has 6 lines of trailing whitespace.

> diff -urN -X linux-2.6.17.1/Documentation/dontdiff ../linux-2.6.17.1/drivers/char/riport.c linux-2.6.17.1/drivers/char/riport.c
> --- ../linux-2.6.17.1/drivers/char/riport.c	1969-12-31 16:00:00.000000000 -0800
> +++ linux-2.6.17.1/drivers/char/riport.c	2006-06-22 16:07:34.000000000 -0700

> +static struct devriport __init *devriport_init(int major, int minor, unsigned int io, int irq,
> +				   int dma, int size, int *presult)
> +{
> +	struct devriport *this;
> +
> +	*presult = 0;
> +	this = kzalloc(sizeof(struct devriport), GFP_KERNEL);
> +	if (!this) {
> +		*presult = -ENOMEM;
> +		goto fail_memory;
> +	}
> +
> +	if (!request_region(io, 3, "riport")) {
> +		PDEBUG("request_region 0x%X of 3 bytes fails\n", io);
> +		*presult = -EBUSY;
> +		goto fail_io;
> +	}
> +	if (!request_region(io + ECP_OFFSET, 3, "riport")) {
> +		release_region(io,3);
> +
> +		PDEBUG("request_region 0x%X of 3 bytes fails\n", io + ECP_OFFSET );
> +		*presult = -EBUSY;
> +		goto fail_io;
> +	}

> +	this->pinode = NULL;
> +	this->pfile = NULL;
> +	this->usage = 0;
> +	this->syncWord = 0;
> +	this->bytestoread = 0;
> +	this->numbytesthisstate = 0;
> +	this->irqinuse = 0;

Since kzalloc() is now being used, above lines aren't needed.

> +		switch (this->readstate) {
> +			/* due to the magic of the ECP port, it seems that we are
> +			 guaranteed to be fed a header from the riegl whenever we call
> +			 riport_open.  this code assumes that is true */

For multi-line comments (multiple places), regular kernel
coding style is:
			/*
			 * due to blah blah ...
			 * end
			 */

> +static int devriport_open(struct devriport *this)
> +{

> +	result =
> +		request_irq(this->irq, devriport_irq_wrap, SA_INTERRUPT,
> +			"riport", this);

Put that on 2 lines.

> +static int __init riport_init(void)
> +{

> +	pdev =
> +	    devriport_init(riport.major, riport.numdevs, io, irq, dma, size,
> +			   &result);

Put on 2 lines.

> +}
> +

> +module_param(io, int, 0444);
> +MODULE_PARM_DESC(io, "if non-zero then overrides IO port address");
> +
> +module_param(irq, int, 0444);
> +MODULE_PARM_DESC(io, "if non-zero then overrides IRQ number");
                    irq

> +
> +module_param(size, int, 0444);
> +MODULE_PARM_DESC(io, "if non-zero then overrides buffer size");
                    size

---
~Randy
