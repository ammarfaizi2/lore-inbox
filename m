Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267323AbTAVFGH>; Wed, 22 Jan 2003 00:06:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267321AbTAVFGG>; Wed, 22 Jan 2003 00:06:06 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:46084
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S267323AbTAVFGB>; Wed, 22 Jan 2003 00:06:01 -0500
Date: Wed, 22 Jan 2003 00:15:27 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH][2.5][1/18] smp_call_function_on_cpu - generic definitions
Message-ID: <Pine.LNX.4.44.0301220013490.29944-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Index: linux-2.5.59/include/linux/smp.h
===================================================================
RCS file: /build/cvsroot/linux-2.5.59/include/linux/smp.h,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 smp.h
--- linux-2.5.59/include/linux/smp.h	17 Jan 2003 11:15:51 -0000	1.1.1.1
+++ linux-2.5.59/include/linux/smp.h	22 Jan 2003 02:42:26 -0000
@@ -50,8 +50,13 @@
 /*
  * Call a function on all other processors
  */
-extern int smp_call_function (void (*func) (void *info), void *info,
-			      int retry, int wait);
+extern int smp_call_function (void (*func) (void *info), void *info, int wait);
+
+/*
+ * Call a function on a single or group of processors
+ */
+extern int smp_call_function_on_cpu (void (*func) (void *info), void *info,
+					int wait, unsigned long mask);
 
 /*
  * True once the per process idle is forked
@@ -95,7 +100,8 @@
 #define smp_processor_id()			0
 #define hard_smp_processor_id()			0
 #define smp_threads_ready			1
-#define smp_call_function(func,info,retry,wait)	({ 0; })
+#define smp_call_function(func,info,wait)	({ 0; })
+#define smp_call_function_on_cpu(func,info,wait,mask) ({ 0; })
 static inline void smp_send_reschedule(int cpu) { }
 static inline void smp_send_reschedule_all(void) { }
 #define cpu_online_map				1
-- 
function.linuxpower.ca

