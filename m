Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265378AbSKPHsn>; Sat, 16 Nov 2002 02:48:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265650AbSKPHsn>; Sat, 16 Nov 2002 02:48:43 -0500
Received: from mtiwmhc11.worldnet.att.net ([204.127.131.115]:17061 "EHLO
	mtiwmhc11.worldnet.att.net") by vger.kernel.org with ESMTP
	id <S265378AbSKPHsm>; Sat, 16 Nov 2002 02:48:42 -0500
Message-ID: <XFMail.20021116025536.f.duncan.m.haldane@worldnet.att.net>
X-Mailer: XFMail 1.5.3 on Linux
X-Priority: 3 (Normal)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="_=XFMail.1.5.3.Linux:20021116025536:12532=_"
Date: Sat, 16 Nov 2002 02:55:36 -0500 (EST)
From: Duncan Haldane <f.duncan.m.haldane@worldnet.att.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] for 2.4.20rc2  Makefile (fixes Oops)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format
--_=XFMail.1.5.3.Linux:20021116025536:12532=_
Content-Type: text/plain; charset=us-ascii

This patch fixes an Oops if  the cpia_usb webcam driver is compiled into 
the kernel (there since 2.4.13).

usb_register() is called before usb_init(), and the usb_bus_list_lock
semaphore is not initialized... OOPS!

The cpia drivers are in drivers/media/media.o.  The fix moves the position
of media.o in the Makefile DRIVERS list to after usb.o.  In 2.4.x. this
means that usb-in-the-kernel now gets initialized before cpia-in-the-kernel:  No
more OOPS.

Can this simple fix get into 2.4.20?

In this context, thus spoke Alan Cox: 
> That media is not right near the end is a quirk of history nothing more.
> It ought to be after usb
and 
> media/video can go after almost anything else so I dont see a problem
> with that in 2.4 or 2.5

Hope he's right!

diff -uNr linux-2.4.20-rc2/Makefile linux-2.4.20-rc2-media/Makefile
--- linux-2.4.20-rc2/Makefile   Fri Nov 15 21:51:22 2002
+++ linux-2.4.20-rc2-media/Makefile     Fri Nov 15 23:12:29 2002
@@ -137,8 +137,7 @@
 DRIVERS-y += drivers/char/char.o \
        drivers/block/block.o \
        drivers/misc/misc.o \
-       drivers/net/net.o \
-       drivers/media/media.o
+       drivers/net/net.o 
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



----------------------------------
E-Mail: Duncan Haldane <f.duncan.m.haldane@worldnet.att.net>
Date: 15-Nov-2002
Time: 21:40:56

This message was sent by XFMail
----------------------------------

--------------End of forwarded message-------------------------

----------------------------------
E-Mail: Duncan Haldane <f.duncan.m.haldane@worldnet.att.net>
Date: 16-Nov-2002
Time: 02:37:42

This message was sent by XFMail
----------------------------------

--_=XFMail.1.5.3.Linux:20021116025536:12532=_
Content-Disposition: attachment; filename="linux-2.4.20-rc2-media.patch"
Content-Transfer-Encoding: base64
Content-Type: application/octet-stream;
 name=linux-2.4.20-rc2-media.patch; SizeOnDisk=871

ZGlmZiAtdU5yIGxpbnV4LTIuNC4yMC1yYzIvTWFrZWZpbGUgbGludXgtMi40LjIwLXJjMi1tZWRp
YS9NYWtlZmlsZQotLS0gbGludXgtMi40LjIwLXJjMi9NYWtlZmlsZQlGcmkgTm92IDE1IDIxOjUx
OjIyIDIwMDIKKysrIGxpbnV4LTIuNC4yMC1yYzItbWVkaWEvTWFrZWZpbGUJRnJpIE5vdiAxNSAy
MzoxMjoyOSAyMDAyCkBAIC0xMzcsOCArMTM3LDcgQEAKIERSSVZFUlMteSArPSBkcml2ZXJzL2No
YXIvY2hhci5vIFwKIAlkcml2ZXJzL2Jsb2NrL2Jsb2NrLm8gXAogCWRyaXZlcnMvbWlzYy9taXNj
Lm8gXAotCWRyaXZlcnMvbmV0L25ldC5vIFwKLQlkcml2ZXJzL21lZGlhL21lZGlhLm8KKwlkcml2
ZXJzL25ldC9uZXQubyAKIERSSVZFUlMtJChDT05GSUdfQUdQKSArPSBkcml2ZXJzL2NoYXIvYWdw
L2FncC5vCiBEUklWRVJTLSQoQ09ORklHX0RSTV9ORVcpICs9IGRyaXZlcnMvY2hhci9kcm0vZHJt
Lm8KIERSSVZFUlMtJChDT05GSUdfRFJNX09MRCkgKz0gZHJpdmVycy9jaGFyL2RybS00LjAvZHJt
Lm8KQEAgLTE3OSw2ICsxNzgsNyBAQAogRFJJVkVSUy0kKENPTkZJR19IQU1SQURJTykgKz0gZHJp
dmVycy9uZXQvaGFtcmFkaW8vaGFtcmFkaW8ubwogRFJJVkVSUy0kKENPTkZJR19UQykgKz0gZHJp
dmVycy90Yy90Yy5hCiBEUklWRVJTLSQoQ09ORklHX1VTQikgKz0gZHJpdmVycy91c2IvdXNiZHJ2
Lm8KK0RSSVZFUlMteSArPWRyaXZlcnMvbWVkaWEvbWVkaWEubwogRFJJVkVSUy0kKENPTkZJR19J
TlBVVCkgKz0gZHJpdmVycy9pbnB1dC9pbnB1dGRydi5vCiBEUklWRVJTLSQoQ09ORklHX0hJTCkg
Kz0gZHJpdmVycy9oaWwvaGlsLm8KIERSSVZFUlMtJChDT05GSUdfSTJPKSArPSBkcml2ZXJzL21l
c3NhZ2UvaTJvL2kyby5vCg==

--_=XFMail.1.5.3.Linux:20021116025536:12532=_--
End of MIME message
