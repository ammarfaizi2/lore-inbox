Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751768AbVLGTD7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751768AbVLGTD7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 14:03:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751766AbVLGTD7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 14:03:59 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:58124 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751760AbVLGTD6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 14:03:58 -0500
Date: Wed, 7 Dec 2005 19:03:52 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: dtor_core@ameritech.net
Cc: Greg KH <greg@kroah.com>, Jean Delvare <khali@linux-fr.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Minor change to platform_device_register_simple prototype
Message-ID: <20051207190352.GI6793@flint.arm.linux.org.uk>
Mail-Followup-To: dtor_core@ameritech.net, Greg KH <greg@kroah.com>,
	Jean Delvare <khali@linux-fr.org>,
	LKML <linux-kernel@vger.kernel.org>
References: <20051205212337.74103b96.khali@linux-fr.org> <20051205202707.GH15201@flint.arm.linux.org.uk> <200512070105.40169.dtor_core@ameritech.net> <d120d5000512070959q6a957009j654e298d6767a5da@mail.gmail.com> <20051207180842.GG6793@flint.arm.linux.org.uk> <d120d5000512071023u151c42f4lcc40862b2debad73@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d5000512071023u151c42f4lcc40862b2debad73@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 07, 2005 at 01:23:11PM -0500, Dmitry Torokhov wrote:
> On 12/7/05, Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> > On Wed, Dec 07, 2005 at 12:59:09PM -0500, Dmitry Torokhov > > I have started moving drivers from the "_simple" interface and I found
> > > that I'm missing platform_device_del that would complement
> > > platform_device_add. Would you object to having such a function, like
> > > we do for other sysfs objects? With it one can write somthing like
> > > this:
> >
> > Greg and myself discussed that, and we decided that it was adding
> > unnecessary complexity to the interface.  Maybe Greg's view has
> > changed?
> >
> 
> How do you write error handling path without the _del function if
> platform_device_add is not the last call? you can't call
> platform_device_unregister() and then platform_device_put(). And I
> don't like to take extra references in error path or assign the
> pointer to NULL in teh middle of unwinding...

The example code in the commit comments contains a complete example of
registering a platform device, and cleaning up should something go
wrong with that process.

Unregistering is just a matter of calling platform_device_unregister().
An unregister call is a del + put in exactly the same way as it is
throughout the rest of the driver model.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
