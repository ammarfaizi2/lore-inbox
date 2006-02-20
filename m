Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932642AbWBTTgm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932642AbWBTTgm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 14:36:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932649AbWBTTgm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 14:36:42 -0500
Received: from 41.150.104.212.access.eclipse.net.uk ([212.104.150.41]:28312
	"EHLO pinky.shadowen.org") by vger.kernel.org with ESMTP
	id S932642AbWBTTgl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 14:36:41 -0500
Date: Mon, 20 Feb 2006 19:36:16 +0000
To: Reuben Farrelly <reuben-lkml@reub.net>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] remove ccache from top level Makefile and make configurable
Message-ID: <20060220193616.GA16407@shadowen.org>
References: <43F9B8A9.4000506@reub.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
InReply-To: <43F9B8A9.4000506@reub.net>
User-Agent: Mutt/1.5.11
From: Andy Whitcroft <apw@shadowen.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

remove ccache from top level Makefile and make configurable

[Here is the patch I used to fix this for out nightly testing.
It seems that if it were something we could configure from outside
the source we'd avoid this occuring again.]

Remove errant ccache from top-level makefile and make it configurable on
the kernel build line.

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
---
 Makefile |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)
diff -upN reference/Makefile current/Makefile
--- reference/Makefile
+++ current/Makefile
@@ -171,9 +171,11 @@ SUBARCH := $(shell uname -m | sed -e s/i
 # Alternatively CROSS_COMPILE can be set in the environment.
 # Default value for CROSS_COMPILE is not to prefix executables
 # Note: Some architectures assign CROSS_COMPILE in their arch/*/Makefile
+# CCACHE specifies the name of a ccache binary to use with gcc.
 
 ARCH		?= $(SUBARCH)
 CROSS_COMPILE	?=
+CCACHE		?=
 
 # Architecture as present in compile.h
 UTS_MACHINE := $(ARCH)
@@ -274,7 +276,7 @@ include  $(srctree)/scripts/Kbuild.inclu
 
 AS		= $(CROSS_COMPILE)as
 LD		= $(CROSS_COMPILE)ld
-CC		= ccache $(CROSS_COMPILE)gcc
+CC		= $(CCACHE) $(CROSS_COMPILE)gcc
 CPP		= $(CC) -E
 AR		= $(CROSS_COMPILE)ar
 NM		= $(CROSS_COMPILE)nm
