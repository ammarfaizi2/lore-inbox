Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262037AbTHTQO6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 12:14:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262043AbTHTQO5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 12:14:57 -0400
Received: from mail.kroah.org ([65.200.24.183]:11964 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262037AbTHTQO4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 12:14:56 -0400
Date: Wed, 20 Aug 2003 09:14:39 -0700
From: Greg KH <greg@kroah.com>
To: Thomas Molina <tmolina@cablespeed.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Zwane Mwaikambo <zwane@linuxpower.ca>
Subject: Re: Console on USB
Message-ID: <20030820161439.GD1354@kroah.com>
References: <Pine.LNX.4.44.0308192200510.886-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0308192200510.886-100000@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 19, 2003 at 10:20:51PM -0500, Thomas Molina wrote:
> I have just spent a very frustrating evening trying to get console on USB 
> working.  My laptop does not have regular DB-9 serial connectors, only 
> USB.  So I ordered a USB to serial converter,

Which usb to serial converter?  Not all of them work with Linux.  Does
this device work with Linux _not_ as a serial console device?

> configured a 2.6.0-test3 
> kernel, added a console=/dev/ttyUSB0 to the kernel command line and 
> connected this to my desktop with a null modem adapter.  However, I am 
> unable to get output from this setup on the desktop.  On another setup I 
> can get a normal serial console output, so I am fairly confident I can set 
> things up correctly.

Which "serial console" are you trying to get working?  The kernel log
console, or a login console?

> Googling around and doing a search on lkml archives gave some minimal 
> help, but I can find very little info past early to mid 2.5 kernels.  The 
> configuration doesn't quite seem to work the way I read documentation.  
> For instance, the web pages I can find indicate I should be able to build 
> this modular; however the configuration makes the setting of console on 
> usb depend on USB being y and EXPERIMENTAL being defined.  

What web page says you can build this modular?  You have to build it
into the kernel.

> In /var/log/messages I can see the USB-to-serial converter being recogized 
> and the driver being loaded, just before the synaptics touchpad is probed.

Can you show us the relevant part of the kernel logs?

> It looks like things are correct, but, as I said, I am unable to get 
> output.  Am I headed for frustration, or is there some advice to get good 
> results?  

You are headed for frustration.  USB serial console was a neat hack, but
pretty pointless.  It has the following problems:
	- can't see oopses before USB starts up, and USB starts up
	  almost last in the system boot process.
	- really can not capture oopses very well as USB is interrupt
	  driven
	- most usb-serial converters have a very small buffer, so you
	  constantly get over-runs in printing out console messages
	  (meaning that only a few of the devices will even work
	  properly, you usually have to buy one of the expensive ones to
	  see all messages.)

> Is there any advice I might be able to use to get this going?  I really 
> want to be able to catch some oops output.

Buy a machine with a serial port.  That's my recommendation :)

Good luck,

greg k-h
