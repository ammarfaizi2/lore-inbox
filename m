Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267775AbUHRVPm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267775AbUHRVPm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 17:15:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267746AbUHRVI5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 17:08:57 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:64049 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S267758AbUHRVEX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 17:04:23 -0400
Date: Thu, 19 Aug 2004 01:04:35 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org
Subject: kbuild: Fix parallel build
Message-ID: <20040818230435.GB23495@mars.ravnborg.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20040818230252.GA23495@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040818230252.GA23495@mars.ravnborg.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/08/17 22:35:04+02:00 sam@mars.ravnborg.org 
#   kbuild: Fix parallel build in a distclean'ed tree
#   
#   Fixes the following error:
#   make: *** No rule to make target `.tmp_kallsyms2.S', needed by `.tmp_kallsyms2.o'.
#   
#   Problem is that make does not know it have to visit scripts before it can use $(KALLSYMS)
#   $(KALLSYMS) is a dependency to .tmp_kallsyms% but make suddenly complains about
#   .tmp_kallsyms2 for some reasons.
#   
#   Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
# 
# Makefile
#   2004/08/17 22:34:48+02:00 sam@mars.ravnborg.org +3 -0
#   Needs to tell make that $(KALLSYMS) is only build after visiting scripts
# 
diff -Nru a/Makefile b/Makefile
--- a/Makefile	2004-08-19 01:04:26 +02:00
+++ b/Makefile	2004-08-19 01:04:26 +02:00
@@ -600,6 +600,9 @@
 .tmp_vmlinux3: $(vmlinux-objs) .tmp_kallsyms2.o arch/$(ARCH)/kernel/vmlinux.lds FORCE
 	$(call if_changed_rule,vmlinux__)
 
+# Needs to visit scripts/ before $(KALLSYMS) can be used.
+$(KALLSYMS): scripts ;
+
 endif
 
 # Finally the vmlinux rule
