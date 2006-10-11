Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161498AbWJKVYF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161498AbWJKVYF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 17:24:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161512AbWJKVXw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 17:23:52 -0400
Received: from mail.kroah.org ([69.55.234.183]:16032 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161413AbWJKVGo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 17:06:44 -0400
Date: Wed, 11 Oct 2006 14:06:17 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, David Woodhouse <dwmw2@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 33/67] Dont advertise (or allow) headers_{install,check} where inappropriate.
Message-ID: <20061011210617.GH16627@kroah.com>
References: <20061011204756.642936754@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="0011-Don-t-advertise-or-allow-headers_-install-check-where-inappropriate.patch"
In-Reply-To: <20061011210310.GA16627@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


-stable review patch.  If anyone has any objections, please let us know.

------------------
From: David Woodhouse <dwmw2@infradead.org>

For architectures which don't have the include/asm-$(ARCH)/Kbuild file,
like ARM26, UM, etc.

Signed-off-by: David Woodhouse <dwmw2@infradead.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 Makefile |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

--- linux-2.6.18.orig/Makefile
+++ linux-2.6.18/Makefile
@@ -894,6 +894,9 @@ export INSTALL_HDR_PATH
 
 PHONY += headers_install
 headers_install: include/linux/version.h
+	@if [ ! -r include/asm-$(ARCH)/Kbuild ]; then \
+	  echo '*** Error: Headers not exportable for this architecture ($(ARCH))'; \
+	  exit 1 ; fi
 	$(Q)unifdef -Ux /dev/null
 	$(Q)rm -rf $(INSTALL_HDR_PATH)/include
 	$(Q)$(MAKE) -rR -f $(srctree)/scripts/Makefile.headersinst obj=include
@@ -1076,13 +1079,17 @@ help:
 	@echo  '  cscope	  - Generate cscope index'
 	@echo  '  kernelrelease	  - Output the release version string'
 	@echo  '  kernelversion	  - Output the version stored in Makefile'
-	@echo  '  headers_install - Install sanitised kernel headers to INSTALL_HDR_PATH'
+	@if [ -r include/asm-$(ARCH)/Kbuild ]; then \
+	 echo  '  headers_install - Install sanitised kernel headers to INSTALL_HDR_PATH'; \
+	 fi
 	@echo  '                    (default: $(INSTALL_HDR_PATH))'
 	@echo  ''
 	@echo  'Static analysers'
 	@echo  '  checkstack      - Generate a list of stack hogs'
 	@echo  '  namespacecheck  - Name space analysis on compiled kernel'
-	@echo  '  headers_check   - Sanity check on exported headers'
+	@if [ -r include/asm-$(ARCH)/Kbuild ]; then \
+	 echo  '  headers_check   - Sanity check on exported headers'; \
+	 fi
 	@echo  ''
 	@echo  'Kernel packaging:'
 	@$(MAKE) $(build)=$(package-dir) help

--
