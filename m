Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261810AbVFTXvM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261810AbVFTXvM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 19:51:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261789AbVFTXtd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 19:49:33 -0400
Received: from mail.kroah.org ([69.55.234.183]:60132 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261788AbVFTXAE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 19:00:04 -0400
Cc: yani.ioannou@gmail.com
Subject: [PATCH] Driver Core: arch: update device attribute callbacks
In-Reply-To: <11193083682108@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 20 Jun 2005 15:59:28 -0700
Message-Id: <11193083681775@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] Driver Core: arch: update device attribute callbacks

Signed-off-by: Yani Ioannou <yani.ioannou@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit ff381d2223a30ee70752791fd9c3588d8f1cab77
tree 124dab1e725ad0d16f1122696a67f1657ea97a8f
parent 3eb8c7836eb074b61d63597be3e4f085814ac4c0
author Yani Ioannou <yani.ioannou@gmail.com> Tue, 17 May 2005 06:40:51 -0400
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 20 Jun 2005 15:15:32 -0700

 arch/arm/common/amba.c        |    2 +-
 arch/arm/kernel/ecard.c       |   12 ++++++------
 arch/arm26/kernel/ecard.c     |   10 +++++-----
 arch/ia64/sn/kernel/tiocx.c   |    4 ++--
 arch/parisc/kernel/drivers.c  |    2 +-
 arch/ppc/kernel/pci.c         |    2 +-
 arch/ppc/syslib/ocp.c         |    2 +-
 arch/ppc/syslib/of_device.c   |    2 +-
 arch/ppc64/kernel/of_device.c |    2 +-
 arch/ppc64/kernel/pci.c       |    2 +-
 arch/ppc64/kernel/vio.c       |    4 ++--
 11 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/arch/arm/common/amba.c b/arch/arm/common/amba.c
--- a/arch/arm/common/amba.c
+++ b/arch/arm/common/amba.c
@@ -169,7 +169,7 @@ static void amba_device_release(struct d
 }
 
 #define amba_attr(name,fmt,arg...)				\
-static ssize_t show_##name(struct device *_dev, char *buf)	\
+static ssize_t show_##name(struct device *_dev, struct device_attribute *attr, char *buf)	\
 {								\
 	struct amba_device *dev = to_amba_device(_dev);		\
 	return sprintf(buf, fmt, arg);				\
diff --git a/arch/arm/kernel/ecard.c b/arch/arm/kernel/ecard.c
--- a/arch/arm/kernel/ecard.c
+++ b/arch/arm/kernel/ecard.c
@@ -866,19 +866,19 @@ static struct expansion_card *__init eca
 	return ec;
 }
 
-static ssize_t ecard_show_irq(struct device *dev, char *buf)
+static ssize_t ecard_show_irq(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct expansion_card *ec = ECARD_DEV(dev);
 	return sprintf(buf, "%u\n", ec->irq);
 }
 
-static ssize_t ecard_show_dma(struct device *dev, char *buf)
+static ssize_t ecard_show_dma(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct expansion_card *ec = ECARD_DEV(dev);
 	return sprintf(buf, "%u\n", ec->dma);
 }
 
