Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264480AbTKNBmp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 20:42:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264481AbTKNBmp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 20:42:45 -0500
Received: from mail.kroah.org ([65.200.24.183]:7321 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264480AbTKNBmn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 20:42:43 -0500
Date: Thu, 13 Nov 2003 17:02:06 -0800
From: Greg KH <greg@kroah.com>
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: rusty@rustcorp.com.au, linux-hotplug-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: file2alias - incorrect? aliases for USB
Message-ID: <20031114010206.GA16352@kroah.com>
References: <20031110093703.GA5449@kroah.com> <E1AJ9Fn-000PHf-00.arvidjaar-mail-ru@f21.mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1AJ9Fn-000PHf-00.arvidjaar-mail-ru@f21.mail.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 10, 2003 at 01:26:39PM +0300, "Andrey Borzenkov"  wrote:
> > I would suggest just ignoring the bcdDevice value, and loading all
> > modules that match the idVendor and idProduct values, and let the kernel
> > sort it out :)
> > 
> > So for your example, you would just:
> > 	modprobe usb:v04E6p0006dl*dh*dc*dsc*dp*ic*isc*ip* 
> > 
> 
> any reason we put in alias fields that apparently won't be used
> at all?

Hm, don't know.  I didn't think of these as ranges, which some of the
fields are.  Possibly we might want to drop those variables from the
strings.

> > Hm, but that's no good either, because the visor driver trips over that
> > with its entry:
> > 	MODULE_ALIAS("usb:v*p*dl*dh*dc*dsc*dp*ic*isc*ip*");
> > and the improper module is loaded.  That needs to be fixed up...
> > 
> > Rusty, any reason why the module alias code is turning an empty
> > MODULE_PARAM structure, as is declared in drivers/usb/serial/visor.c
> > with the line:
> >         { },                                    /* optional parameter entry */ 
> > 
> > Into the above MODULE_ALIAS?  I don't think that's correct.
> > 
> 
> Subject:  [PATCH][2.6.0-test9] prevent catch-all USB aliases in modules.alias
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=106787897124700&w=2

Ah, missed that.  Care to send it to Rusty?  It looks like a simple,
needed fix.

thanks,

greg k-h
