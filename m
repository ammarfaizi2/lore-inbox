Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269467AbUI3UCa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269467AbUI3UCa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 16:02:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269471AbUI3UAB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 16:00:01 -0400
Received: from mail.kroah.org ([69.55.234.183]:33465 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269469AbUI3T72 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 15:59:28 -0400
Date: Thu, 30 Sep 2004 12:59:05 -0700
From: Greg KH <greg@kroah.com>
To: Andi Kleen <ak@suse.de>
Cc: davej@codemonkey.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix improper use of pci_module_init() in drivers/char/agp/amd64-agp.c
Message-ID: <20040930195905.GA18162@kroah.com>
References: <20040930184248.GA17546@kroah.com> <20040930192008.GA28315@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040930192008.GA28315@wotan.suse.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2004 at 09:20:09PM +0200, Andi Kleen wrote:
> On Thu, Sep 30, 2004 at 11:42:48AM -0700, Greg KH wrote:
> > Hi,
> > 
> > In going through the tree and auditing the usage of pci_module_init(), I
> > noticed that the amd64-agp driver was assuming that the return value of
> > this function could be greater than 0 (which is what could happen in 2.2
> > and 2.4 kernels.)  As this is no longer true, I think the following
> > patch is correct.
> > 
> > I can add this to my bk-pci tree if you wish, otherwise feel free to
> > send it upwards.
> 
> There needs to be some replacement for it, you cannot just delete 
> the code.

But that code has not ever run, since early 2.5 days.  Don't tell me
people are used to it :)

> The idea is to run it as fallback when no devices are found. 
> 
> How about this patch?

That does not work the way you are asking it to work.  pci_module_init()
is just a replacement for pci_register_driver these days.  It will
return either "0" if the driver is successfully registered, or a
negative value if something bad happened.  It will not return the number
of devices that this driver bound to.

So, if no devices are in the system, it will return 0, and again, the
code you are wanting to run, will not.

So, how about using the new pci_dev_present() call instead?  That should
be what you want, right?

thanks,

greg k-h
