Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422827AbWHYT6y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422827AbWHYT6y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 15:58:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422865AbWHYT6y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 15:58:54 -0400
Received: from hobbit.corpit.ru ([81.13.94.6]:9053 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S1422827AbWHYT6x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 15:58:53 -0400
Message-ID: <44EF5677.8060304@tls.msk.ru>
Date: Fri, 25 Aug 2006 23:58:47 +0400
From: Michael Tokarev <mjt@tls.msk.ru>
Organization: Telecom Service, JSC
User-Agent: Mail/News 1.5 (X11/20060318)
MIME-Version: 1.0
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: How to identify serial ports (ttySn)?
X-Enigmail-Version: 0.94.0.0
OpenPGP: id=4F9CF57E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On a regular basis, /dev/ttySnn devices gets
renumbered with next kernel version.

For example, we've a PCI serial card (NetMos in
this case), with, say, one serial port on it.
Plus some ports on the motherboard (usually one
or two).  The question is where's the NetMos port,
on which /dev/ttySnn?

Some time ago, probably at the time of linux 2.4,
netmos device number was dependent on the max.
number of "standard" serial ports configured in
the kernel during compile.  Ie, if it where set
to 8 (ttyS0..ttyS7), netmos one becomes ttyS8.
If set to 4, netmos was ttyS4 etc.  I always
configured 8 ports in the kernel, so my netmos
card was always been ttyS8.

Next, with 2.6.something which was the first 2.6
I tried, it suddenly become ttyS4.  I don't remember
the details already.  So I reconfigured all the
machines (it was UPS control program which is
sitting on that port) to use another device.

At least 2.6.11 assigns ttyS3 to the device, saying
the first two ports are reserved for the onboard
devices.  So I again reconfigured the app to use
ttyS3 (or ttyS2 - I'm not sure).

Now, with 2.6.17, the netmos port is ttyS1.  Because
in reality, on the motherboard there's only one
serial port soldered (that's the reason why we
got the netmos card in the first place), so "next
unused" device is ttyS1.

So the question is: how to find where's the thing
on the running kernel, and where it will be with
next version?  Is there a way to assign a name for
the thing, so it will be independent of the current
kernel?  I just want to use it, the hardware is
*constant* for several years, but each kernel
release gives yet another surprize, here or there.

And please don't tell me that's some udev thing.
there's no need to run that f*cked udev on all
those machines, the hardware is stable for many
years, there's no hotpluggable, usb or not,
devices of any sort.

More, there's no way to assign constant name for
that thing with udev, too - it seems.  Serial
ports exports no useful information to be
identified.

Thanks.

/mjt
