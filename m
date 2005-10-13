Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932544AbVJMXhj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932544AbVJMXhj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 19:37:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932545AbVJMXhi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 19:37:38 -0400
Received: from ns.suse.de ([195.135.220.2]:12471 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932544AbVJMXhi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 19:37:38 -0400
Message-ID: <2553895.1129246651478.SLOX.WebMail.wwwrun@imap-dhs.suse.de>
Date: Fri, 14 Oct 2005 01:37:31 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: dtor_core@ameritech.net
Subject: Re: [patch 0/8] Nesting class_device patches that actually work
Cc: Kay Sievers <kay.sievers@vrfy.org>, Greg KH <gregkh@suse.de>,
       Vojtech Pavlik <vojtech@suse.cz>,
       Patrick Mochel <mochel@digitalimplant.org>, airlied@linux.ie,
       linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>
In-Reply-To: <d120d5000510131435m7b27fe59l917ac3e11b2458c8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3 (normal)
X-Mailer: SuSE Linux Openexchange Server 4 - WebMail (Build 2.4160)
X-Operating-System: Linux 2.4.21-295-smp i386 (JVM 1.3.1_13)
Organization: SuSE Linux AG
References: <20051013020844.GA31732@kroah.com> <20051013105826.GA11155@vrfy.org> <d120d5000510131435m7b27fe59l917ac3e11b2458c8@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Do 13.10.2005 23:35 schrieb Dmitry Torokhov
<dmitry.torokhov@gmail.com>:

> On 10/13/05, Kay Sievers <kay.sievers@vrfy.org> wrote:
> >
[ ... ]
> >
> > Instead of that, I propose a unification of "/sys/devices-devices"
> > and "class-devices". The differentiation of both does not make sense
> > in a wold where we can't really tell if a device is hardware or
> > virtual.
> >
[ ... ]
> >
>
> Hi,
>
> Kay eased my task by enumerating all issues I have with Greg's
> approach. Not all the world is udev and not all class devices have
> "/dev" represetation so haveing one program being able to understand
> new sysfs hierarchy is not enough IHMO.
>
Do not forget another side effect: we only have 'devices' within a tree
under /sys/devices.
/sys/class is just a mapping with no real devices in them, only
 symlinks.
So _everything_ can be found under /sys/devices, and you don't have to
figure out whether this device your looking for is a class device or a
proper device or whatever.

So we really have unified view for all devices, may they be physical or
logical devices.

> However I do not think that "moving" class devices into /sys/devices
> hierarchy is the right solution either because one physical device
> could easily end up belonging to several classes. I recenty got an
> e-mail from Adam Belay (whom I am pulling into the discussion)
> regarding his desire to rearrange net/wireless representation. I think
> it would be quite natural to have /sys/class/net/interfaces and
> /sys/class/net/wireless /sys/class/net/irda, and /sys/class/net/wired
> subclasses where "interfaces" would enumerate _all_ network interfaces
> in the system, and the rest would show only devices of their class.
>
But you can! That was the whole idea behind it.
Every device ends up in /sys/devices, and the class is just a 'view' on
those devices.
(You might even call it API if you feel so inclined).
/sys/class/net/interfaces would be implemented just as a collection of
symlinks onto the proper devices in /sys/devices.

Overall this approach would make so many tasks so much simpler.
We could figure out the dependencies on a given device by just following
up the path; no need for the 'PHYSDEVPATH' stuff we have now for the
events. Plus we could model weird things like the SCSI subsystem onto
sysfs without having to resort to dirty tricks like we do now. Hell, we
maybe can even map the OpenPROM device tree onto sysfs for all I know.

So it definitely looks far superior to what we have now.

Cheers,

Hannes

