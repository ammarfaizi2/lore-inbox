Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316842AbSFVG37>; Sat, 22 Jun 2002 02:29:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316844AbSFVG36>; Sat, 22 Jun 2002 02:29:58 -0400
Received: from h-64-105-35-162.SNVACAID.covad.net ([64.105.35.162]:1966 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S316842AbSFVG36>; Sat, 22 Jun 2002 02:29:58 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Fri, 21 Jun 2002 23:29:51 -0700
Message-Id: <200206220629.XAA21506@adam.yggdrasil.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] /proc/scsi/map
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-06-21 at 15:33, Oliver Xymoron wrote:
> On Thu, 20 Jun 2002, Patrick Mochel wrote:
> 
> > > But it was entierly behind me how to fit this
> > > in to the sheme other sd@4,0:h,raw
> > > OS-es are using. And finally how would one fit this in to the
> > > partitioning shemes? For the system aprtitions are simply
> > > block devices hanging off the corresponding block device.
> >
> > Partitions are purely logical entities on a physical disk. They have no
> > presence in the physical device tree.
> 
> As I raised elsewhere in this thread, the distinction between physical and
> logical is troubling.  Consider iSCSI [...]

	Absolutely!  devicefs should be for anything that is simplified
by using the drivers/base rendezvous to eliminate that type of list
management which is repeated so many times in the kernel.

	One thing that is very confusing about the current
drivers/base code is that "struct bus' really has nothing to do
with a bus.  It should be called "struct device_type."  For example,
sd_mod (scsi disk), sr_mod (scsi cdrom), and sg (scsi generic) are
all drivers for arbitrary scsi devices, regardless of whether
they are connected by scsi ribbon cable, usb, or whatever.

	In the example of system partitions and raid, you could put a
struct device in struct gendisk and have the partitioning module
register themselves as drivers of that device type.  That way, they
would automatically try to attach to each disk that had no
partitioning scheme attached (actually, I'd rather eliminate all
partitioning suppot from the kernel and just have the device
mapper make the partition devices under control of a user level
utility, similar to the way all of my systems have been running
for the past couple of years via partx).

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
