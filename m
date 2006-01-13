Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422647AbWAMMmp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422647AbWAMMmp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 07:42:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422648AbWAMMmp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 07:42:45 -0500
Received: from soundwarez.org ([217.160.171.123]:8624 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S1422647AbWAMMmo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 07:42:44 -0500
Date: Fri, 13 Jan 2006 13:42:35 +0100
From: Kay Sievers <kay.sievers@vrfy.org>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
Subject: Re: unify sysfs device tree
Message-ID: <20060113124235.GB3246@vrfy.org>
References: <20060113015652.GA30796@vrfy.org> <200601122324.49442.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200601122324.49442.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2006 at 11:24:49PM -0500, Dmitry Torokhov wrote:
> On Thursday 12 January 2006 20:56, Kay Sievers wrote:
> > Here is for illustration the "input" layer as a flat /sys/class directory. All
> > devices point to /sys/devices which exposes the device hierarchy if userspace
> > wants to know that:
> >         /sys/class/
> >         ...
> >         |-- input
> >         |   |-- input0 -> ../../devices/platform/i8042/serio1/input0
> >         |   |-- input1 -> ../../devices/platform/i8042/serio0/input1
> >         |   |-- input3 -> ../../devices/platform/i8042/serio0/serio2/input3
> >         |   |-- input4 -> ../../devices/pci0000:00/0000:00:1d.1/usb3/3-2/3-2:1.0/input4
> >         |   |-- mice -> ../../devices/mice
> >         |   |-- mouse0 -> ../../devices/platform/i8042/serio0/input1/mouse0
> >         |   |-- mouse1 -> ../../devices/pci0000:00/0000:00:1d.1/usb3/3-2/3-2:1.0/input4/mouse1
> >         |   `-- mouse2 -> ../../devices/platform/i8042/serio0/serio2/input3/mouse2
> 
> Looks nice with exception of my standard argument that inputX and
> mouseX are objects of different (but related) classes.

You can easily distinguish them by the device instance name, we have this
in a lot of other classes too: /class/sound/controlC0 is very different from
/class/sound/pcmC0D0p, /class/sound/timer, ...

> I believe this also relies on overriding class' methods (release, uevent)
> by individual devices and inability for class to define standard attributes
> for such devices. Pretty yucky...

You can, if you want separate classes, put them in different classes.
This will work fine with this model now, cause the device hierarchy is
still nicely exposed in /sys/devices.

Thanks,
Kay
