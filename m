Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030248AbWARFMe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030248AbWARFMe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 00:12:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030240AbWARFMe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 00:12:34 -0500
Received: from mail.kroah.org ([69.55.234.183]:24451 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1030237AbWARFMd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 00:12:33 -0500
Date: Tue, 17 Jan 2006 21:11:40 -0800
From: Greg KH <greg@kroah.com>
To: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Cc: Kristen Accardi <kristen.c.accardi@intel.com>,
       linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net,
       len.brown@intel.com, linux-acpi@vger.kernel.org, pavel@ucw.cz
Subject: Re: [Pcihpd-discuss] [patch 2/4]  acpiphp: handle dock bridges
Message-ID: <20060118051140.GB7493@kroah.com>
References: <20060116200218.275371000@whizzy> <1137545819.19858.47.camel@whizzy> <43CDA761.5040707@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43CDA761.5040707@jp.fujitsu.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2006 at 11:26:41AM +0900, Kenji Kaneshige wrote:
> Hi,
> 
> > +static struct acpiphp_func * get_func(struct acpiphp_slot *slot,
> > +					struct pci_dev *dev)
> > +{
> > +	struct list_head *l;
> > +	struct acpiphp_func *func;
> > +	struct pci_bus *bus = slot->bridge->pci_bus;
> > +
> > +	list_for_each (l, &slot->funcs) {
> > +		func = list_entry(l, struct acpiphp_func, sibling);
> > +		if (pci_get_slot(bus, PCI_DEVFN(slot->device,
> > +					func->function)) == dev)
> > +			return func;
> > +	}
> 
> This seems to leak reference counter of pci_dev. I think you
> must call pci_dev_put() also.

Yes, good catch.

thanks,

greg k-h
