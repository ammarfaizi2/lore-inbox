Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262236AbTCWDi6>; Sat, 22 Mar 2003 22:38:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262244AbTCWDi6>; Sat, 22 Mar 2003 22:38:58 -0500
Received: from mail.world4you.com ([213.164.26.52]:25873 "EHLO
	mail.world4you.com") by vger.kernel.org with ESMTP
	id <S262236AbTCWDi5>; Sat, 22 Mar 2003 22:38:57 -0500
Message-ID: <002101c2f0ef$38f6e5f0$0200000a@hrurusat>
From: "dose" <dose@infernum.com>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.4.20 unresolved symbols with K7/3DNOW
Date: Sun, 23 Mar 2003 04:49:35 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This one seems to have been around for quite a while (2.4.0-textX ?)...when
compiling with CONFIG_MK7=y ("Athlon/Duron/K7" as Processor family) a lot of
modules aren't able to resolve the symbol _mmx_memcpy. This is caused by
CONFIG_X86_USE_3DNOW=y and the problem lies in a wrong symbol export in
arch/i386/kernel/i386_ksyms.c - I wonder why this still hasn't been fixed as
it doesn't seem like a hard thing to do for someone who's into kernel
patching...being new to that, it took me about 3 hours.

Here's the patch (it's just one line so it should work for other 2.4.x
kernels as well)

diff -urN linux-2.4.20/arch/i386/kernel/i386_ksyms.c.orig
linux-2.4.20/arch/i386/kernel/i386_ksyms.c
--- linux-2.4.20/arch/i386/kernel/i386_ksyms.c.orig     Sun Mar 23 04:24:06
2003
+++ linux-2.4.20/arch/i386/kernel/i386_ksyms.c  Sun Mar 23 04:24:18 2003
@@ -120,7 +120,7 @@
 #endif

 #ifdef CONFIG_X86_USE_3DNOW
-EXPORT_SYMBOL(_mmx_memcpy);
+EXPORT_SYMBOL_NOVERS(_mmx_memcpy);
 EXPORT_SYMBOL(mmx_clear_page);
 EXPORT_SYMBOL(mmx_copy_page);
 #endif


--
"enemy of the sun, we are the subterranean
apocalyptic daydreams, casual delirium"
http://www.caffeineshock.com - http://www.dose-xp.org
http://www.blended.org - http://www.infernum.com


