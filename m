Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750834AbVKKQGb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750834AbVKKQGb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 11:06:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750835AbVKKQGb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 11:06:31 -0500
Received: from ozlabs.org ([203.10.76.45]:16877 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1750834AbVKKQGa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 11:06:30 -0500
Date: Sat, 12 Nov 2005 03:03:41 +1100
From: Anton Blanchard <anton@samba.org>
To: apw@shadowen.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Allow flatmem to be disabled when only sparsemem is implemented
Message-ID: <20051111160341.GK14770@krispykreme>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Andy,

What do you think about this?

Anton

--

On architectures that implement sparsemem but not discontigmem we want
to be able to hide the flatmem option in some cases. On ppc64 for
example, when we select NUMA we must not select flatmem.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 
Index: build/mm/Kconfig
===================================================================
--- build.orig/mm/Kconfig	2005-11-11 11:31:38.000000000 +1100
+++ build/mm/Kconfig	2005-11-11 11:41:55.000000000 +1100
@@ -11,7 +11,7 @@
 
 config FLATMEM_MANUAL
 	bool "Flat Memory"
-	depends on !ARCH_DISCONTIGMEM_ENABLE || ARCH_FLATMEM_ENABLE
+	depends on !(ARCH_DISCONTIGMEM_ENABLE || ARCH_SPARSEMEM_ENABLE) || ARCH_FLATMEM_ENABLE
 	help
 	  This option allows you to change some of the ways that
 	  Linux manages its memory internally.  Most users will
