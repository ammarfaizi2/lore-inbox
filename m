Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316158AbSFYXgu>; Tue, 25 Jun 2002 19:36:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316161AbSFYXgt>; Tue, 25 Jun 2002 19:36:49 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:37336 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S316158AbSFYXgs>; Tue, 25 Jun 2002 19:36:48 -0400
Date: Tue, 25 Jun 2002 19:36:41 -0400
From: Doug Ledford <dledford@redhat.com>
To: Frank Davis <fdavis@si.rr.com>
Cc: linux-kernel@vger.kernel.org, jfbeam@bluetronic.net
Subject: Re: [PATCH] 2.5.24 : drivers/scsi/dpt_i2o.c (DMA Rev. 2)
Message-ID: <20020625193641.B19442@redhat.com>
Mail-Followup-To: Frank Davis <fdavis@si.rr.com>,
	linux-kernel@vger.kernel.org, jfbeam@bluetronic.net
References: <Pine.LNX.4.44.0206241320180.901-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0206241320180.901-100000@localhost.localdomain>; from fdavis@si.rr.com on Mon, Jun 24, 2002 at 01:23:14PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2002 at 01:23:14PM -0400, Frank Davis wrote:
> Hello all,
>   I've added the check for 64-bit DMA addressing per Rick's comment. 
> Regards,
> Frank
> 
> --- drivers/scsi/dpt_i2o.c.old	Mon Jun 10 12:18:59 2002
> +++ drivers/scsi/dpt_i2o.c	Mon Jun 24 13:18:03 2002
> @@ -879,6 +879,21 @@
>  	if(pci_enable_device(pDev)) {
>  		return -EINVAL;
>  	}
> +	int using_dac;
> +	
> +	if(!pci_set_dma_mask(pDev, 0xffffffffffffffff))
> +	{	
> +		using_dac = 1;
> +		printk("dpt_i2o : Using 64-bit DMA addressing\n");
> +
> +	}else if(!pci_set_dma_mask(pDev, 0xffffffff))
> +	{
> +		using_dac = 0;
> +		printk("dpt_i2o : Using 32-bit DMA addressing\n");
> +
> +	}else {
> +		printk(KERN_WARNING "dpt_i2o : No suitable DMA available\n");
> +	}	
>  	pci_set_master(pDev);
>  
>  	base_addr0_phys = pci_resource_start(pDev,0);

Please do us a favor and do a *complete* upfit to the new DMA mapping
routines in a single file at a time, send the patch out for that one file,
then move on to the next.  Doing it the way you are now just generates
patch churn and makes it harder for other people to keep in sync with
current versions of files and makes it harder to avoid duplicating effort
and makes it harder for other people to work on these files as their
patches start failing to apply due to one line changes here or there.

-- 
  Doug Ledford <dledford@redhat.com>     919-754-3700 x44233
         Red Hat, Inc. 
         1801 Varsity Dr.
         Raleigh, NC 27606
  
