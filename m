Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932445AbVHIElU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932445AbVHIElU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 00:41:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932447AbVHIElU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 00:41:20 -0400
Received: from dvhart.com ([64.146.134.43]:33153 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S932445AbVHIElT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 00:41:19 -0400
Date: Mon, 08 Aug 2005 21:41:06 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       bugme-daemon@kernel-bugs.osdl.org
Subject: Re: [Bugme-new] [Bug 5003] New: Problem with symbios driver on	recent	-mm trees
Message-ID: <453380000.1123562466@[10.10.2.4]>
In-Reply-To: <1123254086.5003.10.camel@mulgrave>
References: <135040000.1123216397@[10.10.2.4]> <20050804233927.2d3abb16.akpm@osdl.org> <1123251892.5003.6.camel@mulgrave> <179280000.1123252564@[10.10.2.4]> <1123254086.5003.10.camel@mulgrave>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, 2005-08-05 at 07:36 -0700, Martin J. Bligh wrote:
>> Howcome it works on all mainline kernels, and not -mm then? ;-)
>> Did we fix an error path to detect failures, maybe?
> 
> Well, OK, it might be something to do with your drives trying to
> negotiate IU and QAS.  Support for this was added to the sym2 driver but
> never verified (because no-one seemed to have drives that could do it).
> 
> The attached should stop the driver from negotiating these two
> parameters, if you could try it (it will produce complaints about static
> functions defined but not used, but you can ignore them).

Nope, is the same as before with this patch ....

M.
 
> James
> 
> diff --git a/drivers/scsi/sym53c8xx_2/sym_glue.c b/drivers/scsi/sym53c8xx_2/sym_glue.c
> --- a/drivers/scsi/sym53c8xx_2/sym_glue.c
> +++ b/drivers/scsi/sym53c8xx_2/sym_glue.c
> @@ -2122,10 +2122,12 @@ static struct spi_function_template sym2
>  	.show_width	= 1,
>  	.set_dt		= sym2_set_dt,
>  	.show_dt	= 1,
> +#if 0
>  	.set_iu		= sym2_set_iu,
>  	.show_iu	= 1,
>  	.set_qas	= sym2_set_qas,
>  	.show_qas	= 1,
> +#endif
>  	.get_signalling	= sym2_get_signalling,
>  };
>  
> 
> 
> 
> 


