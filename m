Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934357AbWKUGmI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934357AbWKUGmI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 01:42:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934353AbWKUGmH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 01:42:07 -0500
Received: from mail.kroah.org ([69.55.234.183]:64920 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S934357AbWKUGmE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 01:42:04 -0500
Date: Mon, 20 Nov 2006 22:41:22 -0800
From: Greg KH <greg@kroah.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: bus_id collisions
Message-ID: <20061121064122.GA10510@kroah.com>
References: <1164081736.8207.14.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1164081736.8207.14.camel@localhost.localdomain>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2006 at 03:02:16PM +1100, Benjamin Herrenschmidt wrote:
> Hi Greg !
> 
> It occurs to me (after some trouble I had with custom bus types) that
> this comment is incorrect in device.h, in the definition of struct
> device :
> 
>         char    bus_id[BUS_ID_SIZE];    /* position on parent bus */
> 
> As the bus_id needs to be unique for a given bus_type, not only under a
> given parent, due to the symlinks in /sys/bus/<bus_type>/.

Yes, sorry, that comment is _very_ old...

> This has caused me some trouble with of_platform devices, which are
> sort-of platform devices but linked to the Open Firmware device-tree, as
> I generate their names based on the nodes in the tree which need not be
> unique as long as they are unique under a given parent.
> 
> I've worked around it, but I though the comment might need to be
> clarified.

Ok.

> Also, I don't suppose you have any plan to move away from the bus_id
> being a fixed size array inside struct device ?

No, I had not heard of anyone having any problems with the size of it.
We could just do it like the kobject does, and have a function to set it
and handle the pointer vs. array issue there if you _really_ need a
bigger size.

> I would very much like to be able to have larger names ... Among
> others, in order to handle the above problem, I tend to include the
> fully translated 64 bits address of the device in the name :-)
> (Hopefully, it's generally smaller and I don't have leading zero's but
> still, I have little room left for the device name which is annoying).

Oh, that's a very annoying bus id, but I guess it's legal.

I'll poke around and see if I can make it bigger.  You don't want it
bigger for static 'struct device' types, right?

thanks,

greg k-h
