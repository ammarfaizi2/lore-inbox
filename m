Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262831AbVD2QqG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262831AbVD2QqG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 12:46:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262826AbVD2QoZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 12:44:25 -0400
Received: from mail.kroah.org ([69.55.234.183]:23432 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262828AbVD2QnV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 12:43:21 -0400
Date: Fri, 29 Apr 2005 09:38:12 -0700
From: Greg KH <greg@kroah.com>
To: Kylene Jo Hall <kjhall@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10 of 12] Fix Tpm driver -- sysfs owernship changes
Message-ID: <20050429163812.GA32647@kroah.com>
References: <Pine.LNX.4.61.0504271645170.3929@jo.austin.ibm.com> <20050428041915.GD9723@kroah.com> <Pine.LNX.4.61.0504281535330.3947@IBM-8BD8VOWT0JH.austin.ibm.com> <20050429042806.GB25585@kroah.com> <1114792213.20121.7.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1114792213.20121.7.camel@localhost.localdomain>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2005 at 11:30:12AM -0500, Kylene Jo Hall wrote:
> On Thu, 2005-04-28 at 21:28 -0700, Greg KH wrote:
> > On Thu, Apr 28, 2005 at 03:40:16PM -0500, Kylene Hall wrote:
> > > On Wed, 27 Apr 2005, Greg KH wrote:
> > > > On Wed, Apr 27, 2005 at 05:19:03PM -0500, Kylene Hall wrote:
> > > > > -	device_remove_file(&pci_dev->dev, &dev_attr_pubek);
> > > > > -	device_remove_file(&pci_dev->dev, &dev_attr_pcrs);
> > > > > -	device_remove_file(&pci_dev->dev, &dev_attr_caps);
> > > > > +	for (i = 0; i < TPM_NUM_ATTR; i++)
> > > > > +		device_remove_file(&pci_dev->dev, &chip->vendor->attr[i]);
> > > > 
> > > > Use an attribute group, instead of this.  That will allow you to get
> > > > rid of the TPM_NUM_ATTR value, and this looney macro:
> > > > 
> > > > > +#define TPM_DEVICE_ATTRS { \
> > > > > +        __ATTR(pubek, S_IRUGO, tpm_show_pubek, NULL), \
> > > > > +        __ATTR(pcrs, S_IRUGO, tpm_show_pcrs, NULL), \
> > > > > +        __ATTR(caps, S_IRUGO, tpm_show_caps, NULL), \
> > > > > +        __ATTR(cancel, S_IWUSR | S_IWGRP, NULL, tpm_store_cancel) }
> > > > 
> > > > thanks,
> > > > 
> > > > greg k-h
> > > > 
> > > > 
> > > 
> > > Ok, the patch below has the same functionality as the previous patch but 
> > > gets rid of the macro and implements an attribute_group.  Is there any way 
> > > to avoid the repeated code in every tpm_specific file to setup the 
> > > attribute_group and still ensure the files are owned by the tpm_specific 
> > > module?  The only thing I can come up with is either not using the 
> > > TPM_DEVICE macro at all or creating with TPM_DEVICE macro and then 
> > > changing the owner field.
> > 
> > Why are you trying to split this driver up into such tiny pieces?
> > What's wrong with one driver for all devices?
> 
> The driver was orginally all one piece and was split at the suggestion
> of Ian Campbell on this list.

Oh, I remember that.  But if it turns out to be impractical...

thanks,

greg k-h
