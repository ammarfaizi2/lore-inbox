Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932368AbVLPTvm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932368AbVLPTvm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 14:51:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932380AbVLPTvm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 14:51:42 -0500
Received: from xproxy.gmail.com ([66.249.82.201]:42543 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932368AbVLPTvl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 14:51:41 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type;
        b=low8Qj8TK3tV/G1P+wixPLhVOSywsvAcwpNp8q61+dxE7ipJ1DUDq1y+Rp3vFzJ5IuZznYjfCsaTYDOt6euWXP0se6otpDIZ3LauLPhRGDrklRSlUmWnQbDknvQ4piBnpAUrXG/GzCQ59hJmfVLs8WoEawu64qwHf64MjL0tMuw=
Message-ID: <e55525570512161151u6d4388bdv6bc3291fffc697f@mail.gmail.com>
Date: Fri, 16 Dec 2005 15:51:39 -0400
From: Anderson Briglia <briglia.anderson@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] MMC - CONFIG_HOTPLUG support
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_15399_12008496.1134762699994"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_15399_12008496.1134762699994
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi all,

This patch improves the CONFIG_HOTPLUG support on the mmc core driver.
Kernel version: 2.6.15-rc4-omap1

BR,

--
Anderson Briglia

------=_Part_15399_12008496.1134762699994
Content-Type: text/x-patch; name=mmc_config_hotplug.diff; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="mmc_config_hotplug.diff"

Signed-off-by: Anderson Briglia <anderson.briglia@indt.org.br>

Index: linux-2.6.15-rc4/drivers/mmc/mmc_sysfs.c
===================================================================
--- linux-2.6.15-rc4.orig/drivers/mmc/mmc_sysfs.c	2005-12-15 17:00:52.000000000 -0400
+++ linux-2.6.15-rc4/drivers/mmc/mmc_sysfs.c	2005-12-15 17:54:07.000000000 -0400
@@ -145,6 +145,8 @@ static int mmc_bus_match(struct device *
 	return !mmc_card_bad(card);
 }
 
+#ifdef CONFIG_HOTPLUG
+
 static int
 mmc_bus_hotplug(struct device *dev, char **envp, int num_envp, char *buf,
 		int buf_size)
@@ -180,6 +182,17 @@ mmc_bus_hotplug(struct device *dev, char
 	return 0;
 }
 
+#else
+
+static int
+mmc_bus_hotplug(struct device *dev, char **envp, int num_envp, char *buf,
+		int buf_size)
+{
+	return -ENODEV;
+}
+
+#endif  /* CONFIG_HOTPLUG */
+
 static int mmc_bus_suspend(struct device *dev, pm_message_t state)
 {
 	struct mmc_driver *drv = to_mmc_driver(dev->driver);

------=_Part_15399_12008496.1134762699994--
