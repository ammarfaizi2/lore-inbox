Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750859AbWH2HwL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750859AbWH2HwL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 03:52:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751227AbWH2HwL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 03:52:11 -0400
Received: from cantor.suse.de ([195.135.220.2]:55215 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750859AbWH2HwK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 03:52:10 -0400
Date: Tue, 29 Aug 2006 00:51:03 -0700
From: Greg KH <greg@kroah.com>
To: Paul B Schroeder <pschroeder@uplogix.com>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       "'TechSupport'" <techsupport@moschip.com>, AJN Rao <ajnrao@moschip.com>,
       AJN Rao <ajn@moschip.com>
Subject: Re: [PATCH] Moschip 7840 USB-Serial Driver
Message-ID: <20060829075103.GA5952@kroah.com>
References: <44F3ED45.7080502@uplogix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44F3ED45.7080502@uplogix.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2006 at 02:31:17AM -0500, Paul B Schroeder wrote:
> Worked with the tech support folks at Moschip Semiconductor to get the 
> driver working on the latest kernel.  We've been using it for a bit now and 
> it appears to be working well.  They're okay with kernel inclusion of the 
> driver.  I've cleaned it up a bit and put this patch together.
> 
> The patch is against 2.6.18-rc5.  Please apply, it can be found here:
> http://paul.schroeder.name/DEV/kernel/mos7840.patch

Great, but can you submit it as per the Documentation/SubmittingPatches
file?

Also, I've included the following text at the top of the file in my port
of the mos7720 driver from the same developers.  It also applies to this
driver and you should add it too:

 * Originally based on drivers/usb/serial/io_edgeport.c which is:
 *      Copyright (C) 2000 Inside Out Networks, All rights reserved.
 *      Copyright (C) 2001-2002 Greg Kroah-Hartman <greg@kroah.com>

You can see the same function names and comments, as well as variable
usages where they don't really need to be used.

Can you also please clean up those functions to be more kernel-like, and
fix the variable names to follow the coding style rules of the kernel?

The #defines at the start of the file also can be removed, as they are
not needed (TRUE and FALSE don't belong in a driver, use 0 and -ERR
instead).

Also, look at the variables in struct moschip_port.  A lot of them can
be simply removed as they are never used.  The wait queues are one
example of these.  And the use of the "__" type of variables should be
examined, as I don't think it's necessary as these variables never cross
the kernel/user boundry.

There are also a lot of global variables that should be static.

I'll go over the rest when you submit it in an email message so it can
be quoted.

It's a great start though, I remember what the original version looked
like :)

thanks,

greg k-h
