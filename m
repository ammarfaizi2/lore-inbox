Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262167AbVBQAcy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262167AbVBQAcy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 19:32:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262171AbVBQAcy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 19:32:54 -0500
Received: from mail.kroah.org ([69.55.234.183]:62398 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262167AbVBQAcw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 19:32:52 -0500
Date: Wed, 16 Feb 2005 15:56:50 -0800
From: Greg KH <greg@kroah.com>
To: Robert Schwebel <r.schwebel@pengutronix.de>
Cc: linux-kernel@vger.kernel.org, Patrick Mochel <mochel@digitalimplant.org>,
       Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: recursively unregistering platform devices
Message-ID: <20050216235649.GA15537@kroah.com>
References: <20050206142912.GE13303@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050206142912.GE13303@pengutronix.de>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 06, 2005 at 03:29:12PM +0100, Robert Schwebel wrote:
> Hi, 
> 
> I have a locking problem with platform devices in a little bit unusual
> scenario; we have an FPGA which has a device information memory block
> for the several "parts" in the FPGA. So we have written a base driver
> which registers the device information block with the driver model, then
> looks what is in the FPGA, registers the according "devices" with the
> driver model and issues hotplug events to load the related drivers. 
> 
> The registration works fine, although we call platform_add_devices()
> from the base driver for all the "sub devices"; but when we try to
> unload the drivers there is a deadlock. On driver exit we call
> platform_device_unregister() for the base driver which seems to be run
> under a lock which is also being aquired when unregistering the devices
> "inside" the FPGA. 
> 
> Before I investigate deeper - did anyone see this behaviour before? 

Known issue, you can't recursivly register or unregister with the driver
core right now.  I'm working on fixing this issue.

thanks,

greg k-h
