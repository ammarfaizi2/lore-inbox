Return-Path: <linux-kernel-owner+w=401wt.eu-S932066AbXARJBv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932066AbXARJBv (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 04:01:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752024AbXARJBv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 04:01:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:42604 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751950AbXARJBu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 04:01:50 -0500
Date: Thu, 18 Jan 2007 01:00:44 -0800
From: Greg KH <greg@kroah.com>
To: Martin Mares <mj@ucw.cz>
Cc: Matthew Wilcox <matthew@wil.cx>, colpatch@us.ibm.com,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [RFC] pci_bus conversion to struct device
Message-ID: <20070118090044.GA23596@kroah.com>
References: <20070118005344.GA8391@kroah.com> <20070118022352.GA17531@parisc-linux.org> <mj+md-20070118.081204.18154.nikam@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mj+md-20070118.081204.18154.nikam@ucw.cz>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 18, 2007 at 09:14:06AM +0100, Martin Mares wrote:
> Hello!
> 
> > I recommend we just delete the pci_bus class.  I don't think it serves
> > any useful purpose.  The bridge can be inferred frmo the sysfs hierarchy
> > (not to mention lspci will tell you).  The cpuaffinity file should be
> > moved from the bus to the device -- it really doesn't make any sense to
> > talk about which cpu a bus is affine to, only a device.
> 
> It doesn't seem to serve any useful purpose other than the affinity now,
> but I still think that it conceptually belongs there, because it makes
> sense to have per-bus attributes. For example, in the future we could
> show data width and signalling speed.

So, if it were to stay, where in the tree should it be?  Hanging off of
the pci device that is the bridge?  Or just placing these files within
the pci device directory itself, as it is the bridge.

There are also some "legacy io" binary sysfs files in these directories
for those platforms that support it (#ifdef HAVE_PCI_LEGACY), and I'm
guessing that there is some user for them out there, otherwise they
would not have been added...

Hm, only ia64 enables that option.  Matthew, do you care about those
files?

thanks,

greg k-h
