Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316753AbSGZEKb>; Fri, 26 Jul 2002 00:10:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316757AbSGZEKb>; Fri, 26 Jul 2002 00:10:31 -0400
Received: from zok.SGI.COM ([204.94.215.101]:36527 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S316753AbSGZEKb>;
	Fri, 26 Jul 2002 00:10:31 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: jsimmons@heisenberg.transvirtual.com
Cc: linux-kernel@vger.kernel.org
Subject: [patch] 2.5.28 Correct drivers/video aty build inconsistency
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 26 Jul 2002 14:13:37 +1000
Message-ID: <8505.1027656817@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Detected by kbuild 2.5.

pp_makefile4:
Warning: drivers/video/cfbimgblt.o is a sub-object and it appears on select().
         This is an ambiguous combination and is not recommended.

CONFIG_FB_NEOMAGIC=m, CONFIG_FB_ATY=y builds cfbimgblt as a module then
links it into vmlinux via atyfb.

Index: 28.1/drivers/video/aty/Makefile
--- 28.1/drivers/video/aty/Makefile Fri, 26 Jul 2002 10:10:31 +1000 kaos (linux-2.5/u/b/12_Makefile 1.3 444)
+++ 28.1(w)/drivers/video/aty/Makefile Fri, 26 Jul 2002 14:07:55 +1000 kaos (linux-2.5/u/b/12_Makefile 1.3 444)
@@ -3,7 +3,7 @@ export-objs    :=  atyfb_base.o mach64_a
 
 obj-$(CONFIG_FB_ATY) += atyfb.o
 
-atyfb-y				:= atyfb_base.o mach64_accel.o ../cfbimgblt.o
+atyfb-y				:= atyfb_base.o mach64_accel.o
 atyfb-$(CONFIG_FB_ATY_GX)	+= mach64_gx.o
 atyfb-$(CONFIG_FB_ATY_CT)	+= mach64_ct.o mach64_cursor.o
 atyfb-objs			:= $(atyfb-y)
Index: 28.1/drivers/video/Makefile
--- 28.1/drivers/video/Makefile Fri, 26 Jul 2002 10:10:31 +1000 kaos (linux-2.5/x/b/16_Makefile 1.12 444)
+++ 28.1(w)/drivers/video/Makefile Fri, 26 Jul 2002 14:08:51 +1000 kaos (linux-2.5/x/b/16_Makefile 1.12 444)
@@ -89,7 +89,7 @@ obj-$(CONFIG_FB_TX3912)           += tx3
 obj-$(CONFIG_FB_MATROX)		  += matrox/
 obj-$(CONFIG_FB_RIVA)		  += riva/
 obj-$(CONFIG_FB_SIS)		  += sis/
-obj-$(CONFIG_FB_ATY)		  += aty/
+obj-$(CONFIG_FB_ATY)		  += aty/ cfbimgblt.o
 
 obj-$(CONFIG_FB_SUN3)             += sun3fb.o
 obj-$(CONFIG_FB_BWTWO)            += bwtwofb.o

