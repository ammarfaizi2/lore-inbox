Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278078AbRKHMaI>; Thu, 8 Nov 2001 07:30:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278041AbRKHM37>; Thu, 8 Nov 2001 07:29:59 -0500
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:24449 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S277317AbRKHM3x>; Thu, 8 Nov 2001 07:29:53 -0500
Message-ID: <3BEA7875.5000303@wipro.com>
Date: Thu, 08 Nov 2001 17:50:05 +0530
From: "BALBIR SINGH" <balbir.singh@wipro.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH]Problems with compling 2.4.14 on SMP and kernel versioning on modules set.
Content-Type: multipart/mixed;
	boundary="------------InterScan_NT_MIME_Boundary"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.

--------------InterScan_NT_MIME_Boundary
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I could not compile a UP (non-SMP) kernel on my system, with module
versioning set, the problem was traced to ksyms.c

 * Herein lies all the functions/variables that are "exported" for linkage
 * with dynamically loaded kernel modules.
 *                      Jon.
 *

Now linux/module.h is included in ksyms.c

Below is a patch for compiling a NON-SMP kernel in 2.4.14. If this is
correct, please apply. In this patch, the include of linux/module.h
(which redifines smp_num_cpus based on kernel versioning) has been moved
below the include of linux/kernel_stat.h


--- ksyms.c     Thu Nov  8 17:41:39 2001
+++ ksyms.c.org Thu Nov  8 16:41:48 2001
@@ -9,12 +9,12 @@
  *   by Bjorn Ekwall <bj0rn@blox.se>
  */
 
-#include <linux/blkdev.h>
-#include <linux/cdrom.h>
-#include <linux/kernel_stat.h>
 #include <linux/config.h>
 #include <linux/slab.h>
 #include <linux/module.h>
+#include <linux/blkdev.h>
+#include <linux/cdrom.h>
+#include <linux/kernel_stat.h>
 #include <linux/vmalloc.h>
 #include <linux/sys.h>
 #include <linux/utsname.h>



--------------InterScan_NT_MIME_Boundary
Content-Type: text/plain;
	name="InterScan_Disclaimer.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="InterScan_Disclaimer.txt"

-------------------------------------------------------------------------------------------------------------------------
Information transmitted by this E-MAIL is proprietary to Wipro and/or its Customers and
is intended for use only by the individual or entity to which it is
addressed, and may contain information that is privileged, confidential or
exempt from disclosure under applicable law. If you are not the intended
recipient or it appears that this mail has been forwarded to you without
proper authority, you are notified that any use or dissemination of this
information in any manner is strictly prohibited. In such cases, please
notify us immediately at mailto:mailadmin@wipro.com and delete this mail
from your records.
----------------------------------------------------------------------------------------------------------------------

--------------InterScan_NT_MIME_Boundary--
