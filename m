Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261328AbVGLK0c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261328AbVGLK0c (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 06:26:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261322AbVGLKYH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 06:24:07 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:57295 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261311AbVGLKXx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 06:23:53 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>, akpm@osdl.org,
       horst.hummel@de.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [patch 7/12] s390: fba dasd i/o errors.
Date: Tue, 12 Jul 2005 13:22:09 +0300
User-Agent: KMail/1.5.4
References: <20050711163625.GG10822@localhost.localdomain>
In-Reply-To: <20050711163625.GG10822@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507121322.09610.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 11 July 2005 19:36, Martin Schwidefsky wrote:
> [patch 7/12] s390: fba dasd i/o errors.
> 
> From: Horst Hummel <horst.hummel@de.ibm.com>
> 
> The FBA discipline does not use retries for failed requests. A request
> fails after the first unsuccessful start attempt. There are some rare
> conditions (e.g. CIO path recovery) in which the start of an i/o on
> a fba device can fail. A tiny amount of retries is therefore
> reasonable.
> 
> Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
> 
> diffstat:
>  drivers/s390/block/dasd_fba.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff -urpN linux-2.6/drivers/s390/block/dasd_fba.c linux-2.6-patched/drivers/s390/block/dasd_fba.c
> --- linux-2.6/drivers/s390/block/dasd_fba.c	2005-06-17 21:48:29.000000000 +0200
> +++ linux-2.6-patched/drivers/s390/block/dasd_fba.c	2005-07-11 17:37:46.000000000 +0200
> @@ -4,7 +4,7 @@
>   * Bugreports.to..: <Linux390@de.ibm.com>
>   * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 1999,2000
>   *
> - * $Revision: 1.39 $
> + * $Revision: 1.40 $
>   */
>  
>  #include <linux/config.h>
> @@ -354,6 +354,8 @@ dasd_fba_build_cp(struct dasd_device * d
>  	}
>  	cqr->device = device;
>  	cqr->expires = 5 * 60 * HZ;	/* 5 minutes */
> +	cqr->retries = 32;

2..4 maybe, but 32? This isn't tiny by any account.

> +	cqr->buildclk = get_clock();
>  	cqr->status = DASD_CQR_FILLED;
>  	return cqr;
>  }

