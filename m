Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262945AbRFCOCw>; Sun, 3 Jun 2001 10:02:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263102AbRFCOCn>; Sun, 3 Jun 2001 10:02:43 -0400
Received: from [213.128.193.148] ([213.128.193.148]:18961 "EHLO linuxhacker.ru")
	by vger.kernel.org with ESMTP id <S262945AbRFCOCZ>;
	Sun, 3 Jun 2001 10:02:25 -0400
Date: Sun, 3 Jun 2001 18:02:03 +0400
From: Oleg Drokin <green@linuxhacker.ru>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.5-ac7
Message-ID: <20010603180203.B1143@linuxhacker.ru>
In-Reply-To: <200106030746.f537kSZ12820@linuxhacker.ru> <E156VvF-0004D1-00@the-village.bc.nu> <20010603133333.A25478@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010603133333.A25478@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Sun, Jun 03, 2001 at 01:33:33PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Sun, Jun 03, 2001 at 01:33:33PM +0100, Russell King wrote:
> > > AC> 2.4.5-ac7
> > > AC> o       Make USB require PCI                            (me)
> > > Huh?!
> > > How about people from StrongArm sa11x0 port, who have USB host controller (in
> > > sa1111 companion chip) but do not have PCI?
> > The strongarm doesnt have a USB master but a slave.
> Alan, a StrongARM 11x0 with its companion SA11x1 chip is a USB master.
> Last time I looked, it was supported:
After mentioned patch it is no longer possible to choose this driver,
because we have no PCI in sa11x0, but the change is:

--- linux-2.4.5/drivers/usb/Config.in	Sat May 26 10:55:12 2001
+++ linux-2.4.5-ac7/drivers/usb/Config.in	Sun Jun  3 11:42:00 2001
@@ -4,9 +4,11 @@
 mainmenu_option next_comment
 comment 'USB support'
 
-tristate 'Support for USB' CONFIG_USB
+dep_tristate 'Support for USB' CONFIG_USB $CONFIG_PCI
 if [ ! "$CONFIG_USB" = "n" ]; then
    bool '  USB verbose debug messages' CONFIG_USB_DEBUG
+   bool '  Long timeout for slow-responding devices (some MGE Ellipse UPSes)' CONFIG_USB_LONG_TIMEOUT
+   bool '  Large report fetching for "broken" devices (some APC UPSes)' CONFIG_USB_LARGE_CONFIG
 
 comment 'Miscellaneous USB options'
    bool '  Preliminary USB device filesystem' CONFIG_USB_DEVICEFS

