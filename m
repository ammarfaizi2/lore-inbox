Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262638AbVAVAib@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262638AbVAVAib (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 19:38:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262639AbVAVASB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 19:18:01 -0500
Received: from waste.org ([216.27.176.166]:35463 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262628AbVAVAJz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 19:09:55 -0500
Date: Fri, 21 Jan 2005 18:09:49 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <6.464233479@selenic.com>
Message-Id: <7.464233479@selenic.com>
Subject: [PATCH 6/8] core-small: Shrink futex queue hash
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_CORE_SMALL reduce futex hash table

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: tiny-new/kernel/futex.c
===================================================================
--- tiny-new.orig/kernel/futex.c	2004-11-17 00:04:03.000000000 -0800
+++ tiny-new/kernel/futex.c	2004-11-17 10:30:20.749824672 -0800
@@ -40,7 +40,11 @@
 #include <linux/pagemap.h>
 #include <linux/syscalls.h>
 
+#ifdef CONFIG_CORE_SMALL
+#define FUTEX_HASHBITS 4
+#else
 #define FUTEX_HASHBITS 8
+#endif
 
 /*
  * Futexes are matched on equal values of this key.
