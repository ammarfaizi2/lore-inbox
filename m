Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263124AbUDLVmz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 17:42:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263129AbUDLVmz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 17:42:55 -0400
Received: from mail.kroah.org ([65.200.24.183]:50822 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263124AbUDLVmx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 17:42:53 -0400
Date: Mon, 12 Apr 2004 14:42:32 -0700
From: Greg KH <greg@kroah.com>
To: Michael Hunold <hunold@convergence.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problems adding sysfs support to dvb subsystem
Message-ID: <20040412214232.GA23692@kroah.com>
References: <407AFD5B.8010502@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <407AFD5B.8010502@convergence.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 12, 2004 at 10:34:35PM +0200, Michael Hunold wrote:
> 
> What I'd like to have is something like this, so I can add attributes to 
> the frontend for example:
> /sys/class/dvb/adapter0/frontend0/
> 
> I wasn't able to find a driver that provides this simple "hierarchical" 
> order, so I did some experiments with little luck.
> 
> Creating this hierarchical order manually (like for "devfs") didn't 
> work, I get
> > find: /sys/class/dvb/adapter0/frontend0: No such file or directory
> errors upon access:
> 
> > sprintf((void*)&dvbdev->class_device.class_id, "adapter%d/%s%d", 
> adap->num, dnames[type], id);
> > class_device_register(&dvbdev->class_device);

No, you can't create subdirectories directly by just adding a '/' to the
name of the class device, sorry.  You will have to create a kobject for
the directory, and create the attributes in that kobject, like
networking did.

Yeah, it's a bit of a pain, but creating subdirectories in an easy
manner is on the TODO list for the driver core for 2.7.

If you want to get up and running quickly, which would not require you
to fix up any lifetime rules for your dvb drivers, you could implement
the class_simple interface, like a lot of other driver subsystems
currently are doing, and then in 2.7 convert over to a proper driver
model conversion.  I say this as I am only guessing as to what your
lifetime rules are for your dvb devices and drivers...

Hope this helps,

greg k-h
