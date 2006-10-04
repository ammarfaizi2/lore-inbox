Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030383AbWJDB2f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030383AbWJDB2f (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 21:28:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030543AbWJDB2f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 21:28:35 -0400
Received: from tango.0pointer.de ([217.160.223.3]:23560 "EHLO
	tango.0pointer.de") by vger.kernel.org with ESMTP id S1030383AbWJDB2e
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 21:28:34 -0400
Date: Wed, 4 Oct 2006 03:28:32 +0200
From: Lennart Poettering <mzxreary@0pointer.de>
To: Dmitry Torokhov <dtor@insightbb.com>
Cc: len.brown@intel.com, linux-kernel@vger.kernel.org,
       linux-acpi@vger.kernel.org
Subject: Re: [PATCH] misc,acpi,backlight: MSI S270 Laptop support
Message-ID: <20061004012832.GA5171@tango.0pointer.de>
References: <20061003011056.GA28731@ecstasy.ring2.lan> <200610022227.10087.dtor@insightbb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610022227.10087.dtor@insightbb.com>
Organization: .phi.
X-Campaign-1: ()  ASCII Ribbon Campaign
X-Campaign-2: /  Against HTML Email & vCards - Against Microsoft Attachments
X-Disclaimer-1: Diese Nachricht wurde mit einer elektronischen 
X-Disclaimer-2: Datenverarbeitungsanlage erstellt und bedarf daher 
X-Disclaimer-3: keiner Unterschrift.
User-Agent: Leviathan/19.8.0 [zh] (Cray 3; I; Solaris 4.711; Console)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 02.10.06 22:27, Dmitry Torokhov (dtor@insightbb.com) wrote:

> > +        ret = sysfs_create_group(&msipf_device->dev.kobj, &msipf_attribute_group);
> > +        if (ret)
> > +                goto fail_platform_device;
> > +
> > +
> > +        /* Enable automatic brightness control again */
> > +        if (auto_brightness != 2)
> > +                set_auto_brightness(1);     
> > +
> 
> What happens if auto_brightness is 2 but userspace messed up with it
> through device's sysfs attribute? 

If auto_brightness is 2 we assume that the user doesn't want the
module to fiddle with the automatic brightness control
automatically. So we don't do it, neither when loading nor when
unloading the module. However, if the user wants to fiddle with the
setting through sysfs he may do so and we will not reset his changes
when unloading the module. This allows the user to do something like
this to disable the brightness control without having the the driver
loaded the whole time:

  modprobe msi-laptop auto_brightness=2 && echo 0 > /sys/devices/platform/msi-laptop-pf/auto_brightness && modprobe -r msi-laptop

If auto_brightness is 1 or 0, we do as requested but reset the control
to the bootup default when unloading. (i.e. enable it again)

Sounds like a reasonable policy to me, doesn't it to you?

> Overall brightness controll interface (module vs. per-device) needs
> to be tightened up.

Hmm, I am sorry? I don't understand what you mean? 

There's only a single device of this type available in a system at
maximum. Hence "per-device" and "per-module" is mostly the same here.

Lennart

-- 
Lennart Poettering; lennart [at] poettering [dot] net
ICQ# 11060553; GPG 0x1A015CC4; http://0pointer.net/lennart/
