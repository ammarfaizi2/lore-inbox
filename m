Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269747AbTGUL1Z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 07:27:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269755AbTGUL1Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 07:27:24 -0400
Received: from ns.suse.de ([213.95.15.193]:38927 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S269747AbTGUL1K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 07:27:10 -0400
Message-ID: <3F1BD193.3080701@suse.de>
Date: Mon, 21 Jul 2003 13:42:11 +0200
From: Hannes Reinecke <hare@suse.de>
Organization: SuSE Linux AG
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021204
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] include/linux/personality.h
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------020307050502090908030307"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020307050502090908030307
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Hi all,

the attached patch encloses the kernel-only parts of personality.h with
__KERNEL__ to prevent them to be visible in userspace. This also fixes
the nameclash between the macro personality() with the syscall
personality() if the header file is included in an userspace program.
Patch is against 2.4.21, should apply to 2.6.0-test1 equally.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke			hare@suse.de
SuSE Linux AG				S390 & zSeries
Deutschherrnstr. 15-19			+49 911 74053 688
90429 Nürnberg				http://www.suse.de


--------------020307050502090908030307
Content-Type: text/plain;
 name="personality.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="personality.patch"

--- linux-2.4.21-7/include/linux/personality.h.orig	2003-07-21 13:06:24.000000000 +0200
+++ linux-2.4.21-7/include/linux/personality.h	2003-07-21 13:07:53.000000000 +0200
@@ -1,6 +1,8 @@
 #ifndef _LINUX_PERSONALITY_H
 #define _LINUX_PERSONALITY_H
 
+#ifdef __KERNEL__
+
 /*
  * Handling of different ABIs (personalities).
  */
@@ -22,6 +24,7 @@
 extern unsigned long abi_defhandler_libcso;
 extern int abi_fake_utsname;
 
+#endif /* __KERNEL__ */
 
 /*
  * Flags for bug emulation.
@@ -69,6 +72,7 @@
 	PER_MASK =		0x00ff,
 };
 
+#ifdef __KERNEL__
 
 /*
  * Description of an execution domain.
@@ -127,4 +131,6 @@
 		__MOD_DEC_USE_COUNT(ep->module);	\
 } while (0)
 
+#endif /* __KERNEL__ */
+
 #endif /* _LINUX_PERSONALITY_H */


--------------020307050502090908030307--

