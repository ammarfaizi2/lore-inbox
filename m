Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750929AbWJQTsq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750929AbWJQTsq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 15:48:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751245AbWJQTsq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 15:48:46 -0400
Received: from [151.97.230.90] ([151.97.230.90]:21462 "EHLO memento.home.lan")
	by vger.kernel.org with ESMTP id S1750929AbWJQTso (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 15:48:44 -0400
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
To: stable@kernel.org
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net,
       "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: uml: fix processor selection to exclude unsupported processors and features
Date: Tue, 17 Oct 2006 16:58:44 +0200
Message-Id: <11610971243583-git-send-email-blaisorblade@yahoo.it>
X-Mailer: git-send-email 1.4.2.3.g99b7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Makes UML compile on any possible processor choice. The two problems were:

*) x86 code, when 386 is selected, checks at runtime boot_cpuflags, which we do
   not have.
*) 3Dnow support for memcpy() et al. does not compile currently and fixing this
   is not trivial, so simply disable it; with this change, if one selects MK7
   UML compiles (while it did not).
Merged upstream; I'm resending since spam filters blocked my previous mail.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Index: linux-2.6.git/arch/i386/Kconfig.cpu
===================================================================
--- linux-2.6.git.orig/arch/i386/Kconfig.cpu
+++ linux-2.6.git/arch/i386/Kconfig.cpu
@@ -7,6 +7,7 @@ choice
 
 config M386
 	bool "386"
+	depends on !UML
 	---help---
 	  This is the processor type of your CPU. This information is used for
 	  optimizing purposes. In order to compile a kernel that can run on
@@ -301,7 +302,7 @@ config X86_USE_PPRO_CHECKSUM
 
 config X86_USE_3DNOW
 	bool
-	depends on MCYRIXIII || MK7 || MGEODE_LX
+	depends on (MCYRIXIII || MK7 || MGEODE_LX) && !UML
 	default y
 
 config X86_OOSTORE
