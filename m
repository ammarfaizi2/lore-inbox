Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751622AbWCNAmV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751622AbWCNAmV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 19:42:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751731AbWCNAmV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 19:42:21 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:58330 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751622AbWCNAmU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 19:42:20 -0500
Subject: [Patch 1/9] timestamp diff
From: Shailabh Nagar <nagar@watson.ibm.com>
Reply-To: nagar@watson.ibm.com
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Arjan van de Ven <arjan@infradead.org>
In-Reply-To: <1142296834.5858.3.camel@elinux04.optonline.net>
References: <1142296834.5858.3.camel@elinux04.optonline.net>
Content-Type: text/plain
Organization: IBM
Message-Id: <1142296939.5858.6.camel@elinux04.optonline.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 13 Mar 2006 19:42:19 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

nstimestamp_diff.patch

Add kernel utility function for measuring the
interval (diff) between two timespec values

Comments addressed (commenter)

- returns difference as timespec instead of nsecs (Arjan)

Signed-off-by: Balbir Singh <balbir@in.ibm.com>
Signed-off-by: Shailabh Nagar <nagar@us.ibm.com>


 include/linux/time.h |   14 ++++++++++++++
 1 files changed, 14 insertions(+)

Index: linux-2.6.16-rc5/include/linux/time.h
===================================================================
--- linux-2.6.16-rc5.orig/include/linux/time.h	2006-03-10 17:56:56.000000000 -0500
+++ linux-2.6.16-rc5/include/linux/time.h	2006-03-10 17:57:26.000000000 -0500
@@ -147,6 +147,20 @@ extern struct timespec ns_to_timespec(co
  */
 extern struct timeval ns_to_timeval(const nsec_t nsec);
 
+/**
+ * timespec_diff - Return difference of timespecs as a timespec
+ * @start:	first timespec
+ * @end:	second timespec
+ * @ret:	result timespec
+ *
+ * Returns the difference between @start and @end in @ret
+ */
+static inline void timespec_diff(struct timespec *start, struct timespec *end,
+				 struct timespec *ret)
+{
+	ret->tv_sec = end->tv_sec - start->tv_sec;
+	ret->tv_nsec = end->tv_nsec - start->tv_nsec;
+}
 #endif /* __KERNEL__ */
 
 #define NFDBITS			__NFDBITS


