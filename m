Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263864AbUFQWGl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263864AbUFQWGl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 18:06:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263868AbUFQWG3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 18:06:29 -0400
Received: from mail.kroah.org ([65.200.24.183]:47589 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263864AbUFQWG1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 18:06:27 -0400
Date: Thu, 17 Jun 2004 15:05:10 -0700
From: Greg KH <greg@kroah.com>
To: Andrew Zabolotny <zap@homelink.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Backlight and LCD module patches [1]
Message-ID: <20040617220510.GA4122@kroah.com>
References: <20040617223514.2e129ce9.zap@homelink.ru> <20040617194739.GA15983@kroah.com> <20040618015504.661a50a9.zap@homelink.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040618015504.661a50a9.zap@homelink.ru>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2004 at 01:55:04AM +0400, Andrew Zabolotny wrote:
> On Thu, 17 Jun 2004 12:47:39 -0700
> Greg KH <greg@kroah.com> wrote:
> 
> > So no, I'm not going to accept this, you need to change your lcd code to
> > pass around pointers to the proper structures, instead of trying to rely
> > on the name of a device.  Because of this, I'm not going to apply your
> > second patch.
> I think you missed something. It doesn't rely on the name of the device while
> registering/unregistering, I've changed this, look:

No, I saw your change.

> extern int lcd_device_register(const char *name, void *devdata,
>                               struct lcd_properties *lp,
>                               struct lcd_device **alloc_ld);

That function should be:
struct lcd_device lcd_device_register(const char *name, void *devdata,
					struct lcd_properties *lp);

instead.  Then return an ERR_PTR() if you have an error.

> Now this:
> 
> extern struct lcd_device *lcd_device_find(const char *name);
> 
> It needs a char* argument because there's no other easy way to find the
> correspondence between framebuffer devices and lcd/backlight devices
> corresponding to that framebuffer device.

Then you need to have a way to corrispond those devices together,
becides just a name.  Use the pointer that you have provided to link
them together some way.

thanks,

greg k-h
