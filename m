Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261662AbUKCQNh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261662AbUKCQNh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 11:13:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261669AbUKCQNh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 11:13:37 -0500
Received: from ltgp.iram.es ([150.214.224.138]:37763 "EHLO ltgp.iram.es")
	by vger.kernel.org with ESMTP id S261662AbUKCQNb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 11:13:31 -0500
From: Gabriel Paubert <paubert@iram.es>
Date: Wed, 3 Nov 2004 17:13:04 +0100
To: "H. Wiese" <7.e.Q@syncro-community.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: IP Layer on VME-Bus
Message-ID: <20041103161304.GB8075@iram.es>
References: <33093.192.35.17.30.1099489553.squirrel@config.hostunreachable.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33093.192.35.17.30.1099489553.squirrel@config.hostunreachable.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 03, 2004 at 02:45:53PM +0100, H. Wiese wrote:
> Hello,
> 
> we develop a driver which enables us to use an ip layer on top of the vme-bus
> technology. Now we got some problems with coding the driver. We already have
> an old version of this driver (called "dpn") which works well but has no use
> for us anymore since we upgraded our system from kernel 2.2.14 to 2.6.7. So
> now we have to create a new driver.
> 
> The old driver established the ip layer by accessing the dual port ram of
> the VME bus, which is based on a Tundra Universe II Chipset. This enables
> us to transfer data, ping etc. between active VME-modules using the
> VME-bus. Very useful.

Which Universe driver did you use? 

There are several floating around, mine among them. I plan to port 
it to 2.6, time permitting but I'm a bit worried by the size of the 
kernel these days. I have to run diskless systems with 16MB of RAM, 
my 2.2 kernels are about 800kB while the 2.6 kernels on my Mac are 
in the 5MB or more range. Even after removing USB, ext3 and a few 
other things, the 2.6.x kernel will be at least twice the size of 
the 2.2 series it seems.

With my Universe driver or anything derived from it, the thing to 
watch out for is the PCI memory space allocation, 2.2 simply did 
not have the support (it mostly used the thing as the BIOS/firmware
had configures it) and the Universe is a PCI mmio space hog with
base registers outside the standard PCI header space (there are 
valid reasons for both of these characteristics). 

> Well, the problem we will surely run into is: will the driver work as fine as
> the old one if we only recreate the initialization functions working with the
> new kernel function set (e.g. wait_event_interruptible instead of
> interruptible_sleep_on etc.), copy the essential functions from the old
> driver
> to the new one and alter them a little to work with the new kernel functions?

I'm already using wait_event_ and friends in my 2.2 drivers,
you should select a better example ;-)

	Regards,
	Gabriel
