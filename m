Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262078AbSJJSQw>; Thu, 10 Oct 2002 14:16:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262081AbSJJSQw>; Thu, 10 Oct 2002 14:16:52 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:28292 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S262078AbSJJSQw>;
	Thu, 10 Oct 2002 14:16:52 -0400
Date: Thu, 10 Oct 2002 14:22:30 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Patrick Mochel <mochel@osdl.org>
cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] gendisk refcounting
In-Reply-To: <Pine.LNX.4.44.0210100925060.16276-100000@cherise.pdx.osdl.net>
Message-ID: <Pine.GSO.4.21.0210101358370.13421-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 10 Oct 2002, Patrick Mochel wrote:

> Then, the one thing that really integrates into the driver model: Wrap
> add_disk() and del_gendisk() into ->add_device() and ->remove_device()  
> of disk_devclass.
> 
> disk_devclass is initialized and added to the tree in 
> drivers/block/genhd.c::device_init(). Once a driver is bound a device, it 
> is added to the class the driver belongs to, which calls struct 
> device_class::add_device(), with a pointer to the struct device of the 
> drive. 

???

What would trigger that?  Notice that places where we call add_disk() _do_
matter - shifting it around is not a good idea.
 
> The other huge benefits of having a generic object like this are:
> 
> - all the current driver model objects can share them, along with the code 
>   to operate on them. 
> - driverfs can easily be taught about them, making reference counting 
>   easier.
> - The glue layers for adding driverfs support for different object types 
>   becomes quite a bit less. 

I would still try to trim that object down.  Yes, having such a beast
would be useful and yes, struct device is too bloated for that.  But...

