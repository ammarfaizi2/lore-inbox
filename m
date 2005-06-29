Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262699AbVF2Wnt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262699AbVF2Wnt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 18:43:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262707AbVF2Wnt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 18:43:49 -0400
Received: from mail.kroah.org ([69.55.234.183]:13459 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262699AbVF2WnA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 18:43:00 -0400
Date: Wed, 29 Jun 2005 15:42:35 -0700
From: Greg KH <greg@kroah.com>
To: matthieu castet <castet.matthieu@free.fr>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: device_remove_file and disconnect
Message-ID: <20050629224235.GC18462@kroah.com>
References: <42C2D354.6060607@free.fr> <20050629184621.GA28447@kroah.com> <42C301F7.4010309@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42C301F7.4010309@free.fr>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2005 at 10:17:59PM +0200, matthieu castet wrote:
> Hi,
> 
> Greg KH wrote:
> >On Wed, Jun 29, 2005 at 06:59:00PM +0200, matthieu castet wrote:
> >
> >>Hi,
> >>
> >>I have a question about sysfs interface.
> >>
> >>If you open a sysfs file created by a module, then remove it (rmmoding 
> >>the module that create this sysfs file), then try to read the opened 
> >>file, you often get strange result (segdefault or oppps).
> >
> >
> >What file did you do this for?  The module count should be incremented
> >if you do this, to prevent the module from being unloaded.
> >
> Ok, but if we unplug a device, then disconnect will be called even if we 
> opened a sysfs file.

Yes but the device structure will still be in memory, so you will be ok.

> Couldn't be a race between the moment we read our private data and check 
> it is valid and the moment we use it :
> 
> Process A (read/write sysfs file) 		Process B (disconnect)
> recover our private data from struct device
> check it is valid
> 						free our private data
> do operation on private data

No, you should not be freeing your private data on your own.  You should
do that in the device release function.

Again, any specific place in the kernel that you see not doing this?

thanks,

greg k-h
