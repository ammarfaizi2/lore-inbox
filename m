Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267519AbUHWT5I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267519AbUHWT5I (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 15:57:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267532AbUHWT4O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 15:56:14 -0400
Received: from mail.kroah.org ([69.55.234.183]:41923 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266691AbUHWSgL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 14:36:11 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI and I2C fixes for 2.6.8
User-Agent: Mutt/1.5.6i
In-Reply-To: <1093286090580@kroah.com>
Date: Mon, 23 Aug 2004 11:34:50 -0700
Message-Id: <10932860902842@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1807.59.5, 2004/08/05 14:03:11-07:00, greg@kroah.com

[PATCH] I2C: fix up the order of bus drivers in the Kconfig and Makefile

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/busses/Kconfig  |   24 ++++++++++++------------
 drivers/i2c/busses/Makefile |    4 ++--
 2 files changed, 14 insertions(+), 14 deletions(-)


diff -Nru a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
--- a/drivers/i2c/busses/Kconfig	2004-08-23 11:05:21 -07:00
+++ b/drivers/i2c/busses/Kconfig	2004-08-23 11:05:21 -07:00
@@ -185,6 +185,18 @@
 	  This support is also available as a module.  If so, the module 
 	  will be called i2c-keywest.
 
+config I2C_MPC
+	tristate "MPC107/824x/85xx/52xx"
+	depends on I2C && FSL_OCP
+	help
+	  If you say yes to this option, support will be included for the
+	  built-in I2C interface on the MPC107/Tsi107/MPC8240/MPC8245 and
+	  MPC85xx family processors. The driver may also work on 52xx
+	  family processors, though interrupts are known not to work.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called i2c-mpc.
+
 config I2C_NFORCE2
 	tristate "Nvidia Nforce2"
 	depends on I2C && PCI && EXPERIMENTAL
@@ -406,17 +418,5 @@
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-voodoo3.
-
-config I2C_MPC
-	tristate "MPC107/824x/85xx/52xx"
-	depends on I2C && FSL_OCP
-	help
-	  If you say yes to this option, support will be included for the
-	  built-in I2C interface on the MPC107/Tsi107/MPC8240/MPC8245 and
-	  MPC85xx family processors. The driver may also work on 52xx
-	  family processors, though interrupts are known not to work.
-
-	  This driver can also be built as a module.  If so, the module
-	  will be called i2c-mpc.
 
 endmenu
diff -Nru a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
--- a/drivers/i2c/busses/Makefile	2004-08-23 11:05:21 -07:00
+++ b/drivers/i2c/busses/Makefile	2004-08-23 11:05:21 -07:00
@@ -15,9 +15,10 @@
 obj-$(CONFIG_I2C_IOP3XX)	+= i2c-iop3xx.o
 obj-$(CONFIG_I2C_ISA)		+= i2c-isa.o
 obj-$(CONFIG_I2C_ITE)		+= i2c-ite.o
-obj-$(CONFIG_I2C_IXP4XX)	+= i2c-ixp4xx.o
 obj-$(CONFIG_I2C_IXP2000)	+= i2c-ixp2000.o
+obj-$(CONFIG_I2C_IXP4XX)	+= i2c-ixp4xx.o
 obj-$(CONFIG_I2C_KEYWEST)	+= i2c-keywest.o
+obj-$(CONFIG_I2C_MPC)		+= i2c-mpc.o
 obj-$(CONFIG_I2C_NFORCE2)	+= i2c-nforce2.o
 obj-$(CONFIG_I2C_PARPORT)	+= i2c-parport.o
 obj-$(CONFIG_I2C_PARPORT_LIGHT)	+= i2c-parport-light.o
@@ -33,7 +34,6 @@
 obj-$(CONFIG_I2C_VOODOO3)	+= i2c-voodoo3.o
 obj-$(CONFIG_SCx200_ACB)	+= scx200_acb.o
 obj-$(CONFIG_SCx200_I2C)	+= scx200_i2c.o
-obj-$(CONFIG_I2C_MPC)	+= i2c-mpc.o
 
 ifeq ($(CONFIG_I2C_DEBUG_BUS),y)
 EXTRA_CFLAGS += -DDEBUG

