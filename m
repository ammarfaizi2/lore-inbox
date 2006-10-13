Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751453AbWJMRmF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751453AbWJMRmF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 13:42:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751495AbWJMRmE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 13:42:04 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:56506 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751453AbWJMRmC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 13:42:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding:from;
        b=LtuoxWpuE4D2dn6xTOa/BZJlM1DLvWKxWmT6m/iSM97wmKX6YOWSgd8yhsD4WvxRkeNc1kKgBdZnIwZjPZfIIB+8rmQ7eE54V3OlNQ5F1wzTeG4qLHgjGS6mbqbB6uA1rGEezrdK1rkkyrgp0MiFN8PCwz2UWohx/N31xNr7Ao0=
Message-ID: <452FCFEC.3090509@googlemail.com>
Date: Fri, 13 Oct 2006 19:42:04 +0200
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       dwmw2@infradead.org
Subject: Re: Linux 2.6.19-rc2
References: <Pine.LNX.4.64.0610130941550.3952@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0610130941550.3952@g5.osdl.org>
X-Enigmail-Version: 0.94.1.1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Linus Torvalds wrote:
> Ok, it's a week since -rc1, so -rc2 is out there.
> 

Please consider applying this patches.

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/)


----
[PATCH] Fix 'headers_install' with separate output directory

Signed-off-by: David Woodhouse <dwmw2@infradead.org>

diff --git a/Makefile b/Makefile
index 80dac02..bdf7c18 100644
--- a/Makefile
+++ b/Makefile
@@ -932,7 +932,7 @@ headers_install_all: include/linux/versi

 PHONY += headers_install
 headers_install: include/linux/version.h scripts_basic FORCE
-	@if [ ! -r include/asm-$(ARCH)/Kbuild ]; then \
+	@if [ ! -r $(srctree)/include/asm-$(ARCH)/Kbuild ]; then \
 	  echo '*** Error: Headers not exportable for this architecture ($(ARCH))'; \
 	  exit 1 ; fi
 	$(Q)$(MAKE) $(build)=scripts scripts/unifdef



---

Signed-off-by: David Woodhouse <dwmw2@infradead.org>

diff --git a/scripts/Makefile.headersinst b/scripts/Makefile.headersinst
index cac8f21..6a7b740 100644
--- a/scripts/Makefile.headersinst
+++ b/scripts/Makefile.headersinst
@@ -168,7 +168,7 @@ ifdef GENASM
 	$(call cmd,gen)

 else
-$(objhdr-y) :		$(INSTALL_HDR_PATH)/$(_dst)/%.h: $(srctree)/$(obj)/%.h $(KBUILDFILES)
+$(objhdr-y) :		$(INSTALL_HDR_PATH)/$(_dst)/%.h: $(objtree)/$(obj)/%.h $(KBUILDFILES)
 	$(call cmd,o_hdr_install)

 $(header-y) :		$(INSTALL_HDR_PATH)/$(_dst)/%.h: $(srctree)/$(obj)/%.h $(KBUILDFILES)



