Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265903AbUFIWOy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265903AbUFIWOy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 18:14:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265974AbUFIWOy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 18:14:54 -0400
Received: from mail.kroah.org ([65.200.24.183]:22402 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265903AbUFIWOx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 18:14:53 -0400
Date: Wed, 9 Jun 2004 15:13:37 -0700
From: Greg KH <greg@kroah.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] Couple of sysfs patches
Message-ID: <20040609221337.GG16653@kroah.com>
References: <200406090221.24739.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406090221.24739.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 09, 2004 at 02:21:24AM -0500, Dmitry Torokhov wrote:
> Hi,
> 
> I am trying to add sysfs support to the serio subsystem and I would like you
> to consider the following changes:
>  
> - when registering platform device, if device id is set to -1, do not add it
>   as a suffix to device's name. It can be used when there is only one device.
>   The reason for change - i find that i80420 looks ugly, just i8042 is much
>   better ;)

That sounds sane.

> - create platform_device_simple_releasse function that would just free memory
>   occupied by platform device. Having such release routine in core allows
>   drivers implementing simple platform devices not wait in module unload code
>   till last reference to the device is dropped.

I'm _very_ leary of applying this.  It could be abused very badly
(by putting the platform_device as the first object in the structure and
relying on this function to kfree the whole thing.)  So sorry, but no.

Unless you show me a real need for it..

And as for the whitespace cleanup, why?  The lack of spaces seem to be
something that the original author liked doing.  There's nothing in the
kernel coding style guidelines that really mention it that I can see.

So, care to just send me the name change patch against the latest tree?

thanks,

greg k-h
