Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261910AbVEKH5B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261910AbVEKH5B (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 03:57:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261908AbVEKH5B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 03:57:01 -0400
Received: from rproxy.gmail.com ([64.233.170.196]:45158 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261910AbVEKH44 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 03:56:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type;
        b=SMoWfagMZ9wpqtlYclrmOosiKVkNOei1qoS5Ifn1abVZuBkCcOj3asqe9vnw2ALZZYWf6KBXdoSrTlwCXxqYTPIBl3y5xEr9jJLDCPF+Ai4wPX5EevlLEihL/NNoCtBeDMA5iVbUpZD73Zb0MfcfrwPF4wEjZ9EY+sdwxWqy0C4=
Message-ID: <2538186705051100563e884f2f@mail.gmail.com>
Date: Wed, 11 May 2005 03:56:55 -0400
From: Yani Ioannou <yani.ioannou@gmail.com>
Reply-To: Yani Ioannou <yani.ioannou@gmail.com>
To: Greg KH <greg@kroah.com>, LM Sensors <sensors@stimpy.netroedge.com>,
       linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.12-rc4 1/3] (dynamic sysfs callbacks) device_attribute
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_180_2911800.1115798215596"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_180_2911800.1115798215596
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

This patch adds support to the sysfs device_attribute to pass the new
void * attribute member to it's callback functions. The device
attribute will benefit the most from the dynamic sysfs callback patch
compared to the other attributes simply because of it's greater usage.

The first patch simply adds the void * parameter to the device
attribute function types and passes them when calling the callbacks.

Signed-off-by: Yani Ioannou <yani.ioannou@gmail.com>

Thanks,
Yani

---
 drivers/base/core.c    |    4 ++--
 include/linux/device.h |    5 +++--
 2 files changed, 5 insertions(+), 4 deletions(-)

------=_Part_180_2911800.1115798215596
Content-Type: text/x-patch; 
	name=patch-linux-2.6.12-rc4-sysfsdyncallback-deviceattr.diff; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="patch-linux-2.6.12-rc4-sysfsdyncallback-deviceattr.diff"

diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-gregkhcore/drivers/base/core.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/base/core.c
--- linux-2.6.12-rc4-sysfsdyncallback-gregkhcore/drivers/base/core.c	2005-05-10 21:44:00.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr/drivers/base/core.c	2005-05-10 23:17:20.000000000 -0400
@@ -41,7 +41,7 @@ dev_attr_show(struct kobject * kobj, str
 	ssize_t ret = 0;
 
 	if (dev_attr->show)
-		ret = dev_attr->show(dev, buf);
+		ret = dev_attr->show(dev, buf, attr->private);
 	return ret;
 }
 
@@ -54,7 +54,7 @@ dev_attr_store(struct kobject * kobj, st
 	ssize_t ret = 0;
 
 	if (dev_attr->store)
-		ret = dev_attr->store(dev, buf, count);
+		ret = dev_attr->store(dev, buf, count, attr->private);
 	return ret;
 }
 
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-gregkhcore/include/linux/device.h linux-2.6.12-rc4-sysfsdyncallback-deviceattr/include/linux/device.h
--- linux-2.6.12-rc4-sysfsdyncallback-gregkhcore/include/linux/device.h	2005-05-10 21:44:28.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr/include/linux/device.h	2005-05-10 23:23:15.000000000 -0400
@@ -335,8 +335,9 @@ extern void driver_attach(struct device_
 
 struct device_attribute {
 	struct attribute	attr;
-	ssize_t (*show)(struct device * dev, char * buf);
-	ssize_t (*store)(struct device * dev, const char * buf, size_t count);
+	ssize_t (*show)(struct device * dev, char * buf, void * private);
+	ssize_t (*store)(struct device * dev, const char * buf, size_t count,
+			void * private);
 };
 
 #define DEVICE_ATTR(_name,_mode,_show,_store) \







------=_Part_180_2911800.1115798215596--
