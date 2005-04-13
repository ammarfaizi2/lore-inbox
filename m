Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262299AbVDMGdj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262299AbVDMGdj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 02:33:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262320AbVDMGdj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 02:33:39 -0400
Received: from smtp816.mail.sc5.yahoo.com ([66.163.170.2]:26983 "HELO
	smtp816.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262299AbVDMGdf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 02:33:35 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 0/5] I8K driver facelift
Date: Wed, 13 Apr 2005 01:33:31 -0500
User-Agent: KMail/1.8
Cc: Valdis.Kletnieks@vt.edu, Frank Sorenson <frank@tuxrocks.com>,
       LKML <linux-kernel@vger.kernel.org>
References: <200502240110.16521.dtor_core@ameritech.net> <200503170816.j2H8GOEV004208@turing-police.cc.vt.edu> <20050324072413.GK10604@kroah.com>
In-Reply-To: <20050324072413.GK10604@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504130133.32630.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 24 March 2005 02:24, Greg KH wrote:
> On Thu, Mar 17, 2005 at 03:16:24AM -0500, Valdis.Kletnieks@vt.edu wrote:
> > On Wed, 16 Mar 2005 14:38:50 MST, Frank Sorenson said:
> > > Okay, I replaced the sysfs_ops with ops of my own, and now all the show
> > > and store functions also accept the name of the attribute as a parameter.
> > > This lets the functions know what attribute is being accessed, and allows
> > > us to create attributes that share show and store functions, so things
> > > don't need to be defined at compile time (I feel slightly evil!).
> > > 
> > > This patch puts the correct number of temp sensors and fans into sysfs,
> > > and only exposes power_status if enabled by the power_status module
> > > parameter.
> > 
> > Works for me:
> > 
> > [/sys/bus/platform/drivers/i8k/i8k]2 ls -l
> > total 0
> > lrwxrwxrwx  1 root root    0 Mar 17 03:02 bus -> ../../../bus/platform
> > -r--r--r--  1 root root 4096 Mar 17 03:02 cpu_temp
> > -rw-r--r--  1 root root 4096 Mar 17 03:01 detach_state
> > lrwxrwxrwx  1 root root    0 Mar 17 03:02 driver -> ../../../bus/platform/drivers/i8k
> > -r--r--r--  1 root root 4096 Mar 17 03:02 fan1_speed
> > -rw-r--r--  1 root root 4096 Mar 17 03:02 fan1_state
> > -r--r--r--  1 root root 4096 Mar 17 03:02 fan2_speed
> > -rw-r--r--  1 root root 4096 Mar 17 03:02 fan2_state
> > drwxr-xr-x  2 root root    0 Mar 17 03:02 power
> > -r--r--r--  1 root root 4096 Mar 17 03:02 power_status
> > -r--r--r--  1 root root 4096 Mar 17 03:02 temp1
> > -r--r--r--  1 root root 4096 Mar 17 03:02 temp2
> > 
> > The valyes of the fan* settings, and cpu_temp match what's reported in /proc/i8k.
> 
> Please match the same units and filename as the other i2c sensors.  See
> the documentation in the Documentation/i2c/ directory for what that
> standard is, so userspace programs will "just work" with your devices.
>

Greg,

I almost started doing what you just said but then I realized that none of
the programs will "just work" because all of them will look into /sys/bus/i2c
instead of /sys/bus/platform/i8k.

For userspace tools to work transparently we would need something like
/sys/class/sensor/{fan|temp|current}, but it is something I am not ready to do
now - I need to finish input layer first.

So given above I think having private scheme for now is ok. Sooo... Can I get
my attributes goups patch in so I can use it in i8k, please?

Thanks!  

-- 
Dmitry
