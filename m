Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030694AbWJDBhd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030694AbWJDBhd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 21:37:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030693AbWJDBhd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 21:37:33 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:64552 "EHLO
	asav09.insightbb.com") by vger.kernel.org with ESMTP
	id S1030385AbWJDBhc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 21:37:32 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AR4FAGOsIkWBTg
From: Dmitry Torokhov <dtor@insightbb.com>
To: Lennart Poettering <mzxreary@0pointer.de>
Subject: Re: [PATCH] misc,acpi,backlight: MSI S270 Laptop support
Date: Tue, 3 Oct 2006 21:37:29 -0400
User-Agent: KMail/1.9.3
Cc: len.brown@intel.com, linux-kernel@vger.kernel.org,
       linux-acpi@vger.kernel.org
References: <20061003011056.GA28731@ecstasy.ring2.lan> <200610022227.10087.dtor@insightbb.com> <20061004012832.GA5171@tango.0pointer.de>
In-Reply-To: <20061004012832.GA5171@tango.0pointer.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610032137.29844.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 03 October 2006 21:28, Lennart Poettering wrote:
> On Mon, 02.10.06 22:27, Dmitry Torokhov (dtor@insightbb.com) wrote:
> 
> > > +        ret = sysfs_create_group(&msipf_device->dev.kobj, &msipf_attribute_group);
> > > +        if (ret)
> > > +                goto fail_platform_device;
> > > +
> > > +
> > > +        /* Enable automatic brightness control again */
> > > +        if (auto_brightness != 2)
> > > +                set_auto_brightness(1);     
> > > +
> > 
> > What happens if auto_brightness is 2 but userspace messed up with it
> > through device's sysfs attribute? 
> 
> If auto_brightness is 2 we assume that the user doesn't want the
> module to fiddle with the automatic brightness control
> automatically. So we don't do it, neither when loading nor when
> unloading the module. However, if the user wants to fiddle with the
> setting through sysfs he may do so and we will not reset his changes
> when unloading the module. This allows the user to do something like
> this to disable the brightness control without having the the driver
> loaded the whole time:
> 
>   modprobe msi-laptop auto_brightness=2 && echo 0 > /sys/devices/platform/msi-laptop-pf/auto_brightness && modprobe -r msi-laptop
> 
> If auto_brightness is 1 or 0, we do as requested but reset the control
> to the bootup default when unloading. (i.e. enable it again)

Normally drivers clean up after themselves as if they were never loaded,
taht is why I questioned partial cleanup.

-- 
Dmitry
