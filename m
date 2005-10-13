Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751100AbVJMGim@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751100AbVJMGim (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 02:38:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751489AbVJMGim
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 02:38:42 -0400
Received: from styx.suse.cz ([82.119.242.94]:465 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S1751100AbVJMGil (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 02:38:41 -0400
Date: Thu, 13 Oct 2005 08:38:00 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Greg KH <gregkh@suse.de>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>,
       Kay Sievers <kay.sievers@vrfy.org>, Hannes Reinecke <hare@suse.de>,
       Patrick Mochel <mochel@digitalimplant.org>, airlied@linux.ie,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 0/8] Nesting class_device patches that actually work
Message-ID: <20051013063800.GA12008@midnight.suse.cz>
References: <20051013020844.GA31732@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051013020844.GA31732@kroah.com>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 12, 2005 at 07:08:44PM -0700, Greg KH wrote:

> Ok, finally.  Here's a set of _working_ patches that properly implement
> nesting class_device structures, and the follow-on patches to move the
> input subsystem to use them.  Hotplug and release functions work
> properly now, and this will let us move /sys/block/ to use class and
> class_device structures soon.
> 
> The input patches are on top of almost all of Dmitry's input patches.
> All of them are together in one series in my public patches at:
> 	kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/
> and should show up in the next -mm release.
> 
> The sysfs tree looks the same as it did last time, but now hotplug works
> properly for addition and removal, and we actually free the memory used
> :)
> 
> For those that don't remember, here's the sysfs tree on my desktop:
> $ tree /sys/class/input/ -d
> /sys/class/input/
> |-- input0
> |   |-- capabilities
> |   |-- event0
> |   `-- id
> |-- input1
> |   |-- capabilities
> |   |-- device -> ../../../devices/platform/i8042/serio1
> |   |-- event1
> |   |   `-- device -> ../../../../devices/platform/i8042/serio1
> |   `-- id
> |-- input3
> |   |-- capabilities
> |   |-- device -> ../../../devices/pci0000:00/0000:00:1d.0/usb2/2-2/2-2:1.0
> |   |-- event2
> |   |   `-- device -> ../../../../devices/pci0000:00/0000:00:1d.0/usb2/2-2/2-2:1.0
> |   |-- id
> |   |-- mouse0
> |   |   `-- device -> ../../../../devices/pci0000:00/0000:00:1d.0/usb2/2-2/2-2:1.0
> |   `-- ts0
> |       `-- device -> ../../../../devices/pci0000:00/0000:00:1d.0/usb2/2-2/2-2:1.0
> `-- mice

> Ok, I think that covers everything.
> 
> Oh, one final thing.  I really don't think that input should be a class.
> It looks like a "bus" and acts like a "bus" (you have different devices
> that have different drivers bind to them, and you want to load those
> drivers with the hotplug mechanism.) 

[ Vojtech mumbles something about saying that from the beginning. ]

> The only thing keeping this from
> being a bus is the fact that we can't bind multiple drivers to a single
> device these days, and I can't see a way to move this code to that
> model, so oh well...
 
Oh, well.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
