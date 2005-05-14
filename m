Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262714AbVENJ1y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262714AbVENJ1y (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 May 2005 05:27:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262719AbVENJ1x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 May 2005 05:27:53 -0400
Received: from rproxy.gmail.com ([64.233.170.206]:46274 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262714AbVENJ0L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 May 2005 05:26:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type;
        b=oSBL+nMM2zYm5nwzaurRVQoUzYJy6fmIvo9oF4F5QoI6tY3nmi5IrCLNBFU4OJgj0pq+6cpY57PqyDJxLgo1V+2g8abSaApH4I9YhlTj7KAjwhiNO2ru0ReqHWZNCUgdvSXEesi5U6Jjshc16inSZz73PMWZHNZjkk8KtdZYIoQ=
Message-ID: <25381867050514022663d6dde3@mail.gmail.com>
Date: Sat, 14 May 2005 05:26:07 -0400
From: Yani Ioannou <yani.ioannou@gmail.com>
Reply-To: Yani Ioannou <yani.ioannou@gmail.com>
To: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.12-rc4 3/12] arch: (dynamic sysfs callbacks) update device attribute callbacks
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_1407_5944789.1116062767898"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_1407_5944789.1116062767898
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Signed-off-by: Yani Ioannou <yani.ioannou@gmail.com>

---

------=_Part_1407_5944789.1116062767898
Content-Type: text/plain; 
	name=patch-linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn.diff-arch.diff.diffstat.txt; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="patch-linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn.diff-arch.diff.diffstat.txt"

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

------=_Part_1407_5944789.1116062767898
Content-Type: text/x-patch; 
	name=patch-linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn.diff-arch.diff; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="patch-linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn.diff-arch.diff"

diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/arch/arm/common/amba.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/arch/arm/common/amba.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/arch/arm/common/amba.c	2005-05-11 00:28:04.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/arch/arm/common/amba.c	2005-05-11 00:31:13.000000000 -0400
@@ -169,7 +169,7 @@ static void amba_device_release(struct d
 }
 
 #define amba_attr(name,fmt,arg...)				\
-static ssize_t show_##name(struct device *_dev, char *buf)	\
+static ssize_t show_##name(struct device *_dev, char *buf, void *private)	\
 {								\
 	struct amba_device *dev = to_amba_device(_dev);		\
 	return sprintf(buf, fmt, arg);				\
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/arch/arm/kernel/ecard.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/arch/arm/kernel/ecard.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/arch/arm/kernel/ecard.c	2005-05-11 00:28:04.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/arch/arm/kernel/ecard.c	2005-05-11 00:31:13.000000000 -0400
@@ -866,19 +866,19 @@ static struct expansion_card *__init eca
 	return ec;
 }
 
-static ssize_t ecard_show_irq(struct device *dev, char *buf)
+static ssize_t ecard_show_irq(struct device *dev, char *buf, void *private)
 {
 	struct expansion_card *ec = ECARD_DEV(dev);
 	return sprintf(buf, "%u\n", ec->irq);
 }
 
-static ssize_t ecard_show_dma(struct device *dev, char *buf)
+static ssize_t ecard_show_dma(struct device *dev, char *buf, void *private)
 {
 	struct expansion_card *ec = ECARD_DEV(dev);
 	return sprintf(buf, "%u\n", ec->dma);
 }
 
-static ssize_t ecard_show_resources(struct device *dev, char *buf)
+static ssize_t ecard_show_resources(struct device *dev, char *buf, void *private)
 {
 	struct expansion_card *ec = ECARD_DEV(dev);
 	char *str = buf;
@@ -893,19 +893,19 @@ static ssize_t ecard_show_resources(stru
 	return str - buf;
 }
 
-static ssize_t ecard_show_vendor(struct device *dev, char *buf)
+static ssize_t ecard_show_vendor(struct device *dev, char *buf, void *private)
 {
 	struct expansion_card *ec = ECARD_DEV(dev);
 	return sprintf(buf, "%u\n", ec->cid.manufacturer);
 }
 
-static ssize_t ecard_show_device(struct device *dev, char *buf)
+static ssize_t ecard_show_device(struct device *dev, char *buf, void *private)
 {
 	struct expansion_card *ec = ECARD_DEV(dev);
 	return sprintf(buf, "%u\n", ec->cid.product);
 }
 
-static ssize_t ecard_show_type(struct device *dev, char *buf)
+static ssize_t ecard_show_type(struct device *dev, char *buf, void *private)
 {
 	struct expansion_card *ec = ECARD_DEV(dev);
 	return sprintf(buf, "%s\n", ec->type == ECARD_EASI ? "EASI" : "IOC");
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/arch/arm26/kernel/ecard.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/arch/arm26/kernel/ecard.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/arch/arm26/kernel/ecard.c	2005-05-11 00:28:06.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/arch/arm26/kernel/ecard.c	2005-05-11 00:31:51.000000000 -0400
@@ -562,31 +562,31 @@ static void __init ecard_init_resources(
 	}
 }
 
-static ssize_t ecard_show_irq(struct device *dev, char *buf)
+static ssize_t ecard_show_irq(struct device *dev, char *buf, void *private)
 {
 	struct expansion_card *ec = ECARD_DEV(dev);
 	return sprintf(buf, "%u\n", ec->irq);
 }
 
-static ssize_t ecard_show_vendor(struct device *dev, char *buf)
+static ssize_t ecard_show_vendor(struct device *dev, char *buf, void *private)
 {
 	struct expansion_card *ec = ECARD_DEV(dev);
 	return sprintf(buf, "%u\n", ec->cid.manufacturer);
 }
 
-static ssize_t ecard_show_device(struct device *dev, char *buf)
+static ssize_t ecard_show_device(struct device *dev, char *buf, void *private)
 {
 	struct expansion_card *ec = ECARD_DEV(dev);
 	return sprintf(buf, "%u\n", ec->cid.product);
 }
 
-static ssize_t ecard_show_dma(struct device *dev, char *buf)
+static ssize_t ecard_show_dma(struct device *dev, char *buf, void *private)
 {
 	struct expansion_card *ec = ECARD_DEV(dev);
 	return sprintf(buf, "%u\n", ec->dma);
 }
 
-static ssize_t ecard_show_resources(struct device *dev, char *buf)
+static ssize_t ecard_show_resources(struct device *dev, char *buf, void *private)
 {
 	struct expansion_card *ec = ECARD_DEV(dev);
 	char *str = buf;
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/arch/ia64/sn/kernel/tiocx.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/arch/ia64/sn/kernel/tiocx.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/arch/ia64/sn/kernel/tiocx.c	2005-05-11 00:28:05.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/arch/ia64/sn/kernel/tiocx.c	2005-05-11 00:31:34.000000000 -0400
@@ -432,7 +432,7 @@ static int tiocx_reload(struct cx_dev *c
 	return cx_device_reload(cx_dev);
 }
 
-static ssize_t show_cxdev_control(struct device *dev, char *buf)
+static ssize_t show_cxdev_control(struct device *dev, char *buf, void *private)
 {
 	struct cx_dev *cx_dev = to_cx_dev(dev);
 
@@ -443,7 +443,7 @@ static ssize_t show_cxdev_control(struct
 }
 
 static ssize_t store_cxdev_control(struct device *dev, const char *buf,
-				   size_t count)
+				   size_t count, void *private)
 {
 	int n;
 	struct cx_dev *cx_dev = to_cx_dev(dev);
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/arch/parisc/kernel/drivers.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/arch/parisc/kernel/drivers.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/arch/parisc/kernel/drivers.c	2005-05-11 00:28:07.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/arch/parisc/kernel/drivers.c	2005-05-11 00:31:59.000000000 -0400
@@ -466,7 +466,7 @@ static int parisc_generic_match(struct d
 }
 
 #define pa_dev_attr(name, field, format_string)				\
-static ssize_t name##_show(struct device *dev, char *buf)		\
+static ssize_t name##_show(struct device *dev, char *buf, void *private)		\
 {									\
 	struct parisc_device *padev = to_parisc_device(dev);		\
 	return sprintf(buf, format_string, padev->field);		\
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/arch/ppc/kernel/pci.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/arch/ppc/kernel/pci.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/arch/ppc/kernel/pci.c	2005-05-11 00:28:05.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/arch/ppc/kernel/pci.c	2005-05-11 00:31:22.000000000 -0400
@@ -1003,7 +1003,7 @@ pci_create_OF_bus_map(void)
 	}
 }
 
-static ssize_t pci_show_devspec(struct device *dev, char *buf)
+static ssize_t pci_show_devspec(struct device *dev, char *buf, void *private)
 {
 	struct pci_dev *pdev;
 	struct device_node *np;
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/arch/ppc/syslib/ocp.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/arch/ppc/syslib/ocp.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/arch/ppc/syslib/ocp.c	2005-05-11 00:28:05.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/arch/ppc/syslib/ocp.c	2005-05-11 00:31:22.000000000 -0400
@@ -68,7 +68,7 @@ static int ocp_inited;
 /* Sysfs support */
 #define OCP_DEF_ATTR(field, format_string)				\
 static ssize_t								\
-show_##field(struct device *dev, char *buf)				\
+show_##field(struct device *dev, char *buf, void *private)				\
 {									\
 	struct ocp_device *odev = to_ocp_dev(dev);			\
 									\
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/arch/ppc/syslib/of_device.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/arch/ppc/syslib/of_device.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/arch/ppc/syslib/of_device.c	2005-05-11 00:28:05.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/arch/ppc/syslib/of_device.c	2005-05-11 00:31:22.000000000 -0400
@@ -161,7 +161,7 @@ void of_unregister_driver(struct of_plat
 }
 
 
-static ssize_t dev_show_devspec(struct device *dev, char *buf)
+static ssize_t dev_show_devspec(struct device *dev, char *buf, void *private)
 {
 	struct of_device *ofdev;
 
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/arch/ppc64/kernel/of_device.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/arch/ppc64/kernel/of_device.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/arch/ppc64/kernel/of_device.c	2005-05-11 00:28:06.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/arch/ppc64/kernel/of_device.c	2005-05-11 00:31:53.000000000 -0400
@@ -161,7 +161,7 @@ void of_unregister_driver(struct of_plat
 }
 
 
-static ssize_t dev_show_devspec(struct device *dev, char *buf)
+static ssize_t dev_show_devspec(struct device *dev, char *buf, void *private)
 {
 	struct of_device *ofdev;
 
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/arch/ppc64/kernel/pci.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/arch/ppc64/kernel/pci.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/arch/ppc64/kernel/pci.c	2005-05-11 00:28:06.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/arch/ppc64/kernel/pci.c	2005-05-11 00:31:53.000000000 -0400
@@ -507,7 +507,7 @@ int pci_mmap_page_range(struct pci_dev *
 }
 
 #ifdef CONFIG_PPC_MULTIPLATFORM
-static ssize_t pci_show_devspec(struct device *dev, char *buf)
+static ssize_t pci_show_devspec(struct device *dev, char *buf, void *private)
 {
 	struct pci_dev *pdev;
 	struct device_node *np;
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/arch/ppc64/kernel/vio.c linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/arch/ppc64/kernel/vio.c
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/arch/ppc64/kernel/vio.c	2005-05-11 00:28:06.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/arch/ppc64/kernel/vio.c	2005-05-11 00:31:53.000000000 -0400
@@ -300,7 +300,7 @@ static void __devinit vio_dev_release(st
 }
 
 #ifdef CONFIG_PPC_PSERIES
-static ssize_t viodev_show_devspec(struct device *dev, char *buf)
+static ssize_t viodev_show_devspec(struct device *dev, char *buf, void *private)
 {
 	struct device_node *of_node = dev->platform_data;
 
@@ -309,7 +309,7 @@ static ssize_t viodev_show_devspec(struc
 DEVICE_ATTR(devspec, S_IRUSR | S_IRGRP | S_IROTH, viodev_show_devspec, NULL);
 #endif
 
-static ssize_t viodev_show_name(struct device *dev, char *buf)
+static ssize_t viodev_show_name(struct device *dev, char *buf, void *private)
 {
 	return sprintf(buf, "%s\n", to_vio_dev(dev)->name);
 }

------=_Part_1407_5944789.1116062767898--
