Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261669AbSJUUvE>; Mon, 21 Oct 2002 16:51:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261675AbSJUUvE>; Mon, 21 Oct 2002 16:51:04 -0400
Received: from h-64-105-137-32.SNVACAID.covad.net ([64.105.137.32]:40599 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S261669AbSJUUvC>; Mon, 21 Oct 2002 16:51:02 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Mon, 21 Oct 2002 13:56:41 -0700
Message-Id: <200210212056.NAA01321@adam.yggdrasil.com>
To: ebiederm@xmission.com, mochel@osdl.org
Subject: Re: Patch: linux-2.5.42/kernel/sys.c - warm reboot should not suspend devices
Cc: eblade@blackmagik.dynup.net, linux-kernel@vger.kernel.org,
       rmk@arm.linux.org.uk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Biederman writes:
>My big concern is with getting the shutdown path setup in a manner
>that works, and gets testing.

	Rebooting without traversing the device tree seems to have
essentially worked fine for 2.4.x.

>When booting linux from linux with
>sys_kexec a lot of my problems come back to some device driver not
>getting shutdown.

	kmonte and sys_kexec skip the BIOS reset code and therefore
may need to do more elaborate shutdown, but please do not saddle the
normal reboot case with the reliability risk of calling code in each
driver when a user might be rebooting a remote machine precisely
because of a a confused device driver or the potential slow down
(especially since you want an interface where the function that gets
called before reboot may need to do blocking IO).  For
kmonte/sys_kexec, this high cost might be necessary, but for the
normal reboot the cost is not worth the benefit.

	By way, given the ability to register reboot notifiers in the
device tree, I would be happy to see one registered at the top of the
PCI bus tree (so it would be called last) that would shut off the PCI
bus before reboot, along the lines of what Richard B. Johnson posted.
That would not involve walking a lot of data structures in many
different device drivers and it would be just a few instrutions.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."

