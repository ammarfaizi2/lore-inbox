Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268299AbUHXUoP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268299AbUHXUoP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 16:44:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268295AbUHXUoO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 16:44:14 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:28238 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S268299AbUHXUoG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 16:44:06 -0400
Date: Tue, 24 Aug 2004 22:44:44 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: [BK PATCH] kbuild: fix cc-version
Message-ID: <20040824204444.GA26136@mars.ravnborg.org>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When consolidating gcc version handling a bug were introduced.
It made make spit out

/bin/sh: line 1: [: too many arguments

when building the kernel.
As a side-effect all gcc version checks were failing.

Patch below.

Linus - please pull from
bk://linux-sam.bkbits.net/kbuild

[Only cset pushed since last update].

	Sam

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/08/24 22:36:35+02:00 sam@mars.ravnborg.org 
#   kbuild: fix cc-version
#   
#   cc-version needs to use $(shell to get the gcc version.
#   Before if gave the following error when building the kernel:
#   
#   /bin/sh: line 1: [: too many arguments
#   
#   And all checks for gcc version were broken.
#   
#   Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
# 
# Makefile
#   2004/08/24 22:34:30+02:00 sam@mars.ravnborg.org +2 -2
#   fix cc-version
# 
diff -Nru a/Makefile b/Makefile
--- a/Makefile	2004-08-24 22:37:19 +02:00
+++ b/Makefile	2004-08-24 22:37:19 +02:00
@@ -279,8 +279,8 @@
 
 # cc-version
 # Usage gcc-ver := $(call cc-version $(CC))
-cc-version = $(CONFIG_SHELL) $(srctree)/scripts/gcc-version.sh \
-              $(if $(1), $(1), $(CC))
+cc-version = $(shell $(CONFIG_SHELL) $(srctree)/scripts/gcc-version.sh \
+              $(if $(1), $(1), $(CC)))
 
 
 # Look for make include files relative to root of kernel src
