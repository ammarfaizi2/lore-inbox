Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932527AbVJTWBP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932527AbVJTWBP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 18:01:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932539AbVJTWBP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 18:01:15 -0400
Received: from smtp-out.google.com ([216.239.45.12]:2715 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S932527AbVJTWBO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 18:01:14 -0400
Message-ID: <4a45da430510201500u46c57f88p8d48368d2c5c4ed7@mail.google.com>
Date: Thu, 20 Oct 2005 15:00:49 -0700
From: Jonathan Mayer <jonmayer@google.com>
To: Patrick Mochel <mochel@digitalimplant.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] added sysdev attribute to sysdev show/store methods - for linux-2.6.13.4
In-Reply-To: <4a45da430510201447r2970ea67rfac8dffe7223a68@mail.google.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_1742_16591195.1129845649419"
References: <4a45da430510201447r2970ea67rfac8dffe7223a68@mail.google.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_1742_16591195.1129845649419
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

That was discouraging.  My patch got word-wrapped by my editor.=20
Instead, see attachment.

Sorry,
 - Jonathan.

------=_Part_1742_16591195.1129845649419
Content-Type: text/plain; name=sysdev_showstore.patch.txt; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="sysdev_showstore.patch.txt"

diff -ur linux-2.6.13.4.orig/arch/arm/kernel/time.c linux-2.6.13.4.new/arch/arm/kernel/time.c
--- linux-2.6.13.4.orig/arch/arm/kernel/time.c	2005-10-19 10:26:09.000000000 -0700
+++ linux-2.6.13.4.new/arch/arm/kernel/time.c	2005-10-19 10:32:25.000000000 -0700
@@ -143,7 +143,7 @@
 	{ "red",   led_red_on,   led_red_off   },
 };
 
