Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964865AbWACXYS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964865AbWACXYS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 18:24:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964871AbWACXYS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 18:24:18 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:62167 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S964865AbWACXYR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 18:24:17 -0500
Message-ID: <43BB078F.2060304@watson.ibm.com>
Date: Tue, 03 Jan 2006 23:23:59 +0000
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Shailabh Nagar <nagar@watson.ibm.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       elsa-devel <elsa-devel@lists.sourceforge.net>,
       LSE <lse-tech@lists.sourceforge.net>,
       ckrm-tech <ckrm-tech@lists.sourceforge.net>
Subject: [Patch 1/6] Delay accounting: timespec diff 
References: <43BB05D8.6070101@watson.ibm.com>
In-Reply-To: <43BB05D8.6070101@watson.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

nstimestamp_diff.patch

Add kernel utility function for measuring the
interval (diff) between two timespec values, adjusting for overflow

Signed-off-by: Shailabh Nagar <nagar@watson.ibm.com>

 include/linux/time.h |   15 +++++++++++++++
 1 files changed, 15 insertions(+)

Index: linux-2.6.15-rc7/include/linux/time.h
===================================================================
--- linux-2.6.15-rc7.orig/include/linux/time.h
+++ linux-2.6.15-rc7/include/linux/time.h
@@ -114,6 +114,21 @@ set_normalized_timespec (struct timespec
 	ts->tv_nsec = nsec;
 }

+/*
+ * timespec_diff_ns - Return difference of two timestamps in nanoseconds
+ * In the rare case of @end being earlier than @start, return zero
+ */
+static inline unsigned long long
+timespec_diff_ns(struct timespec *start, struct timespec *end)
+{
+	long long ret;
+
+	ret = end->tv_sec*(1000000000) + end->tv_nsec;
+	ret -= start->tv_sec*(1000000000) + start->tv_nsec;
+	if (ret < 0)
+		return 0;
+	return ret;
+}
 #endif /* __KERNEL__ */

 #define NFDBITS			__NFDBITS
