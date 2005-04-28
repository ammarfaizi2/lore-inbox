Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261929AbVD1ETm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261929AbVD1ETm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 00:19:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261926AbVD1ETm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 00:19:42 -0400
Received: from mail.kroah.org ([69.55.234.183]:4775 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261929AbVD1ETd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 00:19:33 -0400
Date: Wed, 27 Apr 2005 21:19:16 -0700
From: Greg KH <greg@kroah.com>
To: Kylene Hall <kjhall@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10 of 12] Fix Tpm driver -- sysfs owernship changes
Message-ID: <20050428041915.GD9723@kroah.com>
References: <Pine.LNX.4.61.0504271645170.3929@jo.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0504271645170.3929@jo.austin.ibm.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2005 at 05:19:03PM -0500, Kylene Hall wrote:
> -	device_remove_file(&pci_dev->dev, &dev_attr_pubek);
> -	device_remove_file(&pci_dev->dev, &dev_attr_pcrs);
> -	device_remove_file(&pci_dev->dev, &dev_attr_caps);
> +	for (i = 0; i < TPM_NUM_ATTR; i++)
> +		device_remove_file(&pci_dev->dev, &chip->vendor->attr[i]);

Use an attribute group, instead of this.  That will allow you to get
rid of the TPM_NUM_ATTR value, and this looney macro:

> +#define TPM_DEVICE_ATTRS { \
> +        __ATTR(pubek, S_IRUGO, tpm_show_pubek, NULL), \
> +        __ATTR(pcrs, S_IRUGO, tpm_show_pcrs, NULL), \
> +        __ATTR(caps, S_IRUGO, tpm_show_caps, NULL), \
> +        __ATTR(cancel, S_IWUSR | S_IWGRP, NULL, tpm_store_cancel) }

thanks,

greg k-h
