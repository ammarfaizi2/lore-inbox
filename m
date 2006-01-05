Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751863AbWAERhD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751863AbWAERhD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 12:37:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751864AbWAERhD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 12:37:03 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:26642 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751863AbWAERg7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 12:36:59 -0500
Date: Thu, 5 Jan 2006 18:36:57 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Ralf Baechle <ralf@linux-mips.org>, Domen Puncer <domen@coderock.org>,
       linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
       davem@davemloft.net
Subject: [2.6 patch] Remove arch/mips/arc/salone.c
Message-ID: <20060105173657.GA12313@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Domen Puncer <domen@coderock.org>

ArcLoad(), ArcInvoke(), ArcExecute() aren't used.

Signed-off-by: Domen Puncer <domen@coderock.org>
Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was sent by Alexey Dobriyan on:
- 8 Nov 2005

 arch/mips/arc/Makefile |    2 +-
 arch/mips/arc/salone.c |   25 -------------------------
 2 files changed, 1 insertion(+), 26 deletions(-)

--- linux-kj.orig/arch/mips/arc/Makefile	2005-11-08 20:46:24.000000000 +0300
+++ linux-kj/arch/mips/arc/Makefile	2005-11-08 20:47:36.000000000 +0300
@@ -3,7 +3,7 @@
 #
 
 lib-y				+= cmdline.o env.o file.o identify.o init.o \
-				   misc.o salone.o time.o tree.o
+				   misc.o time.o tree.o
 
 lib-$(CONFIG_ARC_MEMORY)	+= memory.o
 lib-$(CONFIG_ARC_CONSOLE)	+= arc_con.o
Index: linux-kj/arch/mips/arc/salone.c
===================================================================
--- linux-kj.orig/arch/mips/arc/salone.c	2005-11-08 20:46:24.000000000 +0300
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,24 +0,0 @@
-/*
- * Routines to load into memory and execute stand-along program images using
- * ARCS PROM firmware.
- *
- * Copyright (C) 1996 David S. Miller (dm@engr.sgi.com)
- */
-#include <linux/init.h>
-#include <asm/sgialib.h>
-
-LONG __init ArcLoad(CHAR *Path, ULONG TopAddr, ULONG *ExecAddr, ULONG *LowAddr)
-{
-	return ARC_CALL4(load, Path, TopAddr, ExecAddr, LowAddr);
-}
-
-LONG __init ArcInvoke(ULONG ExecAddr, ULONG StackAddr, ULONG Argc, CHAR *Argv[],
-	CHAR *Envp[])
-{
-	return ARC_CALL5(invoke, ExecAddr, StackAddr, Argc, Argv, Envp);
-}
-
-LONG __init ArcExecute(CHAR *Path, LONG Argc, CHAR *Argv[], CHAR *Envp[])
-{
-	return ARC_CALL4(exec, Path, Argc, Argv, Envp);
-}

