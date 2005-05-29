Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261292AbVE2JRE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261292AbVE2JRE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 05:17:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261293AbVE2JRE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 05:17:04 -0400
Received: from wproxy.gmail.com ([64.233.184.201]:22878 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261292AbVE2JQ6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 05:16:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ag24WfX3PvuLOJ+qIHFA/GOHR0hPWkIf9GBxf/ikMOIvJvXrB1B0cK3ApnqlD7Wtw+kyx0xLrj6AvJB+OQ6DtHJXvE3zFoqfMSYMeB0ScsD1xAz5ex8vUrYVXPgkwoXlGFXn7PVRv1CZXQuu0E6dB2/eNgqiqTV8oUzg0BgvnsQ=
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [RFT][PATCH] aic79xx: remove busyq
Date: Sun, 29 May 2005 13:21:30 +0400
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
References: <20050529074620.GA26151@havoc.gtf.org>
In-Reply-To: <20050529074620.GA26151@havoc.gtf.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505291321.31090.adobriyan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 29 May 2005 11:46, Jeff Garzik wrote:
> This changes the aic79xx driver to use the standard Linux SCSI queueing
> code, rather than its own.  After applying this patch, NO behavior
> changes should be seen.
> 
> The patch is against 2.6.12-rc5, but probably applies OK to recent 2.6.x
> kernels.

s/PF_FREEZE/PF_NOFREEZE/ to apply to recent ones.

> --- a/drivers/scsi/aic7xxx/aic79xx_osm.c
> +++ b/drivers/scsi/aic7xxx/aic79xx_osm.c

> @@ -2478,18 +2045,10 @@ ahd_linux_dv_thread(void *data)
>  	 * Complete thread creation.
>  	 */
>  	lock_kernel();
> -#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,60)
> -	/*
> -	 * Don't care about any signals.
> -	 */
> -	siginitsetinv(&current->blocked, 0);
>  
> -	daemonize();
> -	sprintf(current->comm, "ahd_dv_%d", ahd->unit);
> -#else
>  	daemonize("ahd_dv_%d", ahd->unit);
>  	current->flags |= PF_FREEZE;
> -#endif
> +
>  	unlock_kernel();
>  
>  	while (1) {
