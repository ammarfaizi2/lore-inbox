Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262382AbVD2Etb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262382AbVD2Etb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 00:49:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262345AbVD2Et3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 00:49:29 -0400
Received: from mail.kroah.org ([69.55.234.183]:47794 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262194AbVD2EtK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 00:49:10 -0400
Date: Thu, 28 Apr 2005 21:28:06 -0700
From: Greg KH <greg@kroah.com>
To: Kylene Hall <kjhall@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10 of 12] Fix Tpm driver -- sysfs owernship changes
Message-ID: <20050429042806.GB25585@kroah.com>
References: <Pine.LNX.4.61.0504271645170.3929@jo.austin.ibm.com> <20050428041915.GD9723@kroah.com> <Pine.LNX.4.61.0504281535330.3947@IBM-8BD8VOWT0JH.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0504281535330.3947@IBM-8BD8VOWT0JH.austin.ibm.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2005 at 03:40:16PM -0500, Kylene Hall wrote:
> On Wed, 27 Apr 2005, Greg KH wrote:
> > On Wed, Apr 27, 2005 at 05:19:03PM -0500, Kylene Hall wrote:
> > > -	device_remove_file(&pci_dev->dev, &dev_attr_pubek);
> > > -	device_remove_file(&pci_dev->dev, &dev_attr_pcrs);
> > > -	device_remove_file(&pci_dev->dev, &dev_attr_caps);
> > > +	for (i = 0; i < TPM_NUM_ATTR; i++)
> > > +		device_remove_file(&pci_dev->dev, &chip->vendor->attr[i]);
> > 
> > Use an attribute group, instead of this.  That will allow you to get
> > rid of the TPM_NUM_ATTR value, and this looney macro:
> > 
> > > +#define TPM_DEVICE_ATTRS { \
> > > +        __ATTR(pubek, S_IRUGO, tpm_show_pubek, NULL), \
> > > +        __ATTR(pcrs, S_IRUGO, tpm_show_pcrs, NULL), \
> > > +        __ATTR(caps, S_IRUGO, tpm_show_caps, NULL), \
> > > +        __ATTR(cancel, S_IWUSR | S_IWGRP, NULL, tpm_store_cancel) }
> > 
> > thanks,
> > 
> > greg k-h
> > 
> > 
> 
> Ok, the patch below has the same functionality as the previous patch but 
> gets rid of the macro and implements an attribute_group.  Is there any way 
> to avoid the repeated code in every tpm_specific file to setup the 
> attribute_group and still ensure the files are owned by the tpm_specific 
> module?  The only thing I can come up with is either not using the 
> TPM_DEVICE macro at all or creating with TPM_DEVICE macro and then 
> changing the owner field.

Why are you trying to split this driver up into such tiny pieces?
What's wrong with one driver for all devices?

thanks,

greg k-h
