Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261695AbVBAHnG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261695AbVBAHnG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 02:43:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261804AbVBAHlP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 02:41:15 -0500
Received: from mail.kroah.org ([69.55.234.183]:45980 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261695AbVBAHkw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 02:40:52 -0500
Date: Mon, 31 Jan 2005 23:39:55 -0800
From: Greg KH <greg@kroah.com>
To: long <tlnguyen@snoqualmie.dp.intel.com>
Cc: linux-kernel@vger.kernel.org, tom.l.nguyen@intel.com
Subject: Re: [PATCH] PCI: add PCI Express Port Bus Driver subsystem
Message-ID: <20050201073955.GA21382@kroah.com>
References: <200501242010.j0OKAPIr003363@snoqualmie.dp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501242010.j0OKAPIr003363@snoqualmie.dp.intel.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2005 at 12:10:25PM -0800, long wrote:
> On Tuesday, January 18, 2005 5:03 PM Greg KH wrote:
> >> >
> >> >That would be great, but it doesn't show up that way on my box.  All
> >> >of
> >> >the portX devices are in /sys/devices/ which is what I don't think
> >> >you
> >> >want.  I would love for them to have the parent of the pci_dev
> >> >structure
> >> >:)
> >> 
> >> Agree. Thanks for your inputs. The patch below include the changes
> >> based on your previous post.
> >
> >Hm, that seems like a pretty big patch just to add a pointer to a parent
> >device :)
> >
> >What really does this patch do?  What does the sysfs tree now look like?
> 
> Before changes:
> 
> The patch makes the parent of the device pointing to the pci_dev
> structure. The parents portX devices are in /sys/devices which
> should be removed based on your suggestions. Below is /sys/devices
> before any changes made.
> 
> /sys/devices
> 	|
> 	__ ide0 
> 	|
> 	__ pci0000:00
> 	|
> 	__ pnp0
> 	|
> 	__ port1
> 	|	|
> 	|  	__ port1.00
> 	|	|
> 	|	__ port1.01
> 	|	.
> 	|	.
> 	|	.
> 	|
> 	__ port2
> 	|
>  	__ port3
> 	|
> 	__ system
> 
> After changes:
> 
> The parents portX devices are no longer necessary because port1.00
> and port1.01 devices shoud have the parent of the pci_dev structure
> (based on your suggestion). The patch does the following changes:
> 
> - remove code creating and handling the parent portX devices.
> - rename portX.YZ to pcieYZ (for example port1.00 renamed to pcie00)
>   since portX is no longer needed.
> - make pcieYZ have the parent of the pci_dev structure.
> 
> Below is /sys/devices after changes made to the patch.
> 
> /sys/devices
> 	|
> 	__ ide0 
> 	|
> 	__ pci0000:00
> 	|	|
> 	|	__ 0000:00:00.0
> 	|	|
> 	|	__ 0000:00:04.0
> 	|	|	|
> 	|	.	__ class
> 	|	.	|
> 	|	.	__ pcie00
> 	|		|
> 	|		__ pcie01
> 	|		.
> 	|		.	
> 	|		.
> 	|
> 	__ platform
> 	|
> 	__ pnp0
> 	|
> 	__ system
> 
> 
> Please let me know what you think of the changes.

Ok, that makes more sense now.  I've applied your patch, thanks.

greg k-h
