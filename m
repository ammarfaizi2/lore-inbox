Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317023AbSIANvc>; Sun, 1 Sep 2002 09:51:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317024AbSIANvc>; Sun, 1 Sep 2002 09:51:32 -0400
Received: from netfinity.realnet.co.sz ([196.28.7.2]:35717 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S317023AbSIANva>; Sun, 1 Sep 2002 09:51:30 -0400
Date: Sun, 1 Sep 2002 16:12:39 +0200 (SAST)
From: Zwane Mwaikambo <zwane@mwaikambo.name>
X-X-Sender: zwane@linux-box.realnet.co.sz
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH][2.4.20-ac] check kmalloc return in sis_ds.c
Message-ID: <Pine.LNX.4.44.0209011611280.26729-100000@linux-box.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,
	Diffed against 2.5.33 but applies clean to 2.4.20-pre4-ac1, i 
presumed there would be no point in sending this for 2.5 seeing as that 
isn't as current as whats in your tree.

	Zwane

Index: linux-2.5.33/drivers/char/drm/sis_ds.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.33/drivers/char/drm/sis_ds.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 sis_ds.c
--- linux-2.5.33/drivers/char/drm/sis_ds.c	31 Aug 2002 22:30:31 -0000	1.1.1.1
+++ linux-2.5.33/drivers/char/drm/sis_ds.c	1 Sep 2002 11:25:53 -0000
@@ -50,15 +50,16 @@
   set_t *set;
 
   set = (set_t *)MALLOC(sizeof(set_t));
-  for(i = 0; i < SET_SIZE; i++){
-    set->list[i].free_next = i+1;    
-    set->list[i].alloc_next = -1;
-  }    
-  set->list[SET_SIZE-1].free_next = -1;
-  set->free = 0;
-  set->alloc = -1;
-  set->trace = -1;
-  
+  if (set) {
+    for(i = 0; i < SET_SIZE; i++){
+      set->list[i].free_next = i+1;    
+      set->list[i].alloc_next = -1;
+    }    
+    set->list[SET_SIZE-1].free_next = -1;
+    set->free = 0;
+    set->alloc = -1;
+    set->trace = -1;
+  }
   return set;
 }
 
@@ -172,7 +173,8 @@
 {
   void *addr;
   addr = kmalloc(nmemb*size, GFP_KERNEL);
-  memset(addr, 0, nmemb*size);
+  if (addr)
+    memset(addr, 0, nmemb*size);
   return addr;
 }
 #define free(n) kfree(n)

-- 
function.linuxpower.ca

