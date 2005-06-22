Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262796AbVFVGhG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262796AbVFVGhG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 02:37:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262804AbVFVG15
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 02:27:57 -0400
Received: from mail.kroah.org ([69.55.234.183]:29596 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262800AbVFVFWF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 01:22:05 -0400
Cc: khali@linux-fr.org
Subject: [PATCH] I2C: #include <linux/config.h> cleanup
In-Reply-To: <11194174633604@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 21 Jun 2005 22:17:43 -0700
Message-Id: <11194174631273@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] I2C: #include <linux/config.h> cleanup

Hi Alexey,

> Files that don't use CONFIG_* stuff shouldn't include config.h
> Files that use CONFIG_* stuff should include config.h
>
> It's that simple. ;-)

I agree. This won't change anything though, as all drivers include
either device.h or module.h, which in turn include config.h. But you are
still correct, so I approve your patch.

For completeness, I would propose the following on top of your own
patch:

i2c bus drivers do not need to define DEBUG themselves, as the Kconfig
system takes care of it.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit a551ef79d9413727f76d22dc47b5b15d1d03073b
tree 4b43e032dc6b6cb5de78ce700b12762ab71483e0
parent f0bb60e7b1a0a26c25d8cbf81dda7afbc8bd2982
author Jean Delvare <khali@linux-fr.org> Sat, 16 Apr 2005 18:49:22 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Tue, 21 Jun 2005 21:51:53 -0700

 drivers/i2c/busses/i2c-ixp2000.c |    5 -----
 drivers/i2c/busses/i2c-ixp4xx.c  |    5 -----
 2 files changed, 0 insertions(+), 10 deletions(-)

diff --git a/drivers/i2c/busses/i2c-ixp2000.c b/drivers/i2c/busses/i2c-ixp2000.c
--- a/drivers/i2c/busses/i2c-ixp2000.c
+++ b/drivers/i2c/busses/i2c-ixp2000.c
@@ -26,11 +26,6 @@
  * 'enabled' to drive the GPIOs.
  */
 
-#include <linux/config.h>
-#ifdef CONFIG_I2C_DEBUG_BUS
-#define DEBUG	1
-#endif
-
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/device.h>
diff --git a/drivers/i2c/busses/i2c-ixp4xx.c b/drivers/i2c/busses/i2c-ixp4xx.c
--- a/drivers/i2c/busses/i2c-ixp4xx.c
+++ b/drivers/i2c/busses/i2c-ixp4xx.c
@@ -26,11 +26,6 @@
  *       that is passed as the platform_data to this driver.
  */
 
-#include <linux/config.h>
-#ifdef CONFIG_I2C_DEBUG_BUS
-#define DEBUG	1
-#endif
-
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/device.h>

