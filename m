Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272695AbTHKOAK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 10:00:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272606AbTHKNnU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 09:43:20 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:30347 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S272605AbTHKNk4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 09:40:56 -0400
To: torvalds@transmeta.com
From: davej@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] winchip3d can use same -march as winchip2
Message-Id: <E19mCuO-0003d9-00@tetrachloride>
Date: Mon, 11 Aug 2003 14:40:24 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/arch/i386/Makefile linux-2.5/arch/i386/Makefile
--- bk-linus/arch/i386/Makefile	2003-08-04 01:00:17.000000000 +0100
+++ linux-2.5/arch/i386/Makefile	2003-08-06 18:59:24.000000000 +0100
@@ -38,12 +38,14 @@ cflags-$(CONFIG_MPENTIUMII)	+= $(call ch
 cflags-$(CONFIG_MPENTIUMIII)	+= $(call check_gcc,-march=pentium3,-march=i686)
 cflags-$(CONFIG_MPENTIUM4)	+= $(call check_gcc,-march=pentium4,-march=i686)
 cflags-$(CONFIG_MK6)		+= $(call check_gcc,-march=k6,-march=i586)
+# Please note, that patches that add -march=athlon-xp and friends are pointless.
+# They make zero difference whatsosever to performance at this time.
 cflags-$(CONFIG_MK7)		+= $(call check_gcc,-march=athlon,-march=i686 $(align)-functions=4)
 cflags-$(CONFIG_MK8)		+= $(call check_gcc,-march=k8,$(call check_gcc,-march=athlon,-march=i686 $(align)-functions=4))
 cflags-$(CONFIG_MCRUSOE)	+= -march=i686 $(align)-functions=0 $(align)-jumps=0 $(align)-loops=0
 cflags-$(CONFIG_MWINCHIPC6)	+= $(call check_gcc,-march=winchip-c6,-march=i586)
 cflags-$(CONFIG_MWINCHIP2)	+= $(call check_gcc,-march=winchip2,-march=i586)
-cflags-$(CONFIG_MWINCHIP3D)	+= -march=i586
+cflags-$(CONFIG_MWINCHIP3D)	+= $(call check_gcc,-march=winchip2,-march=i586)
 cflags-$(CONFIG_MCYRIXIII)	+= $(call check_gcc,-march=c3,-march=i486) $(align)-functions=0 $(align)-jumps=0 $(align)-loops=0
 cflags-$(CONFIG_MVIAC3_2)	+= $(call check_gcc,-march=c3-2,-march=i686)
 
