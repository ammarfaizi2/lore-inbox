Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265811AbUA1B6a (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 20:58:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265808AbUA1Bzw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 20:55:52 -0500
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:11702 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S265803AbUA1BzP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 20:55:15 -0500
Date: Wed, 28 Jan 2004 10:54:42 +0900
From: Hironobu Ishii <ishii.hironobu@jp.fujitsu.com>
Subject: [RFC/PATCH, 3/4] readX_check() performance evaluation
To: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-ia64 <linux-ia64@vger.kernel.org>
Message-id: <00a401c3e541$c1d347f0$2987110a@lsd.css.fujitsu.com>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
Content-type: text/plain;	charset="iso-8859-1"
Content-transfer-encoding: 7bit
X-Priority: 3
X-MSMail-priority: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a patch for rawread 1.0.3.
Original rawread 1.0.3 depends on i386.

Thanks, 
Hironobu Ishii

--- rawread.c.old 2004-01-22 19:33:43.000000000 +0900
+++ rawread.c 2004-01-27 23:26:24.406717936 +0900
@@ -94,8 +94,14 @@
 
 __inline__ unsigned long long int rdtsc()
 {
-  unsigned long long int x;
-  __asm__ volatile (".byte 0x0f, 0x31" : "=A" (x));
+ unsigned long long int x;
+#if __i386__
+ __asm__ volatile (".byte 0x0f, 0x31" : "=A" (x));
+#elif __ia64__
+ __asm__ volatile ("mov r8 = ar44");
+#else
+ #error "Please write your own rdtsc()"
+#endif
   return x;
 }
 

