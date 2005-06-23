Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262663AbVFWWGf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262663AbVFWWGf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 18:06:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262812AbVFWWF2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 18:05:28 -0400
Received: from lugor.de ([217.160.170.124]:8 "EHLO solar.mylinuxtime.de")
	by vger.kernel.org with ESMTP id S262732AbVFWWCR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 18:02:17 -0400
From: Christian Hesse <mail@earthworm.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Kernel .patches support
Date: Thu, 23 Jun 2005 23:58:27 +0200
User-Agent: KMail/1.8.1
X-Face: 1\p'dhO'VZk,x0lx6U}!Y*9UjU4n2@4c<"a*K%3Eiu'VwM|-OYs;S-PH>4EdJMfGyycC)=?utf-8?q?k=0A=09=3Anv*xqk4C?=@1b8tdr||mALWpN[2|~h#Iv;)M"O$$#P9Kg+S8+O#%EJx0TBH7b&Q<m)=?utf-8?q?n=23Q=2Eo=0A=09kE=7E=26T=5D0cQX6=5D?=<q!HEE,F}O'Jd#lx/+){Gr@W~J`h7sTS(M+oe5<=?utf-8?q?3O7GY9y=5Fi!qG=26Vv=5CD8/=0A=09=254?=@&~$Z@UwV'NQ$Ph&3fZc(qbDO?{LN'nk>+kRh4`C3[KN`-1uT-TD_m
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1447698.4RtlPmQ6xB";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200506232358.34897.mail@earthworm.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1447698.4RtlPmQ6xB
Content-Type: multipart/mixed;
  boundary="Boundary-01=_ECzuCfDfXi/wQo2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_ECzuCfDfXi/wQo2
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi everybody,

every time I apply a patch to my kernel tree I (or my scripts) make an

echo $PATCHNAME $PATCHVERSION >> .patches

This patch makes the file accessible via /proc/patches.gz. I think this can=
 be=20
handy if you want to know what patches you (or your distributor) applied to=
=20
your running kernel...

Most of the code is copy & past from CONFIG_IKCONFIG[_PROC].

Let me know what you think.

Regards,
=2D-=20
Christian

--Boundary-01=_ECzuCfDfXi/wQo2
Content-Type: text/x-diff;
  charset="us-ascii";
  name="patches.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="patches.patch"

diff -Nur linux-2.6.12+/include/linux/patches.h linux-2.6.12+-patches/inclu=
de/linux/patches.h
=2D-- linux-2.6.12+/include/linux/patches.h	1970-01-01 01:00:00.000000000 +=
0100
+++ linux-2.6.12+-patches/include/linux/patches.h	2005-06-23 23:10:15.27868=
5000 +0200
@@ -0,0 +1,6 @@
+#ifndef _LINUX_PATCHES_H
+#define _LINUX_PATCHES_H
+
+#include <linux/autoconf.h>
+
+#endif
diff -Nur linux-2.6.12+/init/Kconfig linux-2.6.12+-patches/init/Kconfig
=2D-- linux-2.6.12+/init/Kconfig	2005-06-23 23:16:40.748685000 +0200
+++ linux-2.6.12+-patches/init/Kconfig	2005-06-23 23:10:16.928685000 +0200
@@ -226,6 +226,25 @@
 	  This option enables access to the kernel configuration file
 	  through /proc/config.gz.
=20
+config IKPATCHES
+	bool "Kernel .patches support"
+	---help---
+	  This option enables the complete Linux kernel ".patches" file
+	  contents to be saved in the kernel. It provides documentation
+	  of which kernel patches are applied in a running kernel. This
+	  information can be extracted from the kernel image file with
+	  the script scripts/extract-ikpatches and used as input to
+	  rebuild the current kernel or to build another kernel.
+	  It can also be extracted from a running kernel by reading
+	  /proc/patches.gz if enabled (below).
+
+config IKPATCHES_PROC
+	bool "Enable access to .patches through /proc/patches.gz"
+	depends on IKPATCHES && PROC_FS
+	---help---
+	  This option enables access to the kernel patches file
+	  through /proc/patches.gz.
+
 config CPUSETS
 	bool "Cpuset support"
 	depends on SMP
diff -Nur linux-2.6.12+/kernel/Makefile linux-2.6.12+-patches/kernel/Makefi=
le
=2D-- linux-2.6.12+/kernel/Makefile	2005-06-23 23:17:13.248685000 +0200
+++ linux-2.6.12+-patches/kernel/Makefile	2005-06-23 23:10:17.218685000 +02=
00
@@ -21,6 +21,8 @@
 obj-$(CONFIG_CPUSETS) +=3D cpuset.o
 obj-$(CONFIG_IKCONFIG) +=3D configs.o
 obj-$(CONFIG_IKCONFIG_PROC) +=3D configs.o
+obj-$(CONFIG_IKPATCHES) +=3D patches.o
+obj-$(CONFIG_IKPATCHES_PROC) +=3D patches.o
 obj-$(CONFIG_STOP_MACHINE) +=3D stop_machine.o
 obj-$(CONFIG_AUDIT) +=3D audit.o
 obj-$(CONFIG_AUDITSYSCALL) +=3D auditsc.o
