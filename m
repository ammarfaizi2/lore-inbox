Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262935AbVD2ULC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262935AbVD2ULC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 16:11:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262923AbVD2UJM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 16:09:12 -0400
Received: from sccrmhc11.comcast.net ([204.127.202.55]:3303 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S262929AbVD2UEF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 16:04:05 -0400
Message-ID: <42729333.4090102@acm.org>
Date: Fri, 29 Apr 2005 15:04:03 -0500
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] Fix IPMI watchdog so the device can be reopened on an unexpected
 close
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------070901090802080806070801"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070901090802080806070801
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



--------------070901090802080806070801
Content-Type: text/x-patch;
 name="ipmi-watchdog-allow-reopen.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ipmi-watchdog-allow-reopen.patch"

If there is an unexpected close, still allow the watchdog
interface to be re-opened on the IPMI watchdog.

Signed-off-by: Corey Minyard <minyard@acm.org>

Index: linux-2.6.10/drivers/char/ipmi/ipmi_watchdog.c
===================================================================
--- linux-2.6.10.orig/drivers/char/ipmi/ipmi_watchdog.c
+++ linux-2.6.10/drivers/char/ipmi/ipmi_watchdog.c
@@ -723,11 +723,11 @@
 		if (expect_close == 42) {
 			ipmi_watchdog_state = WDOG_TIMEOUT_NONE;
 			ipmi_set_timeout(IPMI_SET_TIMEOUT_NO_HB);
-			clear_bit(0, &ipmi_wdog_open);
 		} else {
 			printk(KERN_CRIT PFX "Unexpected close, not stopping watchdog!\n");
 			ipmi_heartbeat();
 		}
+		clear_bit(0, &ipmi_wdog_open);
 	}
 
 	ipmi_fasync (-1, filep, 0);

--------------070901090802080806070801--
