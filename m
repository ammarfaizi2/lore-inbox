Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269068AbUJTTHW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269068AbUJTTHW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 15:07:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268995AbUJTTHP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 15:07:15 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:12457 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S269155AbUJTTG2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 15:06:28 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mmtimer sparse fixes
Date: Wed, 20 Oct 2004 12:06:23 -0700
User-Agent: KMail/1.7
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_vcrdBNJmoyVuFpQ"
Message-Id: <200410201206.23316.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_vcrdBNJmoyVuFpQ
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Small patch to add __iomem annotations to mmtimer.c.

Signed-off-by: Jesse Barnes <jbarnes@sgi.com>

Thanks,
Jesse

--Boundary-00=_vcrdBNJmoyVuFpQ
Content-Type: text/plain;
  charset="us-ascii";
  name="sparse-mmtimer-fixes.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="sparse-mmtimer-fixes.patch"

===== drivers/char/mmtimer.c 1.4 vs edited =====
--- 1.4/drivers/char/mmtimer.c	2004-10-11 13:04:12 -07:00
+++ edited/drivers/char/mmtimer.c	2004-10-20 10:33:00 -07:00
@@ -101,13 +101,13 @@
 		break;
 
 	case MMTIMER_GETRES: /* resolution of the clock in 10^-15 s */
-		if(copy_to_user((unsigned long *)arg, &mmtimer_femtoperiod,
-				sizeof(unsigned long)))
+		if(copy_to_user((unsigned long __user *)arg,
+				&mmtimer_femtoperiod, sizeof(unsigned long)))
 			return -EFAULT;
 		break;
 
 	case MMTIMER_GETFREQ: /* frequency in Hz */
-		if(copy_to_user((unsigned long *)arg,
+		if(copy_to_user((unsigned long __user *)arg,
 				&sn_rtc_cycles_per_second,
 				sizeof(unsigned long)))
 			return -EFAULT;
@@ -123,8 +123,8 @@
 		break;
 
 	case MMTIMER_GETCOUNTER:
-		if(copy_to_user((unsigned long *)arg, RTC_COUNTER_ADDR,
-				sizeof(unsigned long)))
+		if(copy_to_user((unsigned long __user *)arg,
+				RTC_COUNTER_ADDR, sizeof(unsigned long)))
 			return -EFAULT;
 		break;
 	default:

--Boundary-00=_vcrdBNJmoyVuFpQ--
