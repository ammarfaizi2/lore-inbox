Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136863AbREJR3n>; Thu, 10 May 2001 13:29:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136864AbREJR3e>; Thu, 10 May 2001 13:29:34 -0400
Received: from serenity.mcc.ac.uk ([130.88.200.93]:6671 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S136863AbREJR3V>; Thu, 10 May 2001 13:29:21 -0400
Date: Thu, 10 May 2001 18:29:18 +0100 (BST)
From: John Levon <moz@compsoc.man.ac.uk>
To: linux-kernel@vger.kernel.org, alan@redhat.com
Subject: [PATCH] Small kernel-api addition
Message-ID: <Pine.LNX.4.21.0105101826290.11103-100000@mrbusy.compsoc.man.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Clean against 2.4.4-ac6 and 2.4.4

thanks
john


--- Documentation/DocBook/kernel-api.tmpl.old	Thu May 10 18:02:05 2001
+++ Documentation/DocBook/kernel-api.tmpl	Thu May 10 18:02:57 2001
@@ -41,8 +41,9 @@
 !Iinclude/linux/init.h
      </sect1>
 
-     <sect1><title>Atomics</title>
+     <sect1><title>Atomic and pointer manipulation</title>
 !Iinclude/asm-i386/atomic.h
+!Iinclude/asm-i386/unaligned.h
      </sect1>
 
      <sect1><title>Delaying, scheduling, and timer routines</title>
--- include/asm-i386/unaligned.h.old	Thu May 10 17:54:28 2001
+++ include/asm-i386/unaligned.h	Thu May 10 18:29:11 2001
@@ -9,8 +9,29 @@
  * architectures where unaligned accesses aren't as simple.
  */
 
+/**
+ * get_unaligned - get value from possibly mis-aligned location
+ * @ptr: pointer to value
+ *
+ * This macro should be used for accessing values larger in size than single
+ * bytes at locations that may be improperly aligned, e.g. retrieving a u16
+ * value from a location not u16-aligned.
+ *
+ * Note that unaligned accesses can be very expensive on some architectures.
+ */
 #define get_unaligned(ptr) (*(ptr))
 
+/**
+ * put_unaligned - put value to a possibly mis-aligned location
+ * @val: value to place
+ * @ptr: pointer to location
+ *
+ * This macro should be used for placing values larger in size than single
+ * bytes at locations that may be improperly aligned, e.g. write a u16
+ * value to a location not u16-aligned.
+ *
+ * Note that unaligned accesses can be very expensive on some architectures.
+ */
 #define put_unaligned(val, ptr) ((void)( *(ptr) = (val) ))
 
 #endif

