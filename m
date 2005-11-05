Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750783AbVKERXI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750783AbVKERXI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 12:23:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750826AbVKERXI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 12:23:08 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:14858 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750783AbVKERXH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 12:23:07 -0500
Date: Sat, 5 Nov 2005 17:23:02 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Greg KH <greg@kroah.com>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [DRIVER MODEL] Improved dynamically allocated platform_device interface
Message-ID: <20051105172302.GB12228@flint.arm.linux.org.uk>
Mail-Followup-To: Greg KH <greg@kroah.com>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
References: <20051105105628.GE28438@flint.arm.linux.org.uk> <20051105154210.GA20598@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051105154210.GA20598@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 05, 2005 at 07:42:10AM -0800, Greg KH wrote:
> On Sat, Nov 05, 2005 at 10:56:28AM +0000, Russell King wrote:
> > Re-jig the simple platform device support to allow private data
> > to be attached to a platform device, as well as allowing the
> > parent device to be set.
> > 
> > Example usage:
> > 
> > 	pdev = platform_device_alloc("mydev", id);
> > 	if (pdev) {
> > 		err = platform_device_add_resources(pdev, &resources,
> > 						    ARRAY_SIZE(resources));
> > 		if (err == 0)
> > 			err = platform_device_add_data(pdev, &platform_data,
> > 						       sizeof(platform_data));
> > 		if (err == 0)
> > 			err = platform_device_add(pdev);
> > 	} else {
> > 		err = -ENOMEM;
> > 	}
> > 	if (err)
> > 		platform_device_put(pdev);
> > 
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> 
> Acked-by: Greg Kroah-Hartman <gregkh@suse.de>
> 
> These look great, want me to add them to my tree and get them to Linus
> before 2.6.15?

It might be worth discussing the platform_driver changes I have as well.
I need to fix those up for the current moving target (they break _very_
often) so I'll post them later tonight for comment.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
