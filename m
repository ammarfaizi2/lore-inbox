Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262114AbVCIRUL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262114AbVCIRUL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 12:20:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262097AbVCIRUC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 12:20:02 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:29131 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262111AbVCIRSW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 12:18:22 -0500
Message-ID: <422F2FDD.4050908@us.ltcfwd.linux.ibm.com>
Date: Wed, 09 Mar 2005 12:18:21 -0500
From: Wen Xiong <wendyx@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Wen Xiong <wendyx@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [ patch 4/7] drivers/serial/jsm: new serial device driver
References: <42225A47.3060206@us.ltcfwd.linux.ibm.com> <20050228063954.GB23595@kroah.com> <4228CE41.2000102@us.ltcfwd.linux.ibm.com> <20050304220116.GA1201@kroah.com> <422CD9DB.10103@us.ltcfwd.linux.ibm.com> <20050308064424.GF17022@kroah.com> <422DF525.8030606@us.ltcfwd.linux.ibm.com> <20050308235807.GA11807@kroah.com> <422F1A8A.4000106@us.ltcfwd.linux.ibm.com> <20050309163518.GC25079@kroah.com>
In-Reply-To: <20050309163518.GC25079@kroah.com>
Content-Type: multipart/mixed;
 boundary="------------020701010509070405030302"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020701010509070405030302
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Greg KH wrote:

>On Wed, Mar 09, 2005 at 10:47:22AM -0500, Wen Xiong wrote:
>  
>
>>+static ssize_t jsm_driver_debug_show(struct device_driver *ddp, char *buf)
>>+{
>>+	return snprintf(buf, PAGE_SIZE, "0x%x\n", jsm_debug);
>>+}
>>+static DRIVER_ATTR(debug, S_IRUSR, jsm_driver_debug_show, NULL);
>>    
>>
>
>Should just be a module paramater, right?  So you can drop this too...
>
>This file is getting quite small now :)
>
>thanks,
>
>greg k-h
>
>  
>
If I removed two module paramaters, only two files left: version and state.
 Removed all of them?

Thanks,
wendy


--------------020701010509070405030302
Content-Type: text/plain;
 name="patch4.jasmine"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch4.jasmine"

diff -Nuar linux-2.6.11.org/drivers/serial/jsm/jsm_sysfs.c linux-2.6.11.new/drivers/serial/jsm/jsm_sysfs.c
--- linux-2.6.11.org/drivers/serial/jsm/jsm_sysfs.c	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.11.new/drivers/serial/jsm/jsm_sysfs.c	2005-03-09 11:17:37.055947624 -0600
@@ -0,0 +1,53 @@
+/************************************************************************
+ * Copyright 2003 Digi International (www.digi.com)
+ *
+ * Copyright (C) 2004 IBM Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2, or (at your option)
+ * any later version.
+ * 
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY, EXPRESS OR IMPLIED; without even the 
+ * implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR 
+ * PURPOSE.  See the GNU General Public License for more details.
+ * 
+ * You should have received a copy of the GNU General Public License 
+ * along with this program; if not, write to the Free Software 
+ * Foundation, Inc., 59 * Temple Place - Suite 330, Boston,
+ * MA  02111-1307, USA.
+ *
+ * Contact Information:
+ * Scott H Kilau <Scott_Kilau@digi.com>
+ * Wendy Xiong   <wendyx@us.ltcfwd.linux.ibm.com>
+ *
+ ***********************************************************************/
+#include <linux/device.h>
+#include <linux/serial_reg.h>
+
+#include "jsm_driver.h"
+
+static ssize_t jsm_driver_version_show(struct device_driver *ddp, char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "%s\n", JSM_VERSION);
+}
+static DRIVER_ATTR(version, S_IRUSR, jsm_driver_version_show, NULL);
+
+static ssize_t jsm_driver_state_show(struct device_driver *ddp, char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "%s\n", jsm_driver_state_text[jsm_driver_state]);
+}
+static DRIVER_ATTR(state, S_IRUSR, jsm_driver_state_show, NULL);
+
+void jsm_create_driver_sysfiles(struct device_driver *driverfs)
+{
+	driver_create_file(driverfs, &driver_attr_version);
+	driver_create_file(driverfs, &driver_attr_state);
+}
+
+void jsm_remove_driver_sysfiles(struct device_driver  *driverfs)
+{
+	driver_remove_file(driverfs, &driver_attr_version);
+	driver_remove_file(driverfs, &driver_attr_state);
+}

--------------020701010509070405030302--

