Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932731AbVLHX1D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932731AbVLHX1D (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 18:27:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932743AbVLHX06
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 18:26:58 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:55819 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932742AbVLHX06 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 18:26:58 -0500
Date: Thu, 8 Dec 2005 23:26:52 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Jean Delvare <khali@linux-fr.org>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, Greg KH <greg@kroah.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Minor change to platform_device_register_simple prototype
Message-ID: <20051208232652.GD9357@flint.arm.linux.org.uk>
Mail-Followup-To: Jean Delvare <khali@linux-fr.org>,
	Dmitry Torokhov <dtor_core@ameritech.net>, Greg KH <greg@kroah.com>,
	LKML <linux-kernel@vger.kernel.org>
References: <20051205212337.74103b96.khali@linux-fr.org> <20051205202707.GH15201@flint.arm.linux.org.uk> <200512070105.40169.dtor_core@ameritech.net> <20051207170426.GB28414@kroah.com> <d120d5000512081321p36c422cdg4d360263d89fa826@mail.gmail.com> <20051208223705.6d375083.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051208223705.6d375083.khali@linux-fr.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 08, 2005 at 10:37:05PM +0100, Jean Delvare wrote:
> Hi Dmitry,
> 
> > Another thing - bunch of input code currently creates platform devices
> > but does not create corresponding platform drivers (because they don't
> > support suspend/resume or shutdown and probing is done right there in
> > module init function).
> > 
> > What is the general policy on platform devices? Should they always have
> > a corresponding driver or is it OK to leave them without one?
> 
> If it wasn't OK, I'd expect platform_device_alloc and
> platform_device_register to fail when no matching driver is found.

You're actually talking about driver model convention, which is that
if a driver for a device is missing, we do not return an error - a
hotplug event (or whatever is the flavour of the month) might provide
a driver.

For example, you might have a SMC91x device on your board, and you
may have chosen to build the driver as a module.  You wouldn't want
the device to not register.

Why should a driver registering its own platform device be treated
any different (from any platform provided device or indeed the rest
of the device/driver model)?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
