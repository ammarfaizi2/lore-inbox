Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264311AbVBDR3t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264311AbVBDR3t (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 12:29:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264178AbVBDR3s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 12:29:48 -0500
Received: from postfix4-1.free.fr ([213.228.0.62]:61142 "EHLO
	postfix4-1.free.fr") by vger.kernel.org with ESMTP id S266452AbVBDR2W
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 12:28:22 -0500
Message-ID: <4203B0B5.4080204@free.fr>
Date: Fri, 04 Feb 2005 18:28:21 +0100
From: matthieu castet <castet.matthieu@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: fr-fr, en, en-us
MIME-Version: 1.0
To: Linux Kernel list <linux-kernel@vger.kernel.org>,
       acpi-devel@lists.sourceforge.net
Cc: Len Brown <len.brown@intel.com>
Subject: [PATCH] PNPACPI : don't use device not present
Content-Type: multipart/mixed;
 boundary="------------010306090601000000030008"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010306090601000000030008
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,
this patch avoid the pnpacpi layer reconized not present device.

There is still issue [1] with the ACPI code that need to fix in order 
everything work correctly...

Matthieu CASTET


[1] http://bugzilla.kernel.org/show_bug.cgi?id=3358

--------------010306090601000000030008
Content-Type: text/x-patch;
 name="pnpacpi_spec.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pnpacpi_spec.patch"

--- linux-2.6.9/drivers/pnp/pnpacpi/core.c	2004-11-22 20:35:58.000000000 +0100
+++ linux-2.6.9/drivers/pnp/pnpacpi/core.c	2004-11-26 14:46:54.000000000 +0100
@@ -124,6 +124,10 @@
 	struct pnp_dev *dev;
 
 	pnp_dbg("ACPI device : hid %s", acpi_device_hid(device));
+
+	if(!device->status.present)
+		return -ENODEV;
+
 	dev =  pnpacpi_kmalloc(sizeof(struct pnp_dev), GFP_KERNEL);
 	if (!dev) {
 		pnp_err("Out of memory");

--------------010306090601000000030008--
