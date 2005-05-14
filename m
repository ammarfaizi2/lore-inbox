Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262738AbVENKEy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262738AbVENKEy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 May 2005 06:04:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262727AbVENKCT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 May 2005 06:02:19 -0400
Received: from rproxy.gmail.com ([64.233.170.206]:47644 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262485AbVENJiu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 May 2005 05:38:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type;
        b=dYmtSII84oF9TBBYdMmtP8Q/oXMR4UOP0azLZnH/rgpQ5v0zppwjwrqowgeCiGKwi6oMy7tPgW12lq00lCe0TrAgJWFHBzf5zepWZM3DjbtLddDv35nz0QQ3114NQaFOKoZiDxvFCulnUexDogMonhn1tciElrdFx+fyJOTbAYs=
Message-ID: <2538186705051402386375a3d9@mail.gmail.com>
Date: Sat, 14 May 2005 05:38:43 -0400
From: Yani Ioannou <yani.ioannou@gmail.com>
Reply-To: Yani Ioannou <yani.ioannou@gmail.com>
To: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.12-rc4] include/linux:(dynamic sysfs callbacks) new attribute macros
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_1471_28009831.1116063523907"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_1471_28009831.1116063523907
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

The following patch adds a new __ATTR_PRIVATE macro and a
DEVICE_ATTR_PRIVATE macro to be used when creating static device
attributes with a void * member.


Signed-off-by: Yani Ioannou <yani.ioannou@gmail.com>

Thanks,
Yani

---
 device.h |    3 +++
 sysfs.h  |   11 +++++++++++
 2 files changed, 14 insertions(+)
---

------=_Part_1471_28009831.1116063523907
Content-Type: text/x-patch; 
	name=patch-linux-2.6.12-rc4-sysfsdyncallback-deviceattr-macro.diff; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="patch-linux-2.6.12-rc4-sysfsdyncallback-deviceattr-macro.diff"

diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/include/linux/device.h linux-2.6.12-rc4-sysfsdyncallback-deviceattr-macro/include/linux/device.h
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/include/linux/device.h	2005-05-13 01:02:10.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-macro/include/linux/device.h	2005-05-13 01:09:27.000000000 -0400
@@ -343,6 +343,9 @@ struct device_attribute {
 #define DEVICE_ATTR(_name,_mode,_show,_store) \
 struct device_attribute dev_attr_##_name = __ATTR(_name,_mode,_show,_store)
 
+#define DEVICE_ATTR_PRIVATE(_name,_mode,_show,_store,_private)	\
+struct device_attribute dev_attr_##_name = 			\
+	__ATTR_PRIVATE(_name,_mode,_show,_store,_private)
 
 extern int device_create_file(struct device *device, struct device_attribute * entry);
 extern void device_remove_file(struct device * dev, struct device_attribute * attr);
diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/include/linux/sysfs.h linux-2.6.12-rc4-sysfsdyncallback-deviceattr-macro/include/linux/sysfs.h
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/include/linux/sysfs.h	2005-05-13 01:02:10.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-macro/include/linux/sysfs.h	2005-05-13 01:08:09.000000000 -0400
@@ -45,6 +45,17 @@ struct attribute_group {
 	.store	= _store,			\
 }
 
+#define __ATTR_PRIVATE(_name,_mode,_show,_store,_private) {	\
+	.attr = {						\
+		.name = __stringify(_name),			\
+		.mode = _mode,					\
+		.private = _private,				\
+		.owner = THIS_MODULE,				\
+	}, 							\
+	.show	= _show,					\
+	.store	= _store,					\
+}
+
 #define __ATTR_RO(_name) {			\
 	.attr	= {				\
 		.name = __stringify(_name),	\




------=_Part_1471_28009831.1116063523907--
