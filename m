Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264191AbTIIO4x (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 10:56:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264186AbTIIO4t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 10:56:49 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:48517 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S264181AbTIIO4h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 10:56:37 -0400
Subject: Re: [ANNOUNCE] New hardware - SGA155D dual STM-1/OC3 PCI ad
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Horvath Gyorgy <HORVAATH@tmit.bme.hu>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200309091428.h89ES0Oe015172@alpha.ttt.bme.hu>
References: <200309091428.h89ES0Oe015172@alpha.ttt.bme.hu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1063119321.30379.19.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-5) 
Date: Tue, 09 Sep 2003 15:55:21 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-09-09 at 15:27, Horvath Gyorgy wrote:
>    As I see - SGA155D is a multifunction adapter in this context.
>    Are there any driver model or technique for this situation?
>    My guess is that I write a core driver for the hardware itself
>    that can be compiled in the kernel (or can be modularized).
>    This driver allows manipulating the IP-Core for the FPGA.
>    Functional drivers are then modularized on demand.

That is probably the right model. We do something similar with dual
function parallel/serial cards and of course on a huge scale with USB
where a USB hub means loading many other drivers to use the devices 
attached to it.

>    BTW Can I insmod other drivers from a kernel driver?

Yes. request_module() and the hotplug interface let you do that in
various kernels. Right now for example the USB layer goes back to the
userspace /sbin/hotplug and says "I need a driver for one of these" and
the hotplug layer figures out what to do.

> 2. Packet over SONET...
>    Is syncppp conforming RFC1619, RFC1662, RFC2615?
>    I can't find notes on this in syncppp.c...

Syncppp is pretty basic and obsoleted by the hdlc driver stuff.

> 3. The telephony part is not yet clear for me.
>    For the new application in question - there is not much to do
>    in Linux, since the mass will be driven/sunk by the
>    hard-disks.  But it might be useful elsewhere...
>    Anyway - I will dig-up the Linux telephony project for advice
>    before bothering this list.

Take a look at the Zaptel stuff, thats basically the T1 version of a
winmodem but might have some interesting ideas in it.

> 4. Optionally - and if I have enough time - I'd like
>    to develop a twin-linear filesystem driver for
>    time-stamped capture/playback for multiple channels
>    of data - like a multi-band magnetic tape.
>    BTW do you know an existing one?

I've seen people do this in user space (just interleaving the disk in
big chunks in the app and driving it with O_DIRECT raw access) but not
in kernel file system space.

Alan

