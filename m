Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751135AbWD3OTZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751135AbWD3OTZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Apr 2006 10:19:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751131AbWD3OSY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Apr 2006 10:18:24 -0400
Received: from host199-105.pool8255.interbusiness.it ([82.55.105.199]:23448
	"EHLO zion.home.lan") by vger.kernel.org with ESMTP
	id S1751133AbWD3OSA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Apr 2006 10:18:00 -0400
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 7/7] uml: export symbols added by GCC hardened
Date: Sun, 30 Apr 2006 16:16:24 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Message-Id: <20060430141624.9060.12015.stgit@zion.home.lan>
In-Reply-To: <20060430141512.9060.39338.stgit@zion.home.lan>
References: <20060430141512.9060.39338.stgit@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

GCC hardened introduces additional symbol refererences (for the canary and
friends), also in modules - add weak export_symbols for them. We already tested
that the weak declaration creates no problem on both GCC's providing the
function definition and on GCC's which don't provide it.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/os-Linux/user_syms.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/um/os-Linux/user_syms.c b/arch/um/os-Linux/user_syms.c
index 2598158..3f33165 100644
--- a/arch/um/os-Linux/user_syms.c
+++ b/arch/um/os-Linux/user_syms.c
@@ -96,6 +96,13 @@ EXPORT_SYMBOL_PROTO(getuid);
 EXPORT_SYMBOL_PROTO(fsync);
 EXPORT_SYMBOL_PROTO(fdatasync);
 
+/* Export symbols used by GCC for the stack protector. */
+extern void __stack_smash_handler(void *) __attribute__((weak));
+EXPORT_SYMBOL(__stack_smash_handler);
+
+extern long __guard __attribute__((weak));
+EXPORT_SYMBOL(__guard);
+
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
  * Emacs will notice this stuff at the end of the file and automatically
