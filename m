Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263745AbUFBRfo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263745AbUFBRfo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 13:35:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263718AbUFBRfX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 13:35:23 -0400
Received: from mail.kroah.org ([65.200.24.183]:29149 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263711AbUFBRdz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 13:33:55 -0400
Date: Wed, 2 Jun 2004 10:12:57 -0700
From: Greg KH <greg@kroah.com>
To: Andrew Zabolotny <zap@homelink.ru>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: two patches - request for comments
Message-ID: <20040602171257.GK7829@kroah.com>
References: <20040529012030.795ad27e.zap@homelink.ru> <20040528221006.GB13851@kroah.com> <20040529124421.28c776cc.zap@homelink.ru> <40BCF3BF.3020202@pobox.com> <20040602015740.3cedd197.zap@homelink.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040602015740.3cedd197.zap@homelink.ru>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02, 2004 at 01:57:40AM +0400, Andrew Zabolotny wrote:
> On Tue, 01 Jun 2004 17:23:11 -0400
> Jeff Garzik <jgarzik@pobox.com> wrote:
> 
> > Typical Linux usage to an item being registered is
> > 	ptr = alloc_foo()
> > 	register_foo(ptr)
> > 	unregister_foo(ptr)
> > 	free_foo()
> In this case it is:
> 
> register_lcd_device("foo", ...);
> ...
> unregister_lcd_device("foo");
> 
> The name is guaranteed to be unique by sysfs design during the whole
> device lifetime, and calling unregister_xxx() outside the lifetime brackets
> is clearly an error.
> 
> > It is quite unusual to unregister based on name.  Pointers are far more 
> > likely to be unique, and the programmer is far less likely to screw up 
> > the unregister operation.
> I understand this, I see why it looks unusual. I'll fix this if it matters.

It matters, please fix it.

> It'll be something like:
> 
> lcd_device = register_lcd_device ("foo", ...);
> ...
> unregister_lcd_device (lcd_device);

What about:
	lcd_device = alloc_lcd_device("foo", ...);
	error = register_lcd_device(lcd_device);
	...
	unregister_lcd_device(lcd_device);

thanks,

greg k-h
