Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262057AbUCDS1v (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 13:27:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262064AbUCDS1u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 13:27:50 -0500
Received: from mail.kroah.org ([65.200.24.183]:51346 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262057AbUCDS1t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 13:27:49 -0500
Date: Thu, 4 Mar 2004 10:27:34 -0800
From: Greg KH <greg@kroah.com>
To: Ingo Oeser <ioe-lkml@rameria.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI Hotplug fixes for 2.6.4-rc1
Message-ID: <20040304182734.GE13907@kroah.com>
References: <1078287705197@kroah.com> <200403040716.51298.ioe-lkml@rameria.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200403040716.51298.ioe-lkml@rameria.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 04, 2004 at 07:17:37AM +0100, Ingo Oeser wrote:
> Hi Greg,
> 
> On Wednesday 03 March 2004 05:21, Greg KH wrote:
> > -decl_subsys(pci_hotplug_slots, &hotplug_slot_ktype, NULL);
> > -
> > +/*
> > + * We create a struct subsystem on our own and not use decl_subsys so
> > + * we can have a sane name "slots" in sysfs, yet still keep a good
> > + * global variable name "pci_hotplug_slots_subsys.
> > + * If the decl_subsys() #define ever changes, this declaration will
> > + * need to be update to make sure everything is initialized properly.
> > + */
> > +struct subsystem pci_hotplug_slots_subsys = {
> > +	.kset = {
> > +		.kobj = { .name = "slots" },
> > +		.ktype = &hotplug_slot_ktype,
> > +	}
> > +};
> 
> How about creating a decl_subsys_name() for creating sane names,
> like we have for the module parameters?
> 
> That whould solve all those problems, since this is used not only once.

Good idea.  Care to make up such a patch?

thanks,

greg k-h
