Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263413AbTJQL6A (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 07:58:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263420AbTJQL57
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 07:57:59 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:12807 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263413AbTJQL56 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 07:57:58 -0400
Date: Fri, 17 Oct 2003 12:57:57 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
Cc: linux-kernel@vger.kernel.org, Brard Roudier <groudier@free.fr>
Subject: Re: [patch][1/3] qlogic: use scsi_host_alloc instead scsi_register
Message-ID: <20031017125757.A26699@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>,
	linux-kernel@vger.kernel.org, Brard Roudier <groudier@free.fr>
References: <20031016015213.GA1765@cathedrallabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20031016015213.GA1765@cathedrallabs.org>; from aris@cathedrallabs.org on Wed, Oct 15, 2003 at 11:52:13PM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 15, 2003 at 11:52:13PM -0200, Aristeu Sergio Rozanski Filho wrote:
> +++ linux/drivers/scsi/qlogicfas.c	2003-10-15 23:41:28.000000000 -0200
> @@ -671,7 +671,7 @@
>  	if (qlirq >= 0 && !request_irq(qlirq, do_ql_ihandl, 0, "qlogicfas", NULL))
>  		host->can_queue = 1;
>  #endif
> -	hreg = scsi_register(host, 0);	/* no host data */
> +	hreg = scsi_host_alloc(host, 0);	/* no host data */
>  	if (!hreg)
>  		goto err_release_mem;
>  	hreg->io_port = qbase;
> @@ -679,6 +679,7 @@
>  	hreg->dma_channel = -1;
>  	if (qlirq != -1)
>  		hreg->irq = qlirq;
> +	INIT_LIST_HEAD(&hreg->sht_legacy_list);

This is not good - please use scsi_register for the !PCMCIA case
instead of opencoding it - sht_legacy_list should be completely opaque
to drivers.  Maybe once the current freeze is over we can convert
qlogic.c to a proper new-style driver and merge qlogic_cs into it
instead of having two copies of the same codebase compiled with slightly
different cpp symbols.

