Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267491AbTBUPbJ>; Fri, 21 Feb 2003 10:31:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267493AbTBUPbJ>; Fri, 21 Feb 2003 10:31:09 -0500
Received: from d146.dhcp212-198-27.noos.fr ([212.198.27.146]:6619 "EHLO
	deep-space-9.dsnet") by vger.kernel.org with ESMTP
	id <S267491AbTBUPbH>; Fri, 21 Feb 2003 10:31:07 -0500
Date: Fri, 21 Feb 2003 16:41:07 +0100
From: Stelian Pop <stelian@popies.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 2.5.62-bk] use correct gcc flags when compiling for Crusoe
Message-ID: <20030221164107.G12004@deep-space-9.dsnet>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch makes use of 'check_gcc' facility when compiling for
a Crusoe processor in order to choose the correct -falign or -malign
compiler flags.

Linus, Alan, please apply.

Thanks.

Stelian.

===== arch/i386/Makefile 1.45 vs edited =====
--- 1.45/arch/i386/Makefile	Wed Feb 19 03:58:52 2003
+++ edited/arch/i386/Makefile	Wed Feb 19 09:32:40 2003
@@ -39,12 +39,12 @@
 cflags-$(CONFIG_MK6)		+= $(call check_gcc,-march=k6,-march=i586)
 cflags-$(CONFIG_MK7)		+= $(call check_gcc,-march=athlon,-march=i686 -malign-functions=4)
 cflags-$(CONFIG_MK8)		+= $(call check_gcc,-march=k8,$(call check_gcc,-march=athlon,-march=i686 -malign-functions=4))
-cflags-$(CONFIG_MCRUSOE)	+= -march=i686 -malign-functions=0 -malign-jumps=0 -malign-loops=0
+cflags-$(CONFIG_MCRUSOE)	+= -march=i686
+cflags-$(CONFIG_MCRUSOE)	+= $(call check_gcc,-falign-functions=0 -falign-jumps=0 -falign-loops=0,-malign-functions=0 -malign-jumps=0 -malign-loops=0)
 cflags-$(CONFIG_MWINCHIPC6)	+= $(call check_gcc,-march=winchip-c6,-march=i586)
 cflags-$(CONFIG_MWINCHIP2)	+= $(call check_gcc,-march=winchip2,-march=i586)
 cflags-$(CONFIG_MWINCHIP3D)	+= -march=i586
 cflags-$(CONFIG_MCYRIXIII)	+= $(call check_gcc,-march=c3,-march=i486)
-# The alignment flags change with gcc 3.2
 cflags-$(CONFIG_MCYRIXIII)	+= $(call check_gcc,-falign-functions=0 -falign-jumps=0 -falign-loops=0,-malign-functions=0 -malign-jumps=0 -malign-loops=0)
 cflags-$(CONFIG_MVIAC3_2)	+= $(call check_gcc,-march=c3-2,-march=i686)
 
-- 
Stelian Pop <stelian@popies.net>
