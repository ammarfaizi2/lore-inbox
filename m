Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266304AbUH2KGQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266304AbUH2KGQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 06:06:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266578AbUH2KGQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 06:06:16 -0400
Received: from postfix3-2.free.fr ([213.228.0.169]:16082 "EHLO
	postfix3-2.free.fr") by vger.kernel.org with ESMTP id S266304AbUH2KGN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 06:06:13 -0400
Message-ID: <1093773970.4131aa9251448@imp4-q.free.fr>
Date: Sun, 29 Aug 2004 12:06:10 +0200
From: castet.matthieu@free.fr
To: linux-kernel@vger.kernel.org
Subject: pnp and acpi_pnp
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.5
X-Originating-IP: 213.228.47.30
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

in pnpbios Kconfig, it is said that acpi will  supersede PNPBIOS some day.
But acpi_pnp seem incomplete :
- It doesn't have got a sysfs entry that let the user see the device he has, and
let him change some parameters.
- You can't export pnp alias that let some script (like hotplug) autoload the
modules you need.
- Also it seem less precise than pnpbios detection (might be a acpi bug in my
computer...) : on my laptop I have a serial port (PNP0501) and a ir port
(PNP0510). The 8250_pnp driver only find the serial port, but the 8250_acpi
find both ports, but it is not good because I can't load the specific ir driver
without unloading the serial modules...
- acpi_pnp doesn't also offer generic function
(pnp_{port,irq,dma,...}_{start,len,valid,..}) that permit easy discovering of
the ressource need by the device and don't need specific handler like in
acpi_pnp.

Also if you want support pnpbios and acpi_pnp (not eveybody had a working
acpi...) you had to duplicate your code (and even do 2 modules like serial
module does). If acpi_pnp id will be exported it would be even worse because
the 2 drivers will register the same device, and because pnpbios automatiquely
disable device (and free the resource it uses) if the probe fail, it could be
very problematic...

So could it be possible to integreate acpi_pnp in pnp protocol that already
supprt pnpbios and isapnp ?
Also I believe it must do before too much driver use acpi_pnp.

Thanks.

Matthieu

PS : for the people that think that pnp is useless, they can look for example
how some alsa driver try to manage mpu and joystick without it (for example in
intel8x0.c, they register the LPC (hopefully some clever driver like i8xx_tco
or hw_random that use also the lpc don't register it...), for the jostick they
duplicate generic code from ns558 that can autodetect the port via pnp and find
the good one (alsa driver alway thinks the gameport is on io 0x200, but in
reality it is on io 0x201 on my computer...), it is the same for mpu and the
generic module snd-mpu401(only support acpi pnp, but I had a version that
support pnpbios), and the intel8x0.c don't handle mpu irq whereas snd-mpu401
does...

PS2 : please CC me since I'm not subscribed to lkml.
