Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315416AbSE2Ojr>; Wed, 29 May 2002 10:39:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315419AbSE2Ojq>; Wed, 29 May 2002 10:39:46 -0400
Received: from jalon.able.es ([212.97.163.2]:10924 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S315416AbSE2Ojp>;
	Wed, 29 May 2002 10:39:45 -0400
Date: Wed, 29 May 2002 16:39:17 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] gcc3-march flags
Message-ID: <20020529143917.GA2913@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Mailer: Balsa 1.3.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On top of previous arch-CONFIG reorder, this patch adds support for gcc3
-march flags:

diff -ruN linux-2.4.19-pre8-jam4-0/arch/i386/Makefile linux-2.4.19-pre8-jam4/arch/i386/Makefile
--- linux-2.4.19-pre8-jam4-0/arch/i386/Makefile	2002-05-29 00:30:39.000000000 +0200
+++ linux-2.4.19-pre8-jam4/arch/i386/Makefile	2002-05-29 00:32:27.000000000 +0200
@@ -43,23 +43,23 @@
 endif
 
 ifdef CONFIG_MPENTIUMMMX
-CFLAGS += -march=i586
+CFLAGS += $(shell if $(CC) -march=pentium-mmx -S -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo "-march=pentium-mmx"; else echo "-march=i586"; fi)
 endif
 
 ifdef CONFIG_MPENTIUMPRO
-CFLAGS += -march=i686
+CFLAGS += $(shell if $(CC) -march=pentium-pro -S -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo "-march=pentium-pro"; else echo "-march=i686"; fi)
 endif
 
 ifdef CONFIG_MPENTIUM2
-CFLAGS += -march=i686
+CFLAGS += $(shell if $(CC) -march=pentium2 -S -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo "-march=pentium2"; else echo "-march=i686"; fi)
 endif
 
 ifdef CONFIG_MPENTIUM3
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
Linux werewolf 2.4.19-pre9-jam1 #1 SMP mié may 29 02:20:48 CEST 2002 i686
