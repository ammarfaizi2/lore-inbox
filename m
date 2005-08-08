Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932334AbVHHWzR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932334AbVHHWzR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 18:55:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932335AbVHHWzR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 18:55:17 -0400
Received: from fmr16.intel.com ([192.55.52.70]:50610 "EHLO
	fmsfmr006.fm.intel.com") by vger.kernel.org with ESMTP
	id S932334AbVHHWzQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 18:55:16 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: FW: fix nohalt boot option
Date: Mon, 8 Aug 2005 15:55:09 -0700
Message-ID: <B05667366EE6204181EABE9C1B1C0EB507C5F8C1@scsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: fix nohalt boot option
Thread-Index: AcWcZ/OzYawbL9IfQUCfE4aKhz2uwwAA3p3A
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 08 Aug 2005 22:55:15.0210 (UTC) FILETIME=[3D7F96A0:01C59C6C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"nohalt" option is currently broken on IPF (2.6.12 is the earliest
kernel I looked, might be broken even earlier).

- Ken


-----Original Message-----
From: linux-ia64-owner@vger.kernel.org
[mailto:linux-ia64-owner@vger.kernel.org] On Behalf Of Chen, Kenneth W
Sent: Monday, August 08, 2005 3:25 PM
To: linux-ia64@vger.kernel.org
Subject: fix nohalt boot option

Apparent, this changeset broke the "nohalt" kernel boot option.

http://www.kernel.org/git/gitweb.cgi?p=linux/kernel/git/torvalds/linux-2
.6.git;a=commit;h=8df5a500a3e97f7811cdce0f553ca1917ccd4220

default_idle() is looking at new variable can_do_pal_halt.  However,
that variable did not get cleared upon "nohalt" boot option.  Resulting
a wacky behavior that the kernel option can only have effect when
perfmon
is exercised.


Signed-off-by: Ken Chen <kenneth.w.chen@intel.com>


--- linux-2.6.12/arch/ia64/kernel/process.c.orig	2005-08-08
15:05:47.319034969 -0700
+++ linux-2.6.12/arch/ia64/kernel/process.c	2005-08-08
15:05:59.147159824 -0700
@@ -178,7 +178,7 @@ static int can_do_pal_halt = 1;
 
 static int __init nohalt_setup(char * str)
 {
-	pal_halt = 0;
+	pal_halt = can_do_pal_halt = 0;
 	return 1;
 }
 __setup("nohalt", nohalt_setup);

-
To unsubscribe from this list: send the line "unsubscribe linux-ia64" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
