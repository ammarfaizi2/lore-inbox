Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932785AbWBUVKF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932785AbWBUVKF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 16:10:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932784AbWBUVKF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 16:10:05 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:3531 "EHLO
	aria.kroah.org") by vger.kernel.org with ESMTP id S932783AbWBUVKB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 16:10:01 -0500
Date: Tue, 21 Feb 2006 13:10:04 -0800
From: Greg KH <greg@kroah.com>
To: Andi Kleen <ak@suse.de>
Cc: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       akpm@osdl.org, rmk+lkml@arm.linux.org.uk
Subject: Re: [PATCH 3/6] PCI legacy I/O port free driver (take2) - Add device_flags into pci_device_id
Message-ID: <20060221211004.GA12784@kroah.com>
References: <43FAB283.8090206@jp.fujitsu.com> <43FAB375.2020007@jp.fujitsu.com> <20060221205640.GA12423@kroah.com> <200602212159.52106.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602212159.52106.ak@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2006 at 09:59:51PM +0100, Andi Kleen wrote:
> On Tuesday 21 February 2006 21:56, Greg KH wrote:
> 
> > I don't think you can add fields here, after the driver_data field.  It
> > might mess up userspace tools a lot, as you are changing a userspace
> > api.
> 
> User space should look at the ASCII files (modules.*), not the binary
> As long as the code to generate these files still works it should be ok.

Does it?  Shouldn't the tools export this information too, if it really
should belong in the pci_id structure?

So, is _every_ pci driver going to have to be modified to support this
new field if they are supposed to work on this kind of hardware?  If so,
that doesn't sound like a good idea.  Any way we can just set the bit in
the pci arch specific code for the devices instead?

> > Do you _really_ need to pass this information back from userspace to the
> > driver in this manner?
> 
> Well driver_data wouldn't be needed then either. Obviously it's for more
> than just userspace.

For some drivers, they need that driver_data field to be set.  Just
wanting to make sure that this also is needed.

thanks,

greg k-h
