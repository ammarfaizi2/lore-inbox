Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261835AbUKJBjG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261835AbUKJBjG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 20:39:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261834AbUKJBjG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 20:39:06 -0500
Received: from mail.kroah.org ([69.55.234.183]:46236 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261826AbUKJBij (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 20:38:39 -0500
Date: Tue, 9 Nov 2004 17:24:43 -0800
From: Greg KH <greg@kroah.com>
To: Li Shaohua <shaohua.li@intel.com>
Cc: ACPI-DEV <acpi-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>,
       Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: [PATCH/RFC 1/4]device core changes
Message-ID: <20041110012443.GA9496@kroah.com>
References: <1099887071.1750.243.camel@sli10-desk.sh.intel.com> <20041108225810.GB16197@kroah.com> <1099961418.15294.11.camel@sli10-desk.sh.intel.com> <1099971341.15294.48.camel@sli10-desk.sh.intel.com> <20041109045843.GA4849@kroah.com> <1099990981.15294.57.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1099990981.15294.57.camel@sli10-desk.sh.intel.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 09, 2004 at 05:03:01PM +0800, Li Shaohua wrote:
> On Tue, 2004-11-09 at 12:58, Greg KH wrote:
> > On Tue, Nov 09, 2004 at 11:35:41AM +0800, Li Shaohua wrote:
> > > On Tue, 2004-11-09 at 08:50, Li Shaohua wrote:
> > > > On Tue, 2004-11-09 at 06:58, Greg KH wrote:
> > > > > On Mon, Nov 08, 2004 at 12:11:11PM +0800, Li Shaohua wrote:
> > > > > > Hi,
> > > > > > This is the device core change required. Add .platform_bind method for
> > > > > > bus_type, so platform can do addition things when add a new device. A
> > > > > > case is ACPI, we want to utilize some ACPI methods for physical devices.
> > > > > > 1. Why doesn't use 'platform_notify'?
> > > > > > Current device core has a 'platform_notify' mechanism, but it's not
> > > > > > sufficient for this. Only sepcific bus type know how to parse dev.bus_id
> > > > > > and know how to encode specific device's address into ACPI _ADR syntax.
> > > > > 
> > > > > I don't see why platform_notify is not sufficient.  This is the exact
> > > > > reason it was added to the code.
> > > > As I said in the email, we need know the bus type to decode and encode
> > > > address. If you use platform_notify, you must do something like this:
> > > > switch (dev->bus)
> > > > {
> > > > case pci_bus_type:
> > > > bind PCI devices with ACPI devices
> > > > break;
> > > > case ide_bus_type:
> > > > bind IDE devices with ACPI devices
> > > > break;
> > > > ....
> > > > }
> > > > But note this method requires all bus types are build-in. If a bus type
> > > > is in a loadable module (such as IDE bus), the method will failed. I
> > > > searched current tree, only ARM implemented 'platform_notify', but ARM
> > > > only cares PCI bus, ACPI cares about all bus types.
> > > > > 
> > > Oops, it's my bad. we can identify the bus type from bus_type->name, but
> > > it looks like a little ugly. Why the bus_type hasn't a flag to identify
> > > which bus it is?
> > 
> > Because if you have a struct bus * you _have_ to know what type it is.
> > 
> > > Anyway, thanks Greg. I will add as you said.
> > 
> > Hm, hopefully Pat will chime in about what would be best for this, as he
> > created the platform_notify interface.
> Ok, an updated version. Use 'platform_notify', but add a 'type' in 
> 'struct bus_type'. Using bus_type->name to identify the bus type is
> pretty much ugly and slow. 

No, no "type" for a bus, sorry.

Maybe your other patches weren't so bad...  If we implement them, can we
drop the platform notify stuff?

thanks,

greg k-h
