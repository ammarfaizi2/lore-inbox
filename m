Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289172AbSBMXkb>; Wed, 13 Feb 2002 18:40:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289161AbSBMXkV>; Wed, 13 Feb 2002 18:40:21 -0500
Received: from gwyn.tux.org ([207.96.122.8]:59554 "EHLO gwyn.tux.org")
	by vger.kernel.org with ESMTP id <S289172AbSBMXkO>;
	Wed, 13 Feb 2002 18:40:14 -0500
Date: Wed, 13 Feb 2002 18:40:00 -0500
From: Timothy Ball <timball@tux.org>
To: akpm@zip.com.au
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Cleanup drivers/char/console.c
Message-ID: <20020213234000.GA2538@gwyn.tux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.0i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch cleans up the FLUSH macro used in
drivers/char/console.c. I haven't made any deep dark changes... just
added a ";" at the end of the lines where FLUSH is called, cause it
looked pretty wierd w/o it.

--timball

--snip--snip--snip--
--- console.c.orig	Wed Feb 13 18:21:25 2002
+++ console.c	Wed Feb 13 18:35:16 2002
@@ -1830,12 +1830,14 @@
 			const unsigned char *buf, int count)
 {
 #ifdef VT_BUF_VRAM_ONLY
-#define FLUSH do { } while(0);
+#define FLUSH() do { } while(0)
 #else
-#define FLUSH if (draw_x >= 0) { \
-	sw->con_putcs(vc_cons[currcons].d, (u16 *)draw_from, (u16 *)draw_to-(u16 *)draw_from, y, draw_x); \
-	draw_x = -1; \
-	}
+#define FLUSH() do { \
+        if (draw_x >= 0) { \
+        sw->con_putcs(vc_cons[currcons].d, (u16 *)draw_from, (u16 *)draw_to-(u16 *)draw_from, y, draw_x); \
+        draw_x = -1; \
+        } \
+   } while(0)
 #endif
 
 	int c, tc, ok, n = 0, draw_x = -1;
@@ -1975,7 +1977,7 @@
                                 continue; /* Conversion failed */
 
 			if (need_wrap || decim)
-				FLUSH
+				FLUSH();
 			if (need_wrap) {
 				cr(currcons);
 				lf(currcons);
@@ -1999,10 +2001,10 @@
 			}
 			continue;
 		}
-		FLUSH
+		FLUSH();
 		do_con_trol(tty, currcons, c);
 	}
-	FLUSH
+	FLUSH();
 	console_conditional_schedule();
 	release_console_sem();
 
@@ -2024,7 +2026,7 @@
 	}
 
 	return n;
-#undef FLUSH
+#undef FLUSH()
 }
 
 /*

-- 
	GPG key available on pgpkeys.mit.edu
pub  1024D/511FBD54 2001-07-23 Timothy Lu Hu Ball <timball@tux.org>
Key fingerprint = B579 29B0 F6C8 C7AA 3840  E053 FE02 BB97 511F BD54
