Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932496AbWB0Wd1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932496AbWB0Wd1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 17:33:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932391AbWB0Wcr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 17:32:47 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:28545 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S932358AbWB0WcK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 17:32:10 -0500
Message-Id: <20060227223352.122673000@sorel.sous-sol.org>
References: <20060227223200.865548000@sorel.sous-sol.org>
Date: Mon, 27 Feb 2006 14:32:20 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Jean Delvare <khali@linux-fr.org>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 20/39] [PATCH] hwmon it87: Probe i2c 0x2d only
Content-Disposition: inline; filename=hwmon-it87-probe-i2c-0x2d-only.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

Only scan I2C address 0x2d. This is the default address and no IT87xxF
chip was ever seen on I2C at a different address. These chips are
better accessed through their ISA interface anyway.

This fixes bug #5889, although it doesn't address the whole class
of problems. We'd need the ability to blacklist arbitrary I2C addresses
on systems known to contain I2C devices which behave badly when probed.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---

 Documentation/hwmon/it87 |    2 +-
 drivers/hwmon/it87.c     |    3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

--- linux-2.6.15.4.orig/Documentation/hwmon/it87
+++ linux-2.6.15.4/Documentation/hwmon/it87
@@ -9,7 +9,7 @@ Supported chips:
                http://www.ite.com.tw/
   * IT8712F
     Prefix: 'it8712'
-    Addresses scanned: I2C 0x28 - 0x2f
+    Addresses scanned: I2C 0x2d
                        from Super I/O config space (8 I/O ports)
     Datasheet: Publicly available at the ITE website
                http://www.ite.com.tw/
--- linux-2.6.15.4.orig/drivers/hwmon/it87.c
+++ linux-2.6.15.4/drivers/hwmon/it87.c
@@ -45,8 +45,7 @@
 
 
 /* Addresses to scan */
-static unsigned short normal_i2c[] = { 0x28, 0x29, 0x2a, 0x2b, 0x2c, 0x2d,
-					0x2e, 0x2f, I2C_CLIENT_END };
+static unsigned short normal_i2c[] = { 0x2d, I2C_CLIENT_END };
 static unsigned short isa_address;
 
 /* Insmod parameters */

--
