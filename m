Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279840AbRKIMBt>; Fri, 9 Nov 2001 07:01:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279842AbRKIMBj>; Fri, 9 Nov 2001 07:01:39 -0500
Received: from cpe.atm0-0-0-122182.0x3ef30264.bynxx2.customer.tele.dk ([62.243.2.100]:61525
	"EHLO marvin.athome.dk") by vger.kernel.org with ESMTP
	id <S279840AbRKIMB1>; Fri, 9 Nov 2001 07:01:27 -0500
Message-ID: <3BEBC592.1030506@fugmann.dhs.org>
Date: Fri, 09 Nov 2001 13:01:22 +0100
From: Anders Peter Fugmann <afu@fugmann.dhs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
To: andrew.grover@intel.com
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] fix ACPI multible power entries
Content-Type: multipart/mixed;
 boundary="------------070007080809060306020400"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070007080809060306020400
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi.

In trying to get ACPI to work on my system, i was stumbled to see two 
button entries under /proc/acpi/button/.

Attached is a patch which corrects this behaviour.
The patch applies to 2.4.14.

Regards
Anders Fugmann



--------------070007080809060306020400
Content-Type: text/plain;
 name="acpi.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="acpi.diff"

--- linux-2.4.14/drivers/acpi/ospm/button/bn_osl.c.orig	Thu Nov  8 21:03:35 2001
+++ linux-2.4.14/drivers/acpi/ospm/button/bn_osl.c	Fri Nov  9 12:52:57 2001
@@ -97,10 +97,13 @@
 			printk(KERN_WARNING "ACPI: Multiple power buttons detected, ignoring fixed-feature\n");
 		default:
 			printk(KERN_INFO "ACPI: Power Button (CM) found\n");
-			bn_power_button = BN_TYPE_GENERIC;
-			if (!proc_mkdir(BN_PROC_POWER_BUTTON, bn_proc_root)) {
-				status = AE_ERROR;
+			/* Only create proc entry, if it has not been created before */
+			if (!bn_power_button) {
+			      if (!proc_mkdir(BN_PROC_POWER_BUTTON, bn_proc_root)) {
+			            status = AE_ERROR;
+			      }
 			}
+			bn_power_button = BN_TYPE_GENERIC;
 			break;
 		}
 		break;
@@ -130,9 +133,13 @@
 		default:
 			bn_sleep_button = BN_TYPE_GENERIC;
 			printk(KERN_INFO "ACPI: Sleep Button (CM) found\n");
-			if (!proc_mkdir(BN_PROC_SLEEP_BUTTON, bn_proc_root)) {
-				status = AE_ERROR;
+			/* Only create proc entry, if it has not been created before */
+			if (!bn_sleep_button) {
+			      if (!proc_mkdir(BN_PROC_SLEEP_BUTTON, bn_proc_root)) {
+				    status = AE_ERROR;
+			      }
 			}
+			bn_sleep_button = BN_TYPE_GENERIC;
 			break;
 		}
 		break;

--------------070007080809060306020400--

