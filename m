Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266572AbUIIRtf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266572AbUIIRtf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 13:49:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266391AbUIIRtZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 13:49:25 -0400
Received: from mail.kroah.org ([69.55.234.183]:44984 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266572AbUIIRrL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 13:47:11 -0400
Date: Thu, 9 Sep 2004 10:33:49 -0700
From: Greg KH <greg@kroah.com>
To: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, akpm@osdl.org, bjorn.helgaas@hp.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] missing pci_disable_device()
Message-ID: <20040909173349.GA14633@kroah.com>
References: <413D0E4E.1000200@jp.fujitsu.com> <1094550581.9150.8.camel@localhost.localdomain> <413E7925.1010801@jp.fujitsu.com> <1094647195.11723.5.camel@localhost.localdomain> <413FF05B.8090505@jp.fujitsu.com> <20040909062009.GD10428@kroah.com> <41403075.1010103@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41403075.1010103@jp.fujitsu.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 09, 2004 at 07:29:09PM +0900, Kenji Kaneshige wrote:
> Greg KH wrote:
> >>I understand that there are some devices that need to be enabled
> >>even after their drivers are unloaded, and my approach might not
> >>be safe in this case. I think the best way to solve the problem
> >>(missing pci_disable_device) is to fix broken drivers one by one.
> >>I think debug printk will helpful to fix those drivers, but I
> >>don't know what kind of message is appropriate...
> >
> >Yes, this should be pointed out with a warning message, which will be
> >safer.  How about something like:
> >
> >	dev_warn(&pci_dev->dev, "Device was removed without properly "
> >				"calling pci_disable_device(), please 
> >				fix.\n");
> >	WARN_ON(1);
> >
> >Care to redo your patch with that?
> 
> Thank you for your advice.
> 
> I changed my patch based on your feedback. But I have one
> concern about putting "WARN_ON(1);". I'm worrying that people
> might be surprised if stack dump is shown on their console,
> especially if the broken driver handles many devices.
> 
> For example, following console messages were displayed when I
> tested my patch by loading/unloading 'uhci_hcd' which handles
> two devices on my machine. How do you think?

I like Alan's advice.  Also, a patch for the uhci-hcd driver would be
nice to have :)

thanks,

greg k-h
