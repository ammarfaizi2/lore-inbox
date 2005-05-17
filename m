Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261365AbVEQKnm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261365AbVEQKnm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 06:43:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261376AbVEQKnV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 06:43:21 -0400
Received: from rproxy.gmail.com ([64.233.170.203]:52833 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261365AbVEQKkw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 06:40:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type;
        b=lXUc6fryE0s27SVoyHpjag0Dm8YMZ8FebKbPgFp6VpbHvfTS/kFZopAO5zil9NKgsxtUdQwGGOm2k7sDCjDf29YhjmK26at1FHj8X4w4pH23WzFszbU6FGDHQv5HPHop9QgGJkSafBAcqCzhnNCmWWI3GSBpm6VvppNrCIQ4ocI=
Message-ID: <25381867050517034045502624@mail.gmail.com>
Date: Tue, 17 May 2005 06:40:51 -0400
From: Yani Ioannou <yani.ioannou@gmail.com>
Reply-To: Yani Ioannou <yani.ioannou@gmail.com>
To: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       lm-sensors@lm-sensors.org
Subject: [PATCH 2.6.12-rc4 4/15] arch: update device attribute callbacks
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_260_2018218.1116326451502"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_260_2018218.1116326451502
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Signed-off-by: Yani Ioannou <yani.ioannou@gmail.com>

---

------=_Part_260_2018218.1116326451502
Content-Type: text/plain; 
	name=patch-linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update.diff-arch.diff.diffstat.txt; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="patch-linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update.diff-arch.diff.diffstat.txt"

 arm/common/amba.c        |    2 +-
 arm/kernel/ecard.c       |   12 ++++++------
 arm26/kernel/ecard.c     |   10 +++++-----
 ia64/sn/kernel/tiocx.c   |    4 ++--
 parisc/kernel/drivers.c  |    2 +-
 ppc/kernel/pci.c         |    2 +-
 ppc/syslib/ocp.c         |    2 +-
 ppc/syslib/of_device.c   |    2 +-
 ppc64/kernel/of_device.c |    2 +-
 ppc64/kernel/pci.c       |    2 +-
 ppc64/kernel/vio.c       |    4 ++--
 11 files changed, 22 insertions(+), 22 deletions(-)



------=_Part_260_2018218.1116326451502
Content-Type: text/x-patch; 
	name=patch-linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update.diff-arch.diff; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="patch-linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update.diff-arch.diff"

diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/arch/arm/common/amba.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/arch/arm/common/amba.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/arch/arm/common/amba.c	2005-05-16 20:35:06.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/arch/arm/common/amba.c	2005-05-16 23:45:52.000000000 -0400
@@ -169,7 +169,7 @@ static void amba_device_release(struct d
 }
 
 #define amba_attr(name,fmt,arg...)				\
-static ssize_t show_##name(struct device *_dev, char *buf)	\
+static ssize_t show_##name(struct device *_dev, struct device_attribute *attr, char *buf)	\
 {								\
 	struct amba_device *dev = to_amba_device(_dev);		\
 	return sprintf(buf, fmt, arg);				\
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/arch/arm/kernel/ecard.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/arch/arm/kernel/ecard.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/arch/arm/kernel/ecard.c	2005-05-16 20:35:06.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/arch/arm/kernel/ecard.c	2005-05-16 23:45:52.000000000 -0400
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
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/arch/arm26/kernel/ecard.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/arch/arm26/kernel/ecard.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/arch/arm26/kernel/ecard.c	2005-05-16 20:35:21.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/arch/arm26/kernel/ecard.c	2005-05-16 23:45:52.000000000 -0400
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
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/arch/ia64/sn/kernel/tiocx.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/arch/ia64/sn/kernel/tiocx.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/arch/ia64/sn/kernel/tiocx.c	2005-05-16 20:35:15.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/arch/ia64/sn/kernel/tiocx.c	2005-05-16 23:45:52.000000000 -0400
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
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/arch/parisc/kernel/drivers.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/arch/parisc/kernel/drivers.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/arch/parisc/kernel/drivers.c	2005-05-16 20:35:25.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/arch/parisc/kernel/drivers.c	2005-05-16 23:45:52.000000000 -0400
@@ -466,7 +466,7 @@ static int parisc_generic_match(struct d
 }
 
 #define pa_dev_attr(name, field, format_string)				\
-static ssize_t name##_show(struct device *dev, char *buf)		\
+static ssize_t name##_show(struct device *dev, struct device_attribute *attr, char *buf)		\
 {									\
 	struct parisc_device *padev = to_parisc_device(dev);		\
 	return sprintf(buf, format_string, padev->field);		\
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/arch/ppc/kernel/pci.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/arch/ppc/kernel/pci.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/arch/ppc/kernel/pci.c	2005-05-16 20:35:10.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/arch/ppc/kernel/pci.c	2005-05-16 23:45:52.000000000 -0400
@@ -1003,7 +1003,7 @@ pci_create_OF_bus_map(void)
 	}
 }
 
-static ssize_t pci_show_devspec(struct device *dev, char *buf)
+static ssize_t pci_show_devspec(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct pci_dev *pdev;
 	struct device_node *np;
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/arch/ppc/syslib/ocp.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/arch/ppc/syslib/ocp.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/arch/ppc/syslib/ocp.c	2005-05-16 20:35:10.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/arch/ppc/syslib/ocp.c	2005-05-16 23:45:52.000000000 -0400
@@ -68,7 +68,7 @@ static int ocp_inited;
 /* Sysfs support */
 #define OCP_DEF_ATTR(field, format_string)				\
 static ssize_t								\
-show_##field(struct device *dev, char *buf)				\
+show_##field(struct device *dev, struct device_attribute *attr, char *buf)				\
 {									\
 	struct ocp_device *odev = to_ocp_dev(dev);			\
 									\
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/arch/ppc/syslib/of_device.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/arch/ppc/syslib/of_device.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/arch/ppc/syslib/of_device.c	2005-05-16 20:35:10.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/arch/ppc/syslib/of_device.c	2005-05-16 23:45:52.000000000 -0400
@@ -161,7 +161,7 @@ void of_unregister_driver(struct of_plat
 }
 
 
-static ssize_t dev_show_devspec(struct device *dev, char *buf)
+static ssize_t dev_show_devspec(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct of_device *ofdev;
 
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/arch/ppc64/kernel/of_device.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/arch/ppc64/kernel/of_device.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/arch/ppc64/kernel/of_device.c	2005-05-16 20:35:22.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/arch/ppc64/kernel/of_device.c	2005-05-16 23:45:52.000000000 -0400
@@ -161,7 +161,7 @@ void of_unregister_driver(struct of_plat
 }
 
 
-static ssize_t dev_show_devspec(struct device *dev, char *buf)
+static ssize_t dev_show_devspec(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct of_device *ofdev;
 
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/arch/ppc64/kernel/pci.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/arch/ppc64/kernel/pci.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/arch/ppc64/kernel/pci.c	2005-05-16 20:35:22.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/arch/ppc64/kernel/pci.c	2005-05-16 23:45:52.000000000 -0400
@@ -507,7 +507,7 @@ int pci_mmap_page_range(struct pci_dev *
 }
 
 #ifdef CONFIG_PPC_MULTIPLATFORM
-static ssize_t pci_show_devspec(struct device *dev, char *buf)
+static ssize_t pci_show_devspec(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct pci_dev *pdev;
 	struct device_node *np;
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/arch/ppc64/kernel/vio.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/arch/ppc64/kernel/vio.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/arch/ppc64/kernel/vio.c	2005-05-16 20:35:22.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/arch/ppc64/kernel/vio.c	2005-05-16 23:45:52.000000000 -0400
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



------=_Part_260_2018218.1116326451502--
