Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263003AbUFJUNF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263003AbUFJUNF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 16:13:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262960AbUFJUNF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 16:13:05 -0400
Received: from outmx014.isp.belgacom.be ([195.238.2.69]:22972 "EHLO
	outmx014.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S263003AbUFJULd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 16:11:33 -0400
Subject: [PATCH 2.6.7-rc3-mm1] make maxdebug
From: FabF <fabian.frederick@skynet.be>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-2cpneDH/ktOWkPlGiMwj"
Message-Id: <1086898414.3738.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 10 Jun 2004 22:13:35 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-2cpneDH/ktOWkPlGiMwj
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Andrew,

	Here's a patch to have maximum debug reporting.If you find the idea
interesting, I could work on full "debug off" feature and improve it....

Regards,
FabF

--=-2cpneDH/ktOWkPlGiMwj
Content-Disposition: attachment; filename=maxdebug1.diff
Content-Type: text/x-patch; name=maxdebug1.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -Naur orig/Makefile edited/Makefile
--- orig/Makefile	2004-06-10 17:38:35.000000000 +0200
+++ edited/Makefile	2004-06-10 21:25:39.000000000 +0200
@@ -1167,4 +1167,28 @@
 
 endif	# skip-makefile
 
+#	Maximum debug selection.
+#	All modules having #undef DEBUG_XXX will be #define DEBUG_XXX
+#	.config is synced as well.
+#	WARNING : Irreversible process
+#	(06/2004 - FabF)
+maxdebug : 
+	@path=""; \
+	ls -R | while read line; do \
+	entry=`echo $$line | awk '/:$$/'`; \
+	if [ ! -z $$entry ]; then \
+		path=`echo $$entry | sed s/://g`; \
+	else \
+		if [ ! -z `echo $$line | awk '/\.c$$/'` ] || [ ! -z `echo $$line | awk '/\.h$$/'` ]; then \
+			if [ ! -z "$$line" ]; then \
+				sed /DEBUG/s/undef/define/g $$path/$$line > $$path/$$line"tmp"; \
+				mv $$path/$$line"tmp" $$path/$$line; \
+				echo $$line ; \
+			fi \
+		fi \
+	fi \
+	done; \
+	sed /DEBUG/s/'# '//g .config > .config.tmp; \
+	sed /DEBUG/s/'is not set'/'=y'/g .config.tmp > .config 
+
 FORCE:

--=-2cpneDH/ktOWkPlGiMwj--

