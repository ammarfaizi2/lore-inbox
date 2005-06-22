Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262870AbVFVKl5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262870AbVFVKl5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 06:41:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262854AbVFVG4m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 02:56:42 -0400
Received: from mail.kroah.org ([69.55.234.183]:8348 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262782AbVFVFVz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 01:21:55 -0400
Cc: khali@linux-fr.org
Subject: [PATCH] I2C: Add support for the LPC47M15x and LPC47M192 chips to smsc47m1
In-Reply-To: <11194174633368@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 21 Jun 2005 22:17:43 -0700
Message-Id: <11194174633743@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] I2C: Add support for the LPC47M15x and LPC47M192 chips to smsc47m1

This simple patch adds support for the SMSC LPC47M15x and LPC47M192
chips to the smsc47m1 hardware monitoring driver. These chips are
compatible with the other ones already supported by the driver, so I see
no reason not to support them, especially when the Linux 2.4 version of
the driver does already.

I also modified the info printks to name the chips by their real name.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit ec5ce552d946a55c1e504054627c9068fb7afb8a
tree 88a4ff89a92939fbc6da3b92d80a6025a3351432
parent b9110b1c893f45ec66ae39e359decdfad84525be
author Jean Delvare <khali@linux-fr.org> Tue, 26 Apr 2005 22:09:43 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Tue, 21 Jun 2005 21:51:54 -0700

 drivers/i2c/chips/Kconfig    |    2 +-
 drivers/i2c/chips/smsc47m1.c |   10 ++++++----
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/chips/Kconfig b/drivers/i2c/chips/Kconfig
--- a/drivers/i2c/chips/Kconfig
+++ b/drivers/i2c/chips/Kconfig
@@ -331,7 +331,7 @@ config SENSORS_SMSC47M1
 	help
 	  If you say yes here you get support for the integrated fan
 	  monitoring and control capabilities of the SMSC LPC47B27x,
-	  LPC47M10x, LPC47M13x and LPC47M14x chips.
+	  LPC47M10x, LPC47M13x, LPC47M14x, LPC47M15x and LPC47M192 chips.
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called smsc47m1.
diff --git a/drivers/i2c/chips/smsc47m1.c b/drivers/i2c/chips/smsc47m1.c
--- a/drivers/i2c/chips/smsc47m1.c
+++ b/drivers/i2c/chips/smsc47m1.c
@@ -372,14 +372,16 @@ static int smsc47m1_find(int *address)
 	 * SMSC LPC47M10x/LPC47M13x (device id 0x59), LPC47M14x (device id
 	 * 0x5F) and LPC47B27x (device id 0x51) have fan control.
 	 * The LPC47M15x and LPC47M192 chips "with hardware monitoring block"
-	 * can do much more besides (device id 0x60, unsupported).
+	 * can do much more besides (device id 0x60).
 	 */
 	if (val == 0x51)
-		printk(KERN_INFO "smsc47m1: Found SMSC47B27x\n");
+		printk(KERN_INFO "smsc47m1: Found SMSC LPC47B27x\n");
 	else if (val == 0x59)
-		printk(KERN_INFO "smsc47m1: Found SMSC47M10x/SMSC47M13x\n");
+		printk(KERN_INFO "smsc47m1: Found SMSC LPC47M10x/LPC47M13x\n");
 	else if (val == 0x5F)
-		printk(KERN_INFO "smsc47m1: Found SMSC47M14x\n");
+		printk(KERN_INFO "smsc47m1: Found SMSC LPC47M14x\n");
+	else if (val == 0x60)
+		printk(KERN_INFO "smsc47m1: Found SMSC LPC47M15x/LPC47M192\n");
 	else {
 		superio_exit();
 		return -ENODEV;

