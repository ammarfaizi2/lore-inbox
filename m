Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291558AbSBHMZb>; Fri, 8 Feb 2002 07:25:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291541AbSBHMZW>; Fri, 8 Feb 2002 07:25:22 -0500
Received: from mail.sonytel.be ([193.74.243.200]:64713 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S291013AbSBHMZO>;
	Fri, 8 Feb 2002 07:25:14 -0500
Date: Fri, 8 Feb 2002 13:25:07 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linux Kernel Development <linux-kernel@vger.kernel.org>,
        Linux Serial Development <linux-serial@vger.kernel.org>
Subject: CONFIG_SERIAL_ACPI and early_serial_setup
Message-ID: <Pine.GSO.4.21.0202081320200.29963-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


If CONFIG_SERIAL_ACPI=y, but CONFIG_SERIAL=m, the kernel (2.4.18-pre9) doesn't
link because early_serial_setup() is not found.

I think the correct fix is to not allow CONFIG_SERIAL_ACPI, unless
CONFIG_SERIAL=y.

--- linux-tux-2.4.18-pre9/drivers/char/Config.in.orig	Fri Feb  8 09:38:36 2002
+++ linux-tux-2.4.18-pre9/drivers/char/Config.in	Fri Feb  8 13:23:25 2002
@@ -15,9 +15,9 @@
       tristate '   Atomwide serial port support' CONFIG_ATOMWIDE_SERIAL
       tristate '   Dual serial port support' CONFIG_DUALSP_SERIAL
    fi
-fi
-if [ "$CONFIG_ACPI" = "y" ]; then
-   bool '  Support for serial ports defined by ACPI tables' CONFIG_SERIAL_ACPI
+   if [ "$CONFIG_ACPI" = "y" ]; then
+      bool '  Support for serial ports defined by ACPI tables' CONFIG_SERIAL_ACPI
+   fi
 fi
 dep_mbool 'Extended dumb serial driver options' CONFIG_SERIAL_EXTENDED $CONFIG_SERIAL
 if [ "$CONFIG_SERIAL_EXTENDED" = "y" ]; then

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

