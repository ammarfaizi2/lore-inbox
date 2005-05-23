Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261194AbVEWXuC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261194AbVEWXuC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 19:50:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261253AbVEWXpl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 19:45:41 -0400
Received: from fire.osdl.org ([65.172.181.4]:62086 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261194AbVEWXb2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 19:31:28 -0400
Date: Mon, 23 May 2005 16:30:47 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, ak@suse.de
Subject: [patch 14/16] x86_64: Add a guard page at the end of the 47bit address space
Message-ID: <20050523233047.GZ27549@shell0.pdx.osdl.net>
References: <20050523231529.GL27549@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050523231529.GL27549@shell0.pdx.osdl.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] x86_64: Add a guard page at the end of the 47bit address space

This works around a bug in the AMD K8 CPUs.

Signed-off-by: Andi Kleen <ak@suse.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Chris Wright <chrisw@osdl.org>
---

 processor.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

Index: release-2.6.11/include/asm-x86_64/processor.h
===================================================================
--- release-2.6.11.orig/include/asm-x86_64/processor.h
+++ release-2.6.11/include/asm-x86_64/processor.h
@@ -160,9 +160,9 @@ static inline void clear_in_cr4 (unsigne
 
 
 /*
- * User space process size. 47bits.
+ * User space process size. 47bits minus one guard page.
  */
-#define TASK_SIZE	(0x800000000000UL)
+#define TASK_SIZE	(0x800000000000UL - 4096)
 
 /* This decides where the kernel will search for a free chunk of vm
  * space during mmap's.

