Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750839AbWDRXtE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750839AbWDRXtE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 19:49:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750840AbWDRXtD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 19:49:03 -0400
Received: from dmesg.printk.net ([212.13.197.101]:30908 "EHLO dmesg.printk.net")
	by vger.kernel.org with ESMTP id S1750839AbWDRXtB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 19:49:01 -0400
Date: Wed, 19 Apr 2006 00:41:56 +0100
From: Jon Masters <jonathan@jonmasters.org>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] MODULE_FIRMWARE for binary firmware(s)
Message-ID: <20060418234156.GA28346@apogee.jonmasters.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-MailScanner: Found to be clean
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

diff -urN linux-2.6.16.2_orig/include/linux/module.h linux-2.6.16.2_dev/include/linux/module.h
--- linux-2.6.16.2_orig/include/linux/module.h  2006-04-07 17:56:47.000000000 +0100
+++ linux-2.6.16.2_dev/include/linux/module.h   2006-04-12 13:51:56.000000000 +0100
@@ -155,6 +155,8 @@
 */
 #define MODULE_VERSION(_version) MODULE_INFO(version, _version)

+#define MODULE_FIRMWARE(_firmware) MODULE_INFO(firmware, _firmware)
+
 /* Given an address, look for it in the exception tables */
 const struct exception_table_entry *search_exception_tables(unsigned long add);
