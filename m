Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261471AbTHSV65 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 17:58:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261421AbTHSV4l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 17:56:41 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:1797 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S261388AbTHSVzB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 17:55:01 -0400
Date: Tue, 19 Aug 2003 23:52:57 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       Sam Ravnborg <sam@ravnborg.org>
Subject: Re: kbuild: Separate output directory - ieee patch
Message-ID: <20030819215256.GB1791@mars.ravnborg.org>
References: <20030819215157.GA1791@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030819215157.GA1791@mars.ravnborg.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1270  -> 1.1271 
#	drivers/ieee1394/Makefile	1.19    -> 1.20   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/08/19	sam@mars.ravnborg.org	1.1271
# ieee/kbuild: fix oui2c build rule
# 
# 1) Refer to script in $(srctree), so separate output directory
# works with this Makefile
# 2) Add oui.c to targets, so kbuild will detect changes in command line - done by 'if_changed'
# 3) Add FORCE to prerequisites to make sure command-line is checked
# --------------------------------------------
#
diff -Nru a/drivers/ieee1394/Makefile b/drivers/ieee1394/Makefile
--- a/drivers/ieee1394/Makefile	Tue Aug 19 23:40:56 2003
+++ b/drivers/ieee1394/Makefile	Tue Aug 19 23:40:56 2003
@@ -16,11 +16,10 @@
 obj-$(CONFIG_IEEE1394_AMDTP) += amdtp.o
 obj-$(CONFIG_IEEE1394_CMP) += cmp.o
 
-clean-files := oui.c
-
 quiet_cmd_oui2c = OUI2C   $@
-      cmd_oui2c = $(CONFIG_SHELL) $(obj)/oui2c.sh < $(obj)/oui.db > $@
+      cmd_oui2c = $(CONFIG_SHELL) $(srctree)/$(src)/oui2c.sh < $< > $@
 
-$(obj)/oui.o: $(obj)/oui.c
-$(obj)/oui.c: $(obj)/oui.db $(obj)/oui2c.sh
+targets := oui.c
+$(obj)/oui.o: $(src)/oui.c
+$(obj)/oui.c: $(src)/oui.db $(src)/oui2c.sh FORCE
 	$(call if_changed,oui2c)
