Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030515AbVJGSTT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030515AbVJGSTT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 14:19:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030526AbVJGSTT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 14:19:19 -0400
Received: from mail.kroah.org ([69.55.234.183]:42930 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1030515AbVJGSTS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 14:19:18 -0400
Date: Fri, 7 Oct 2005 11:18:55 -0700
From: Greg KH <greg@kroah.com>
To: Kristen Accardi <kristen.c.accardi@intel.com>
Cc: pcihpd-discuss@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       acpi-devel@lists.sourceforge.net, rajesh.shah@intel.com,
       len.brown@intel.com
Subject: Re: [patch 1/2] acpiphp: allocate resources for adapters with bridges
Message-ID: <20051007181855.GD6925@kroah.com>
References: <1128707147.11020.10.camel@whizzy> <20051007175903.GA6925@kroah.com> <1128708344.11020.15.camel@whizzy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1128708344.11020.15.camel@whizzy>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 07, 2005 at 11:05:44AM -0700, Kristen Accardi wrote:
> On Fri, 2005-10-07 at 10:59 -0700, Greg KH wrote:
> > On Fri, Oct 07, 2005 at 10:45:46AM -0700, Kristen Accardi wrote:
> > > Allocate resources for adapters with p2p bridges.
> > > 
> > > Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
> > > 
> > > diff -uprN -X linux-2.6.14-rc2/Documentation/dontdiff linux-2.6.14-rc2/drivers/pci/hotplug/acpiphp_glue.c linux-2.6.14-rc2-kca1/drivers/pci/hotplug/acpiphp_glue.c
> > > --- linux-2.6.14-rc2/drivers/pci/hotplug/acpiphp_glue.c	2005-08-28 16:41:01.000000000 -0700
> > > +++ linux-2.6.14-rc2-kca1/drivers/pci/hotplug/acpiphp_glue.c	2005-09-28 10:43:15.000000000 -0700
> > > @@ -58,6 +58,9 @@ static LIST_HEAD(bridge_list);
> > >  
> > >  static void handle_hotplug_event_bridge (acpi_handle, u32, void *);
> > >  static void handle_hotplug_event_func (acpi_handle, u32, void *);
> > > +static void acpiphp_sanitize_bus(struct pci_bus *bus);
> > > +static void acpiphp_set_hpp_values(acpi_handle handle, struct pci_bus *bus);
> > 
> > These are not static functions, but functions somewhere else in the
> > kernel.  Please put their function prototypes in a header file
> > somewhere.  You also need to EXPORT_SYMBOL_GPL() them so that the
> > hotplug driver can use them when it is loaded as a module.
> > 
> > thanks,
> > 
> > greg k-h
> 
> Actually, these functions are present as static functions in
> acpiphp_glue.c, and only used in acpiphp_glue.c, so I don't believe I
> need to export them or make them non static (they are static currently).

oops, sorry, you are right, I got those confused with the other acpi
function you added.

greg k-h
