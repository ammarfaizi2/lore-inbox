Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261324AbVCFGL1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261324AbVCFGL1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 01:11:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261326AbVCFGL0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 01:11:26 -0500
Received: from 64-85-47-3.ip.van.radiant.net ([64.85.47.3]:26629 "EHLO
	vlinkmail") by vger.kernel.org with ESMTP id S261324AbVCFGLS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 01:11:18 -0500
Date: Sat, 5 Mar 2005 21:56:35 -0800
From: Greg KH <greg@kroah.com>
To: James Nelson <james4765@cwazy.co.uk>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH 1/13] speedtch: Clean up printk()'s in drivers/usb/atm/speedtch.c
Message-ID: <20050306055635.GA12662@kroah.com>
References: <20050305233712.7648.24364.93822@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050305233712.7648.24364.93822@localhost.localdomain>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 05, 2005 at 05:37:13PM -0600, James Nelson wrote:
> Add a KERN_WARNING constant to a printk() that is missing it, and add a driver
> prefix to another two in drivers/usb/atm/speedtch.c

Please CC: usb patches to the usb maintainer, it makes it a bit hard for
him to apply them otherwise :)

> Signed-off-by: James Nelson <james4765@gmail.com>
> 
> diff -Nurp -x dontdiff-osdl --exclude='*~' linux-2.6.11-mm1-original/drivers/usb/atm/speedtch.c linux-2.6.11-mm1/drivers/usb/atm/speedtch.c
> --- linux-2.6.11-mm1-original/drivers/usb/atm/speedtch.c	2005-03-05 13:29:48.000000000 -0500
> +++ linux-2.6.11-mm1/drivers/usb/atm/speedtch.c	2005-03-05 13:36:44.000000000 -0500
> @@ -192,8 +192,8 @@ static int speedtch_set_swbuff(struct sp
>  			      0x32, 0x40, state ? 0x01 : 0x00,
>  			      0x00, NULL, 0, 100);
>  	if (ret < 0) {
> -		printk("Warning: %sabling SW buffering: usb_control_msg returned %d\n",
> -		     state ? "En" : "Dis", ret);
> +		printk(KERN_WARNING "%s: %sabling SW buffering: usb_control_msg returned %d\n",
> +		     speedtch_driver_name, state ? "En" : "Dis", ret);

No, please, if you are going to convert anything like this, use the
dev_dbg(), dev_warn(), and assorted macros instead.  Or if nothing else,
the usb subsystem has it's own dbg(), err() and warn() macros that
should be gotten rid of, but that's a lot of changes...

These comments pretty much go for all of your patches in this series,
please rework them all.

thanks,

greg k-h
