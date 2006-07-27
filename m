Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751425AbWG0XBL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751425AbWG0XBL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 19:01:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751433AbWG0XBK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 19:01:10 -0400
Received: from ns2.suse.de ([195.135.220.15]:41394 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751425AbWG0XBJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 19:01:09 -0400
Date: Thu, 27 Jul 2006 15:56:45 -0700
From: Greg KH <greg@kroah.com>
To: Pavel Machek <pavel@suse.cz>
Cc: "Brown, Len" <len.brown@intel.com>,
       Shem Multinymous <multinymous@gmail.com>,
       Matthew Garrett <mjg59@srcf.ucam.org>, vojtech@suse.cz,
       kernel list <linux-kernel@vger.kernel.org>,
       linux-thinkpad@linux-thinkpad.org, linux-acpi@vger.kernel.org
Subject: Re: Generic battery interface
Message-ID: <20060727225645.GB23195@kroah.com>
References: <CFF307C98FEABE47A452B27C06B85BB6011688D8@hdsmsx411.amr.corp.intel.com> <20060727221632.GE3797@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060727221632.GE3797@elf.ucw.cz>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > sysfs is great for demos from a shell prompt,
> > but isn't such a great programming interface, either
> > from inside the kernel or from user-space.

I would tend to dispute this point :)

> Anyone volunteers write battery layer? If so, I'd go with /dev/XXX,
> otherwise I'd go with /sys/XXX, because it is simpler to code, and I
> believe it is also good enough...

Please go with /sys/battery/batteryN/XXXX, not an ioctl filled /dev/
interface that can not easily be scripted.

That way it is extensable (if the specific battery type just doesn't
provide a specific functionality, that sysfs file will not be present),
it allows for polling if needed, and would unify all the different types
of batteries.

Look at the kind of documentation the hwmon and i2c people have
created[1] for how to specify sysfs interfaces for different types of
sensor devices.  It should not be that hard to create the same for
something as "simple" as a battery :)

thanks,

greg k-h

[1] Documentation/hwmon/sysfs-interface
