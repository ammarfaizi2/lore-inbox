Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261773AbTJ1W6z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 17:58:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261779AbTJ1W6z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 17:58:55 -0500
Received: from quechua.inka.de ([193.197.184.2]:26576 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S261773AbTJ1W6x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 17:58:53 -0500
From: Andreas Jellinghaus <aj@dungeon.inka.de>
Subject: Re: ANNOUNCE: User-space System Device Enumeration (uSDE)
Date: Tue, 28 Oct 2003 23:59:14 +0100
User-Agent: Pan/0.14.2 (This is not a psychotic episode. It's a cleansing moment of clarity. (Debian GNU/Linux))
Message-Id: <pan.2003.10.28.22.59.13.441436@dungeon.inka.de>
References: <3F9DA5A6.3020008@mvista.com> <Pine.LNX.4.33.0310280901490.7139-100000@osdlab.pdx.osdl.net>
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I find it difficult to see your justification for designing a project from
> scratch instead of contributing your time, effort, and ideas to a pair of
> already existing, albeit immature, projects that do exactly the same
> thing.

Hi Patric,

maybe you can tell me:
with devfs it is _very_ simple to see what a driver does, and what
information it passes on devices. it is the major and minor number,
the device type, a name, and a default permissions (that does not
require changes in most cases).

sysfs is very sparse:
 - no (explicit) device type
   (/sys/block/ has block devices, the rest is char.)
 - no default permissions
   (the driver author often knows well, if a device should be secured
   or not. why can't he pass that information?)
 - only plain names like old /dev. I still can't see how any user space
   tool can find out, that my /sys/block/hda/ is a hard disk, and 
   /sys/block/hdc/ is a cdrom. how could any tool create /dev/discs/ and
   /dev/cdrom/ devices without that distinction?
 - why is a usb printer class usb? I thought that was the bus? shouldn't
   it be class printer (or "lp" or something like that)? how can any
   tool create /dev/printers/ devices, if it cannot see how some usb
   device is a printer or not?

and how would some driver create additional export information for many
devices? understanding how floppy.c creates devfs devices for all those
fd0u1440 and friend devices is easy. but how would that driver create
information on those devices via sysfs?

I don't know exactly what the problem with devfs is, but maybe it is
because devfs is a filesystem? if so, could devfs be turned into a
/proc/ file, so we can get all those information currently registered
by all or most devices via that file, and some small userspace tool
has a chance to create a devfs like /dev/?

if sysfs doesn't gather and export the same amount of information 
devfs does, I don't know how any tool based on sysfs can ever 
seriously replace it. you want people to join current effords
(i.e, udev+sysfs). with many open questions I don't see how that
is possible? 

finishing the sysfs documentation and porting some drivers like
floppy.c and lp.c to sysfs could help. In its current state, I
don't understand many parts of sysfs, and it looks very natural
to me, that people rather implement something from scratch if it
is easy, than try to understand some very complex.

Regards, Andreas

