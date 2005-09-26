Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932387AbVIZFTa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932387AbVIZFTa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 01:19:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932385AbVIZFTa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 01:19:30 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:47060 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932387AbVIZFT3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 01:19:29 -0400
To: torvalds@osdl.org
Subject: [PATCH] m32r: set CHECKFLAGS properly
Cc: linux-kernel@vger.kernel.org, takata@linux-m32r.org
Message-Id: <E1EJlOi-00059w-IJ@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Mon, 26 Sep 2005 06:19:28 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We do _not_ need "sparse" in sparse arguments ;-)
What we do need is __BIG_ENDIAN__; right now unconditional, when m32r starts
using CPU_LITTLE_ENDIAN, we'll need to adjust.
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
----
diff -urN RC14-rc2-git5-rpc-iomem/arch/m32r/Makefile RC14-rc2-git5-sparse-m32r/arch/m32r/Makefile
--- RC14-rc2-git5-rpc-iomem/arch/m32r/Makefile	2005-06-17 15:48:29.000000000 -0400
+++ RC14-rc2-git5-sparse-m32r/arch/m32r/Makefile	2005-09-25 23:46:36.000000000 -0400
@@ -24,7 +24,7 @@
 CFLAGS += $(cflags-y)
 AFLAGS += $(aflags-y)
 
-CHECKFLAGS	:= $(CHECK) -D__m32r__
+CHECKFLAGS	+= -D__m32r__ -D__BIG_ENDIAN__=1
 
 head-y	:= arch/m32r/kernel/head.o arch/m32r/kernel/init_task.o
 
