Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264822AbSL0SiR>; Fri, 27 Dec 2002 13:38:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265094AbSL0SiR>; Fri, 27 Dec 2002 13:38:17 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:7176 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S264822AbSL0SiQ>;
	Fri, 27 Dec 2002 13:38:16 -0500
Date: Fri, 27 Dec 2002 10:42:13 -0800
From: Greg KH <greg@kroah.com>
To: Djeizon Barros <djeizon@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.4.20 Panic Report - Panic + Ksymoops + Config
Message-ID: <20021227184213.GB12245@kroah.com>
References: <000901c2adc8$0801df00$ce07b1c8@pentiumii>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000901c2adc8$0801df00$ce07b1c8@pentiumii>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 27, 2002 at 02:50:10PM -0200, Djeizon Barros wrote:
> Hi
> 
> I never had to fill a kernel bug report in 5 years using linux 
> - so please excuse me if I missed something here.This is kernel 2.4.20
> vanilla and unpatched. Looks like something weird in usb.c.

Ah, here's a patch for this problem.  It's in my list of things to send
to Marcelo next.  If you want to fix this without patching, make the
cpia driver a module.

thanks,

greg k-h


diff -Nru a/Makefile b/Makefile
--- a/Makefile	Fri Dec 27 10:51:55 2002
+++ b/Makefile	Fri Dec 27 10:51:55 2002
@@ -137,8 +137,7 @@
 DRIVERS-y += drivers/char/char.o \
 	drivers/block/block.o \
 	drivers/misc/misc.o \
-	drivers/net/net.o \
-	drivers/media/media.o
+	drivers/net/net.o
 DRIVERS-$(CONFIG_AGP) += drivers/char/agp/agp.o
 DRIVERS-$(CONFIG_DRM_NEW) += drivers/char/drm/drm.o
 DRIVERS-$(CONFIG_DRM_OLD) += drivers/char/drm-4.0/drm.o
@@ -179,6 +178,7 @@
 DRIVERS-$(CONFIG_HAMRADIO) += drivers/net/hamradio/hamradio.o
 DRIVERS-$(CONFIG_TC) += drivers/tc/tc.a
 DRIVERS-$(CONFIG_USB) += drivers/usb/usbdrv.o
+DRIVERS-y +=drivers/media/media.o
 DRIVERS-$(CONFIG_INPUT) += drivers/input/inputdrv.o
 DRIVERS-$(CONFIG_HIL) += drivers/hil/hil.o
 DRIVERS-$(CONFIG_I2O) += drivers/message/i2o/i2o.o
