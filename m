Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751551AbWH1WIY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751551AbWH1WIY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 18:08:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751553AbWH1WIY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 18:08:24 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:38044 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1751551AbWH1WIX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 18:08:23 -0400
Subject: [PATCH] MODULE_FIRMWARE for binary firmware(s)
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Mon, 28 Aug 2006 17:08:20 -0500
Message-Id: <1156802900.3465.30.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jon Masters <jcm@redhat.com>

Right now, various kernel modules are being migrated over to use
request_firmware in order to pull in binary firmware blobs from userland
when the module is loaded. This makes sense.

However, there is right now little mechanism in place to automatically
determine which binary firmware blobs must be included with a kernel in
order to satisfy the prerequisites of these drivers. This affects
vendors, but also regular users to a certain extent too.

The attached patch introduces MODULE_FIRMWARE as a mechanism for
advertising that a particular firmware file is to be loaded - it will
then show up via modinfo and could be used e.g. when packaging a kernel.

Signed-off-by: Jon Masters <jcm@redhat.com>

Comments added in line with all the other MODULE_ tag

Signed-off-by: James Bottomley <James.Bottomley@SteelEye.com>
Index: BUILD-2.6/include/linux/module.h
===================================================================
--- BUILD-2.6.orig/include/linux/module.h	2006-08-28 13:16:22.000000000 -0500
+++ BUILD-2.6/include/linux/module.h	2006-08-28 13:17:46.000000000 -0500
@@ -156,6 +156,11 @@ extern struct module __this_module;
 */
 #define MODULE_VERSION(_version) MODULE_INFO(version, _version)
 
+/* Optional firmware file (or files) needed by the module
+ * format is simply firmware file name.  Multiple firmware
+ * files require multiple MODULE_FIRMWARE() specifiers */
+#define MODULE_FIRMWARE(_firmware) MODULE_INFO(firmware, _firmware)
+
 /* Given an address, look for it in the exception tables */
 const struct exception_table_entry *search_exception_tables(unsigned long add);
 


