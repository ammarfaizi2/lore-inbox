Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275530AbRJJMC3>; Wed, 10 Oct 2001 08:02:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275552AbRJJMCT>; Wed, 10 Oct 2001 08:02:19 -0400
Received: from [212.56.224.1] ([212.56.224.1]:50111 "EHLO sendar.prophecy.lu")
	by vger.kernel.org with ESMTP id <S275530AbRJJMCG>;
	Wed, 10 Oct 2001 08:02:06 -0400
Message-ID: <3BC439AB.B9B83B65@linux.lu>
Date: Wed, 10 Oct 2001 14:06:03 +0200
From: Thierry Coutelier <Thierry.Coutelier@linux.lu>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.10 i686)
X-Accept-Language: en, fr, de
MIME-Version: 1.0
To: lartc@mailman.ds9a.nl, linux-kernel@vger.kernel.org
CC: Kuznet@Ms2.Inr.Ac.Ru
Subject: Kernel patch for cls_u32.c 
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

To solve a problem while listing filters you may add this patch.
It works for all kernel versions from  2.4.6 to 2.4.11
It wold be cool to have it in the next kernel release.

---
diff -ur 2.4.6/linux/net/sched/cls_u32.c linux/net/sched/cls_u32.c
--- 2.4.6/linux/net/sched/cls_u32.c Thu Feb  1 23:06:10 2001
+++ linux/net/sched/cls_u32.c Wed Jul 11 23:55:23 2001
@@ -613,7 +613,8 @@

  for (ht = tp_c->hlist; ht; ht = ht->next) {
   if (arg->count >= arg->skip) {
-   if (arg->fn(tp, (unsigned long)ht, arg) < 0) {
+   if (ht == tp->root &&
+       arg->fn(tp, (unsigned long)ht, arg) < 0) {
     arg->stop = 1;
     return;
    }
@@ -625,7 +626,8 @@
      arg->count++;
      continue;
     }
-    if (arg->fn(tp, (unsigned long)n, arg) < 0) {
+    if (ht == tp->root &&
+        arg->fn(tp, (unsigned long)n, arg) < 0) {
      arg->stop = 1;
      return;
     }

---

Thierry.Coutelier@linux.lu
http://www.linux.lu

