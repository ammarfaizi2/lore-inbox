Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261888AbVEPVFz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261888AbVEPVFz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 17:05:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261876AbVEPVER
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 17:04:17 -0400
Received: from mx1.redhat.com ([66.187.233.31]:9393 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261888AbVEPVCZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 17:02:25 -0400
Date: Mon, 16 May 2005 17:02:17 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: linux-kernel@vger.kernel.org
cc: xen-devel@lists.xensource.com
Subject: [PATCH] Makefile include path ordering
Message-ID: <Pine.LNX.4.61.0505161700150.14180@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The arch Makefile may override the include path order, which is
used by Xen (and UML?) to make sure include/asm-xen is searched
before include/asm-i386.

The Makefile change to 2.6.12-rc4 made the top Makefile always
override the value specified by the arch Makefile.  This trivial
patch makes the Xen kernel compile again.

Signed-off-by: Rik van Riel <riel@redhat.com>

--- linux-2.6.11/Makefile.order	2005-05-16 16:20:20.000000000 -0400
+++ linux-2.6.11/Makefile	2005-05-16 16:21:30.000000000 -0400
@@ -530,7 +530,7 @@
 include $(srctree)/arch/$(ARCH)/Makefile
 
 # arch Makefile may override CC so keep this after arch Makefile is included
-NOSTDINC_FLAGS := -nostdinc -isystem $(shell $(CC) -print-file-name=include)
+NOSTDINC_FLAGS += -nostdinc -isystem $(shell $(CC) -print-file-name=include)
 CHECKFLAGS     += $(NOSTDINC_FLAGS)
 
 # warn about C99 declaration after statement
