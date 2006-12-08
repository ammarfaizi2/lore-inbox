Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424292AbWLHEMU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424292AbWLHEMU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 23:12:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424304AbWLHEMU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 23:12:20 -0500
Received: from liaag2ad.mx.compuserve.com ([149.174.40.155]:32832 "EHLO
	liaag2ad.mx.compuserve.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1424292AbWLHEMT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 23:12:19 -0500
Date: Thu, 7 Dec 2006 23:02:04 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [patch] Document how to decode an IOCTL number
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Message-ID: <200612072306_MC3-1-D448-DB6A@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Document how to decode a binary IOCTL number.

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>
---
 Documentation/ioctl/ioctl-decoding.txt |   24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

--- /dev/null
+++ 2.6.19.0.5-32smp/Documentation/ioctl/ioctl-decoding.txt
@@ -0,0 +1,24 @@
+To decode a hex IOCTL code:
+
+Most architecures use this generic format, but check
+include/ARCH/ioctl.h for specifics, e.g. powerpc
+uses 3 bits to encode read/write and 13 bits for size.
+
+ bits    meaning
+ 31-30	00 - no parameters: uses _IO macro
+	10 - read: _IOR
+	01 - write: _IOW
+	11 - read/write: _IOWR
+
+ 29-16	size of arguments
+
+ 15-8	ascii character supposedly
+	unique to each driver
+
+ 7-0	function #
+
+
+ So for example 0x82187201 is a read with arg length of 0x218,
+character 'r' function 1. Grepping the source reveals this is:
+
+#define VFAT_IOCTL_READDIR_BOTH         _IOR('r', 1, struct dirent [2])
-- 
Chuck
"Even supernovas have their duller moments."
