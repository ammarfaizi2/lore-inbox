Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932612AbVJGVrq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932612AbVJGVrq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 17:47:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932623AbVJGVrq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 17:47:46 -0400
Received: from mail.kroah.org ([69.55.234.183]:24994 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932612AbVJGVrq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 17:47:46 -0400
Date: Fri, 7 Oct 2005 14:45:04 -0700
From: Greg KH <greg@kroah.com>
To: William D Waddington <william.waddington@beezmo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFClue] pci_get_device, new driver model
Message-ID: <20051007214504.GA11545@kroah.com>
References: <43469FB8.50303@beezmo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43469FB8.50303@beezmo.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 07, 2005 at 09:18:00AM -0700, William D Waddington wrote:
> CRAP, I think this one got sent when half written - sorry about that.
> 
> I'm missing something fundamental, and beg your indulgence.  Read LDD 3,
> googled, and looked around in the code (but not in the right places...)
> 
> My current 2.6 drivers support multiple identical PCI boards per host.
> The init code spins on pci_find_device and assigns instance/minor
> numbers as boards are found.  Load script insmods the driver,
> gets the major # from /proc/devices, and creates the /dev/ entries
> on the fly.

Ick, don't do that.

> If I convert to pci_get_device, it looks like subsequent calls in the
> loop "put" the previously "gotten" device.  I need the pci_dev struct
> to persist for later use (DMA, etc).  Do I take an additional bump to
> the ref count for each board found before looping, and "put" each when
> the driver is unloaded?

When you save the pointer off, you need to increment the count.

> If I just give in to the new driver model how/when do I associate
> instance/minor numbers with boards found?

It doesn't matter.  Use udev to handle your device naming for you, it
can associate any type of name with any type of device you have, and you
can do it by topology, location, serial number, or the phase of the
moon.

> Is it ever possible for ordinary PCI boards to be (logically) removed
> and re-added w/out removing the driver?

Yes, on hotplug pci systems.  You can fake this out by testing with the
fakephp driver if you don't have this kind of hardware.

> If so, how to maintain association between a particular board and
> minor number?

Again, use udev, that's what it is there for.

Hope this helps,

greg k-h
