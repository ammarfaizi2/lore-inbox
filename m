Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261419AbUCUWIt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 17:08:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261405AbUCUWIt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 17:08:49 -0500
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:21260 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261419AbUCUWIn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 17:08:43 -0500
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: [PATCH] gcc3 does not inline some functions
Date: Sun, 21 Mar 2004 23:57:34 +0200
User-Agent: KMail/1.5.4
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_O/gXAs1J4PVoIdQ"
Message-Id: <200403212357.34290.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_O/gXAs1J4PVoIdQ
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

# cut 2.4.25/System.map -d' ' -f3 | sort | uniq -c | sort -r | head -10
    216 __constant_c_and_count_memset
    120 __constant_memcpy
     67 __constant_copy_to_user
     66 __constant_copy_from_user
     50 version
     23 debug
     17 max_interrupt_work
     16 rx_copybreak
     16 options
     16 mdio_write

Fix is below. Backported from 2.6. Untested.
--
vda

--Boundary-00=_O/gXAs1J4PVoIdQ
Content-Type: text/x-diff;
  charset="us-ascii";
  name="24_inline.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="24_inline.patch"

--- linux-2.4.25/include/linux/compiler.h.orig	Sun Mar 21 23:50:13 2004
+++ linux-2.4.25/include/linux/compiler.h	Sun Mar 21 23:51:06 2004
@@ -13,4 +13,12 @@
 #define likely(x)	__builtin_expect((x),1)
 #define unlikely(x)	__builtin_expect((x),0)
 
+#if __GNUC__ == 3
+#if __GNUC_MINOR__ >= 1
+# define inline         __inline__ __attribute__((always_inline))
+# define __inline__     __inline__ __attribute__((always_inline))
+# define __inline       __inline__ __attribute__((always_inline))
+#endif
+#endif
+
 #endif /* __LINUX_COMPILER_H */

--Boundary-00=_O/gXAs1J4PVoIdQ--

