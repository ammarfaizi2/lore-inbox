Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264854AbUD1PTP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264854AbUD1PTP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 11:19:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264856AbUD1PTP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 11:19:15 -0400
Received: from rtp-iport-2.cisco.com ([64.102.122.149]:56244 "EHLO
	rtp-iport-2.cisco.com") by vger.kernel.org with ESMTP
	id S264854AbUD1PTK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 11:19:10 -0400
X-BrightmailFiltered: true
To: "David S. Miller" <davem@redhat.com>
Cc: jmorris@redhat.com, Matt_Domsch@dell.com, B.Zolnierkiewicz@elka.pw.edu.pl,
       linux-kernel@vger.kernel.org
Subject: [PATCH] lib/crc32.c: uses (and includes) compiler.h
References: <Xine.LNX.4.44.0403261134210.4331-100000@thoron.boston.redhat.com>
	<yqujr7vai6k4.fsf@chaapala-lnx2.cisco.com>
	<200403302043.22938.bzolnier@elka.pw.edu.pl>
	<yqujwu52ywsy.fsf@chaapala-lnx2.cisco.com>
	<20040330192350.GB5149@lists.us.dell.com>
	<yquj1xn87mpy.fsf_-_@chaapala-lnx2.cisco.com>
	<yqujpta3y7ia.fsf_-_@chaapala-lnx2.cisco.com>
	<20040423164226.3d6fa2c3.davem@redhat.com>
	<yqujk7019ox2.fsf_-_@chaapala-lnx2.cisco.com>
From: Clay Haapala <chaapala@cisco.com>
Organization: Cisco Systems, Inc. SRBU
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAHlBMVEXl5ufMrp3a4OLr6ujO
 lXzChGmsblZzRzjF1+ErFRAz+KIaAAACVElEQVR4nG3TQW/aMBQAYC9IO88dguyWUomqt0DQ
 do7koO22SXFQb6uE7XIMKrFya+mhPk8D43+79+wMyrp3gnx59nvxMxmNEnIWycgH+U9E55CO
 rkZJ8hYipbXTdfcvQK/Xy6JF2zqI+qpbjZAszSDG2oXYp0FI5mOqbAeuDtLBdeuO8fNVxkzr
 E9jklKEgQWsppYYf9v4IE3i/4RiVRPneQTpoXSM8QA7un3QZQ2cl54wXIH7VDwEmrdOiZBgF
 V5BiLwLM4B3BS0ZpB24d4IvzW+QIc7/JIcAQIadF2eeUzn3FAa6xWFYUotjIRmLB7vEvCC4t
 VAugpTrC2FleLBm2wVnlAc7Dl2u5L1UozgWCjTxMW+vb4GVVFhWWFSCdKmgDMhaNFoxL3bSH
 rc/Irn1/RcWlh+UqNgHeNwishJ1L6LCpjdmGz76RmFGyuSwLgLUxJhyUlLA7fHMpeSGVPsFA
 wqtK4voI8RE+I3DsDpfamSNMpIBTKrF1yIpPMA0AzQPU5gSwCTyC/aEAtX4NM6gLM3CCziBT
 jRR+StQ/AA8a7AMuwxn0YAmcRKnVGwDRiOcw3uMWlajgAJsAPbw4OIpwrH3/vdq9B7hpl7GD
 w61A4PxwSqyH9J25gePnYdqhYjjZ5s6QCb3bwvOLJWPBFvCvWVDSthYmcff44IcacOUOt1Yv
 yGCF1+twuQtQCPjzZIaK/Lrx9+6b7TKEdXTwgz8R+uJv5K1jOcWMnO7NJ3v/QlprnzP1deUe
 8j4CpVE82MRj4j5SHGDnfvul8uGwjqNnpf4Ak4pzJDIy3lkAAAAASUVORK5CYII=
Date: Wed, 28 Apr 2004 10:19:02 -0500
In-Reply-To: <yqujk7019ox2.fsf_-_@chaapala-lnx2.cisco.com> (Clay Haapala's
 message of "Tue, 27 Apr 2004 14:55:05 -0500")
Message-ID: <yqujd65sku55.fsf_-_@chaapala-lnx2.cisco.com>
User-Agent: Gnus/5.110002 (No Gnus v0.2) XEmacs/21.5 (chayote, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is the crc32.c patch to remove attribute((pure)), with compiler.h
included.
-- 
Clay Haapala (chaapala@cisco.com) Cisco Systems SRBU +1 763-398-1056
   6450 Wedgwood Rd, Suite 130 Maple Grove MN 55311 PGP: C89240AD
  "Oh, *that* Physics Prize.  Well, I just substituted 'stupidity' for
      'dark matter' in the equations, and it all came together."

--- linux-2.6.5.orig/lib/crc32.c	Sat Apr  3 21:36:14 2004
+++ linux-2.6.5/lib/crc32.c	Wed Apr 28 10:07:20 2004
@@ -23,6 +23,7 @@
 #include <linux/crc32.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/compiler.h>
 #include <linux/types.h>
 #include <linux/slab.h>
 #include <linux/init.h>
@@ -37,13 +38,6 @@
 #endif
 #include "crc32table.h"
 
-#if __GNUC__ >= 3	/* 2.x has "attribute", but only 3.0 has "pure */
-#define attribute(x) __attribute__(x)
-#else
-#define attribute(x)
-#endif
-
-
 MODULE_AUTHOR("Matt Domsch <Matt_Domsch@dell.com>");
 MODULE_DESCRIPTION("Ethernet CRC32 calculations");
 MODULE_LICENSE("GPL");
@@ -62,7 +56,7 @@
  * @len - length of buffer @p
  * 
  */
-u32 attribute((pure)) crc32_le(u32 crc, unsigned char const *p, size_t len)
+u32 __attribute_pure__ crc32_le(u32 crc, unsigned char const *p, size_t len)
 {
 	int i;
 	while (len--) {
@@ -82,7 +76,7 @@
  * @len - length of buffer @p
  * 
  */
-u32 attribute((pure)) crc32_le(u32 crc, unsigned char const *p, size_t len)
+u32 __attribute_pure__ crc32_le(u32 crc, unsigned char const *p, size_t len)
 {
 # if CRC_LE_BITS == 8
 	const u32      *b =(u32 *)p;
@@ -165,7 +159,7 @@
  * @len - length of buffer @p
  * 
  */
-u32 attribute((pure)) crc32_be(u32 crc, unsigned char const *p, size_t len)
+u32 __attribute_pure__ crc32_be(u32 crc, unsigned char const *p, size_t len)
 {
 	int i;
 	while (len--) {
@@ -187,7 +181,7 @@
  * @len - length of buffer @p
  * 
  */
-u32 attribute((pure)) crc32_be(u32 crc, unsigned char const *p, size_t len)
+u32 __attribute_pure__ crc32_be(u32 crc, unsigned char const *p, size_t len)
 {
 # if CRC_BE_BITS == 8
 	const u32      *b =(u32 *)p;
