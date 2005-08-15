Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964876AbVHOSGU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964876AbVHOSGU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 14:06:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964878AbVHOSGU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 14:06:20 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:47798 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964876AbVHOSGT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 14:06:19 -0400
Date: Mon, 15 Aug 2005 11:06:17 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [-mm PATCH 1/32] include: update jiffies/{m,u}secs conversion functions
Message-ID: <20050815180617.GD2854@us.ibm.com>
References: <20050815180514.GC2854@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050815180514.GC2854@us.ibm.com>
X-Operating-System: Linux 2.6.12 (i686)
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Description: Clarify the human-time units to jiffies conversion
functions by using the constants in time.h. This makes many of the
subsequent patches direct copies of the current code.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

---

 include/linux/jiffies.h |   40 ++++++++++++++++++++--------------------
 include/linux/time.h    |    4 ++++
 2 files changed, 24 insertions(+), 20 deletions(-)

--- 2.6.13-rc5-mm1/include/linux/time.h	2005-03-01 23:38:12.000000000 -0800
+++ 2.6.13-rc5-mm1-dev/include/linux/time.h	2005-08-14 12:53:17.000000000 -0700
@@ -28,6 +28,10 @@ struct timezone {
 #ifdef __KERNEL__
 
 /* Parameters used to convert the timespec values */
+#ifndef MSEC_PER_SEC
+#define MSEC_PER_SEC (1000L)
+#endif
+
 #ifndef USEC_PER_SEC
 #define USEC_PER_SEC (1000000L)
 #endif
diff -urpN 2.6.13-rc5-mm1/include/linux/jiffies.h 2.6.13-rc5-mm1-dev/include/linux/jiffies.h
--- 2.6.13-rc5-mm1/include/linux/jiffies.h	2005-03-01 23:37:31.000000000 -0800
+++ 2.6.13-rc5-mm1-dev/include/linux/jiffies.h	2005-08-10 23:31:04.000000000 -0700
@@ -254,23 +254,23 @@ static inline u64 get_jiffies_64(void)
  */
 static inline unsigned int jiffies_to_msecs(const unsigned long j)
 {
-#if HZ <= 1000 && !(1000 % HZ)
-	return (1000 / HZ) * j;
-#elif HZ > 1000 && !(HZ % 1000)
-	return (j + (HZ / 1000) - 1)/(HZ / 1000);
+#if HZ <= MSEC_PER_SEC && !(MSEC_PER_SEC % HZ)
+	return (MSEC_PER_SEC / HZ) * j;
+#elif HZ > MSEC_PER_SEC && !(HZ % MSEC_PER_SEC)
+	return (j + (HZ / MSEC_PER_SEC) - 1)/(HZ / MSEC_PER_SEC);
 #else
-	return (j * 1000) / HZ;
+	return (j * MSEC_PER_SEC) / HZ;
 #endif
 }
 
 static inline unsigned int jiffies_to_usecs(const unsigned long j)
 {
-#if HZ <= 1000000 && !(1000000 % HZ)
-	return (1000000 / HZ) * j;
-#elif HZ > 1000000 && !(HZ % 1000000)
-	return (j + (HZ / 1000000) - 1)/(HZ / 1000000);
+#if HZ <= USEC_PER_SEC && !(USEC_PER_SEC % HZ)
+	return (USEC_PER_SEC / HZ) * j;
+#elif HZ > USEC_PER_SEC && !(HZ % USEC_PER_SEC)
+	return (j + (HZ / USEC_PER_SEC) - 1)/(HZ / USEC_PER_SEC);
 #else
-	return (j * 1000000) / HZ;
+	return (j * USEC_PER_SEC) / HZ;
 #endif
 }
 
@@ -278,12 +278,12 @@ static inline unsigned long msecs_to_jif
 {
 	if (m > jiffies_to_msecs(MAX_JIFFY_OFFSET))
 		return MAX_JIFFY_OFFSET;
-#if HZ <= 1000 && !(1000 % HZ)
-	return (m + (1000 / HZ) - 1) / (1000 / HZ);
-#elif HZ > 1000 && !(HZ % 1000)
-	return m * (HZ / 1000);
+#if HZ <= MSEC_PER_SEC && !(MSEC_PER_SEC % HZ)
+	return (m + (MSEC_PER_SEC / HZ) - 1) / (MSEC_PER_SEC / HZ);
+#elif HZ > MSEC_PER_SEC && !(HZ % MSEC_PER_SEC)
+	return m * (HZ / MSEC_PER_SEC);
 #else
-	return (m * HZ + 999) / 1000;
+	return (m * HZ + MSEC_PER_SEC - 1) / MSEC_PER_SEC;
 #endif
 }
 
@@ -291,12 +291,12 @@ static inline unsigned long usecs_to_jif
 {
 	if (u > jiffies_to_usecs(MAX_JIFFY_OFFSET))
 		return MAX_JIFFY_OFFSET;
-#if HZ <= 1000000 && !(1000000 % HZ)
-	return (u + (1000000 / HZ) - 1) / (1000000 / HZ);
-#elif HZ > 1000000 && !(HZ % 1000000)
-	return u * (HZ / 1000000);
+#if HZ <= USEC_PER_SEC && !(USEC_PER_SEC % HZ)
+	return (u + (USEC_PER_SEC / HZ) - 1) / (USEC_PER_SEC / HZ);
+#elif HZ > USEC_PER_SEC && !(HZ % USEC_PER_SEC)
+	return u * (HZ / USEC_PER_SEC);
 #else
-	return (u * HZ + 999999) / 1000000;
+	return (u * HZ + USEC_PER_SEC - 1) / USEC_PER_SEC;
 #endif
 }
 
