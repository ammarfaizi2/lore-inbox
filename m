Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316644AbSE0PBH>; Mon, 27 May 2002 11:01:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316649AbSE0PBG>; Mon, 27 May 2002 11:01:06 -0400
Received: from jalon.able.es ([212.97.163.2]:62715 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S316644AbSE0PBG>;
	Mon, 27 May 2002 11:01:06 -0400
Date: Mon, 27 May 2002 17:00:48 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [PATCH][RFC] gcc3 arch options
Message-ID: <20020527150048.GC6738@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.3.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Patch below adds support for newer gcc -march code generation options.
It adds options for pentium-mmx, pentium-pro, pentium2, pentium3 and pentium4.
(note: pII part depends or previous patch).
It just what Luca Barbieri did adding PII.

I have been running a PII optmized kernel on a dual PII@400 box and nothing
has broken for 2 days....

Patch follows:

--- linux-2.4.19-pre8-jam4/arch/i386/Makefile.orig	2002-05-26 11:39:23.000000000 +0200
+++ linux-2.4.19-pre8-jam4/arch/i386/Makefile	2002-05-26 11:43:06.000000000 +0200
@@ -43,23 +43,23 @@
 endif
 
 ifdef CONFIG_M586MMX
-CFLAGS += -march=i586
+CFLAGS += $(shell if $(CC) -march=pentium-mmx -S -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo "-march=pentium-mmx"; else echo "-march=i586"; fi)
 endif
 
 ifdef CONFIG_M686
-CFLAGS += -march=i686
+CFLAGS += $(shell if $(CC) -march=pentium-pro -S -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo "-march=pentium-pro; else echo "-march=i686"; fi)
 endif
 
 ifdef CONFIG_MPENTIUMII
-CFLAGS += -march=i686
+CFLAGS += $(shell if $(CC) -march=pentium2 -S -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo "-march=pentium2"; else echo "-march=i686"; fi)
 endif
 
 ifdef CONFIG_MPENTIUMIII
-CFLAGS += -march=i686
+CFLAGS += $(shell if $(CC) -march=pentium3 -S -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo "-march=pentium3"; else echo "-march=i686"; fi)
 endif
 
 ifdef CONFIG_MPENTIUM4
-CFLAGS += -march=i686
+CFLAGS += $(shell if $(CC) -march=pentium4 -S -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo "-march=pentium4"; else echo "-march=i686"; fi)
 endif
 
 ifdef CONFIG_MK6


-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.3 (Cooker) for i586
Linux werewolf 2.4.19-pre8-jam4 #2 SMP dom may 26 11:20:42 CEST 2002 i686
