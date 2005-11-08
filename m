Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964844AbVKHRsJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964844AbVKHRsJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 12:48:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932403AbVKHRsJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 12:48:09 -0500
Received: from nproxy.gmail.com ([64.233.182.202]:23323 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932497AbVKHRsI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 12:48:08 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=pgUhAJZ1jfY4pZSU9gRd1cKAe1LT2QzxO6zqByg1OTf3n1kiVGXzTtxCLDaeyTln/jKIy6XfLDxr+RKUyLdEWY75idCs4bb78m04iROhiGAMgdjkMGF3UZFnLd/pxNstEvMz4Y1jz97wCH3dhBiPXIrAisxCUHV7KRhsE8IOu0U=
Date: Tue, 8 Nov 2005 21:01:31 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Domen Puncer <domen@coderock.org>, linux-mips@linux-mips.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH] Remove arch/mips/arc/salone.c
Message-ID: <20051108180131.GF7631@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Domen Puncer <domen@coderock.org>

ArcLoad(), ArcInvoke(), ArcExecute() aren't used.

Signed-off-by: Domen Puncer <domen@coderock.org>
Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>

Index: linux-kj/arch/mips/arc/Makefile
===================================================================
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

