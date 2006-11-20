Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966768AbWKTV2f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966768AbWKTV2f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 16:28:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966787AbWKTV2e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 16:28:34 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:6079 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S966768AbWKTV2e
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 16:28:34 -0500
Date: Mon, 20 Nov 2006 16:28:32 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
cc: linux1394-devel@lists.sourceforge.net, Greg Kroah-Hartman <gregkh@suse.de>,
       <linux-kernel@vger.kernel.org>
Subject: Re: deadlock in "modprobe -r ohci1394" shortly after "modprobe
 ohci1394"
In-Reply-To: <456213F2.8070805@s5r6.in-berlin.de>
Message-ID: <Pine.LNX.4.44L0.0611201626390.7916-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Nov 2006, Stefan Richter wrote:

> Alan Stern wrote:
> > Wait a minute.  Above you agreed that the problem was caused by knodemgrd 
> > attempting to rescan the host's _parent_.  So which is the focus of the 
> > deadlock: the host or its parent?
> 
> The parent of the hpsb_host.
> 
> ohci1394 works on a pci_dev which contains a dev, let's call it A.
> 
> ieee1394 has a hpsb_host which contains a dev, let's call it B. B's
> parent is A. Then there is one or more node_entry with dev C whose
> parent is B, end unit_directory with dev D whose parent is C.
> 
> The bus of devices B, C, D is set to be ieee1394_bus_type, and that's
> what knodemgrd is scanning.
> 
> knodemgrd blocks on the semaphore of the parent of B because
> driver_detach took the semaphore of A (and of the parent of A if there
> is one).

Okay, I get it.

> > Is the problem caused by the fact that some of these struct device's 
> > aren't bound to a driver?  Remember, bus_rescan_devices() will skip over 
> > anything that already has a driver.  Could you solve your problem by 
> > adding a do_nothing driver that would bind to these otherwise unused 
> > devices?
> 
> Excellently, that's what I will try in a minute. It is surely intended
> that the hpsb_host can get a driver bound too, but as I mentioned, we
> don't have a driver which needs this capability and I don't foresee any
> such driver.
> 
> Thanks for the directions.

You're welcome.  Let me know how it turns out.

Alan Stern

