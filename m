Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262962AbTCWIJK>; Sun, 23 Mar 2003 03:09:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262964AbTCWIJK>; Sun, 23 Mar 2003 03:09:10 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:64779 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262962AbTCWIJI>;
	Sun, 23 Mar 2003 03:09:08 -0500
Date: Sun, 23 Mar 2003 00:19:56 -0800
From: Greg KH <greg@kroah.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org, akpm@digeo.com
Subject: Re: [PATCH] alternative dev patch
Message-ID: <20030323081956.GK26145@kroah.com>
References: <UTC200303202150.h2KLoEl09978.aeb@smtp.cwi.nl> <Pine.LNX.4.44.0303202314210.5042-100000@serv> <20030321012455.GB10298@kroah.com> <Pine.LNX.4.44.0303210936590.5042-100000@serv> <20030322013800.GD18835@kroah.com> <Pine.LNX.4.44.0303221306350.5042-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0303221306350.5042-100000@serv>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 22, 2003 at 02:02:00PM +0100, Roman Zippel wrote:
> > So only tty drivers currently do this.  But that might just be because
> > it's pretty hard to get a range of minors right now, as the api hasn't
> > been present.  Once we expand the range, I bet it will get quite common
> > (most character drivers only want from 1-16 minors normally.)
> 
> There are a few options:
> 1. Drivers can implement that themselves:

Yeah, but as I know, it's a big pain in the butt.  Let's make it easy to
do this, don't make writing a driver tougher than it has to be (it's
already much harder than it used to be.)  Andries's patch makes it easy,
which is a good thing in my book.

> a) The driver allocates the major itself and opens the real minor device 
> in its open function, (e.g. see the misc driver example). Especially tape 
> drivers have to do this anyway, because they encoded the open mode in 
> higher bits, so regions won't help you here at all.
> b) The driver allocates the major itself and installs the file_operations 
> directly in the char_device, e.g. that is something you might want to do 
> in the usb driver:
> 
> register_usb_device(...)
> {
> 	...
> 	cdev = cdget(dev);
> 	down(&cdev->sem);
> 	if (cdev->fops)
> 		...;
> 	cdev->fops = fops;
> 	up(&cdev->sem);
> }
> (see the misc driver again for a detailed example.)

Look at drivers/usb/core/file.c::usb_open(), it does much the same
thing.  Well, functionally the same, not identical in any way :)

thanks,

greg k-h
