Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261391AbSI3XdL>; Mon, 30 Sep 2002 19:33:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261392AbSI3XdL>; Mon, 30 Sep 2002 19:33:11 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:59804 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261391AbSI3XdK>;
	Mon, 30 Sep 2002 19:33:10 -0400
Message-ID: <3D98DFA0.6020908@us.ibm.com>
Date: Mon, 30 Sep 2002 16:34:56 -0700
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel <linux-kernel@vger.kernel.org>
CC: Martin Bligh <mjbligh@us.ibm.com>, Linus Torvalds <torvalds@transmeta.com>
Subject: [patch][rfc] xquad_portio cleanup
Content-Type: multipart/mixed;
 boundary="------------060306060507030306080906"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060306060507030306080906
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Alan, Martin, Linus, and anyone else who cares, ;)

	Here's a patch Martin and I put together a while ago to clean up the 
xquad_portio kludgery that's been floating around for too long.  I think 
this pretty much goes along with what you have in your tree, Alan.  It's 
a small patch, so if no one complains, please apply Linus.


Cheers!

-Matt

--------------060306060507030306080906
Content-Type: text/plain;
 name="xquad_fixup-2539.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="xquad_fixup-2539.patch"

diff -Nur linux-2.5.31-vanilla/arch/i386/boot/compressed/misc.c linux-2.5.31-xquad/arch/i386/boot/compressed/misc.c
--- linux-2.5.31-vanilla/arch/i386/boot/compressed/misc.c	Sat Aug 10 18:41:40 2002
+++ linux-2.5.31-xquad/arch/i386/boot/compressed/misc.c	Thu Aug 15 14:28:33 2002
@@ -9,6 +9,8 @@
  * High loaded stuff by Hans Lermen & Werner Almesberger, Feb. 1996
  */
 
+#define STANDALONE
+
 #include <linux/linkage.h>
 #include <linux/vmalloc.h>
 #include <linux/tty.h>
@@ -120,10 +122,6 @@
 static int vidport;
 static int lines, cols;
 
-#ifdef CONFIG_MULTIQUAD
-static void * xquad_portio = NULL;
-#endif
-
 #include "../../../../lib/inflate.c"
 
 static void *malloc(int size)
diff -Nur linux-2.5.31-vanilla/include/asm-i386/io.h linux-2.5.31-xquad/include/asm-i386/io.h
--- linux-2.5.31-vanilla/include/asm-i386/io.h	Sat Aug 10 18:41:28 2002
+++ linux-2.5.31-xquad/include/asm-i386/io.h	Thu Aug 15 15:17:31 2002
@@ -298,7 +298,11 @@
 #endif
 
 #ifdef CONFIG_MULTIQUAD
-extern void *xquad_portio;    /* Where the IO area was mapped */
+ #ifdef STANDALONE
+  #define xquad_portio 0
+ #else /* !STANDALONE */
+  extern void *xquad_portio;    /* Where the IO area was mapped */
+ #endif /* STANDALONE */
 #endif /* CONFIG_MULTIQUAD */
 
 /*

--------------060306060507030306080906--

