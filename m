Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129902AbQKASKv>; Wed, 1 Nov 2000 13:10:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130726AbQKASKl>; Wed, 1 Nov 2000 13:10:41 -0500
Received: from mta6.snfc21.pbi.net ([206.13.28.240]:11398 "EHLO
	mta6.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S129902AbQKASK3>; Wed, 1 Nov 2000 13:10:29 -0500
Date: Wed, 01 Nov 2000 09:35:18 -0800
From: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-usb-devel] Patch: linux-2.4.0-test10-pre7/drivers/usb/usb.c
 driver matching bug
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Message-id: <013501c0442a$1b08f160$6500000a@brownell.org>
MIME-version: 1.0
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
Content-type: text/plain; charset="Windows-1252"
Content-transfer-encoding: 7bit
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
In-Reply-To: <200011010342.TAA08318@adam.yggdrasil.com>
X-Priority: 3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> linux-2.4.0-test10-pre7/drivers/usb/usb.c introduced a really
> cool feature, where USB drivers can declare a data structure that
> describes the various ID bytes of the USB devices that they are
> relevant to. 

It's the same tool architecture used with PCI:  modules.pcimap
(and now modules.isapnpmap) also come from MODULE_DEVICE_TABLE
entries.  Modutils 2.3.19+ required.


>     Updated versions of depmod and hotplug are then
> used so that the appropriate USB drivers can then be loaded
> automatically as soon as you plug in a device, without any
> need to create additional system configuration files.

The "no additional config files" is what's new in test10.

Before, handcrafted /etc/usb/drivers/* scripts were used;
great as proof-of-concept, lousy to maintain as the primary
way to handle driver hotplugging.


> Anyhow, the USB implementation of this has a tiny bug,
> where it does an apples-and-oranges comparison.  The patch is
> attached below.

My bad ... thanks for that one-liner, and the driver updates
to make more USB drivers use this new "modutils" support!


> By the way, I was able to test this all the way to the
> point of plugging in a USB printer and watching the module
> automatically load and bind to the printer interface.  (I
> will submit the usb/printer.c device table support patch to
> linux-usb-devel momentarily.)

For the benefit of LKML readers who don't read Linux-USB-devel,
see http://www.linux-usb.org/policy.html for an overview (not
updated yet to reflect 2.4.0-test10).  Scripts are in CVS:

http://cvs.sourceforge.net/cgi-bin/cvsweb.cgi/usbd/etc/?cvsroot=linux-usb

You can make this work with just "hotplug" (called by kernel)
and "policy" (handling USB-specific driver selection).  That
"hotplug" script should eventually handle other types of bus.

The USB "policy" script uses "modules.usbmap", but will fall back
to /etc/usb/drivers scripts, which you should NOT have if you're
trying to test "modules.usbmap" support in a driver.  (If you
just want to use this not debug it, you want those scripts.)

With the USB driver updates I've already seen, it looks like an
upcoming 2.4 kernel may no longer need those driver scripts; not
sure about the 2.2 backports though.

- Dave



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
