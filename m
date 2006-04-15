Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751588AbWDOIKm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751588AbWDOIKm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Apr 2006 04:10:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751590AbWDOIKl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Apr 2006 04:10:41 -0400
Received: from mx1.redhat.com ([66.187.233.31]:11404 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751585AbWDOIKl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Apr 2006 04:10:41 -0400
Subject: [RFC] binary firmware and modules
From: Jon Masters <jcm@redhat.com>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-WfFg/Wf1lsHWTiSt+/iv"
Date: Sat, 15 Apr 2006 09:10:55 +0100
Message-Id: <1145088656.23134.54.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 (2.6.0-1) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-WfFg/Wf1lsHWTiSt+/iv
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi folks,

Right now, various kernel modules are being migrated over to use
request_firmware in order to pull in binary firmware blobs from userland
when the module is loaded. This makes sense.

However, there is right now little mechanism in place to automatically
determine which binary firmware blobs must be included with a kernel in
order to satisfy the prerequisites of these drivers. This affects
vendors, but also regular users to a certain extent too.

The attached patch introduces MODULE_FIRMWARE as one way of advertising
that a particular firmware file is to be loaded - it will then show up
via modinfo and could be used e.g. when packaging a kernel. I've also
given an example via the QLogic gla2xxx driver.

I expect that there are better ways to do this, so I'd like comments
from those closer to the ground on this problem. In particular, it would
be better if drivers didn't have to list the firmware twice - once in
request_firmware and then via MODULE_FIRMWARE. Maybe API change time?

Jon.

P.S. Until I fix evolution again, I'm using an attachment.


--=-WfFg/Wf1lsHWTiSt+/iv
Content-Disposition: attachment; filename=module_firmware.patch
Content-Type: text/x-patch; name=module_firmware.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -urN linux-2.6.16.2_orig/drivers/scsi/qla2xxx/qla_os.c linux-2.6.16.2_dev/drivers/scsi/qla2xxx/qla_os.c
--- linux-2.6.16.2_orig/drivers/scsi/qla2xxx/qla_os.c   2006-04-07 17:56:47.000000000 +0100
+++ linux-2.6.16.2_dev/drivers/scsi/qla2xxx/qla_os.c    2006-04-12 20:22:15.000000000 +0100
@@ -2765,3 +2765,9 @@
 MODULE_DESCRIPTION("QLogic Fibre Channel HBA Driver");
 MODULE_LICENSE("GPL");
 MODULE_VERSION(QLA2XXX_VERSION);
+MODULE_FIRMWARE("ql2100_fw.bin");
+MODULE_FIRMWARE("ql2200_fw.bin");
+MODULE_FIRMWARE("ql2300_fw.bin");
+MODULE_FIRMWARE("ql2322_fw.bin");
+MODULE_FIRMWARE("ql6312_fw.bin");
+MODULE_FIRMWARE("ql2400_fw.bin");
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

--=-WfFg/Wf1lsHWTiSt+/iv--

