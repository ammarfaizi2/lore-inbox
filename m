Return-Path: <linux-kernel-owner+w=401wt.eu-S1751898AbXARDck@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751898AbXARDck (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 22:32:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751907AbXARDck
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 22:32:40 -0500
Received: from ns1.suse.de ([195.135.220.2]:47557 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751898AbXARDck (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 22:32:40 -0500
Date: Wed, 17 Jan 2007 19:31:45 -0800
From: Greg KH <greg@kroah.com>
To: Matthew Wilcox <matthew@wil.cx>
Cc: colpatch@us.ibm.com, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [RFC] pci_bus conversion to struct device
Message-ID: <20070118033145.GA16368@kroah.com>
References: <20070118005344.GA8391@kroah.com> <20070118022352.GA17531@parisc-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070118022352.GA17531@parisc-linux.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 17, 2007 at 07:23:52PM -0700, Matthew Wilcox wrote:
> On Wed, Jan 17, 2007 at 04:53:45PM -0800, Greg KH wrote:
> > I'm trying to clean up all the usages of struct class_device to use
> > struct device, and I ran into the pci_bus code.  Right now you create a
> > symlink called "bridge" under the /sys/class/pci_bus/XXXX:XX/ directory
> > to the pci device that is the bridge.
> 
> I recommend we just delete the pci_bus class.  I don't think it serves
> any useful purpose.  The bridge can be inferred frmo the sysfs hierarchy
> (not to mention lspci will tell you).  The cpuaffinity file should be
> moved from the bus to the device -- it really doesn't make any sense to
> talk about which cpu a bus is affine to, only a device.

I would like to do that, but I want to make sure that no userspace tools
are using this information.

But, as Matt Dobson is now gone off somewhere in Europe, not doing Linux
stuff anymore, he's not going to answer this.  So I'll just make up a
removal patch and let it sit in -mm for a while to see if anything
breaks.

I really only think the big NUMA boxes care about that information, if
anything.

thanks,

greg k-h
