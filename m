Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751241AbVK1U6q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751241AbVK1U6q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 15:58:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751253AbVK1U6q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 15:58:46 -0500
Received: from mail.kroah.org ([69.55.234.183]:35027 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751241AbVK1U6o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 15:58:44 -0500
Date: Mon, 28 Nov 2005 12:56:12 -0800
From: Greg KH <greg@kroah.com>
To: Doug Thompson <norsk5@yahoo.com>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [RFC] EDAC a new sysfs 'subsystem' under /sys/devices
Message-ID: <20051128205612.GG17740@kroah.com>
References: <20051122235744.15404.qmail@web50110.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051122235744.15404.qmail@web50110.mail.yahoo.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2005 at 03:57:44PM -0800, Doug Thompson wrote:
> EDAC is for detecting and logging memory ECC, PCI
> Parity and (future) other hardware errors.
> 
> In my process of getting edac ready for kernel
> submission:
> 
> I have been exploring mechanisms for placing EDAC
> controls and attribute files into sysfs for a few days
> now.
> 
> In the process, I "discovered" how sysfs subystems are
> currently used. I have determined that EDAC itself
> should be a subsystem, since more than one type of
> EDAC device can be created.
> 
> I made a copy of drivers/base/sys.c to a new file,
> drivers/base/edac.c (and corresponding .h file) and
> refactored it to become a 'edacdev' subsystem.
> 
> I have mounted edac to: /sys/devices/edac because the
> /sys/device/system subsystem is not exported (at the
> moment. I suppose that could be changed). 

Yes, that would be trivial to do :)

> I now have:
> 
> /sys/devices/edac/mc/mc0/csrow0 kobjects working and
> am adding attribute files to their respective
> kobjects.
> 
> My RFC is:
> 
> Should I leave edac under /sys/devices OR refactor
> drivers/base/sys.c and export the "system" subsystem
> and mount edac under /sys/devices/system? 

Please put it under /sys/devices/system.

Also, see the patch on lkml from Pat Mochel which might make your deep
sysfs trees much easier to create and use.

> Another RFC is:
> 
> Should EDAC really have a "new" subsystem in the
> kernel?  (I believe it fits bets, but am looking for
> alternatives)

Why not just a system device?

> It requires a new drivers/base/edac.c (and .h file +
> plumbing).  I would like to see that, as it really
> works nicely. The EDAC module currently in the -mm
> tree will depend  on it, in order to implement the
> requested sysfs features. (Other options are possible
> I suppose)

No, you should not be adding stuff to drivers/base.

> The only problem I ran into was that I needed further
> subdirectories under 'mc/mc0', and I had to resort to
> using kobject_register() since the subsystem didn't
> have methods for such creation. Yet that code now
> works nicely.

See the patch from Pat for how to do this easier.  But even without that
patch, creating new kobjects is one way to do it.

thanks,

greg k-h
