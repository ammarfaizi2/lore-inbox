Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261578AbVALX0Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261578AbVALX0Y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 18:26:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261579AbVALXZr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 18:25:47 -0500
Received: from mail.kroah.org ([69.55.234.183]:44173 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261578AbVALXYO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 18:24:14 -0500
Date: Wed, 12 Jan 2005 15:21:12 -0800
From: Greg KH <greg@kroah.com>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Export symbol from I2C eeprom driver
Message-ID: <20050112232112.GD15085@kroah.com>
References: <9e47339105010721347fbeb907@mail.gmail.com> <20050108055315.GC8571@kroah.com> <9e473391050107220875baa32b@mail.gmail.com> <20050108222719.GA3226@kroah.com> <9e473391050108161426b36e4d@mail.gmail.com> <20050110234726.GE3286@kroah.com> <9e4733910501101820388563bb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e4733910501101820388563bb@mail.gmail.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2005 at 09:20:49PM -0500, Jon Smirl wrote:
> On Mon, 10 Jan 2005 15:47:26 -0800, Greg KH <greg@kroah.com> wrote:
> > > I don't want to load the driver from the script because the radeon
> > > driver is creating a sysfs link into the eeprom directory from the
> > > radeon one.
> > 
> > How are you getting the kobject to the eeprom directory from the radeon
> > driver?
> > 
> 
> I own the private I2C bus and eeprom is the only chip that will attach
> to the bus. I need to do the link in the driver since there are four
> busses and upto two monitors. The driver knows how to pair the head up
> with the right bus.
> 
> if (dev_priv->primary_head.connector != ddc_none)
>   list_for_each(item,
> &dev_priv->i2c[dev_priv->primary_head.connector].adapter.clients) {
>     client = list_entry(item, struct i2c_client, list);
>     sysfs_create_link(&dev->primary.dev_class->kobj,
> &client->dev.kobj, "monitor");
>     break;
>   }

Ick.  Oh well, sure, that's ok.  But I really think that a Kconfig rule
could be made for this, instead of trying to pull an exported symbol in.

And I have a patch in my queue to delete that id, so you will have to
come up with another symbol in the driver to do that with :)

thanks,

greg k-h
