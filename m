Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266885AbUHOUT7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266885AbUHOUT7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 16:19:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266881AbUHOUSb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 16:18:31 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:46396 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S266882AbUHOURh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 16:17:37 -0400
Date: Sun, 15 Aug 2004 22:20:13 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: kbuild: Allow external modules to use host.progs with no warning
Message-ID: <20040815202013.GE14133@mars.ravnborg.org>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20040815201224.GI7682@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040815201224.GI7682@mars.ravnborg.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/08/15 21:54:22+02:00 sam@mars.ravnborg.org 
#   kbuild: Allow external modules to use host-progs with no warning
#   
#   Only warn if $(host-progs) and $(hostptogs-y) are not equal.
#   This allows external modules to use:
#   hostprogs-y := file ...
#   host-progs  := $(hostprogs-y)
#   
#   This is backwards compatible and will not warn.
#   
#   Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
# 
# scripts/Makefile.build
#   2004/08/15 21:54:06+02:00 sam@mars.ravnborg.org +2 -0
#   Only warn if $(host-progs) and $(hostptogs-y) are not equal.
#   This allows external modules to use:
#   hostprogs-y := file ...
#   host-progs := $(hostprogs-y)
#   
#   This is backwards compatible and will not warn.
# 
diff -Nru a/scripts/Makefile.build b/scripts/Makefile.build
--- a/scripts/Makefile.build	2004-08-15 22:20:04 +02:00
+++ b/scripts/Makefile.build	2004-08-15 22:20:04 +02:00
@@ -15,8 +15,10 @@
 include scripts/Makefile.lib
 
 ifdef host-progs
+ifneq ($(hostprogs-y),$(host-progs))
 $(warning kbuild: $(obj)/Makefile - Usage of host-progs is deprecated. Please replace with hostprogs-y!)
 hostprogs-y += $(host-progs)
+endif
 endif
 
 # Do not include host rules unles needed
