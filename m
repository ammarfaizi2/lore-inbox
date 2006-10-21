Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992997AbWJUM5a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992997AbWJUM5a (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 08:57:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993000AbWJUM5a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 08:57:30 -0400
Received: from mtagate5.uk.ibm.com ([195.212.29.138]:40628 "EHLO
	mtagate5.uk.ibm.com") by vger.kernel.org with ESMTP
	id S2992997AbWJUM53 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 08:57:29 -0400
Subject: [Patch 1/5] I/O statistics through request queues: timeval_to_us()
From: Martin Peschke <mp3@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Sat, 21 Oct 2006 14:57:25 +0200
Message-Id: <1161435445.3054.112.camel@dyn-9-152-230-71.boeblingen.de.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The next patch requires a timeval-to-microseconds conversion.
Introducing a helper function (and fixing a comment).

Signed-off-by: Martin Peschke <mp3@de.ibm.com>
---

 time.h |   14 +++++++++++++-
 1 files changed, 13 insertions(+), 1 deletion(-)

diff -urp a/include/linux/time.h b/include/linux/time.h
--- a/include/linux/time.h	2006-10-03 16:25:53.000000000 +0200
+++ b/include/linux/time.h	2006-10-06 21:36:08.000000000 +0200
@@ -133,8 +133,20 @@ static inline s64 timespec_to_ns(const s
 }
 
 /**
+ * timeval_to_us - Convert timeval to microseconds
+ * @tv:		pointer to the timeval variable to be converted
+ *
+ * Returns the scalar nanosecond representation of the timeval
+ * parameter.
+ */
+static inline s64 timeval_to_us(const struct timeval *tv)
+{
+	return ((s64) tv->tv_sec * USEC_PER_SEC) + tv->tv_usec;
+}
+
+/**
  * timeval_to_ns - Convert timeval to nanoseconds
- * @ts:		pointer to the timeval variable to be converted
+ * @tv:		pointer to the timeval variable to be converted
  *
  * Returns the scalar nanosecond representation of the timeval
  * parameter.


