Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964888AbVLGXV2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964888AbVLGXV2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 18:21:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964899AbVLGXV2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 18:21:28 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:37132 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S964888AbVLGXV1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 18:21:27 -0500
Date: Wed, 7 Dec 2005 23:21:06 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Greg KH <greg@kroah.com>
Cc: dtor_core@ameritech.net, Jean Delvare <khali@linux-fr.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Minor change to platform_device_register_simple prototype
Message-ID: <20051207232105.GO6793@flint.arm.linux.org.uk>
Mail-Followup-To: Greg KH <greg@kroah.com>, dtor_core@ameritech.net,
	Jean Delvare <khali@linux-fr.org>,
	LKML <linux-kernel@vger.kernel.org>
References: <20051205202707.GH15201@flint.arm.linux.org.uk> <200512070105.40169.dtor_core@ameritech.net> <d120d5000512070959q6a957009j654e298d6767a5da@mail.gmail.com> <20051207180842.GG6793@flint.arm.linux.org.uk> <d120d5000512071023u151c42f4lcc40862b2debad73@mail.gmail.com> <20051207190352.GI6793@flint.arm.linux.org.uk> <d120d5000512071418q521d2155r81759ef8993000d8@mail.gmail.com> <20051207225126.GA648@kroah.com> <d120d5000512071459s9b461d8ye7abc41d0e1950fd@mail.gmail.com> <20051207230615.GB742@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051207230615.GB742@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 07, 2005 at 03:06:15PM -0800, Greg KH wrote:
> On Wed, Dec 07, 2005 at 05:59:24PM -0500, Dmitry Torokhov wrote:
> > Yes, the I can just write:
> > 
> >         ...
> >         err = platform_driver_register(&i8042_driver);
> >         if (err)
> >                 goto err_controller_cleanup;
> > 
> >         i8042_platform_device = platform_device_alloc("i8042", -1);
> >         if (!i8042_platform_device) {
> >                 err = -ENOMEM;
> >                 goto err_unregister_driver;
> >         }
> > 
> >         err = platform_device_add(i8042_platform_device);
> >         if (err)
> >                 goto err_free_device;
> >         ...
> > 
> >         if (!have_ports) {
> >                 err = -ENODEV;
> >                 goto err_delete_device;
> >         }
> > 
> >         mod_timer(&i8042_timer, jiffies + I8042_POLL_PERIOD);
> >         return 0;
> > 
> >  err_delete_device:
> >         platform_device_del(i8042_platform_device);
> >  err_free_device:
> >         platform_device_put(i8042_platform_device);
> >  err_unregister_driver:
> >         platform_driver_unregister(&i8042_driver);
> >  ....
> > 
> > As you can see - single cleanup path..
> 
> Ok, that's fine with me.  Russell, any objections?

None what so ever - that's mostly what I envisioned with the patch
with the _del method.  However, I didn't have an existing user for it.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
