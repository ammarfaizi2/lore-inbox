Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313120AbSEPOpS>; Thu, 16 May 2002 10:45:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313128AbSEPOpR>; Thu, 16 May 2002 10:45:17 -0400
Received: from charentes.fr.clara.net ([212.43.194.76]:56332 "EHLO
	charentes.fr.clara.net") by vger.kernel.org with ESMTP
	id <S313120AbSEPOpP>; Thu, 16 May 2002 10:45:15 -0400
Message-ID: <3CE3E19F.5000800@msg-software.com>
Date: Thu, 16 May 2002 16:43:11 +0000
From: Rolland Dudemaine <rolland.dudemaine@msg-software.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc1) Gecko/20020417
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: mj@ucw.cz, linux-kernel@vger.kernel.org
Subject: boot logo size patch
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

For a *long* time, the boot logo has stayed in the kernel at many 
places. Recently, it has been cleaned up to reduce the number of 
identical logos. Along with the logo data, the LINUX_LOGO_COLORS have 
been moved to each linux_logo.h file.
However, the image size still remains in fbcon.c . It's too bad that 
this is not separated in each linux_logo.h file, because that would 
allow easy logo changing... (and having patched it a couple of times, I 
know it IS working with other sizes than 80x80).

What I am proposing in this patch is moving LOGO_H and LOGO_W to each 
linux_logo.h file. Here we go :

diff -urN linux.unpatched/drivers/video/fbcon.c linux/drivers/video/fbcon.c
--- linux.unpatched/drivers/video/fbcon.c    Wed May 15 10:23:15 2002
+++ linux/drivers/video/fbcon.c    Wed May 15 15:09:49 2002
@@ -110,8 +110,6 @@
#  define DPRINTK(fmt, args...)
#endif

-#define LOGO_H            80
-#define LOGO_W            80
#define LOGO_LINE    (LOGO_W/8)

struct display fb_display[MAX_NR_CONSOLES];
diff -urN linux.unpatched/include/asm-m68k/linux_logo.h 
linux/include/asm-m68k/linux_logo.h
--- linux.unpatched/include/asm-m68k/linux_logo.h    Tue Jun 12 17:39:50 
2001
+++ linux/include/asm-m68k/linux_logo.h    Wed May 15 15:13:16 2002
@@ -30,6 +30,9 @@

#define LINUX_LOGO_COLORS    185

+#define LOGO_H            80
+#define LOGO_W            80
+
#ifdef INCLUDE_LINUX_LOGO_DATA

unsigned char linux_logo_red[] __initdata = {
diff -urN linux.unpatched/include/asm-mips64/linux_logo.h 
linux/include/asm-mips64/linux_logo.h
--- linux.unpatched/include/asm-mips64/linux_logo.h    Sun Sep  9 
17:43:02 2001
+++ linux/include/asm-mips64/linux_logo.h    Wed May 15 15:09:49 2002
@@ -27,6 +27,9 @@

#define LINUX_LOGO_COLORS    187

+#define LOGO_H            80
+#define LOGO_W            80
+
#ifdef INCLUDE_LINUX_LOGO_DATA

unsigned char linux_logo_red[] __initdata = {
diff -urN linux.unpatched/include/asm-ppc/linux_logo.h 
linux/include/asm-ppc/linux_logo.h
--- linux.unpatched/include/asm-ppc/linux_logo.h    Tue Jun 12 02:15:27 
2001
+++ linux/include/asm-ppc/linux_logo.h    Wed May 15 15:09:49 2002
@@ -19,9 +19,6 @@

#define linux_logo_banner "Linux/PPC version " UTS_RELEASE

-#define LINUX_LOGO_HEIGHT    80
-#define LINUX_LOGO_WIDTH    80
-
#include <linux/linux_logo.h>

#endif /* __KERNEL__ */
diff -urN linux.unpatched/include/asm-ppc64/linux_logo.h 
linux/include/asm-ppc64/linux_logo.h
--- linux.unpatched/include/asm-ppc64/linux_logo.h    Tue May  7 
11:30:04 2002
+++ linux/include/asm-ppc64/linux_logo.h    Wed May 15 15:09:49 2002
@@ -20,7 +20,4 @@

#define linux_logo_banner "Linux/PPC-64 version " UTS_RELEASE

-#define LINUX_LOGO_HEIGHT    80
-#define LINUX_LOGO_WIDTH    80
-
#include <linux/linux_logo.h>
diff -urN linux.unpatched/include/asm-sh/linux_logo.h 
linux/include/asm-sh/linux_logo.h
--- linux.unpatched/include/asm-sh/linux_logo.h    Sat Sep  8 19:29:09 2001
+++ linux/include/asm-sh/linux_logo.h    Wed May 15 15:09:49 2002
@@ -30,6 +30,9 @@

#define LINUX_LOGO_COLORS       160

+#define LOGO_H            80
+#define LOGO_W            80
+
#ifdef INCLUDE_LINUX_LOGO_DATA

unsigned char linux_logo_red[] __initdata = {
diff -urN linux.unpatched/include/asm-sparc/linux_logo.h 
linux/include/asm-sparc/linux_logo.h
--- linux.unpatched/include/asm-sparc/linux_logo.h    Tue Jun 12 
18:08:46 2001
+++ linux/include/asm-sparc/linux_logo.h    Wed May 15 15:09:49 2002
@@ -28,6 +28,9 @@

#define LINUX_LOGO_COLORS    221

+#define LOGO_H            80
+#define LOGO_W            80
+
#ifdef INCLUDE_LINUX_LOGO_DATA

unsigned char linux_logo_red[] __initdata = {
diff -urN linux.unpatched/include/asm-sparc64/linux_logo.h 
linux/include/asm-sparc64/linux_logo.h
--- linux.unpatched/include/asm-sparc64/linux_logo.h    Tue Jun 12 
18:08:46 2001
+++ linux/include/asm-sparc64/linux_logo.h    Wed May 15 15:09:49 2002
@@ -28,6 +28,9 @@

#define LINUX_LOGO_COLORS    221

+#define LOGO_H            80
+#define LOGO_W            80
+
#ifdef INCLUDE_LINUX_LOGO_DATA

unsigned char linux_logo_red[] __initdata = {
diff -urN linux.unpatched/include/linux/linux_logo.h 
linux/include/linux/linux_logo.h
--- linux.unpatched/include/linux/linux_logo.h    Wed May 15 15:40:58 2002
+++ linux/include/linux/linux_logo.h    Wed May 15 15:12:25 2002
@@ -20,6 +20,9 @@

#ifndef __HAVE_ARCH_LINUX_LOGO
#define LINUX_LOGO_COLORS    187
+
+#define LOGO_H            80
+#define LOGO_W            80
#endif

#ifdef INCLUDE_LINUX_LOGO_DATA

As you can see, this also removes LINUX_LOGO_HEIGHT and LINUX_LOGO_WIDTH 
from ppc config.

Hope this has come to the right man, and will be the beginning to my 
small contribution to the linux kernel...

Best regards,
Rolland Dudemaine

