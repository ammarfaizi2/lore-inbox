Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265211AbTBTMNz>; Thu, 20 Feb 2003 07:13:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265222AbTBTMNz>; Thu, 20 Feb 2003 07:13:55 -0500
Received: from h-64-105-35-136.SNVACAID.covad.net ([64.105.35.136]:56221 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S265211AbTBTMNo>; Thu, 20 Feb 2003 07:13:44 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Thu, 20 Feb 2003 04:09:34 -0800
Message-Id: <200302201209.EAA12261@adam.yggdrasil.com>
To: zippel@linux-m68k.org
Subject: Re: [RFC] Is an alternative module interface needed/possible?
Cc: linux-kernel@vger.kernel.org, rusty@rustcorp.com.au, wa@almesberger.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2003-02-20, Roman Zippel responded to Werner Almesberger:
>The question is now whether we return an error value or use a callback. 
>When a device is removed, we usually also want to remove all its data 
>structures, on the other hand we can only remove a module when there are 
>no users, so here we return an error value.
>Now I need a bigger example to put this into a context, a nice example is 
>scsi_unregister. It removes among other things procfs entries and these 
>entries have a reference to struct Scsi_Host. As long as scsi_unregister 
>is called from module_exit everything works fine, but a bit searching 
>reveals drivers/usb/storage/usb.c, which create/removes a scsi host when 
>you plug/unplug a storage device (let's ignore other problems here, like 
>it's still mounted).

	The ability to remove a module is generally independent of
whether or not there is any hardware present at that moment for which
the module supplies a driver.  Instead, the determining issue is
whether there are file descriptors open for that driver.

	Of course, if the necessary hardware was never present at any
time when the device driver's module was loaded, then there never will
be any file descriptors open for the device driver.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
