Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264829AbUEEWcu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264829AbUEEWcu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 18:32:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264830AbUEEWcu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 18:32:50 -0400
Received: from mail.kroah.org ([65.200.24.183]:40373 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264829AbUEEWcW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 18:32:22 -0400
Date: Wed, 5 May 2004 15:31:02 -0700
From: Greg KH <greg@kroah.com>
To: Matt Domsch <Matt_Domsch@dell.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: PCI devices with no PCI_CACHE_LINE_SIZE implemented
Message-ID: <20040505223102.GF30003@kroah.com>
References: <20040429195301.GB15106@lists.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040429195301.GB15106@lists.us.dell.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2004 at 02:53:01PM -0500, Matt Domsch wrote:
> Greg,
> 
> Some PCI device functions, such as the EHCI portion of Intel ICH5 and
> ICH6 chips, do not implement the PCI_CACHE_LINE_SIZE register (which
> is legal to not implement per PCI spec as it is a busmaster that
> cannot issue a MWI).  However, for each of these, the kernel tries to
> set the value, fails, and prints a KERN_WARNING message about it.
> 
> a) need this be a warning, wouldn't KERN_DEBUG suffice, if a message
> is needed at all?  This is printed in pci_generic_prep_mwi().

Yes, we should make that KERN_DEBUG.  I don't have a problem with that.
Care to make a patch?

> b) How might you prefer to handle such devices?
> 
> Per the PCI 2.3 spec, reading a value of 0 may mean several things:
> 1) setting the register at all isn't supported
>    - this is what pci.c assumes now and returns -EINVAL.
> 2) setting the register to the value you tried isn't supported, but
>    you can try again with another value until you find the right one.
>    - but there are no hints as to what the right value for a device
>      might be.

I think we need to stick with 1, unless we get more info on what the
"proper" value should be.

thanks,

greg k-h
