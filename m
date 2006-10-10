Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964914AbWJJB7Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964914AbWJJB7Q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 21:59:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964915AbWJJB7Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 21:59:16 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:59600 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S964914AbWJJB7N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 21:59:13 -0400
Date: Tue, 10 Oct 2006 11:59:02 +1000
From: Greg Banks <gnb@sgi.com>
To: Kai Germaschewski <kai@germaschewski.name>,
       Sam Ravnborg <sam@ravnborg.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] kbuild: allow multi-word $M in Makefile.modpost
Message-ID: <20061010015902.GZ28796@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some people want to do crazy things like pass multiple directories
as the value of $(SUBDIRS) or $M.  Mostly this kinda works, except
that Makefile.modpost constructs a modpost commandline which fails
modpost's argument parsing.  This patch fixes that little wrinkle.

Signed-off-by: Greg Banks <gnb@melbourne.sgi.com>
---

 scripts/Makefile.modpost |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux-git-20061009/scripts/Makefile.modpost
===================================================================
--- linux-git-20061009.orig/scripts/Makefile.modpost	2006-10-09 17:01:57.000000000 +1000
+++ linux-git-20061009/scripts/Makefile.modpost	2006-10-10 11:41:20.952515917 +1000
@@ -44,7 +44,7 @@ include scripts/Kbuild.include
 include scripts/Makefile.lib
 
 kernelsymfile := $(objtree)/Module.symvers
-modulesymfile := $(KBUILD_EXTMOD)/Module.symvers
+modulesymfile := $(firstword $(KBUILD_EXTMOD))/Module.symvers
 
 # Step 1), find all modules listed in $(MODVERDIR)/
 __modules := $(sort $(shell grep -h '\.ko' /dev/null $(wildcard $(MODVERDIR)/*.mod)))


-- 
Greg Banks, R&D Software Engineer, SGI Australian Software Group.
I don't speak for SGI.
