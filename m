Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261890AbVBISSP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261890AbVBISSP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 13:18:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261889AbVBISSO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 13:18:14 -0500
Received: from mail.kroah.org ([69.55.234.183]:48839 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261886AbVBISRs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 13:17:48 -0500
Date: Wed, 9 Feb 2005 10:17:37 -0800
From: Greg KH <greg@kroah.com>
To: Kylene Hall <kjhall@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, Emily Ratliff <emilyr@us.ibm.com>,
       Tom Lendacky <toml@us.ibm.com>, tpmdd-devel@lists.sourceforge.net
Subject: Re: [PATCH 1/1] tpm: update tpm sysfs file ownership
Message-ID: <20050209181736.GA23422@kroah.com>
References: <Pine.LNX.4.58.0501181621200.2473@jo.austin.ibm.com> <Pine.LNX.4.58.0501181735110.13908@jo.austin.ibm.com> <Pine.LNX.4.58.0501281539340.6360@jo.austin.ibm.com> <Pine.LNX.4.58.0501311322380.9872@jo.austin.ibm.com> <Pine.LNX.4.58.0502031034290.18135@jo.austin.ibm.com> <Pine.LNX.4.58.0502041405230.22211@jo.austin.ibm.com> <20050204205226.GA26780@kroah.com> <1107553040.22140.30.camel@jo.austin.ibm.com> <20050204215134.GA27433@kroah.com> <Pine.LNX.4.58.0502091201110.3969@jo.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0502091201110.3969@jo.austin.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 09, 2005 at 12:05:42PM -0600, Kylene Hall wrote:
> @@ -539,9 +551,8 @@ void tpm_remove_hardware(struct device *
>  	dev_set_drvdata(dev, NULL);
>  	misc_deregister(&chip->vendor->miscdev);
>  
> -	device_remove_file(dev, &dev_attr_pubek);
> -	device_remove_file(dev, &dev_attr_pcrs);
> -	device_remove_file(dev, &dev_attr_caps);
> +	for ( i = 0; i < TPM_ATTRS; i++ ) 
> +		device_remove_file(dev, &chip->attr[i]);
>  
>  	dev_mask[chip->dev_num / 32] &= !(1 << (chip->dev_num % 32));
>  

This code works?

> @@ -608,6 +619,11 @@ int tpm_register_hardware(struct device 
>  	struct tpm_chip *chip;
>  	int i, j;
>  
> +	DEVICE_ATTR(pcrs, S_IRUGO, show_pcrs, NULL);
> +	DEVICE_ATTR(pubek, S_IRUGO, show_pubek, NULL);
> +	DEVICE_ATTR(caps, S_IRUGO, show_caps, NULL);
> +	DEVICE_ATTR(cancel, S_IWUSR | S_IWGRP, NULL, store_cancel);
> +
>  	/* Driver specific per-device data */
>  	chip = kmalloc(sizeof(*chip), GFP_KERNEL);
>  	if (chip == NULL)

You do realize you just created those attributes on the stack?  And then
you try to remove them from within a different scope above?

thanks,

greg k-h
