Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267460AbRGLJ4V>; Thu, 12 Jul 2001 05:56:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267461AbRGLJ4L>; Thu, 12 Jul 2001 05:56:11 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:17169 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S267460AbRGLJ4E>;
	Thu, 12 Jul 2001 05:56:04 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15181.29641.394178.784579@tango.paulus.ozlabs.org>
Date: Thu, 12 Jul 2001 19:54:17 +1000 (EST)
To: torvalds@transmeta.com, tytso@mit.edu
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] set serial_driver.name_base
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, Ted,

The following patch sets serial_driver.name_base so that devfs gives
us the correct names for the serial ports when we have a non-zero
SERIAL_DEV_OFFSET (as on powermacs).  It will be completely benign in
other situations since SERIAL_DEV_OFFSET is 0 there.

Thanks,
Paul.

diff -urN linux/drivers/char/serial.c linuxppc_2_4/drivers/char/serial.c
--- linux/drivers/char/serial.c	Thu Jul 12 16:54:25 2001
+++ linuxppc_2_4/drivers/char/serial.c	Tue Jul 10 14:01:04 2001
@@ -5352,6 +5352,7 @@
 #endif
 	serial_driver.major = TTY_MAJOR;
 	serial_driver.minor_start = 64 + SERIAL_DEV_OFFSET;
+	serial_driver.name_base = SERIAL_DEV_OFFSET;
 	serial_driver.num = NR_PORTS;
 	serial_driver.type = TTY_DRIVER_TYPE_SERIAL;
 	serial_driver.subtype = SERIAL_TYPE_NORMAL;
