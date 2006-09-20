Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750835AbWITGEM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750835AbWITGEM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 02:04:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750803AbWITGEM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 02:04:12 -0400
Received: from web36710.mail.mud.yahoo.com ([209.191.85.44]:51599 "HELO
	web36710.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750835AbWITGEK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 02:04:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=1ZBvkfdnmeGtFXGUNVpBnV9GVVpEPzalGZM51T/jtC2VNwAqUqoxyABTosIYvi5UxJfUEP9T+5VOP7jQPr+OS8vnIdQjYrtifpM/07t2juYOtVrhpKjv3zfWpE7GCgYABzX1GKXtTieta2xmMd7XL0H/4K+t3jnGhClSqNx5JXM=  ;
Message-ID: <20060920060410.37146.qmail@web36710.mail.mud.yahoo.com>
Date: Tue, 19 Sep 2006 23:04:10 -0700 (PDT)
From: Alex Dubov <oakad@yahoo.com>
Subject: [PATCH 2/2] [MMC] Driver for TI FlashMedia card reader - Kconfig/Makefile entries
To: linux-kernel@vger.kernel.org
Cc: drzeus-list@drzeus.cx, rmk+lkml@arm.linux.org.uk
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Alex Dubov <oakad@yahoo.com>
---
 drivers/misc/Kconfig  |   21 ++++++++++++++++++++-
 drivers/misc/Makefile |    4 +++-
 drivers/mmc/Kconfig   |   14 ++++++++++++++
 drivers/mmc/Makefile  |    1 +
 4 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 7fc692a..7dfe4f3 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -28,5 +28,24 @@ config IBM_ASM
 
 	  If unsure, say N.
 
-endmenu
+config TIFM_CORE
+	tristate "TI Flash Media interface support (EXPERIMENTAL)"
+	depends on EXPERIMENTAL
+	help
+	  If you want support for Texas Instruments(R) Flash Media adapters
+	  you should select this option and than also choose an appropriate
+	  host adapter and card format driver support.
+	  
+	  If unsure, say N.
+
+config TIFM_7XX1
+	tristate "TI Flash Media PCI74xx/PCI76xx host adapter support (EXPERIMENTAL)"
+	depends on PCI && TIFM_CORE && EXPERIMENTAL
+	default TIFM_CORE
+	help
+	  This option enables support for Texas Instruments(R) PCI74xx and
+	  PCI76xx families of Flash Media adapters, found in many laptops.
 
+	  If unsure, say N.
+
+endmenu
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index 19c2b85..b1a9d90 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -3,5 +3,7 @@ # Makefile for misc devices that really 
 #
 obj- := misc.o	# Dummy rule to force built-in.o to be made
 
-obj-$(CONFIG_IBM_ASM)	+= ibmasm/
+obj-$(CONFIG_IBM_ASM)		+= ibmasm/
 obj-$(CONFIG_HDPU_FEATURES)	+= hdpuftrs/
+obj-$(CONFIG_TIFM_CORE)       	+= tifm_core.o
+obj-$(CONFIG_TIFM_7XX1)       	+= tifm_7xx1.o
diff --git a/drivers/mmc/Kconfig b/drivers/mmc/Kconfig
index 45bcf09..aa08dd1 100644
--- a/drivers/mmc/Kconfig
+++ b/drivers/mmc/Kconfig
@@ -109,4 +109,18 @@ config MMC_IMX
 
 	  If unsure, say N.
 
+comment "Texas Instruments Flash Media MMC/SD interface requires TIFM_CORE"
+        depends on MMC != n && TIFM_CORE = n
+	
+config MMC_TIFM_SD
+	tristate "TI Flash Media MMC/SD Interface support  (EXPERIMENTAL)"
+	depends on TIFM_CORE && MMC && EXPERIMENTAL
+	default TIFM_CORE
+	help
+	  This selects the Texas Instruments(R) Flash Media MMC/SD card
+	  interface found in many laptops.
+	  If you have a controller with this interface, say Y or M here.
+
+	  If unsure, say N.
+
 endmenu
diff --git a/drivers/mmc/Makefile b/drivers/mmc/Makefile
index d2957e3..e937ff6 100644
--- a/drivers/mmc/Makefile
+++ b/drivers/mmc/Makefile
@@ -23,6 +23,7 @@ obj-$(CONFIG_MMC_WBSD)		+= wbsd.o
 obj-$(CONFIG_MMC_AU1X)		+= au1xmmc.o
 obj-$(CONFIG_MMC_OMAP)		+= omap.o
 obj-$(CONFIG_MMC_AT91RM9200)	+= at91_mci.o
+obj-$(CONFIG_MMC_TIFM_SD)	+= tifm_sd.o
 
 mmc_core-y := mmc.o mmc_queue.o mmc_sysfs.o
 
-- 
1.4.2.1



__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
