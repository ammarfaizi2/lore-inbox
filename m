Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285405AbRLNQXb>; Fri, 14 Dec 2001 11:23:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285407AbRLNQXV>; Fri, 14 Dec 2001 11:23:21 -0500
Received: from server1.symplicity.com ([209.61.154.230]:1800 "HELO
	mail2.symplicity.com") by vger.kernel.org with SMTP
	id <S285405AbRLNQXN>; Fri, 14 Dec 2001 11:23:13 -0500
From: "Alok K. Dhir" <alok@dhir.net>
To: "'Jens Axboe'" <axboe@suse.de>, "'David S. Miller'" <davem@redhat.com>
Cc: <lord@sgi.com>, <gibbs@scsiguy.com>, <LB33JM16@yahoo.com>,
        <linux-kernel@vger.kernel.org>
Subject: RE: highmem, aic7xxx, and vfat: too few segs for dma mapping
Date: Fri, 14 Dec 2001 11:22:50 -0500
Message-ID: <003101c184bb$93b52e80$9865fea9@pcsn630778>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2616
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
In-Reply-To: <20011214161506.GB1180@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is this going into the 2.4.17 as well?

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org 
> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Jens Axboe
> Sent: Friday, December 14, 2001 11:15 AM
> To: David S. Miller
> Cc: lord@sgi.com; gibbs@scsiguy.com; LB33JM16@yahoo.com; 
> linux-kernel@vger.kernel.org
> Subject: Re: highmem, aic7xxx, and vfat: too few segs for dma mapping
> 
> 
> On Fri, Dec 14 2001, Jens Axboe wrote:
> > 
> *.kernel.org/pub/linux/kernel/people/axboe/patches/v2.5/2.5.1-pre11/bi
> > o-pre11-5.bz2
> 
> Steve Lord caught two typos in the patch, here's an 
> incremental diff attached. There will also be a bio-pre11-6 
> at the above location in a few minutes.
> 
> --- linux/drivers/scsi/scsi.c~	Fri Dec 14 11:06:25 2001
> +++ linux/drivers/scsi/scsi.c	Fri Dec 14 11:06:46 2001
> @@ -2590,7 +2590,6 @@
>  	/*
>  	 * setup sg memory pools
>  	 */
> -	ts = 0;
>  	for (i = 0; i < SG_MEMPOOL_NR; i++) {
>  		struct scsi_host_sg_pool *sgp = scsi_sg_pools + i;
>  		int size = scsi_host_sg_pool_sizes[i] * 
> sizeof(struct scatterlist);
> --- linux/drivers/scsi/sym53c8xx.c~	Fri Dec 14 11:10:38 2001
> +++ linux/drivers/scsi/sym53c8xx.c	Fri Dec 14 11:10:51 2001
> @@ -12174,7 +12174,7 @@
>  
>  		use_sg = map_scsi_sg_data(np, cmd);
>  		if (use_sg > MAX_SCATTER) {
> -			unmap_scsi_sg_data(np, cmd);
> +			unmap_scsi_data(np, cmd);
>  			return -1;
>  		}
>  		data = &cp->phys.data[MAX_SCATTER - use_sg];
> 
> -- 
> Jens Axboe
> 
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in the body of a message to 
> majordomo@vger.kernel.org More majordomo info at  
http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

