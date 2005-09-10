Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932290AbVIJUfh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932290AbVIJUfh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 16:35:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932294AbVIJUfg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 16:35:36 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:33039 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S932290AbVIJUff
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 16:35:35 -0400
Date: Sat, 10 Sep 2005 22:37:13 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH 6/7] kbuild: add objectify
Message-ID: <20050910203713.GF29334@mars.ravnborg.org>
References: <20050910200347.GA3762@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050910200347.GA3762@mars.ravnborg.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use foo := $(call objectify, $(foo)) to prefix $(foo) with $(obj)/ unless
$(foo) is an absolute path.
For now no in-tree users - soon to come.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

---

 scripts/Kbuild.include |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

0a504f259c90fb41d3495d490fc9dbe2530c8749
diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -49,6 +49,9 @@ build := -f $(if $(KBUILD_SRC),$(srctree
 cmd = @$(if $($(quiet)cmd_$(1)),\
       echo '  $(subst ','\'',$($(quiet)cmd_$(1)))' &&) $(cmd_$(1))
 
+# Add $(obj)/ for paths that is not absolute
+objectify = $(foreach o,$(1),$(if $(filter /%,$(o)),$(o),$(obj)/$(o)))
+
 ###
 # if_changed      - execute command if any prerequisite is newer than 
 #                   target, or command line has changed

