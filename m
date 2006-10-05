Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932288AbWJEVnL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932288AbWJEVnL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 17:43:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932255AbWJEVmx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 17:42:53 -0400
Received: from smtp007.mail.ukl.yahoo.com ([217.12.11.96]:58290 "HELO
	smtp007.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S932269AbWJEVmQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 17:42:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:Subject:Date:To:Cc:Bcc:Message-Id:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:User-Agent;
  b=QMO2rEzGrgmvfviJerKe3rHCi5FOHoEi6b+nqNCyzcaQ/k8t9sNwuv6n3hUPd592tHEBEOW4uLvuVxVnR22/6ct4echrvlIZ24P6JddDjM7hL+0no23pvpGMme3lDen31Xk/wF9ZvzqC3o7XLebSkZN8UWT/pWBzpRx6s2uhVvE=  ;
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 13/14] uml: deprecate CONFIG_MODE_TT
Date: Thu, 05 Oct 2006 23:39:16 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Message-Id: <20061005213916.17268.53832.stgit@memento.home.lan>
In-Reply-To: <20061005213212.17268.7409.stgit@memento.home.lan>
References: <20061005213212.17268.7409.stgit@memento.home.lan>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Deprecate TT mode in Kconfig so that users won't select it, update the MODE_SKAS
description (it was largely obsolete and misleadin) and btw describe advantages
for high memory usage with CONFIG_STATIC_LINK.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/Kconfig |   22 +++++++++++++++-------
 1 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index 450547a..78fb619 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -50,13 +50,15 @@ config IRQ_RELEASE_METHOD
 menu "UML-specific options"
 
 config MODE_TT
-	bool "Tracing thread support"
+	bool "Tracing thread support (DEPRECATED)"
 	default n
 	help
 	This option controls whether tracing thread support is compiled
-	into UML.  This option is largely obsolete, given that skas0 provides
+	into UML. This option is largely obsolete, given that skas0 provides
 	skas security and performance without needing to patch the host.
-	It is safe to say 'N' here.
+	It is safe to say 'N' here; saying 'Y' may cause additional problems
+	with the resulting binary even if you run UML in SKAS mode, and running
+	in TT mode is strongly *NOT RECOMMENDED*.
 
 config STATIC_LINK
 	bool "Force a static link"
@@ -69,6 +71,9 @@ config STATIC_LINK
 	for use in a chroot jail.  So, if you intend to run UML inside a
 	chroot, and you disable CONFIG_MODE_TT, you probably want to say Y
 	here.
+	Additionally, this option enables using higher memory spaces (up to
+	2.75G) for UML - disabling CONFIG_MODE_TT and enabling this option leads
+	to best results for this.
 
 config KERNEL_HALF_GIGS
 	int "Kernel address space size (in .5G units)"
@@ -85,10 +90,13 @@ config MODE_SKAS
 	default y
 	help
 	This option controls whether skas (separate kernel address space)
-	support is compiled in.  If you have applied the skas patch to the
-	host, then you certainly want to say Y here (and consider saying N
-	to CONFIG_MODE_TT).  Otherwise, it is safe to say Y.  Disabling this
-	option will shrink the UML binary slightly.
+	support is compiled in.
+	Unless you have specific needs to use TT mode (which applies almost only
+	to developers), you should say Y here.
+	SKAS mode will make use of the SKAS3 patch if it is applied on the host
+	(and your UML will run in SKAS3 mode), but if no SKAS patch is applied
+	on the host it will run in SKAS0 mode, which is anyway faster than TT
+	mode.
 
 source "arch/um/Kconfig.arch"
 source "mm/Kconfig"
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 
