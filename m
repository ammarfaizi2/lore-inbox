Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129464AbRCACx6>; Wed, 28 Feb 2001 21:53:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129495AbRCACxs>; Wed, 28 Feb 2001 21:53:48 -0500
Received: from mta6.snfc21.pbi.net ([206.13.28.240]:8693 "EHLO
	mta6.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S129473AbRCACxf>; Wed, 28 Feb 2001 21:53:35 -0500
Date: Wed, 28 Feb 2001 18:48:21 -0800
From: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-usb-devel] USB oops Linux 2.4.2ac6
To: linux-kernel@vger.kernel.org
Cc: linux-usb-devel@lists.sourceforge.net
Message-id: <113501c0a1fa$1499e5e0$6800000a@brownell.org>
MIME-version: 1.0
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
Content-type: text/plain; charset="iso-8859-1"
Content-transfer-encoding: 7bit
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
In-Reply-To: <E14XuMy-0004ZW-00@the-village.bc.nu>
 <3A9D4E46.C1660841@cypress.com>
X-Priority: 3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Tbird-700 on MSI-6167 (Viper based) board.
> from dmesg
> -------------
> usb.c: registered new driver usbdevfs
> usb.c: registered new driver hub
> usb-ohci.c: USB OHCI at membase 0xd3874000, IRQ 11
> usb-ohci.c: usb-00:07.4, Advanced Micro Devices [AMD] AMD-756 [Viper]
> USB

Note that there's a chip erratum (#4 I think) on the AMD-756 that
makes it handle lowspeed devices wrong ... AMD told me I'd need
an NDA to learn their workaround, and I've not pursued it.  (Does
anyone already know what kind of NDA they use?)

> --------------
> If I boot with my mouse plugged in, or plug it in after the system
> is up, I get an oops. 
> While I was buildong the kernel I got a message from the kernel
> --------
> Feb 28 10:03:07 tedpc kernel: usb-ohci.c: bogus NDP=242 for OHCI
> usb-00:07.4
> Feb 28 10:03:07 tedpc kernel: usb-ohci.c: rereads as NDP=4
> -----

These are symptoms of that erratum.  Don't plug lowspeed devices
(like, probably, your mouse) into the root hub ... something about
that makes some of the registers read wrong.   Like telling you
that you've got 242 downstream ports.  At least this time it was
a clearly bogus value.

Since the second register read was correct, I've sometimes thought
maybe it'd work better if you just redefined readl() to do each read
twice ... might be worth the experiment, since you have the hardware.

> ----
> kernel BUG at slab.c:1398!
> ----

Something went wrong ... :-)  Hard to say who without
at least a stacktrace.

- Dave