-static ssize_t leds_store(struct sys_device *dev, const char *buf, size_t size)
+static ssize_t leds_store(struct sys_device *dev, struct sysdev_attribute *attr, const char *buf, size_t size)
 {
 	int ret = -EINVAL, len = strcspn(buf, " ");
 
diff -ur linux-2.6.13.4.orig/arch/ppc64/kernel/sysfs.c linux-2.6.13.4.new/arch/ppc64/kernel/sysfs.c
--- linux-2.6.13.4.orig/arch/ppc64/kernel/sysfs.c	2005-10-19 10:26:10.000000000 -0700
+++ linux-2.6.13.4.new/arch/ppc64/kernel/sysfs.c	2005-10-19 10:32:25.000000000 -0700
@@ -28,8 +28,8 @@
 /* default to snooze disabled */
 DEFINE_PER_CPU(unsigned long, smt_snooze_delay);
 
-static ssize_t store_smt_snooze_delay(struct sys_device *dev, const char *buf,
-				      size_t count)
+static ssize_t store_smt_snooze_delay(struct sys_device *dev, struct sysdev_attribute *attr,
+                                      const char *buf, size_t count)
 {
 	struct cpu *cpu = container_of(dev, struct cpu, sysdev);
 	ssize_t ret;
@@ -44,7 +44,8 @@
 	return count;
 }
 
-static ssize_t show_smt_snooze_delay(struct sys_device *dev, char *buf)
+static ssize_t show_smt_snooze_delay(struct sys_device *dev, struct sysdev_attribute *attr,
+                                     char *buf)
 {
 	struct cpu *cpu = container_of(dev, struct cpu, sysdev);
 
@@ -200,14 +201,14 @@
 	mtspr(ADDRESS, val); \
 	return 0; \
 } \
-static ssize_t show_##NAME(struct sys_device *dev, char *buf) \
+static ssize_t show_##NAME(struct sys_device *dev, struct sysdev_attribute *attr, char *buf) \
 { \
 	struct cpu *cpu = container_of(dev, struct cpu, sysdev); \
 	unsigned long val = run_on_cpu(cpu->sysdev.id, read_##NAME, 0); \
 	return sprintf(buf, "%lx\n", val); \
 } \
 static ssize_t __attribute_used__ \
-	store_##NAME(struct sys_device *dev, const char *buf, size_t count) \
+	store_##NAME(struct sys_device *dev, struct sysdev_attribute *attr, const char *buf, size_t count) \
 { \
 	struct cpu *cpu = container_of(dev, struct cpu, sysdev); \
 	unsigned long val; \
@@ -367,7 +368,7 @@
 #endif
 
 /* Only valid if CPU is present. */
-static ssize_t show_physical_id(struct sys_device *dev, char *buf)
+static ssize_t show_physical_id(struct sys_device *dev, struct sysdev_attribute *attr, char *buf)
 {
 	struct cpu *cpu = container_of(dev, struct cpu, sysdev);
 
diff -ur linux-2.6.13.4.orig/arch/sh/drivers/dma/dma-sysfs.c linux-2.6.13.4.new/arch/sh/drivers/dma/dma-sysfs.c
--- linux-2.6.13.4.orig/arch/sh/drivers/dma/dma-sysfs.c	2005-10-19 10:26:11.000000000 -0700
+++ linux-2.6.13.4.new/arch/sh/drivers/dma/dma-sysfs.c	2005-10-19 10:32:25.000000000 -0700
@@ -21,7 +21,7 @@
 
 EXPORT_SYMBOL(dma_sysclass);
 
-static ssize_t dma_show_devices(struct sys_device *dev, char *buf)
+static ssize_t dma_show_devices(struct sys_device *dev, struct sysdev_attribute *attr, char *buf)
 {
 	ssize_t len = 0;
 	int i;
@@ -53,13 +53,13 @@
 
 postcore_initcall(dma_sysclass_init);
 
-static ssize_t dma_show_dev_id(struct sys_device *dev, char *buf)
+static ssize_t dma_show_dev_id(struct sys_device *dev, struct sysdev_attribute *attr, char *buf)
 {
 	struct dma_channel *channel = to_dma_channel(dev);
 	return sprintf(buf, "%s\n", channel->dev_id);
 }
 
-static ssize_t dma_store_dev_id(struct sys_device *dev,
+static ssize_t dma_store_dev_id(struct sys_device *dev, struct sysdev_attribute *attr,
 				const char *buf, size_t count)
 {
 	struct dma_channel *channel = to_dma_channel(dev);
@@ -69,7 +69,7 @@
 
 static SYSDEV_ATTR(dev_id, S_IRUGO | S_IWUSR, dma_show_dev_id, dma_store_dev_id);
 
-static ssize_t dma_store_config(struct sys_device *dev,
+static ssize_t dma_store_config(struct sys_device *dev, struct sysdev_attribute *attr,
 				const char *buf, size_t count)
 {
 	struct dma_channel *channel = to_dma_channel(dev);
@@ -83,13 +83,13 @@
 
 static SYSDEV_ATTR(config, S_IWUSR, NULL, dma_store_config);
 
-static ssize_t dma_show_mode(struct sys_device *dev, char *buf)
+static ssize_t dma_show_mode(struct sys_device *dev, struct sysdev_attribute *attr, char *buf)
 {
 	struct dma_channel *channel = to_dma_channel(dev);
 	return sprintf(buf, "0x%08x\n", channel->mode);
 }
 
-static ssize_t dma_store_mode(struct sys_device *dev,
+static ssize_t dma_store_mode(struct sys_device *dev, struct sysdev_attribute *attr,
 			      const char *buf, size_t count)
 {
 	struct dma_channel *channel = to_dma_channel(dev);
@@ -100,7 +100,9 @@
 static SYSDEV_ATTR(mode, S_IRUGO | S_IWUSR, dma_show_mode, dma_store_mode);
 
 #define dma_ro_attr(field, fmt)						\
-static ssize_t dma_show_##field(struct sys_device *dev, char *buf)	\
+static ssize_t dma_show_##field(struct sys_device *dev,                 \
+                                struct sysdev_attribute *attr,          \
+                                char *buf)	                        \
 {									\
 	struct dma_channel *channel = to_dma_channel(dev);		\
 	return sprintf(buf, fmt, channel->field);			\
diff -ur linux-2.6.13.4.orig/arch/x86_64/kernel/mce.c linux-2.6.13.4.new/arch/x86_64/kernel/mce.c
--- linux-2.6.13.4.orig/arch/x86_64/kernel/mce.c	2005-10-19 10:26:19.000000000 -0700
+++ linux-2.6.13.4.new/arch/x86_64/kernel/mce.c	2005-10-19 10:32:25.000000000 -0700
@@ -528,10 +528,14 @@
 
 /* Why are there no generic functions for this? */
 #define ACCESSOR(name, var, start) \
-	static ssize_t show_ ## name(struct sys_device *s, char *buf) { 	   	   \
+	static ssize_t show_ ## name(struct sys_device *s,                         \
+                                     struct sysdev_attribute *attr,                \
+                                     char *buf) { 	   	                   \
 		return sprintf(buf, "%lx\n", (unsigned long)var);		   \
 	} 									   \
-	static ssize_t set_ ## name(struct sys_device *s,const char *buf,size_t siz) { \
+	static ssize_t set_ ## name(struct sys_device *s,                          \
+                                    struct sysdev_attribute *attr,                 \
+                                    const char *buf,size_t siz) {                  \
 		char *end; 							   \
 		unsigned long new = simple_strtoul(buf, &end, 0); 		   \
 		if (end == buf) return -EINVAL;					   \
diff -ur linux-2.6.13.4.orig/drivers/base/cpu.c linux-2.6.13.4.new/drivers/base/cpu.c
--- linux-2.6.13.4.orig/drivers/base/cpu.c	2005-10-19 10:26:20.000000000 -0700
+++ linux-2.6.13.4.new/drivers/base/cpu.c	2005-10-19 10:34:23.000000000 -0700
@@ -21,15 +21,15 @@
 	return 0;
 }
 
-static ssize_t show_online(struct sys_device *dev, char *buf)
+static ssize_t show_online(struct sys_device *dev, struct sysdev_attribute *attr, char *buf)
 {
 	struct cpu *cpu = container_of(dev, struct cpu, sysdev);
 
 	return sprintf(buf, "%u\n", !!cpu_online(cpu->sysdev.id));
 }
 
-static ssize_t store_online(struct sys_device *dev, const char *buf,
-			    size_t count)
+static ssize_t store_online(struct sys_device *dev, struct sysdev_attribute *attr, 
+                            const char *buf, size_t count)
 {
 	struct cpu *cpu = container_of(dev, struct cpu, sysdev);
 	ssize_t ret;
diff -ur linux-2.6.13.4.orig/drivers/base/node.c linux-2.6.13.4.new/drivers/base/node.c
--- linux-2.6.13.4.orig/drivers/base/node.c	2005-10-19 10:26:20.000000000 -0700
+++ linux-2.6.13.4.new/drivers/base/node.c	2005-10-19 10:32:25.000000000 -0700
@@ -17,7 +17,7 @@
 };
 
 
-static ssize_t node_read_cpumap(struct sys_device * dev, char * buf)
+static ssize_t node_read_cpumap(struct sys_device * dev, struct sysdev_attribute *attr, char * buf)
 {
 	struct node *node_dev = to_node(dev);
 	cpumask_t mask = node_to_cpumask(node_dev->sysdev.id);
@@ -34,7 +34,8 @@
 static SYSDEV_ATTR(cpumap, S_IRUGO, node_read_cpumap, NULL);
 
 #define K(x) ((x) << (PAGE_SHIFT - 10))
-static ssize_t node_read_meminfo(struct sys_device * dev, char * buf)
+static ssize_t node_read_meminfo(struct sys_device * dev, struct sysdev_attribute *attr,
+                                 char * buf)
 {
 	int n;
 	int nid = dev->id;
@@ -72,7 +73,8 @@
 #undef K
 static SYSDEV_ATTR(meminfo, S_IRUGO, node_read_meminfo, NULL);
 
-static ssize_t node_read_numastat(struct sys_device * dev, char * buf)
+static ssize_t node_read_numastat(struct sys_device * dev, struct sysdev_attribute *attr,
+                                  char * buf)
 {
 	unsigned long numa_hit, numa_miss, interleave_hit, numa_foreign;
 	unsigned long local_node, other_node;
@@ -112,7 +114,8 @@
 }
 static SYSDEV_ATTR(numastat, S_IRUGO, node_read_numastat, NULL);
 
-static ssize_t node_read_distance(struct sys_device * dev, char * buf)
+static ssize_t node_read_distance(struct sys_device * dev, struct sysdev_attribute *attr,
+                                  char * buf)
 {
 	int nid = dev->id;
 	int len = 0;
diff -ur linux-2.6.13.4.orig/drivers/base/sys.c linux-2.6.13.4.new/drivers/base/sys.c
--- linux-2.6.13.4.orig/drivers/base/sys.c	2005-10-19 10:26:20.000000000 -0700
+++ linux-2.6.13.4.new/drivers/base/sys.c	2005-10-19 10:35:33.000000000 -0700
@@ -35,7 +35,7 @@
 	struct sysdev_attribute * sysdev_attr = to_sysdev_attr(attr);
 
 	if (sysdev_attr->show)
-		return sysdev_attr->show(sysdev, buffer);
+		return sysdev_attr->show(sysdev, sysdev_attr, buffer);
 	return -EIO;
 }
 
@@ -48,7 +48,7 @@
 	struct sysdev_attribute * sysdev_attr = to_sysdev_attr(attr);
 
 	if (sysdev_attr->store)
-		return sysdev_attr->store(sysdev, buffer, count);
+		return sysdev_attr->store(sysdev, sysdev_attr, buffer, count);
 	return -EIO;
 }
 
diff -ur linux-2.6.13.4.orig/include/linux/sysdev.h linux-2.6.13.4.new/include/linux/sysdev.h
--- linux-2.6.13.4.orig/include/linux/sysdev.h	2005-10-19 10:27:19.000000000 -0700
+++ linux-2.6.13.4.new/include/linux/sysdev.h	2005-10-19 10:32:25.000000000 -0700
@@ -74,21 +74,26 @@
 extern int sysdev_register(struct sys_device *);
 extern void sysdev_unregister(struct sys_device *);
 
-
-struct sysdev_attribute { 
+struct sysdev_attribute {
 	struct attribute	attr;
-	ssize_t (*show)(struct sys_device *, char *);
-	ssize_t (*store)(struct sys_device *, const char *, size_t);
+	ssize_t (*show)(struct sys_device *, struct sysdev_attribute *, char *);
+	ssize_t (*store)(struct sys_device *, struct sysdev_attribute *, const char *, size_t);
+        void * data;
 };
 
 
-#define SYSDEV_ATTR(_name,_mode,_show,_store) 		\
+
+#define SYSDEV_ATTR_WITH_DATA(_name,_mode,_show,_store,_data) 		\
 struct sysdev_attribute attr_##_name = { 			\
 	.attr = {.name = __stringify(_name), .mode = _mode },	\
 	.show	= _show,					\
 	.store	= _store,					\
+        .data   = _data,                                        \
 };
 
+#define SYSDEV_ATTR(_name,_mode,_show,_store) 		\
+  SYSDEV_ATTR_WITH_DATA(_name,_mode,_show,_store,NULL)
+
 extern int sysdev_create_file(struct sys_device *, struct sysdev_attribute *);
 extern void sysdev_remove_file(struct sys_device *, struct sysdev_attribute *);
 

------=_Part_1742_16591195.1129845649419--
