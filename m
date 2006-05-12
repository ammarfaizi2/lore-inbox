Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750785AbWELVex@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750785AbWELVex (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 17:34:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750791AbWELVex
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 17:34:53 -0400
Received: from tetsuo.zabbo.net ([207.173.201.20]:463 "EHLO tetsuo.zabbo.net")
	by vger.kernel.org with ESMTP id S1750785AbWELVex (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 17:34:53 -0400
From: Zach Brown <zach.brown@oracle.com>
To: Andrew Morton <akpm@osdl.org>, Sam Ravnborg <sam@ravnborg.org>,
       linux-kernel@vger.kernel.org
Message-Id: <20060512213452.2074.84076.sendpatchset@tetsuo.zabbo.net>
Subject: [PATCH] Add dependency on kernel.release to the package targets
Date: Fri, 12 May 2006 14:34:52 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Add dependency on kernel.release to the package targets

The binrpm-pkg target uses KERNELRELEASE when generated its .spec
file.  When binrpm-pkg was the first build target run in a tree it
generated the .spec before kernel.release so the Version: tag
in the .spec was empty.

I don't know if this is the best fix, but binrpm-pkg works when we
explicitly build kernel.release before descending into package-dir.

Signed-off-by: Zach Brown <zach.brown@oracle.com>
---

 Makefile |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: 2.6.17-rc3-mm1-rds/Makefile
===================================================================
--- 2.6.17-rc3-mm1-rds.orig/Makefile
+++ 2.6.17-rc3-mm1-rds/Makefile
@@ -986,9 +986,9 @@ distclean: mrproper
 # rpm target kept for backward compatibility
 package-dir	:= $(srctree)/scripts/package
 
-%pkg: FORCE 
+%pkg: include/config/kernel.release FORCE
 	$(Q)$(MAKE) $(build)=$(package-dir) $@
-rpm: FORCE
+rpm: include/config/kernel.release FORCE
 	$(Q)$(MAKE) $(build)=$(package-dir) $@
 
 
