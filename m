Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263741AbUDPUxp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 16:53:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263740AbUDPUxo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 16:53:44 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:64925 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S263746AbUDPUuu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 16:50:50 -0400
Date: Fri, 16 Apr 2004 21:49:48 +0100
From: Dave Jones <davej@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>, mdomsch@dell.com
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Fix edd driver dereferencing before pointer checks.
Message-ID: <20040416204948.GH20937@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linus Torvalds <torvalds@osdl.org>, mdomsch@dell.com,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lots of occurences of the same bug..

		Dave


--- linux-2.6.5/drivers/firmware/edd.c~	2004-04-16 21:38:09.000000000 +0100
+++ linux-2.6.5/drivers/firmware/edd.c	2004-04-16 21:47:57.000000000 +0100
@@ -125,13 +125,15 @@
 static ssize_t
 edd_show_host_bus(struct edd_device *edev, char *buf)
 {
-	struct edd_info *info = edd_dev_get_info(edev);
+	struct edd_info *info;
 	char *p = buf;
 	int i;
 
-	if (!edev || !info || !buf) {
+	if (!edev)
+		return -EINVAL;
+	info = edd_dev_get_info(edev);
+	if (!info || !buf)
 		return -EINVAL;
-	}
 
 	for (i = 0; i < 4; i++) {
 		if (isprint(info->params.host_bus_type[i])) {
@@ -169,13 +171,15 @@
 static ssize_t
 edd_show_interface(struct edd_device *edev, char *buf)
 {
-	struct edd_info *info = edd_dev_get_info(edev);
+	struct edd_info *info;
 	char *p = buf;
 	int i;
 
-	if (!edev || !info || !buf) {
+	if (!edev)
+		return -EINVAL;
+	info = edd_dev_get_info(edev);
+	if (!info || !buf)
 		return -EINVAL;
-	}
 
 	for (i = 0; i < 8; i++) {
 		if (isprint(info->params.interface_type[i])) {
@@ -231,11 +235,13 @@
 static ssize_t
 edd_show_raw_data(struct edd_device *edev, char *buf)
 {
-	struct edd_info *info = edd_dev_get_info(edev);
+	struct edd_info *info;
 	ssize_t len = sizeof (info->params);
-	if (!edev || !info || !buf) {
+	if (!edev)
+		return -EINVAL;
+	info = edd_dev_get_info(edev);
+	if (!info || !buf)
 		return -EINVAL;
-	}
 
 	if (!(info->params.key == 0xBEDD || info->params.key == 0xDDBE))
 		len = info->params.length;
@@ -251,11 +257,13 @@
 static ssize_t
 edd_show_version(struct edd_device *edev, char *buf)
 {
-	struct edd_info *info = edd_dev_get_info(edev);
+	struct edd_info *info;
 	char *p = buf;
-	if (!edev || !info || !buf) {
+	if (!edev)
+		return -EINVAL;
+	info = edd_dev_get_info(edev);
+	if (!info || !buf)
 		return -EINVAL;
-	}
 
 	p += scnprintf(p, left, "0x%02x\n", info->version);
 	return (p - buf);
@@ -272,11 +280,13 @@
 static ssize_t
 edd_show_extensions(struct edd_device *edev, char *buf)
 {
-	struct edd_info *info = edd_dev_get_info(edev);
+	struct edd_info *info;
 	char *p = buf;
-	if (!edev || !info || !buf) {
+	if (!edev)
+		return -EINVAL;
+	info = edd_dev_get_info(edev);
+	if (!info || !buf)
 		return -EINVAL;
-	}
 
 	if (info->interface_support & EDD_EXT_FIXED_DISK_ACCESS) {
 		p += scnprintf(p, left, "Fixed disk access\n");
@@ -296,11 +306,13 @@
 static ssize_t
 edd_show_info_flags(struct edd_device *edev, char *buf)
 {
-	struct edd_info *info = edd_dev_get_info(edev);
+	struct edd_info *info;
 	char *p = buf;
-	if (!edev || !info || !buf) {
+	if (!edev)
+		return -EINVAL;
+	info = edd_dev_get_info(edev);
+	if (!info || !buf)
 		return -EINVAL;
-	}
 
 	if (info->params.info_flags & EDD_INFO_DMA_BOUNDARY_ERROR_TRANSPARENT)
 		p += scnprintf(p, left, "DMA boundary error transparent\n");
@@ -324,11 +336,13 @@
 static ssize_t
 edd_show_legacy_cylinders(struct edd_device *edev, char *buf)
 {
-	struct edd_info *info = edd_dev_get_info(edev);
+	struct edd_info *info;
 	char *p = buf;
-	if (!edev || !info || !buf) {
+	if (!edev)
+		return -EINVAL;
+	info = edd_dev_get_info(edev);
+	if (!info || !buf)
 		return -EINVAL;
-	}
 
 	p += snprintf(p, left, "0x%x\n", info->legacy_cylinders);
 	return (p - buf);
@@ -337,11 +351,13 @@
 static ssize_t
 edd_show_legacy_heads(struct edd_device *edev, char *buf)
 {
-	struct edd_info *info = edd_dev_get_info(edev);
+	struct edd_info *info;
 	char *p = buf;
-	if (!edev || !info || !buf) {
+	if (!edev)
+		return -EINVAL;
+	info = edd_dev_get_info(edev);
+	if (!info || !buf)
 		return -EINVAL;
-	}
 
 	p += snprintf(p, left, "0x%x\n", info->legacy_heads);
 	return (p - buf);
@@ -350,11 +366,13 @@
 static ssize_t
 edd_show_legacy_sectors(struct edd_device *edev, char *buf)
 {
-	struct edd_info *info = edd_dev_get_info(edev);
+	struct edd_info *info;
 	char *p = buf;
-	if (!edev || !info || !buf) {
+	if (!edev)
+		return -EINVAL;
+	info = edd_dev_get_info(edev);
+	if (!info || !buf)
 		return -EINVAL;
-	}
 
 	p += snprintf(p, left, "0x%x\n", info->legacy_sectors);
 	return (p - buf);
@@ -363,11 +381,13 @@
 static ssize_t
 edd_show_default_cylinders(struct edd_device *edev, char *buf)
 {
-	struct edd_info *info = edd_dev_get_info(edev);
+	struct edd_info *info;
 	char *p = buf;
-	if (!edev || !info || !buf) {
+	if (!edev)
+		return -EINVAL;
+	info = edd_dev_get_info(edev);
+	if (!info || !buf)
 		return -EINVAL;
-	}
 
 	p += scnprintf(p, left, "0x%x\n", info->params.num_default_cylinders);
 	return (p - buf);
@@ -376,11 +396,13 @@
 static ssize_t
 edd_show_default_heads(struct edd_device *edev, char *buf)
 {
-	struct edd_info *info = edd_dev_get_info(edev);
+	struct edd_info *info;
 	char *p = buf;
-	if (!edev || !info || !buf) {
+	if (!edev)
+		return -EINVAL;
+	info = edd_dev_get_info(edev);
+	if (!info || !buf)
 		return -EINVAL;
-	}
 
 	p += scnprintf(p, left, "0x%x\n", info->params.num_default_heads);
 	return (p - buf);
@@ -389,11 +411,13 @@
 static ssize_t
 edd_show_default_sectors_per_track(struct edd_device *edev, char *buf)
 {
-	struct edd_info *info = edd_dev_get_info(edev);
+	struct edd_info *info;
 	char *p = buf;
-	if (!edev || !info || !buf) {
+	if (!edev)
+		return -EINVAL;
+	info = edd_dev_get_info(edev);
+	if (!info || !buf)
 		return -EINVAL;
-	}
 
 	p += scnprintf(p, left, "0x%x\n", info->params.sectors_per_track);
 	return (p - buf);
@@ -402,11 +426,13 @@
 static ssize_t
 edd_show_sectors(struct edd_device *edev, char *buf)
 {
-	struct edd_info *info = edd_dev_get_info(edev);
+	struct edd_info *info;
 	char *p = buf;
-	if (!edev || !info || !buf) {
+	if (!edev)
+		return -EINVAL;
+	info = edd_dev_get_info(edev);
+	if (!info || !buf)
 		return -EINVAL;
-	}
 
 	p += scnprintf(p, left, "0x%llx\n", info->params.number_of_sectors);
 	return (p - buf);
@@ -426,8 +452,11 @@
 static int
 edd_has_legacy_cylinders(struct edd_device *edev)
 {
-	struct edd_info *info = edd_dev_get_info(edev);
-	if (!edev || !info)
+	struct edd_info *info;
+	if (!edev)
+		return -EINVAL;
+	info = edd_dev_get_info(edev);
+	if (!info)
 		return -EINVAL;
 	return info->legacy_cylinders > 0;
 }
@@ -435,8 +464,11 @@
 static int
 edd_has_legacy_heads(struct edd_device *edev)
 {
-	struct edd_info *info = edd_dev_get_info(edev);
-	if (!edev || !info)
+	struct edd_info *info;
+	if (!edev)
+		return -EINVAL;
+	info = edd_dev_get_info(edev);
+	if (!info)
 		return -EINVAL;
 	return info->legacy_heads > 0;
 }
@@ -444,8 +476,11 @@
 static int
 edd_has_legacy_sectors(struct edd_device *edev)
 {
-	struct edd_info *info = edd_dev_get_info(edev);
-	if (!edev || !info)
+	struct edd_info *info;
+	if (!edev)
+		return -EINVAL;
+	info = edd_dev_get_info(edev);
+	if (!info)
 		return -EINVAL;
 	return info->legacy_sectors > 0;
 }
@@ -453,8 +488,11 @@
 static int
 edd_has_default_cylinders(struct edd_device *edev)
 {
-	struct edd_info *info = edd_dev_get_info(edev);
-	if (!edev || !info)
+	struct edd_info *info;
+	if (!edev)
+		return -EINVAL;
+	info = edd_dev_get_info(edev);
+	if (!info)
 		return -EINVAL;
 	return info->params.num_default_cylinders > 0;
 }
@@ -462,8 +500,11 @@
 static int
 edd_has_default_heads(struct edd_device *edev)
 {
-	struct edd_info *info = edd_dev_get_info(edev);
-	if (!edev || !info)
+	struct edd_info *info;
+	if (!edev)
+		return -EINVAL;
+	info = edd_dev_get_info(edev);
+	if (!info)
 		return -EINVAL;
 	return info->params.num_default_heads > 0;
 }
@@ -471,8 +512,11 @@
 static int
 edd_has_default_sectors_per_track(struct edd_device *edev)
 {
-	struct edd_info *info = edd_dev_get_info(edev);
-	if (!edev || !info)
+	struct edd_info *info;
+	if (!edev)
+		return -EINVAL;
+	info = edd_dev_get_info(edev);
+	if (!info)
 		return -EINVAL;
 	return info->params.sectors_per_track > 0;
 }
@@ -480,11 +524,14 @@
 static int
 edd_has_edd30(struct edd_device *edev)
 {
-	struct edd_info *info = edd_dev_get_info(edev);
+	struct edd_info *info;
 	int i, nonzero_path = 0;
 	char c;
 
-	if (!edev || !info)
+	if (!edev)
+		return 0;
+	info = edd_dev_get_info(edev);
+	if (!info)
 		return 0;
 
 	if (!(info->params.key == 0xBEDD || info->params.key == 0xDDBE)) {
@@ -508,8 +555,11 @@
 static int
 edd_has_disk80_sig(struct edd_device *edev)
 {
-	struct edd_info *info = edd_dev_get_info(edev);
-	if (!edev || !info)
+	struct edd_info *info;
+	if (!edev)
+		return 0;
+	info = edd_dev_get_info(edev);
+	if (!info)
 		return 0;
 	return info->device == 0x80;
 }
@@ -597,9 +647,12 @@
 static int
 edd_dev_is_type(struct edd_device *edev, const char *type)
 {
-	struct edd_info *info = edd_dev_get_info(edev);
+	struct edd_info *info;
+	if (!edev)
+		return 0;
+	info = edd_dev_get_info(edev);
 
-	if (edev && type && info) {
+	if (type && info) {
 		if (!strncmp(info->params.host_bus_type, type, strlen(type)) ||
 		    !strncmp(info->params.interface_type, type, strlen(type)))
 			return 1;
