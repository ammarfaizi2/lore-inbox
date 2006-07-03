Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750703AbWGCArf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750703AbWGCArf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 20:47:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750719AbWGCArf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 20:47:35 -0400
Received: from thunk.org ([69.25.196.29]:17841 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1750703AbWGCArf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 20:47:35 -0400
Date: Sun, 2 Jul 2006 20:47:32 -0400
From: Theodore Tso <tytso@mit.edu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm5
Message-ID: <20060703004732.GB32434@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20060701033524.3c478698.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060701033524.3c478698.akpm@osdl.org>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch is needed to fix UML compilation in -mm5 given
that alternatives_smp_module_add and alternatives_smp_module_del are
null inline functions if !CONFIG_SMP.

Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>

Index: linux-2.6.17-mm5/arch/um/kernel/um_arch.c
===================================================================
--- linux-2.6.17-mm5.orig/arch/um/kernel/um_arch.c	2006-07-02 20:37:17.000000000 -0400
+++ linux-2.6.17-mm5/arch/um/kernel/um_arch.c	2006-07-02 20:38:08.000000000 -0400
@@ -495,6 +495,7 @@
 {
 }
 
+#ifdef CONFIG_SMP
 void alternatives_smp_module_add(struct module *mod, char *name,
 				 void *locks, void *locks_end,
 				 void *text,  void *text_end)
@@ -504,3 +505,4 @@
 void alternatives_smp_module_del(struct module *mod)
 {
 }
+#endif
