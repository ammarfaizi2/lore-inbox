Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263661AbUATAOy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 19:14:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265140AbUATAO3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 19:14:29 -0500
Received: from mail.kroah.org ([65.200.24.183]:24748 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265141AbUATAAH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 19:00:07 -0500
Subject: Re: [PATCH] i2c driver fixes for 2.6.1
In-Reply-To: <10745567643883@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 19 Jan 2004 15:59:24 -0800
Message-Id: <10745567642211@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1474.98.17, 2004/01/16 14:12:27-08:00, khali@linux-fr.org

[PATCH] I2C: clean up ISA dependancies

Quoting myself:

> 1* Elektor depends on ISA.
> 2* ELV and Velleman do not depend on ISA.
> 3* i2c-isa is M by default, and has an additional help text
> 4* via686a autoselects i2c-isa
> 5* i2c-isa doesn't depend on ISA

Here's the patch:


 drivers/i2c/busses/Kconfig |    6 +++---
 drivers/i2c/chips/Kconfig  |    1 +
 2 files changed, 4 insertions(+), 3 deletions(-)


diff -Nru a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
--- a/drivers/i2c/busses/Kconfig	Mon Jan 19 15:30:05 2004
+++ b/drivers/i2c/busses/Kconfig	Mon Jan 19 15:30:05 2004
@@ -49,7 +49,7 @@
 
 config I2C_ELEKTOR
 	tristate "Elektor ISA card"
-	depends on I2C_ALGOPCF && BROKEN_ON_SMP
+	depends on I2C_ALGOPCF && ISA && BROKEN_ON_SMP
 	help
 	  This supports the PCF8584 ISA bus I2C adapter.  Say Y if you own
 	  such an adapter.
@@ -59,7 +59,7 @@
 
 config I2C_ELV
 	tristate "ELV adapter"
-	depends on I2C_ALGOBIT && ISA
+	depends on I2C_ALGOBIT
 	help
 	  This supports parallel-port I2C adapters called ELV.  Say Y if you
 	  own such an adapter.
@@ -321,7 +321,7 @@
 
 config I2C_VELLEMAN
 	tristate "Velleman K8000 adapter"
-	depends on I2C_ALGOBIT && ISA
+	depends on I2C_ALGOBIT
 	help
 	  This supports the Velleman K8000 parallel-port I2C adapter.  Say Y
 	  if you own such an adapter.
diff -Nru a/drivers/i2c/chips/Kconfig b/drivers/i2c/chips/Kconfig
--- a/drivers/i2c/chips/Kconfig	Mon Jan 19 15:30:05 2004
+++ b/drivers/i2c/chips/Kconfig	Mon Jan 19 15:30:05 2004
@@ -117,6 +117,7 @@
 	tristate "VIA686A"
 	depends on I2C && EXPERIMENTAL
 	select I2C_SENSOR
+	select I2C_ISA
 	help
 	  If you say yes here you get support for the integrated sensors in
 	  Via 686A/B South Bridges.

