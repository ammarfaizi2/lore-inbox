Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265044AbUGSRSH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265044AbUGSRSH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jul 2004 13:18:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265091AbUGSRSH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jul 2004 13:18:07 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:2293 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S265044AbUGSRSB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jul 2004 13:18:01 -0400
Date: Mon, 19 Jul 2004 13:17:59 -0400
From: "George G. Davis" <gdavis@mvista.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Allow `make O=<obj> {cscope,tags}` to work
Message-ID: <20040719171759.GA1890@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

Here's a trivial fix to allow `make O=<obj> {cscope,tags}` to work:


# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/07/19 12:49:14-04:00 gdavis@davisg.ne.client2.attbi.com 
#   Makefile:
#     Allow `make O=<obj> {cscope,tags}` to work
# 
# Makefile
#   2004/07/19 12:28:02-04:00 gdavis@davisg.ne.client2.attbi.com +9 -9
#   Allow `make O=<obj> {cscope,tags}` to work
# 
diff -Nru a/Makefile b/Makefile
--- a/Makefile	2004-07-19 13:00:49 -04:00
+++ b/Makefile	2004-07-19 13:00:49 -04:00
@@ -1009,26 +1009,26 @@
 # ---------------------------------------------------------------------------
 
 define all-sources
-	( find . $(RCS_FIND_IGNORE) \
+	( find $(srctree) $(RCS_FIND_IGNORE) \
 	       \( -name include -o -name arch \) -prune -o \
 	       -name '*.[chS]' -print; \
-	  find arch/$(ARCH) $(RCS_FIND_IGNORE) \
+	  find $(srctree)/arch/$(ARCH) $(RCS_FIND_IGNORE) \
 	       -name '*.[chS]' -print; \
-	  find security/selinux/include $(RCS_FIND_IGNORE) \
+	  find $(srctree)/security/selinux/include $(RCS_FIND_IGNORE) \
 	       -name '*.[chS]' -print; \
-	  find include $(RCS_FIND_IGNORE) \
+	  find $(srctree)/include $(RCS_FIND_IGNORE) \
 	       \( -name config -o -name 'asm-*' \) -prune \
 	       -o -name '*.[chS]' -print; \
-	  find include/asm-$(ARCH) $(RCS_FIND_IGNORE) \
+	  find $(srctree)/include/asm-$(ARCH) $(RCS_FIND_IGNORE) \
 	       -name '*.[chS]' -print; \
-	  find include/asm-generic $(RCS_FIND_IGNORE) \
+	  find $(srctree)/include/asm-generic $(RCS_FIND_IGNORE) \
 	       -name '*.[chS]' -print )
 endef
 
-quiet_cmd_cscope-file = FILELST cscope.files
-      cmd_cscope-file = $(all-sources) > cscope.files
+quiet_cmd_cscope-file = FILELST $(obj)/cscope.files
+      cmd_cscope-file = $(all-sources) > $(obj)/cscope.files
 
-quiet_cmd_cscope = MAKE    cscope.out
+quiet_cmd_cscope = MAKE    $(obj)/cscope.out
       cmd_cscope = cscope -k -b -q
 
 cscope: FORCE


--
Regards,
George
