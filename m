Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932293AbWHPW1a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932293AbWHPW1a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 18:27:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932294AbWHPW1a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 18:27:30 -0400
Received: from cantor2.suse.de ([195.135.220.15]:36537 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932293AbWHPW13 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 18:27:29 -0400
Date: Wed, 16 Aug 2006 15:26:33 -0700
From: Greg KH <greg@kroah.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: PATCH: Multiprobe sanitizer
Message-ID: <20060816222633.GA6829@kroah.com>
References: <1155746538.24077.371.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1155746538.24077.371.camel@localhost.localdomain>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2006 at 05:42:18PM +0100, Alan Cox wrote:
> There are numerous drivers that can use multithreaded probing but having
> some kind of global flag as the way to control this makes migration to
> threaded probing hard and since it enables it everywhere and is almost
> as likely to cause serious pain as holding a clog dance in a minefield.
> 
> If we have a pci_driver multithread_probe flag to inherit you can turn
> it on for one driver at a time. 

I was thinking about this originally, but didn't want to go and modify
every PCI driver to enable it :)

But I do like your patch below that lets the options mix nicely.

> From playing so far however I think we need a different model at the
> device layer which serializes until the called probe function says "ok
> you can start another one now". That would need some kind of flag and
> semaphore plus a helper function.

What would this help out with?  Would the PCI layer (for example) handle
this "notify the core that it can continue" type logic?  Or would the
individual drivers need to be able to control it?

I'm guessing that you are thinking of this in relation to the disk
drivers, have you found cases where something like this is necessary due
to hardware constraints?

thanks,

greg k-h
