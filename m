Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263274AbTENRaj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 13:30:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263310AbTENRaj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 13:30:39 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:33160 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S263274AbTENRag
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 13:30:36 -0400
Date: Wed, 14 May 2003 10:44:31 -0700
From: Greg KH <greg@kroah.com>
To: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
Cc: linux-kernel@vger.kernel.org, "Saxena, Sunil" <sunil.saxena@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Carbonari, Steven" <steven.carbonari@intel.com>
Subject: Re: RFC Proposal to enable MSI support in Linux kernel
Message-ID: <20030514174431.GA2750@kroah.com>
References: <C7AB9DA4D0B1F344BF2489FA165E50241361D9@orsmsx404.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C7AB9DA4D0B1F344BF2489FA165E50241361D9@orsmsx404.jf.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Even though you are trying to withdraw this message (which is pointless
for something sent to a mailing list), I had a few small questions with
regards to PCI Hotplug devices:

> +/**
> + * msi_hp_free_vectors: reclaim all MSI previous assigned to this device
> + * argument: device pointer of type struct pci_dev 
> + *
> + * description: used during hotplug removed, from which device is
> hot-removed;

Oops, your patch wrapped, please try another email client, or change the
configuration options of your current one.

> + * PCI subsystem reclaims associated MSI to unused state, which may be used
> 
> + * later on.
> + **/ 
> +void remove_hotplug_vectors(void* dev_id)
> +{
> +     struct msi_desc_t *entry;
> +     struct pci_dev *dev = (struct pci_dev *)dev_id;
> +     int type;
> +     void *mask_entry_addr;
> +      unsigned int flags;

Hm, wierd indenting style, can you just follow Documentation/CodingStyle
and use tabs?

Anyway, what code is supposed to use this function?  A PCI Hotplug
controller driver?  If so, do you have any patches to the current
drivers that show how it is used?

Also, why pass a void *?  That's usually forbidden in the kernel, and
since you are instantly casting it to a struct pci_dev *, why not just
use that?

thanks,

greg k-h
