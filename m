Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132256AbQLRABw>; Sun, 17 Dec 2000 19:01:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130371AbQLRABd>; Sun, 17 Dec 2000 19:01:33 -0500
Received: from lsmls01.we.mediaone.net ([24.130.1.20]:34017 "EHLO
	lsmls01.we.mediaone.net") by vger.kernel.org with ESMTP
	id <S132256AbQLRABU>; Sun, 17 Dec 2000 19:01:20 -0500
To: linux-kernel@vger.kernel.org
Cc: dyky@df-usa.com
Subject: linux-2.4.0-test13-pre2 has problems on Alpha
X-Mailer: Mew version 1.94.2 on XEmacs 21.1 (Canyonlands)
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
 boundary="--Next_Part(Sun_Dec_17_15:30:39_2000_886)--"
Content-Transfer-Encoding: 7bit
Message-Id: <20001217153040B.dyky@df-usa.com>
Date: Sun, 17 Dec 2000 15:30:40 -0800
From: Daiki Matsuda <dyky@df-usa.com>
X-Dispatcher: imput version 20000414(IM141)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----Next_Part(Sun_Dec_17_15:30:39_2000_886)--
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi, all.

I tested test13-pre2 on Alpha, but it is not compilable. So, I send a
small patch, and in test13-pre3 its problem may not be repaired.

'CONFIG_ALPHA' is used in drivers/pci/Makefile, but it is not defined
in anywhere. So, I added it to arch/alpha/config.in.

I think the point in arch/alpha/math-emu/Makefile small.

Regards
Daiki Matsuda


----Next_Part(Sun_Dec_17_15:30:39_2000_886)--
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="alpha.2.4.0test13-pre2.build.patch"

--- linux/arch/alpha/math-emu/Makefile.old	Sun Dec 17 22:06:10 2000
+++ linux/arch/alpha/math-emu/Makefile	Sun Dec 17 22:04:58 2000
@@ -8,7 +8,7 @@
 # Note 2! The CFLAGS definition is now in the main makefile...
 
 O_TARGET := math-emu.o
-O_OBJS   := math.o qrnnd.o
+obj-y   := math.o qrnnd.o
 CFLAGS += -I. -I$(TOPDIR)/include/math-emu -w
 
 ifeq ($(CONFIG_MATHEMU),m)
--- linux/arch/alpha/config.in.old	Sun Dec 17 22:22:27 2000
+++ linux/arch/alpha/config.in	Sun Dec 17 22:23:38 2000
@@ -24,6 +24,8 @@
 mainmenu_option next_comment
 comment 'General setup'
 
+define_bool CONFIG_ALPHA y
+
 choice 'Alpha system type' \
 	"Generic		CONFIG_ALPHA_GENERIC		\
 	 Alcor/Alpha-XLT	CONFIG_ALPHA_ALCOR		\

----Next_Part(Sun_Dec_17_15:30:39_2000_886)----
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
