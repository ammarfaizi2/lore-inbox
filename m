Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314529AbSFYTuY>; Tue, 25 Jun 2002 15:50:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315413AbSFYTuX>; Tue, 25 Jun 2002 15:50:23 -0400
Received: from h-64-105-35-162.SNVACAID.covad.net ([64.105.35.162]:62642 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S314529AbSFYTuW>; Tue, 25 Jun 2002 15:50:22 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Tue, 25 Jun 2002 12:50:18 -0700
Message-Id: <200206251950.MAA00725@adam.yggdrasil.com>
To: linux-kernel@vger.kernel.org
Subject: Re: driverfs is not for everything! (was: [PATCH] /proc/scsi/map )
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> = ???
>  = Patrick Mochel
>> I think the qualification for appearing in driverfs is actually possessing a 
>> driver.  Therefore, we accept FC and iSCSI.  Things which appear as 
>> FileSystems are debatable, but not anything which has a real device driver.
>
>The qualification for appearing in the device tree is the physical 
>presence of the device, regardless of the presence of a driver to control 
>it. (This typically depends on the presence of the bus driver so it can 
>discover the device.) Presence in the device tree implies presence in 
>driverfs.

	Lots of "soft" drivers, from /dev/lop to FC and iSCSI could
be simplified by using the struct device <--> struct device_driver
rendezvous code.  Under Patrick's propoposed, policy, we would not be
able to get the simplifications in scsi.c, usb.c, or anything else that
could possibly drive a device that was too "soft" for Patrick.

	It is also important for supporting hot plugging that user level
facilities understand that if ide disk #7 was removed that that
poisons /dev/loop/7.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
