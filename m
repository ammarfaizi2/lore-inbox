Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315200AbSH1Q5K>; Wed, 28 Aug 2002 12:57:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316795AbSH1Q5K>; Wed, 28 Aug 2002 12:57:10 -0400
Received: from p0118.as-l043.contactel.cz ([194.108.242.118]:19952 "EHLO
	SnowWhite.SuSE.cz") by vger.kernel.org with ESMTP
	id <S315200AbSH1Q5I> convert rfc822-to-8bit; Wed, 28 Aug 2002 12:57:08 -0400
To: linux-kernel@vger.kernel.org
Cc: Tim Waugh <twaugh@redhat.com>
Subject: parport_serial and serial driver?
From: Pavel@Janik.cz (Pavel =?iso-8859-2?q?Jan=EDk?=)
X-Face: $"d&^B_IKlTHX!y2d,3;grhwjOBqOli]LV`6d]58%5'x/kBd7.MO&n3bJ@Zkf&RfBu|^qL+
 ?/Re{MpTqanXS2'~Qp'J2p^M7uM:zp[1Xq#{|C!*'&NvCC[9!|=>#qHqIhroq_S"MH8nSH+d^9*BF:
 iHiAs(t(~b#1.{w.d[=Z
Date: Wed, 28 Aug 2002 18:50:50 +0200
Message-ID: <m3it1vapw5.fsf@Janik.cz>
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) Emacs/21.3.50
 (i386-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I use non-modular kernel with parport_serial driver built in (NetMos-based
cards, 2.4.latest-vanilla patched for NetMos PCI IDs). The problem is that
parport_serial is initialized before serial driver and thus both serial
ports on that card are detected as ttyS00. This patch helped me:

--- linux.orig/Makefile	Wed Aug 28 13:46:45 2002
+++ linux/Makefile	Wed Aug 28 13:46:51 2002
@@ -130,12 +130,13 @@
 DRIVERS-  :=
 
 DRIVERS-$(CONFIG_ACPI) += drivers/acpi/acpi.o
-DRIVERS-$(CONFIG_PARPORT) += drivers/parport/driver.o
 DRIVERS-y += drivers/char/char.o \
 	drivers/block/block.o \
 	drivers/misc/misc.o \
 	drivers/net/net.o \
 	drivers/media/media.o
+# Change the order of initialization of parport_serial and serial
+DRIVERS-$(CONFIG_PARPORT) += drivers/parport/driver.o
 DRIVERS-$(CONFIG_AGP) += drivers/char/agp/agp.o
 DRIVERS-$(CONFIG_DRM_NEW) += drivers/char/drm/drm.o
 DRIVERS-$(CONFIG_DRM_OLD) += drivers/char/drm-4.0/drm.o


When the same kernel has parport_serial as a module, everything works
fine, because serial is already initialized.

BTW - Is there a way to specify the order of initialization (module_init)
of certain drivers? What is the proper solution to my problem?
-- 
Pavel Janík

panic("IRQ, you lose...");
                  -- 2.2.16 arch/mips/sgi/kernel/indy_int.c
