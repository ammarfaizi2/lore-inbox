Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261421AbUEFLqH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261421AbUEFLqH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 07:46:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261685AbUEFLqH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 07:46:07 -0400
Received: from mx1.redhat.com ([66.187.233.31]:3523 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261421AbUEFLqD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 07:46:03 -0400
Date: Thu, 6 May 2004 13:45:44 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       B.Zolnierkiewicz@elka.pw.edu.pl, akpm@osdl.org
Subject: Re: Force IDE cache flush on shutdown
Message-ID: <20040506114544.GC16548@devserv.devel.redhat.com>
References: <20040506070449.GA12862@devserv.devel.redhat.com> <20040506084918.B12990@infradead.org> <20040506075044.GC12862@devserv.devel.redhat.com> <20040506085549.A13098@infradead.org> <20040506104638.GA9929@devserv.devel.redhat.com> <20040506115220.A14669@infradead.org> <20040506113309.GB16548@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040506113309.GB16548@devserv.devel.redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, May 06, 2004 at 01:33:09PM +0200, Arjan van de Ven wrote:
> On Thu, May 06, 2004 at 11:52:20AM +0100, Christoph Hellwig wrote:
> > > +	idedisk_driver.gen_driver.shutdown = ide_drive_shutdown;
> > 
> > isn't idedisk_driver initialized statically somewhere?  You should probably
> 
> ok ok you win
> 
> diff -purN linux-2.6.5/drivers/ide/ide-disk.c linux/drivers/ide/ide-disk.c
> --- linux-2.6.5/drivers/ide/ide-disk.c	2004-05-06 13:26:53.350284720 +0200
> +++ linux/drivers/ide/ide-disk.c	2004-05-06 13:32:01.322465832 +0200
> @@ -1725,6 +1725,9 @@ static ide_driver_t idedisk_driver = {
>  	.drives			= LIST_HEAD_INIT(idedisk_driver.drives),
>  	.start_power_step	= idedisk_start_power_step,
>  	.complete_power_step	= idedisk_complete_power_step,
> +	.gen_driver = {
> +		.shutdown	= ide_drive_shutdown,
> +	},	                                


and that needs a prototype as well 

--- linux-2.6.5/drivers/ide/ide-disk.c~	2004-05-06 13:44:41.052969240 +0200
+++ linux-2.6.5/drivers/ide/ide-disk.c	2004-05-06 13:44:41.053969088 +0200
@@ -1701,6 +1701,7 @@
 }
 
 static int idedisk_attach(ide_drive_t *drive);
+static int ide_drive_shutdown(struct device * dev);
 
 /*
  *      IDE subdriver functions, registered with ide.c
