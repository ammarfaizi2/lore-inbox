Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130535AbQKYAXW>; Fri, 24 Nov 2000 19:23:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130573AbQKYAXN>; Fri, 24 Nov 2000 19:23:13 -0500
Received: from maile.telia.com ([194.22.190.16]:42251 "EHLO maile.telia.com")
        by vger.kernel.org with ESMTP id <S130535AbQKYAXD>;
        Fri, 24 Nov 2000 19:23:03 -0500
From: Roger Larsson <roger.larsson@norran.net>
Date: Sat, 25 Nov 2000 00:49:57 +0100
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain;
  charset="US-ASCII"
To: Nigel Gamble <nigel@nrg.org>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.05.10011221551330.19078-100000@cosmic.nrg.org>
In-Reply-To: <Pine.LNX.4.05.10011221551330.19078-100000@cosmic.nrg.org>
Subject: [PATCH] Re: [PATCH] Latest preemptible kernel (low latency) patch available
Cc: linux-audio-dev@ginette.musique.umontreal.ca
MIME-Version: 1.0
Message-Id: <00112500495700.06800@dox>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I got compilation errors due to use of START / STOP 
definitions (zlib.c, ppp?)

This little additional patch should fix it. They were not
used in any other place of the patch...

I am still compiling...

/RogerL

--- spinlock.h.preemt	Sat Nov 25 00:31:38 2000
+++ spinlock.h	Sat Nov 25 00:30:50 2000
@@ -47,21 +47,21 @@
 /*
  * Here are the basic preemption lock macros.
  */
-#define START 0
-#define STOP 1
-#define BKL ((((pree)current)->lock_depth) != -1)
+#define PREEMPT_START 0
+#define PREEMPT_STOP 1
+#define PREEMPT_BKL ((((pree)current)->lock_depth) != -1)
 
 #ifdef DEBUG_PREEMPT
 #define debug_lock(t) do {                          \
-                                   if ((in_ctx_sw_off() - (BKL?1:0)) < t) \
+                                   if ((in_ctx_sw_off() - (PREEMPT_BKL?1:0)) 
< t) \
                                       SPIN_BREAKPOINT; \
                                  } while (0) 
 #else
 #define debug_lock(t) do {   } while (0) 
 #endif
 
-#define preempt_lock_start(c) debug_lock(START)
-#define preempt_lock_stop()   debug_lock(STOP)
+#define preempt_lock_start(c) debug_lock(PREEMPT_START)
+#define preempt_lock_stop()   debug_lock(PREEMPT_STOP)
 
 #ifdef CONFIG_PREEMPT
 #include <asm/current.h>

-- 
Home page:
  http://www.norran.net/nra02596/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
