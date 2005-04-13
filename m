Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262538AbVDMIBh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262538AbVDMIBh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 04:01:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262681AbVDMIBh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 04:01:37 -0400
Received: from mail.kroah.org ([69.55.234.183]:38095 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262538AbVDMIBW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 04:01:22 -0400
Date: Wed, 13 Apr 2005 01:00:36 -0700
From: Greg KH <greg@kroah.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Valdis.Kletnieks@vt.edu, Frank Sorenson <frank@tuxrocks.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/5] I8K driver facelift
Message-ID: <20050413080035.GC25581@kroah.com>
References: <200502240110.16521.dtor_core@ameritech.net> <200503170816.j2H8GOEV004208@turing-police.cc.vt.edu> <20050324072413.GK10604@kroah.com> <200504130133.32630.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200504130133.32630.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2005 at 01:33:31AM -0500, Dmitry Torokhov wrote:
> On Thursday 24 March 2005 02:24, Greg KH wrote:
> > On Thu, Mar 17, 2005 at 03:16:24AM -0500, Valdis.Kletnieks@vt.edu wrote:
> > > On Wed, 16 Mar 2005 14:38:50 MST, Frank Sorenson said:
> > > > Okay, I replaced the sysfs_ops with ops of my own, and now all the show
> > > > and store functions also accept the name of the attribute as a parameter.
> > > > This lets the functions know what attribute is being accessed, and allows
> > > > us to create attributes that share show and store functions, so things
> > > > don't need to be defined at compile time (I feel slightly evil!).
> > > > 
> > > > This patch puts the correct number of temp sensors and fans into sysfs,
> > > > and only exposes power_status if enabled by the power_status module
> > > > parameter.
> > > 
> > > Works for me:
> > > 
> > > [/sys/bus/platform/drivers/i8k/i8k]2 ls -l
> > > total 0
> > > lrwxrwxrwx  1 root root    0 Mar 17 03:02 bus -> ../../../bus/platform
> > > -r--r--r--  1 root root 4096 Mar 17 03:02 cpu_temp
> > > -rw-r--r--  1 root root 4096 Mar 17 03:01 detach_state
> > > lrwxrwxrwx  1 root root    0 Mar 17 03:02 driver -> ../../../bus/platform/drivers/i8k
> > > -r--r--r--  1 root root 4096 Mar 17 03:02 fan1_speed
> > > -rw-r--r--  1 root root 4096 Mar 17 03:02 fan1_state
> > > -r--r--r--  1 root root 4096 Mar 17 03:02 fan2_speed
> > > -rw-r--r--  1 root root 4096 Mar 17 03:02 fan2_state
> > > drwxr-xr-x  2 root root    0 Mar 17 03:02 power
> > > -r--r--r--  1 root root 4096 Mar 17 03:02 power_status
> > > -r--r--r--  1 root root 4096 Mar 17 03:02 temp1
> > > -r--r--r--  1 root root 4096 Mar 17 03:02 temp2
> > > 
> > > The valyes of the fan* settings, and cpu_temp match what's reported in /proc/i8k.
> > 
> > Please match the same units and filename as the other i2c sensors.  See
> > the documentation in the Documentation/i2c/ directory for what that
> > standard is, so userspace programs will "just work" with your devices.
> >
> 
> Greg,
> 
> I almost started doing what you just said but then I realized that none of
> the programs will "just work" because all of them will look into /sys/bus/i2c
> instead of /sys/bus/platform/i8k.
> 
> For userspace tools to work transparently we would need something like
> /sys/class/sensor/{fan|temp|current}, but it is something I am not ready to do
> now - I need to finish input layer first.

The sensors developers are creating just such a class, see their hwmon
patch in their email archive if you are curious.

> So given above I think having private scheme for now is ok. Sooo... Can I get
> my attributes goups patch in so I can use it in i8k, please?

Ick, no, use the upcoming hwmon stuff instead :)

thanks,

greg k-h
