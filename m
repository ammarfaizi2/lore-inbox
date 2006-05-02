Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964918AbWEBQXU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964918AbWEBQXU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 12:23:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964915AbWEBQXU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 12:23:20 -0400
Received: from mx1.suse.de ([195.135.220.2]:17850 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964919AbWEBQXT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 12:23:19 -0400
Date: Tue, 2 May 2006 09:21:36 -0700
From: Greg KH <greg@kroah.com>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, Dave Airlie <airlied@linux.ie>,
       Arjan van de Ven <arjan@linux.intel.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, pjones@redhat.com
Subject: Re: Add a "enable" sysfs attribute to the pci devices to allow userspace (Xorg) to enable devices without doing foul direct access
Message-ID: <20060502162136.GA4668@kroah.com>
References: <1146300385.3125.3.camel@laptopd505.fenrus.org> <1146301148.3125.7.camel@laptopd505.fenrus.org> <Pine.LNX.4.64.0604291001490.2080@skynet.skynet.ie> <200605021014.45684.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200605021014.45684.bjorn.helgaas@hp.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 02, 2006 at 10:14:45AM -0600, Bjorn Helgaas wrote:
> On Saturday 29 April 2006 03:04, Dave Airlie wrote:
> > 
> > > This patch adds an "enable" sysfs attribute to each PCI device. When read it
> > > shows the "enabled-ness" of the device, but you can write a "0" into it to
> > > disable a device, and a "1" to enable it.
> > >
> > > This later is needed for X and other cases where userspace wants to enable
> > > the BARs on a device (typical example: to run the video bios on a secundary
> > > head). Right now X does all this "by hand" via bitbanging, that's just evil.
> > > This allows X to no longer do that but to just let the kernel do this.
> > >
> > > Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
> > > CC: Peter Jones <pjones@redhat.com>
> > > CC: Dave Airlie <airlied@linux.ie>
> > 
> > ACK
> > 
> > This would allow me to remove the issue in X where loading the DRM at X 
> > startup acts differently than loading the DRM before X runs, due to Xs PCI 
> > probe running in-between... with this I can just enable all VGA devices 
> > and no worry whether they have a DRM or not..
> 
> This sysfs "enable" patch seems like goodness.
> 
> But I hope that when X uses this, it only enables & disables VGA
> devices it's actually using.  In the past, it seems like X has
> blindly disabled *all* VGA devices in the system, even though
> they might be in use by another X server.  I'm sure that's all
> well-understood and cleaned up now; just wanted to make sure
> this nightmare didn't recur.

Hopefully with the recent PCI changes to X, this will not happen.  If it
does, that's a big bug in X :)

thanks,

greg k-h
