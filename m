Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262073AbUD2SzZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262073AbUD2SzZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 14:55:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262462AbUD2SzZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 14:55:25 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:20430 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S262073AbUD2SzL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 14:55:11 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: [PATCH] Kconfig.debug family
Date: Thu, 29 Apr 2004 20:54:49 +0200
User-Agent: KMail/1.5.3
Cc: trini@kernel.crashing.org, linux-kernel@vger.kernel.org, akpm@osdl.org,
       jgarzik@pobox.com, mpm@selenic.com, zwane@linuxpower.ca
References: <20040421205140.445ae864.rddunlap@osdl.org> <200404291842.23968.bzolnier@elka.pw.edu.pl> <20040429095143.6de85098.rddunlap@osdl.org>
In-Reply-To: <20040429095143.6de85098.rddunlap@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404292054.49663.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 29 of April 2004 18:51, Randy.Dunlap wrote:
> On Thu, 29 Apr 2004 18:42:23 +0200 Bartlomiej Zolnierkiewicz wrote:

> | Only on x86 it does a proper thing:
> |
> | arch/<arch>/Kconfig -> arch/<arch>/Kconfig.debug -> lib/Kconfig.debug
>
> That's because I goofed up... it's the wrong patch.
>
> I was trying something that someone suggested (You!) and it didn't

:)

> work out in a desirable way as far as how it's presented in
> {x,menu}config, so I need to fix that (i386 part) and then you

In your previous patch (vs 2.6.5) there was only one "Kernel hacking" menu,
in this one there are two menus: "Kernel hacking" and "X86 kernel hacking".

I hacked it quickly and I have one menu again (on x86 arch specific options
are not configurable) so I also hacked+checked  ppc and 'make menuconfig'
looks OK).  Did I miss something?

diff -u linux-2.6.6-rc2-bk4-bzolnier/arch/i386/Kconfig.debug linux-2.6.6-rc2-bk4-bzolnier/arch/i386/Kconfig.debug
--- linux-2.6.6-rc2-bk4-bzolnier/arch/i386/Kconfig.debug	2004-04-29 20:31:57.358189632 +0200
+++ linux-2.6.6-rc2-bk4-bzolnier/arch/i386/Kconfig.debug	2004-04-29 20:45:11.884403288 +0200
@@ -1,6 +1,7 @@
-source "lib/Kconfig.debug"
 
-menu "X86 kernel hacking"
+menu "Kernel hacking"
+
+source "lib/Kconfig.debug"
 
 config X86_FIND_SMP_CONFIG
 	bool
diff -u linux-2.6.6-rc2-bk4-bzolnier/arch/ppc/Kconfig linux-2.6.6-rc2-bk4-bzolnier/arch/ppc/Kconfig
--- linux-2.6.6-rc2-bk4-bzolnier/arch/ppc/Kconfig	2004-04-29 20:31:57.396183856 +0200
+++ linux-2.6.6-rc2-bk4-bzolnier/arch/ppc/Kconfig	2004-04-29 20:45:49.703653888 +0200
@@ -1108,7 +1108,7 @@
 
 source "lib/Kconfig"
 
-source "lib/Kconfig.debug"
+source "arch/ppc/Kconfig.debug"
 
 source "security/Kconfig"
 
diff -u linux-2.6.6-rc2-bk4-bzolnier/arch/ppc/Kconfig.debug linux-2.6.6-rc2-bk4-bzolnier/arch/ppc/Kconfig.debug
--- linux-2.6.6-rc2-bk4-bzolnier/arch/ppc/Kconfig.debug	2004-04-29 20:31:57.397183704 +0200
+++ linux-2.6.6-rc2-bk4-bzolnier/arch/ppc/Kconfig.debug	2004-04-29 20:45:33.027189096 +0200
@@ -1,4 +1,6 @@
-menu "PPC kernel hacking"
+menu "Kernel hacking"
+
+source "lib/Kconfig.debug"
 
 config KGDB
 	bool "Include kgdb kernel debugger"
@@ -66 +67,0 @@
-
diff -u linux-2.6.6-rc2-bk4-bzolnier/lib/Kconfig.debug linux-2.6.6-rc2-bk4-bzolnier/lib/Kconfig.debug
--- linux-2.6.6-rc2-bk4-bzolnier/lib/Kconfig.debug	2004-04-29 20:31:57.439177320 +0200
+++ linux-2.6.6-rc2-bk4-bzolnier/lib/Kconfig.debug	2004-04-29 20:39:43.907263392 +0200
@@ -1,6 +1,4 @@
-# Generic debug menu
-
-menu "Kernel hacking"
+# Generic debug options
 
 config DEBUG_KERNEL
 	bool "Kernel debugging"
@@ -97,7 +95,7 @@
 	  debugging info resulting in a larger kernel image.
 	  Say Y here only if you plan to use gdb to debug the kernel.
 	  If you don't debug the kernel, you can say N.
-	  
+
 config FRAME_POINTER
 	bool "Compile the kernel with frame pointers"
 	depends on DEBUG_KERNEL && (!ARM && !ARM26 && !X86_64 && !S390 && !V850 && !SPARC64)
@@ -148,3 +145,0 @@
-
-endmenu
-

> can complain some more.  :)

:)

Bartlomiej