-static ssize_t ecard_show_resources(struct device *dev, char *buf)
+static ssize_t ecard_show_resources(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct expansion_card *ec = ECARD_DEV(dev);
 	char *str = buf;
@@ -893,19 +893,19 @@ static ssize_t ecard_show_resources(stru
 	return str - buf;
 }
 
-static ssize_t ecard_show_vendor(struct device *dev, char *buf)
+static ssize_t ecard_show_vendor(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct expansion_card *ec = ECARD_DEV(dev);
 	return sprintf(buf, "%u\n", ec->cid.manufacturer);
 }
 
-static ssize_t ecard_show_device(struct device *dev, char *buf)
+static ssize_t ecard_show_device(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct expansion_card *ec = ECARD_DEV(dev);
 	return sprintf(buf, "%u\n", ec->cid.product);
 }
 
-static ssize_t ecard_show_type(struct device *dev, char *buf)
+static ssize_t ecard_show_type(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct expansion_card *ec = ECARD_DEV(dev);
 	return sprintf(buf, "%s\n", ec->type == ECARD_EASI ? "EASI" : "IOC");
diff --git a/arch/arm26/kernel/ecard.c b/arch/arm26/kernel/ecard.c
--- a/arch/arm26/kernel/ecard.c
+++ b/arch/arm26/kernel/ecard.c
@@ -562,31 +562,31 @@ static void __init ecard_init_resources(
 	}
 }
 
-static ssize_t ecard_show_irq(struct device *dev, char *buf)
+static ssize_t ecard_show_irq(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct expansion_card *ec = ECARD_DEV(dev);
 	return sprintf(buf, "%u\n", ec->irq);
 }
 
-static ssize_t ecard_show_vendor(struct device *dev, char *buf)
+static ssize_t ecard_show_vendor(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct expansion_card *ec = ECARD_DEV(dev);
 	return sprintf(buf, "%u\n", ec->cid.manufacturer);
 }
 
-static ssize_t ecard_show_device(struct device *dev, char *buf)
+static ssize_t ecard_show_device(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct expansion_card *ec = ECARD_DEV(dev);
 	return sprintf(buf, "%u\n", ec->cid.product);
 }
 
-static ssize_t ecard_show_dma(struct device *dev, char *buf)
+static ssize_t ecard_show_dma(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct expansion_card *ec = ECARD_DEV(dev);
 	return sprintf(buf, "%u\n", ec->dma);
 }
 
-static ssize_t ecard_show_resources(struct device *dev, char *buf)
+static ssize_t ecard_show_resources(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct expansion_card *ec = ECARD_DEV(dev);
 	char *str = buf;
diff --git a/arch/ia64/sn/kernel/tiocx.c b/arch/ia64/sn/kernel/tiocx.c
--- a/arch/ia64/sn/kernel/tiocx.c
+++ b/arch/ia64/sn/kernel/tiocx.c
@@ -432,7 +432,7 @@ static int tiocx_reload(struct cx_dev *c
 	return cx_device_reload(cx_dev);
 }
 
-static ssize_t show_cxdev_control(struct device *dev, char *buf)
+static ssize_t show_cxdev_control(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct cx_dev *cx_dev = to_cx_dev(dev);
 
@@ -442,7 +442,7 @@ static ssize_t show_cxdev_control(struct
 		       tiocx_btchar_get(cx_dev->cx_id.nasid));
 }
 
-static ssize_t store_cxdev_control(struct device *dev, const char *buf,
+static ssize_t store_cxdev_control(struct device *dev, struct device_attribute *attr, const char *buf,
 				   size_t count)
 {
 	int n;
diff --git a/arch/parisc/kernel/drivers.c b/arch/parisc/kernel/drivers.c
--- a/arch/parisc/kernel/drivers.c
+++ b/arch/parisc/kernel/drivers.c
@@ -466,7 +466,7 @@ static int parisc_generic_match(struct d
 }
 
 #define pa_dev_attr(name, field, format_string)				\
-static ssize_t name##_show(struct device *dev, char *buf)		\
+static ssize_t name##_show(struct device *dev, struct device_attribute *attr, char *buf)		\
 {									\
 	struct parisc_device *padev = to_parisc_device(dev);		\
 	return sprintf(buf, format_string, padev->field);		\
diff --git a/arch/ppc/kernel/pci.c b/arch/ppc/kernel/pci.c
--- a/arch/ppc/kernel/pci.c
+++ b/arch/ppc/kernel/pci.c
@@ -1003,7 +1003,7 @@ pci_create_OF_bus_map(void)
 	}
 }
 
-static ssize_t pci_show_devspec(struct device *dev, char *buf)
+static ssize_t pci_show_devspec(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct pci_dev *pdev;
 	struct device_node *np;
diff --git a/arch/ppc/syslib/ocp.c b/arch/ppc/syslib/ocp.c
--- a/arch/ppc/syslib/ocp.c
+++ b/arch/ppc/syslib/ocp.c
@@ -68,7 +68,7 @@ static int ocp_inited;
 /* Sysfs support */
 #define OCP_DEF_ATTR(field, format_string)				\
 static ssize_t								\
-show_##field(struct device *dev, char *buf)				\
+show_##field(struct device *dev, struct device_attribute *attr, char *buf)				\
 {									\
 	struct ocp_device *odev = to_ocp_dev(dev);			\
 									\
diff --git a/arch/ppc/syslib/of_device.c b/arch/ppc/syslib/of_device.c
--- a/arch/ppc/syslib/of_device.c
+++ b/arch/ppc/syslib/of_device.c
@@ -161,7 +161,7 @@ void of_unregister_driver(struct of_plat
 }
 
 
-static ssize_t dev_show_devspec(struct device *dev, char *buf)
+static ssize_t dev_show_devspec(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct of_device *ofdev;
 
diff --git a/arch/ppc64/kernel/of_device.c b/arch/ppc64/kernel/of_device.c
--- a/arch/ppc64/kernel/of_device.c
+++ b/arch/ppc64/kernel/of_device.c
@@ -161,7 +161,7 @@ void of_unregister_driver(struct of_plat
 }
 
 
-static ssize_t dev_show_devspec(struct device *dev, char *buf)
+static ssize_t dev_show_devspec(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct of_device *ofdev;
 
diff --git a/arch/ppc64/kernel/pci.c b/arch/ppc64/kernel/pci.c
--- a/arch/ppc64/kernel/pci.c
+++ b/arch/ppc64/kernel/pci.c
@@ -507,7 +507,7 @@ int pci_mmap_page_range(struct pci_dev *
 }
 
 #ifdef CONFIG_PPC_MULTIPLATFORM
-static ssize_t pci_show_devspec(struct device *dev, char *buf)
+static ssize_t pci_show_devspec(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct pci_dev *pdev;
 	struct device_node *np;
diff --git a/arch/ppc64/kernel/vio.c b/arch/ppc64/kernel/vio.c
--- a/arch/ppc64/kernel/vio.c
+++ b/arch/ppc64/kernel/vio.c
@@ -300,7 +300,7 @@ static void __devinit vio_dev_release(st
 }
 
 #ifdef CONFIG_PPC_PSERIES
-static ssize_t viodev_show_devspec(struct device *dev, char *buf)
+static ssize_t viodev_show_devspec(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct device_node *of_node = dev->platform_data;
 
@@ -309,7 +309,7 @@ static ssize_t viodev_show_devspec(struc
 DEVICE_ATTR(devspec, S_IRUSR | S_IRGRP | S_IROTH, viodev_show_devspec, NULL);
 #endif
 
-static ssize_t viodev_show_name(struct device *dev, char *buf)
+static ssize_t viodev_show_name(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	return sprintf(buf, "%s\n", to_vio_dev(dev)->name);
 }

