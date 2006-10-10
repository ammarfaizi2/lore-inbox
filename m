Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932079AbWJJNuR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932079AbWJJNuR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 09:50:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932078AbWJJNuQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 09:50:16 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:11372 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750792AbWJJNuO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 09:50:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=Dc01j5mEYCd6lTKVlBp6T6E9ENypY6guwViSqJaVVc+DSLNt9l5vUHec7NN9ZEYB1xhGbXFz7Hhqc8mD7RNnfmeYTroftVS89UeKMC/Gao9yjdKa08Z4xJz4wqAhTm71Z9vPmsS7RydhSwZqmQzyUWp1iAsAFSsjOT3Ax7YG9dw=
Date: Tue, 10 Oct 2006 17:49:56 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Jeff Garzik <jeff@garzik.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: [PATCH] drivers/ide: fix error return bugs, interface
Message-ID: <20061010134956.GA5347@martell.zuzino.mipt.ru>
References: <20061010131639.GA8523@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061010131639.GA8523@havoc.gtf.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> --- a/drivers/ide/pci/cs5530.c
> +++ b/drivers/ide/pci/cs5530.c
> @@ -250,7 +250,9 @@ static unsigned int __devinit init_chips
>  	 */
>  
>  	pci_set_master(cs5530_0);
> -	pci_set_mwi(cs5530_0);
> +	if (pci_set_mwi(cs5530_0))
> +		dev_printk(KERN_WARNING, &cs5530_0->dev,
> +			   "MWI enable failed\n");

Use dev_warn()

