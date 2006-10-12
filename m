Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932490AbWJLGNS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932490AbWJLGNS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 02:13:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932492AbWJLGNS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 02:13:18 -0400
Received: from relay03.pair.com ([209.68.5.17]:16396 "HELO relay03.pair.com")
	by vger.kernel.org with SMTP id S932490AbWJLGNS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 02:13:18 -0400
X-pair-Authenticated: 71.197.50.189
From: Chase Venters <chase.venters@clientec.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix jiffies.h comment
Date: Thu, 12 Oct 2006 01:12:46 -0500
User-Agent: KMail/1.9.4
Organization: Clientec, Inc.
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610120113.09242.chase.venters@clientec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jiffies.h includes a comment informing that jiffies_64 must be read with the 
assistance of the xtime_lock seqlock. The comment text, however, calls 
jiffies_64 "not volatile", which should probably read "not atomic".

Signed-off-by: Chase Venters <chase.venters@clientec.com>

diff --git a/include/linux/jiffies.h b/include/linux/jiffies.h
index c8d5f20..0ec6e28 100644
--- a/include/linux/jiffies.h
+++ b/include/linux/jiffies.h
@@ -74,7 +74,7 @@ #define TICK_USEC_TO_NSEC(TUSEC) (SH_DIV
 #define __jiffy_data  __attribute__((section(".data")))
 
 /*
- * The 64-bit value is not volatile - you MUST NOT read it
+ * The 64-bit value is not atomic - you MUST NOT read it
  * without sampling the sequence number in xtime_lock.
  * get_jiffies_64() will do this for you as appropriate.
  */