@@ -52,3 +54,17 @@
 targets +=3D config_data.h
 $(obj)/config_data.h: $(obj)/config_data.gz FORCE
 	$(call if_changed,ikconfiggz)
+
+$(obj)/patches.o: $(obj)/patches_data.h
+
+# patches_data.h contains the same information as ikpatches.h but gzipped.
+# Info from patches_data can be extracted from /proc/patches*
+targets +=3D patches_data.gz
+$(obj)/patches_data.gz: .patches FORCE
+	$(call if_changed,gzip)
+
+quiet_cmd_ikpatchesgz =3D IKPTC   $@
+      cmd_ikpatchesgz =3D (echo "static const char kernel_patches_data[] =
=3D MAGIC_START"; cat $< | scripts/bin2c; echo "MAGIC_END;") > $@
+targets +=3D patches_data.h
+$(obj)/patches_data.h: $(obj)/patches_data.gz FORCE
+	$(call if_changed,ikpatchesgz)
diff -Nur linux-2.6.12+/kernel/patches.c linux-2.6.12+-patches/kernel/patch=
es.c
=2D-- linux-2.6.12+/kernel/patches.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.12+-patches/kernel/patches.c	2005-06-23 23:10:17.608685000 +0=
200
@@ -0,0 +1,115 @@
+/*
+ * kernel/patches.c
+ * Echo the kernel .patches file used to build the kernel
+ *
+ * Copyright (C) 2005 Christian Hesse <Christi@n-Hesse.de>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or (at
+ * your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
+ * NON INFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include <linux/patches.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/proc_fs.h>
+#include <linux/seq_file.h>
+#include <linux/init.h>
+#include <asm/uaccess.h>
+
+/**************************************************/
+/* the actual current patchesfile                 */
+
+/*
+ * Define kernel_patches_data and kernel_patches_data_size, which contains=
 the
+ * wrapped and compressed patches file.  The file is first compressed
+ * with gzip and then bounded by two eight byte magic numbers to allow
+ * extraction from a binary kernel image:
+ *
+ *   IKPTC_ST
+ *   <image>
+ *   IKPTC_ED
+ */
+#define MAGIC_START	"IKPTC_ST"
+#define MAGIC_END	"IKPTC_ED"
+#include "patches_data.h"
+
+
+#define MAGIC_SIZE (sizeof(MAGIC_START) - 1)
+#define kernel_patches_data_size \
+	(sizeof(kernel_patches_data) - 1 - MAGIC_SIZE * 2)
+
+#ifdef CONFIG_IKPATCHES_PROC
+
+/**************************************************/
+/* globals and useful constants                   */
+
+static ssize_t
+ikpatches_read_current(struct file *file, char __user *buf,
+		      size_t len, loff_t * offset)
+{
+	loff_t pos =3D *offset;
+	ssize_t count;
+
+	if (pos >=3D kernel_patches_data_size)
+		return 0;
+
+	count =3D min(len, (size_t)(kernel_patches_data_size - pos));
+	if (copy_to_user(buf, kernel_patches_data + MAGIC_SIZE + pos, count))
+		return -EFAULT;
+
+	*offset +=3D count;
+	return count;
+}
+
+static struct file_operations ikpatches_file_ops =3D {
+	.owner =3D THIS_MODULE,
+	.read =3D ikpatches_read_current,
+};
+
+/***************************************************/
+/* ikpatches_init: start up everything we need to */
+
+static int __init ikpatches_init(void)
+{
+	struct proc_dir_entry *entry;
+
+	/* create the current patches file */
+	entry =3D create_proc_entry("patches.gz", S_IFREG | S_IRUGO,
+				  &proc_root);
+	if (!entry)
+		return -ENOMEM;
+
+	entry->proc_fops =3D &ikpatches_file_ops;
+	entry->size =3D kernel_patches_data_size;
+
+	return 0;
+}
+
+/***************************************************/
+/* ikpatches_cleanup: clean up our mess           */
+
+static void __exit ikpatches_cleanup(void)
+{
+	remove_proc_entry("patches.gz", &proc_root);
+}
+
+module_init(ikpatches_init);
+module_exit(ikpatches_cleanup);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Christian Hesse");
+MODULE_DESCRIPTION("Echo the kernel .patch file that lists applied patches=
");
+
+#endif /* CONFIG_IKPATCHES_PROC */

--Boundary-01=_ECzuCfDfXi/wQo2--

--nextPart1447698.4RtlPmQ6xB
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.15 (GNU/Linux)

iD8DBQBCuzCKlZfG2c8gdSURAn+WAKDtR5rVluRfSec250lLfylcE8Qd0QCdH4Il
W3IYfyVqJskV9u2t1VbDABs=
=iK1V
-----END PGP SIGNATURE-----

--nextPart1447698.4RtlPmQ6xB--
