Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262240AbULRAHm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262240AbULRAHm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 19:07:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262245AbULRAHl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 19:07:41 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:5048 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262240AbULRAFo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 19:05:44 -0500
Date: Fri, 17 Dec 2004 16:05:31 -0800
From: Greg KH <greg@kroah.com>
To: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH]PCI Express Port Bus Driver
Message-ID: <20041218000531.GC24586@kroah.com>
References: <C7AB9DA4D0B1F344BF2489FA165E5024073EBAE0@orsmsx404.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C7AB9DA4D0B1F344BF2489FA165E5024073EBAE0@orsmsx404.amr.corp.intel.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2004 at 04:06:44PM -0800, Nguyen, Tom L wrote:
> On Wednesday, December 15, 2004 1:37 PM, Greg KH wrote: 
> >> +config PCIEPORTBUS
> >> +	bool "PCI Express support"
> >> +	depends on PCI_GOMMCONFIG
> >
> > This should also work if PCI_GOANY is selected, right?  Otherwise this
> > feature will never be turned on by any distro :(
> PCIE port bus driver depends on PCI_GOMMCONFIG to locate service
> attributes for advanced error reporting (AER) and virtual channel (VC)
> for each PCIE port.  Without PCI_GOMMCONFIG, then a read to 0x100
> offset or above will return 0xffff; in other words, neither AER nor VC
> service support is found. We would like to move forward to have
> PCI_GOMMCONFIG dependency as the new features come along. RHEL 4 is
> shipping with PCI_GOMMCONFIG configured into the kernel by default and
> we expect the next major version of SuSE linux to do the same.

Hm, I get a oops message at boot time, on a non-pci express box, with
PCI_GOMMCONFIG enabled and your patch.  Something down in the ACPI
subsystem. 

Have you tested this kind of configuration?

I'll hold off on applying the patch for now due to this :)

thanks,

greg k-h
