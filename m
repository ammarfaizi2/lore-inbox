Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292063AbSBOJuB>; Fri, 15 Feb 2002 04:50:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292076AbSBOJtv>; Fri, 15 Feb 2002 04:49:51 -0500
Received: from mail.sonytel.be ([193.74.243.200]:22254 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S292063AbSBOJtl>;
	Fri, 15 Feb 2002 04:49:41 -0500
Date: Fri, 15 Feb 2002 10:48:32 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>, Dave Jones <davej@suse.de>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
        Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>,
        Timothy Ball <timball@tux.org>
Subject: [PATCH] fbdev do {} while (0);
Message-ID: <Pine.GSO.4.21.0202151027420.24874-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi Linus, Marcelo, and Dave,

`do { ... } while(0)' does not need the trailing semicolon and may lead to
strange side effects. The following patch (by Timothy Ball <timball@tux.org>)
fixes it in the following files:
  - drivers/video/chipsfb.c
  - drivers/video/fbcon-cfb24.c
  - drivers/video/virgefb.c

The patch applies to 2.4.18-rc1 and 2.5.4-dj1 as well.

diff -urN linux-2.5.5-pre1/drivers/video/chipsfb.c do-while-2.5.5-pre1/drivers/video/chipsfb.c
--- linux-2.5.5-pre1/drivers/video/chipsfb.c	Tue Jan 29 10:14:21 2002
+++ do-while-2.5.5-pre1/drivers/video/chipsfb.c	Fri Feb 15 10:26:35 2002
@@ -79,7 +79,7 @@
 } while (0)
 #define read_ind(num, var, ap, dp)	do { \
 	outb((num), (ap)); var = inb((dp)); \
-} while (0);
+} while (0)
 
 /* extension registers */
 #define write_xr(num, val)	write_ind(num, val, 0x3d6, 0x3d7)
diff -urN linux-2.5.5-pre1/drivers/video/fbcon-cfb24.c do-while-2.5.5-pre1/drivers/video/fbcon-cfb24.c
--- linux-2.5.5-pre1/drivers/video/fbcon-cfb24.c	Tue Oct  2 11:47:45 2001
+++ do-while-2.5.5-pre1/drivers/video/fbcon-cfb24.c	Fri Feb 15 10:25:23 2002
@@ -76,14 +76,14 @@
 	out1 = (in1<<8)  | (in2>>16); \
 	out2 = (in2<<16) | (in3>>8); \
 	out3 = (in3<<24) | in4; \
-    } while (0);
+    } while (0)
 #elif defined(__LITTLE_ENDIAN)
 #define convert4to3(in1, in2, in3, in4, out1, out2, out3) \
     do { \
 	out1 = in1       | (in2<<24); \
 	out2 = (in2>> 8) | (in3<<16); \
 	out3 = (in3>>16) | (in4<< 8); \
-    } while (0);
+    } while (0)
 #else
 #error FIXME: No endianness??
 #endif
diff -urN linux-2.5.5-pre1/drivers/video/virgefb.c do-while-2.5.5-pre1/drivers/video/virgefb.c
--- linux-2.5.5-pre1/drivers/video/virgefb.c	Tue Jan 29 10:14:27 2002
+++ do-while-2.5.5-pre1/drivers/video/virgefb.c	Fri Feb 15 10:30:04 2002
@@ -670,12 +670,9 @@
  */
 
 #define Cyber3D_WaitQueue(v) \
-{ \
 	 do { \
 		while ((rl_3d(0x8504) & 0x1f00) < (((v)+2) << 8)); \
-	 } \
-	while (0); \
-}
+	 } while (0)
 
 static inline void Cyber3D_WaitBusy(void)
 {

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

