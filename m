Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263202AbVBDXgl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263202AbVBDXgl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 18:36:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265955AbVBDXgj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 18:36:39 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:18662 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S263202AbVBDXfG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 18:35:06 -0500
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Legacy IO spaces (was Re: [RFC] Reliable video POSTing on resume)
Date: Fri, 4 Feb 2005 15:34:02 -0800
User-Agent: KMail/1.7.2
Cc: Pavel Machek <pavel@ucw.cz>,
       Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>,
       ncunningham@linuxmail.org, ACPI List <acpi-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Matthew Garrett <mjg59@srcf.ucam.org>
References: <20050122134205.GA9354@wsc-gmbh.de> <200502041010.13220.jbarnes@engr.sgi.com> <9e4733910502041459500ae8d3@mail.gmail.com>
In-Reply-To: <9e4733910502041459500ae8d3@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502041534.03004.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, February 4, 2005 2:59 pm, Jon Smirl wrote:
> Can you build a no-op version of these that will run on the x86? That
> would allow a single user space API for x86, ia64. Maybe the ppc
> people will join too.

Shouldn't be too hard I think.

> Why does this appear in /sys/class/pci_bus/0000:17/? For example on my
> x86 system I have a single legacy space but if I do a dir of
> /sys/class/pci_bus I show three buses. You wouldn't want the
> legacy_io/mem attributes on each of these three buses since that
> implies three independent address spaces.
>
> [jonsmirl@jonsmirl pci_bus]$ ls /sys/class/pci_bus
> 0000:00  0000:01  0000:02

In that case they'll all point to the same memory and I/O space.  On the 
machines I coded it on, each bus has its own space.

> How would things be sorted out so that legacy_io/mem attributes only
> appear on my root bridge chip 0000:00 and not on the child buses. I
> guess this also means the user space app has to search through the bus
> entries.

We might have to add more arch code in that case, but I thought it might be 
easiest for apps if they could just open the space for the bus they're 
interested in and it would be routed correctly.  I think that'll be ok so 
long as two apps aren't trying to do stuff on the bus at the same time.

> In order to know how many VGA many simultaneous VGA devices you can
> have there needs to be some way to count the number of legacy address
> spaces. Maybe there should be a /sys/class/legacy to describe the
> legacy spaces. Is it possible to have the same legacy space aliased at
> two different addresses depending on which root bus is used to get to
> it?
>
> I need to know how to answer these questions:
> 1) how many legacy spaces are there

Depends on your platform.

> 2) how many VGA devices are in each space

Ditto since the number of spaces depends on the platform.

> 3) how do I do VGA bus routing to access the VGA device

This interface just deals with the whole legacy ISA space, not just VGA ports.  
I guess some chipsets will do VGA only or split them up?

> 4) how do I address each of the devices.

Jesse
