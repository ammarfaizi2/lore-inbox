Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267687AbUHYAou@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267687AbUHYAou (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 20:44:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267186AbUHYAnr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 20:43:47 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:44222 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267687AbUHYAnU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 20:43:20 -0400
Message-ID: <412BE09C.4030706@pobox.com>
Date: Tue, 24 Aug 2004 20:43:08 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ibmasm: add missing pci_enable_device()
References: <200408242224.i7OMOs1H029517@hera.kernel.org>
In-Reply-To: <200408242224.i7OMOs1H029517@hera.kernel.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux Kernel Mailing List wrote:
> diff -Nru a/drivers/misc/ibmasm/module.c b/drivers/misc/ibmasm/module.c
> --- a/drivers/misc/ibmasm/module.c	2004-08-24 15:25:05 -07:00
> +++ b/drivers/misc/ibmasm/module.c	2004-08-24 15:25:05 -07:00
> @@ -62,10 +62,17 @@
>  	int result = -ENOMEM;
>  	struct service_processor *sp;
>  
> +	if (pci_enable_device(pdev)) {
> +		printk(KERN_ERR "%s: can't enable PCI device at %s\n",
> +			DRIVER_NAME, pci_name(pdev));
> +		return -ENODEV;
> +	}


Another [minor] bug in this series of changes:  you should propagate the 
return value of pci_enable_device(), not make up your own.

	Jeff


