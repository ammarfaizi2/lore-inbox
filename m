Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269356AbUIIGXI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269356AbUIIGXI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 02:23:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269357AbUIIGXI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 02:23:08 -0400
Received: from mail.kroah.org ([69.55.234.183]:40111 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269356AbUIIGXD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 02:23:03 -0400
Date: Wed, 8 Sep 2004 23:20:09 -0700
From: Greg KH <greg@kroah.com>
To: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, akpm@osdl.org, bjorn.helgaas@hp.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] missing pci_disable_device()
Message-ID: <20040909062009.GD10428@kroah.com>
References: <413D0E4E.1000200@jp.fujitsu.com> <1094550581.9150.8.camel@localhost.localdomain> <413E7925.1010801@jp.fujitsu.com> <1094647195.11723.5.camel@localhost.localdomain> <413FF05B.8090505@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <413FF05B.8090505@jp.fujitsu.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 09, 2004 at 02:55:39PM +0900, Kenji Kaneshige wrote:
> Alan Cox wrote:
> > On Mer, 2004-09-08 at 04:14, Kenji Kaneshige wrote:
> >> > Think about unloading frame buffers or PCI devices with multiple
> >> > functions and multiple drivers. I agree the drivers definitely want
> >> > fixing where appropriate. I'm not sure your approach is safe (although a
> >> 
> >> I don't understand what you are worried about. Could you tell me
> >> what would be a problem with frame buffers or PCI devices with
> >> multiple functions?
> > 
> > If I have a framebuffer driver loaded for my video card in bitmap mode
> > all is well. If I unload it you then disable the video hardware even
> > though it would still be otherwise usable in text mode.
> > 
> > The same occurs when one PCI device has multiple functions (not PCI
> > functions but linux drivers using it). There are some examples of this
> > such as the CS5520 where one BAR is the IDE controller.
> > 
> 
> Thank you for answering.
> 
> I understand that there are some devices that need to be enabled
> even after their drivers are unloaded, and my approach might not
> be safe in this case. I think the best way to solve the problem
> (missing pci_disable_device) is to fix broken drivers one by one.
> I think debug printk will helpful to fix those drivers, but I
> don't know what kind of message is appropriate...

Yes, this should be pointed out with a warning message, which will be
safer.  How about something like:

	dev_warn(&pci_dev->dev, "Device was removed without properly "
				"calling pci_disable_device(), please fix.\n");
	WARN_ON(1);

Care to redo your patch with that?

thanks,

greg k-h
