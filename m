Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267548AbUHJSRB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267548AbUHJSRB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 14:17:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267656AbUHJSQ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 14:16:58 -0400
Received: from mail.kroah.org ([69.55.234.183]:8417 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267548AbUHJSQU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 14:16:20 -0400
Date: Tue, 10 Aug 2004 09:30:29 -0700
From: Greg KH <greg@kroah.com>
To: John Rose <johnrose@austin.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
       Hotplug List <pcihpd-discuss@lists.sourceforge.net>
Subject: Re: [Pcihpd-discuss] struct pci_bus, no release() function?
Message-ID: <20040810163029.GA30942@kroah.com>
References: <1091477728.23381.24.camel@sinatra.austin.ibm.com> <20040809064524.GD13690@kroah.com> <1092069286.20704.20.camel@sinatra.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092069286.20704.20.camel@sinatra.austin.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 09, 2004 at 11:34:46AM -0500, John Rose wrote:
> On Mon, 2004-08-09 at 01:45, Greg KH wrote:
> > On Mon, Aug 02, 2004 at 03:15:28PM -0500, John Rose wrote:
> > > At probe time, pci_scan_bus_parented() allocates and registers a struct
> > > device for each PCI bus it scans.  This generic device structure never
> > > gets assigned a "release" function.  
> > > 
> > > Attempts to unregister such a PCI Bus at runtime result in a kernel
> > > message like:
> > > Device 'pci0001:00' does not have a release() function, it is broken and
> > > must be fixed.
> > 
> > You're right, that should be fixed.  Care to send a patch?  Should just
> > be a 1 line change.  You can tell no one else has tried to remove a root
> > bus device before...
> > 
> > > Are architectures free to assign their own release function for
> > > "devices" associated with struct pci_bus?
> > 
> > Why would they want to?  It should just be set to pci_release_dev, like
> > all other struct pci_dev devices are, right?
> 
> Root buses don't have an associated pci_dev struct, so this function
> won't do.

Ah, good point.  We should probably fix that up and make it a struct
pci_dev.  Or just make a release function for the struct device we
create.  Either way is fine for me.

thanks,

greg k-h
