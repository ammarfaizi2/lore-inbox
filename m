Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262946AbTEXDOZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 23:14:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262976AbTEXDOZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 23:14:25 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:48883 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262946AbTEXDOY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 23:14:24 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: James Cleverdon <jamesclv@us.ibm.com>
Reply-To: jamesclv@us.ibm.com
Organization: IBM xSeries Linux Solutions
To: "Martin J. Bligh" <mbligh@aracnet.com>, linux-kernel@vger.kernel.org
Subject: [PATCH][2.5] static MAX_MP_BUSSES increase for Summit boxes
Date: Fri, 23 May 2003 20:27:26 -0700
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200305232027.26945.jamesclv@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The dynamic MAX_MP_BUSSES fix for v2.4 never made it into 2.5.  x440s with 
RXE100s and 32-way x445s without can easily overflow it.

Here's a static patch:


diff -pru 2.5.69/include/asm-i386/mpspec.h t69/include/asm-i386/mpspec.h
--- 2.5.69/include/asm-i386/mpspec.h	Sun May  4 16:52:48 2003
+++ t69/include/asm-i386/mpspec.h	Fri May 23 20:17:59 2003
@@ -191,7 +191,13 @@ struct mpc_config_translation
 #define MAX_IRQ_SOURCES 256
 #endif /* CONFIG_X86_NUMAQ */
 
+#ifdef CONFIG_X86_SUMMIT
+/* BIOS reserves an amazing number of PCI busses on x440s and x445s,
+ * especially when RXE100s are attached. */
+#define MAX_MP_BUSSES 258
+#else
 #define MAX_MP_BUSSES 32
+#endif
 enum mp_bustype {
 	MP_BUS_ISA = 1,
 	MP_BUS_EISA,


-- 
James Cleverdon
IBM xSeries Linux Solutions
{jamesclv(Unix, preferred), cleverdj(Notes)} at us dot ibm dot com

