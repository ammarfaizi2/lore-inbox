Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030553AbWFIWKh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030553AbWFIWKh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 18:10:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030555AbWFIWKh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 18:10:37 -0400
Received: from cantor2.suse.de ([195.135.220.15]:58533 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030553AbWFIWKg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 18:10:36 -0400
Date: Fri, 9 Jun 2006 15:08:03 -0700
From: Greg KH <gregkh@suse.de>
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/5] VT binding: Add sysfs support
Message-ID: <20060609220803.GB7636@suse.de>
References: <448933D7.6040301@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <448933D7.6040301@gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2006 at 04:39:51PM +0800, Antonino A. Daplas wrote:
> Add sysfs attributes for binding and unbinding VT console drivers. The
> attributes are located in /sys/class/tty/console and are namely:
> 
>     A. backend - list registered drivers in the following format:
> 
>     "I C: Description"

No, this violates the "one value per file" issue with sysfs.  How do you
know you will not overflow the buffer passed to you?

> 
>     Where: I  = ID number of the driver
>            C  = status of the driver which can be:
> 
> 		S = system driver
> 		B = bound modular driver
> 		U = unbound modular driver
> 
> 	   Description - text description of the driver
> 
>     B. bind - binds a driver to the console layer
> 
>        echo <ID> > /sys/class/tty/console/bind
> 
>     C. unbind - unbinds a driver from the console layer
> 
>        echo <ID> > /sys/class/tty/console/unbind
> 
> The tty layer does nothing to these attributes except create them and punt all
> requests to the VT layer.

Why is this needed?  What is wrong with the current scheme of binding
ttys to the console?

thanks,

greg k-h
