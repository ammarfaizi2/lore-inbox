Return-Path: <linux-kernel-owner+w=401wt.eu-S964872AbXASG6O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964872AbXASG6O (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 01:58:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964894AbXASG6O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 01:58:14 -0500
Received: from colo.lackof.org ([198.49.126.79]:36830 "EHLO colo.lackof.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964893AbXASG6N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 01:58:13 -0500
Date: Thu, 18 Jan 2007 23:58:05 -0700
From: Grant Grundler <grundler@parisc-linux.org>
To: Martin Mares <mj@ucw.cz>
Cc: Matthew Wilcox <matthew@wil.cx>, Greg KH <greg@kroah.com>,
       colpatch@us.ibm.com, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [RFC] pci_bus conversion to struct device
Message-ID: <20070119065805.GA14240@colo.lackof.org>
References: <20070118005344.GA8391@kroah.com> <20070118022352.GA17531@parisc-linux.org> <mj+md-20070118.081204.18154.nikam@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mj+md-20070118.081204.18154.nikam@ucw.cz>
X-Home-Page: http://www.parisc-linux.org/
User-Agent: Mutt/1.5.9i
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

Other per bus attributes might be address routing, VGA routing enabled,
Fast-back-to-back enabled. PCI-X bridges and PCI-e bridges might also
advertise data related to MMRBC and similar onboard buffer mgt behaviors.

ISTR, IBM PCI-X bridge works better with 512 "block" (data xfer size)
than larger sizes becuase it internally allocates buffer space
in 512B chunks. It would be useful to know along with downstream
device MMRBC. Not sure this all has to come from /sys though.

grant
