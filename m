Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264363AbUD2MkM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264363AbUD2MkM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 08:40:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264367AbUD2MkM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 08:40:12 -0400
Received: from natsmtp00.rzone.de ([81.169.145.165]:39675 "EHLO
	natsmtp00.rzone.de") by vger.kernel.org with ESMTP id S264363AbUD2MkF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 08:40:05 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH] s390 (6/6): oprofile for s390.
Date: Thu, 29 Apr 2004 14:39:56 +0200
User-Agent: KMail/1.6.1
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Philippe Elie <phil.el@wanadoo.fr>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200404291439.58788.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Schwidefsky wrote:
> > > +#if defined(CONFIG_OPROFILE) || defined(CONFIG_OPROFILE_MODULE)
> >
> > this must depend on CONFIG_PROFILING ?
> 
> Currently oprofile is the only profiling method implemented for s390.
> So this doesn't really change much. But in principle you are right,
> as soon as a second profiling method gets added this would have to
> be changed to CONFIG_PROFILING.

No, it should already be changed now, because the code is also needed
for readprofile. CONFIG_PROFILING should enable the generic profiling
code here, even if CONFIG_OPROFILE is not set.
Note that the identical code on i386 is always compiled in, regardless
of CONFIG_PROFILING and CONFIG_OPROFILE.

	Arnd <><

===
Enable basic profiling code on s390 depending on CONFIG_PROFILING,
not CONFIG_OPROFILE.
===== arch/s390/kernel/time.c 1.25 vs edited =====
--- 1.25/arch/s390/kernel/time.c	Wed Apr 28 19:51:41 2004
+++ edited/arch/s390/kernel/time.c	Thu Apr 29 11:13:36 2004
@@ -179,7 +179,7 @@
 #endif /* CONFIG_ARCH_S390X */
 
 
-#if defined(CONFIG_OPROFILE) || defined(CONFIG_OPROFILE_MODULE)
+#ifdef CONFIG_PROFILING
 extern char _stext, _etext;
 
 /*
@@ -223,7 +223,7 @@
 }
 #else
 #define s390_do_profile(regs)  do { ; } while(0)
-#endif /* CONFIG_OPROFILE */
+#endif /* CONFIG_PROFILING */
 
 
 /*
===== arch/s390/oprofile/Kconfig 1.1 vs edited =====
--- 1.1/arch/s390/oprofile/Kconfig	Wed Apr 28 19:51:41 2004
+++ edited/arch/s390/oprofile/Kconfig	Thu Apr 29 11:16:21 2004
@@ -5,8 +5,8 @@
 config PROFILING
 	bool "Profiling support (EXPERIMENTAL)"
 	help
-	  Say Y here to enable the extended profiling support mechanisms used
-	  by profilers such as OProfile.
+	  Say Y here to enable profiling support mechanisms used by
+	  profilers such as readprofile or OProfile.
 
 
 config OPROFILE
