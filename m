Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751193AbVKAUou@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751193AbVKAUou (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 15:44:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751204AbVKAUou
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 15:44:50 -0500
Received: from host175-37.pool8253.interbusiness.it ([82.53.37.175]:53966 "EHLO
	zion.home.lan") by vger.kernel.org with ESMTP id S1751193AbVKAUot
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 15:44:49 -0500
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 1/2] uml: build host-binaries with the native host arch again
Date: Tue, 01 Nov 2005 21:48:37 +0100
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Message-Id: <20051101204836.27258.46611.stgit@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

This patch reverts back the changes to HOSTCFLAGS and HOSTLDFLAGS

When we were building complete binaries to get constants (such as ptrace
register layout on stack) from host userspace headers, we needed to make the
arch for building HOST binaries match our one: i.e. on a 64bit system compiling
32bit binaries, we compile 32-bit hostprogs and need, say, 32-bit ncurses. Now
we can revert that - that avoids problem with, say, menuconfig and ncurses, on a
system which can't compile well 32-bit programs.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/Makefile-i386 |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/um/Makefile-i386 b/arch/um/Makefile-i386
--- a/arch/um/Makefile-i386
+++ b/arch/um/Makefile-i386
@@ -17,8 +17,6 @@ ifeq ("$(origin SUBARCH)", "command line
 ifneq ("$(shell uname -m | sed -e s/i.86/i386/)", "$(SUBARCH)")
 CFLAGS			+= $(call cc-option,-m32)
 USER_CFLAGS		+= $(call cc-option,-m32)
-HOSTCFLAGS		+= $(call cc-option,-m32)
-HOSTLDFLAGS		+= $(call cc-option,-m32)
 AFLAGS			+= $(call cc-option,-m32)
 LINK-y			+= $(call cc-option,-m32)
 UML_OBJCOPYFLAGS	+= -F $(ELF_FORMAT)

