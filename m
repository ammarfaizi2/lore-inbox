Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946274AbWKAFiO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946274AbWKAFiO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 00:38:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946270AbWKAFho
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 00:37:44 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:5265 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1946380AbWKAFhU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 00:37:20 -0500
Message-Id: <20061101053730.817228000@sous-sol.org>
References: <20061101053340.305569000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Tue, 31 Oct 2006 21:33:56 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk,
       "Paolo Blaisorblade Giarrusso" <blaisorblade@yahoo.it>,
       Jeff Dike <jdike@addtoit.com>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 16/61] uml: fix processor selection to exclude unsupported processors and features
Content-Disposition: inline; filename=uml-fix-processor-selection-to-exclude-unsupported-processors-and-features.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Makes UML compile on any possible processor choice. The two problems were:

*) x86 code, when 386 is selected, checks at runtime boot_cpuflags, which we do
   not have.
*) 3Dnow support for memcpy() et al. does not compile currently and fixing this
   is not trivial, so simply disable it; with this change, if one selects MK7
   UML compiles (while it did not).
Merged upstream.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>

---
 arch/i386/Kconfig.cpu |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- linux-2.6.18.1.orig/arch/i386/Kconfig.cpu
+++ linux-2.6.18.1/arch/i386/Kconfig.cpu
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

--
