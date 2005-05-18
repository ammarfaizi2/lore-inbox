Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262072AbVERDAB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262072AbVERDAB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 23:00:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262069AbVERC7e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 22:59:34 -0400
Received: from rproxy.gmail.com ([64.233.170.204]:48742 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262067AbVERC7J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 22:59:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:references;
        b=oRumMTZssNqKzV7/sWmn3qS6kMagKXj+sMdgY+XdKY2s6ZSqWDRPSybTlX4QNMzGTCVkcnb1isBXlVmTYhyBVYtBIY/ntAaOJf796HGhq1wh6Zmj0pIrcTd3y0CRperC7D53P3VizawcLk7HrIhIJS/rg8zQAmXwz6O5xfDFSTo=
Message-ID: <253818670505171959f5cecb@mail.gmail.com>
Date: Tue, 17 May 2005 22:59:05 -0400
From: Yani Ioannou <yani.ioannou@gmail.com>
Reply-To: Yani Ioannou <yani.ioannou@gmail.com>
To: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       lm-sensors@lm-sensors.org
Subject: Re: [PATCH 2.6.12-rc4 14/15] include/linux/i2c-sysfs.h: i2c sensor_device_attribute and macros
In-Reply-To: <2538186705051703463587a54@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_543_15761002.1116385145712"
References: <2538186705051703463587a54@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_543_15761002.1116385145712
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Oops..I caught this simple typo while compile testing the adm1026
patch with everything, but it looks like I forgot to update the patch,
here is the corrected version (just adding the missing '=3D' ):

Signed-off-by: Yani Ioannou <yani.ioannou@gmail.com>

Yani

On 5/17/05, Yani Ioannou <yani.ioannou@gmail.com> wrote:
> This patch creates a new header with a potential standard i2c sensor
> attribute type (which simply includes an int representing the sensor
> number/index) and the associated macros, SENSOR_DEVICE_ATTR to define
> a static attribute and to_sensor_dev_attr to get a
> sensor_device_attribute reference from an embedded device_attribute
> reference.
>=20
> Please see the next patch to see how these can be used.
>=20
> Signed-off-by: Yani Ioannou <yani.ioannou@gmail.com>
>=20
> ---
>=20
>=20
>

------=_Part_543_15761002.1116385145712
Content-Type: text/plain; 
	name=patch-linux-2.6.12-rc4-sysfsdyncallback-deviceattr-i2c.diff.diffstat.txt; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="patch-linux-2.6.12-rc4-sysfsdyncallback-deviceattr-i2c.diff.diffstat.txt"

 i2c-sysfs.h |   37 +++++++++++++++++++++++++++++++++++++
 1 files changed, 37 insertions(+)

------=_Part_543_15761002.1116385145712
Content-Type: text/x-patch; 
	name=patch-linux-2.6.12-rc4-sysfsdyncallback-deviceattr-i2c.diff; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="patch-linux-2.6.12-rc4-sysfsdyncallback-deviceattr-i2c.diff"

diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/include/linux/i2c-sysfs.h linux-2.6.12-rc4-sysfsdyncallback-deviceattr-i2c/include/linux/i2c-sysfs.h
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/include/linux/i2c-sysfs.h	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-i2c/include/linux/i2c-sysfs.h	2005-05-16 23:30:12.000000000 -0400
@@ -0,0 +1,37 @@
+/*
+ *  i2c-sysfs.h - i2c chip driver sysfs defines
+ *
+ *  Copyright (C) 2005 Yani Ioannou <yani.ioannou@gmail.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+#ifndef _LINUX_I2C_SYSFS_H
+#define _LINUX_I2C_SYSFS_H
+
+struct sensor_device_attribute{
+	struct device_attribute dev_attr;
+	int index;
+};
+
+#define to_sensor_dev_attr(_dev_attr) \
+container_of(_dev_attr, struct sensor_device_attribute, dev_attr)
+
+#define SENSOR_DEVICE_ATTR(_name,_mode,_show,_store,_index)	\
+struct sensor_device_attribute sensor_dev_attr_##_name = {	\
+	.dev_attr=__ATTR(_name,_mode,_show,_store),		\
+	.index=_index,						\
+}
+
+#endif /* _LINUX_I2C_SYSFS_H */

------=_Part_543_15761002.1116385145712--
