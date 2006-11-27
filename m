Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933336AbWK0TTE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933336AbWK0TTE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 14:19:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933340AbWK0TTD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 14:19:03 -0500
Received: from smtp105.sbc.mail.mud.yahoo.com ([68.142.198.204]:34134 "HELO
	smtp105.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S933336AbWK0TTB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 14:19:01 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=28Qj88/o39zw5b5kub9vs3u8OXZTX+rm+R5eYQv2ru/sX5KFPp1Nan3FVIRTXedsXYXOcvpp8YPVS3xH3wVkGnq0RzVWQWC+l6rtmRc6dkH+hhMXCnvuVe/k3lfXVf38GH/WHChb/PEHok2mURiw+0xen6gpzh1qbUBM3nJtd7M=  ;
X-YMail-OSG: Vf8b6vQVM1nDzG3WmLb6b9DBQhe5IvFQgN6itZwrsixx546deqk1dZyBf92N2aD7p09lk0iir6rzBfLSaeod8FRs2tMBmdhWmt146D6DT33VIRO1XG3v
From: David Brownell <david-b@pacbell.net>
To: Akinobu Mita <akinobu.mita@gmail.com>
Subject: Re: [PATCH] spi: check platform_device_register_simple() error
Date: Mon, 27 Nov 2006 10:28:38 -0800
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org
References: <20061127050915.GH1231@APFDCB5C>
In-Reply-To: <20061127050915.GH1231@APFDCB5C>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611271028.39173.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 26 November 2006 9:09 pm, Akinobu Mita wrote:
> This patch checks the return value of platform_device_register_simple().
> 
> Cc: David Brownell <dbrownell@users.sourceforge.net>
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

Acked-by: David Brownell <dbrownell@users.sourceforge.net>

... thanks, good catch.


> 
> ---
>  drivers/spi/spi_butterfly.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> Index: work-fault-inject/drivers/spi/spi_butterfly.c
> ===================================================================
> --- work-fault-inject.orig/drivers/spi/spi_butterfly.c
> +++ work-fault-inject/drivers/spi/spi_butterfly.c
> @@ -250,6 +250,8 @@ static void butterfly_attach(struct parp
>  	 * setting up a platform device like this is an ugly kluge...
>  	 */
>  	pdev = platform_device_register_simple("butterfly", -1, NULL, 0);
> +	if (IS_ERR(pdev))
> +		return;
>  
>  	master = spi_alloc_master(&pdev->dev, sizeof *pp);
>  	if (!master) {
> 
