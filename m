Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264808AbUGAMnf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264808AbUGAMnf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 08:43:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264815AbUGAMnd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 08:43:33 -0400
Received: from pxy4allmi.all.mi.charter.com ([24.247.15.43]:31209 "EHLO
	proxy4.gha.chartermi.net") by vger.kernel.org with ESMTP
	id S264808AbUGAMnb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 08:43:31 -0400
Message-ID: <40E407C8.3010209@quark.didntduck.org>
Date: Thu, 01 Jul 2004 08:47:04 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040625
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Sam Ravnborg <sam@ravnborg.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] Clean up module install rules
Content-Type: multipart/mixed;
 boundary="------------060603040701010107040105"
X-Charter-Information: 
X-Charter-Scan: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060603040701010107040105
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Consolidate rules for installing internal and external modules.

--
				Brian Gerst


--------------060603040701010107040105
Content-Type: text/plain;
 name="modinst-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="modinst-1"

diff -urN linux-2.6.7-bk/scripts/Makefile.modinst linux/scripts/Makefile.modinst
--- linux-2.6.7-bk/scripts/Makefile.modinst	2004-06-23 18:06:06.000000000 -0400
+++ linux/scripts/Makefile.modinst	2004-06-29 13:45:26.232647680 -0400
@@ -16,20 +16,10 @@
 __modinst: $(modules)
 	@:
 
-# Modules built within the kernel tree
-
 quiet_cmd_modules_install = INSTALL $@
-      cmd_modules_install = mkdir -p $(MODLIB)/kernel/$(@D); \
-			    cp $@ $(MODLIB)/kernel/$(@D)
-
-$(filter-out ../% /%,$(modules)):
-	$(call cmd,modules_install)
-
-# Modules built outside just go into extra
+      cmd_modules_install = mkdir -p $(2); cp $@ $(2)
 
-quiet_cmd_modules_install_extra = INSTALL $(obj-m:.o=.ko)
-      cmd_modules_install_extra = mkdir -p $(MODLIB)/extra; \
-			    	  cp $@ $(MODLIB)/extra
+modinst_dir = $(MODLIB)/$(if $(filter ../% /%,$@),extra/,kernel/$(@D))
 
-$(filter     ../% /%,$(modules)):
-	$(call cmd,modules_install_extra)
+$(modules):
+	$(call cmd,modules_install,$(modinst_dir))


--------------060603040701010107040105--
