Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751663AbWB0ICu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751663AbWB0ICu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 03:02:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751670AbWB0ICu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 03:02:50 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:8601 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751663AbWB0ICt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 03:02:49 -0500
Subject: [Patch 1/7] timespec diff utility
From: Shailabh Nagar <nagar@watson.ibm.com>
Reply-To: nagar@watson.ibm.com
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: lse-tech <lse-tech@lists.sourceforge.net>
In-Reply-To: <1141026996.5785.38.camel@elinux04.optonline.net>
References: <1141026996.5785.38.camel@elinux04.optonline.net>
Content-Type: text/plain
Organization: IBM
Message-Id: <1141027367.5785.42.camel@elinux04.optonline.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 27 Feb 2006 03:02:47 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

nstimestamp_diff.patch

Add kernel utility function for measuring the
interval (diff) between two timespec values, adjusting for overflow

Signed-off-by: Shailabh Nagar <nagar@watson.ibm.com>

 include/linux/time.h |   14 ++++++++++++++
 1 files changed, 14 insertions(+)

Index: linux-2.6.16-rc4/include/linux/time.h
===================================================================
--- linux-2.6.16-rc4.orig/include/linux/time.h	2006-02-27 01:20:04.000000000 -0500
+++ linux-2.6.16-rc4/include/linux/time.h	2006-02-27 01:52:49.000000000 -0500
@@ -147,6 +147,20 @@ extern struct timespec ns_to_timespec(co
  */
 extern struct timeval ns_to_timeval(const nsec_t nsec);
 
+/*
+ * timespec_diff_ns - Return difference of two timestamps in nanoseconds
+ * In the rare case of @end being earlier than @start, return zero
+ */
+static inline nsec_t timespec_diff_ns(struct timespec *start, struct timespec *end)
+{
+	nsec_t ret;
+
+	ret = (nsec_t)(end->tv_sec - start->tv_sec)*NSEC_PER_SEC;
+	ret += (nsec_t)(end->tv_nsec - start->tv_nsec);
+	if (ret < 0)
+ 		return 0;
+	return ret;
+}
 #endif /* __KERNEL__ */
 
 #define NFDBITS			__NFDBITS


