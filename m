Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267389AbUHJBfV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267389AbUHJBfV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 21:35:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267394AbUHJBfV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 21:35:21 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:39103 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S267389AbUHJBeU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 21:34:20 -0400
Subject: Re: [Pcihpd-discuss] struct pci_bus, no release() function?
From: John Rose <johnrose@austin.ibm.com>
To: Greg KH <greg@kroah.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
       Hotplug List <pcihpd-discuss@lists.sourceforge.net>
In-Reply-To: <20040809064524.GD13690@kroah.com>
References: <1091477728.23381.24.camel@sinatra.austin.ibm.com>
	 <20040809064524.GD13690@kroah.com>
Content-Type: text/plain
Message-Id: <1092069286.20704.20.camel@sinatra.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 09 Aug 2004 11:34:46 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-08-09 at 01:45, Greg KH wrote:
> On Mon, Aug 02, 2004 at 03:15:28PM -0500, John Rose wrote:
> > At probe time, pci_scan_bus_parented() allocates and registers a struct
> > device for each PCI bus it scans.  This generic device structure never
> > gets assigned a "release" function.  
> > 
> > Attempts to unregister such a PCI Bus at runtime result in a kernel
> > message like:
> > Device 'pci0001:00' does not have a release() function, it is broken and
> > must be fixed.
> 
> You're right, that should be fixed.  Care to send a patch?  Should just
> be a 1 line change.  You can tell no one else has tried to remove a root
> bus device before...
> 
> > Are architectures free to assign their own release function for
> > "devices" associated with struct pci_bus?
> 
> Why would they want to?  It should just be set to pci_release_dev, like
> all other struct pci_dev devices are, right?

Root buses don't have an associated pci_dev struct, so this function
won't do.  Is that specific to ppc64?  Regardless, seems like we need a
special release func for this case.

Thanks-
John

