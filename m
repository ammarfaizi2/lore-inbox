Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030319AbWCUFOZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030319AbWCUFOZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 00:14:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030322AbWCUFOZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 00:14:25 -0500
Received: from mail03.syd.optusnet.com.au ([211.29.132.184]:52461 "EHLO
	mail03.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1030319AbWCUFOZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 00:14:25 -0500
From: Con Kolivas <kernel@kolivas.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] cleanup smp_call_function UP build
Date: Tue, 21 Mar 2006 16:15:05 +1100
User-Agent: KMail/1.8.3
Cc: Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603211615.05766.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix for compiler warnings on UP builds:
net/core/flow.c: In function 'flow_cache_flush':
net/core/flow.c:299: warning: statement with no effect

Signed-off-by: Con Kolivas <kernel@kolivas.org>

 include/linux/smp.h |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

Index: linux-2.6.16-ck1/include/linux/smp.h
===================================================================
--- linux-2.6.16-ck1.orig/include/linux/smp.h	2006-03-21 15:55:29.000000000 +1100
+++ linux-2.6.16-ck1/include/linux/smp.h	2006-03-21 15:59:09.000000000 +1100
@@ -93,7 +93,11 @@ void smp_prepare_boot_cpu(void);
  */
 #define raw_smp_processor_id()			0
 #define hard_smp_processor_id()			0
-#define smp_call_function(func,info,retry,wait)	({ 0; })
+static inline int up_smp_call_function(void)
+{
+	return 0;
+}
+#define smp_call_function(func,info,retry,wait)	(up_smp_call_function())
 #define on_each_cpu(func,info,retry,wait)	({ func(info); 0; })
 static inline void smp_send_reschedule(int cpu) { }
 #define num_booting_cpus()			1
