Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262076AbUCNX40 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 18:56:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262078AbUCNX40
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 18:56:26 -0500
Received: from waste.org ([209.173.204.2]:24201 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262076AbUCNX4Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 18:56:25 -0500
Date: Sun, 14 Mar 2004 17:56:19 -0600
From: Matt Mackall <mpm@selenic.com>
To: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: [patch] Fix stack overflow test for non-8k stacks
Message-ID: <20040314235619.GY20174@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is needed to work properly with 4k and 16k stacks. Please apply.

 test-mpm/arch/i386/kernel/entry.S |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN arch/i386/kernel/entry.S~stack_overflow arch/i386/kernel/entry.S
--- test/arch/i386/kernel/entry.S~stack_overflow	2004-03-14 17:37:47.000000000 -0600
+++ test-mpm/arch/i386/kernel/entry.S	2004-03-14 17:49:25.000000000 -0600
@@ -55,7 +55,7 @@
          */
 #ifdef CONFIG_STACK_OVERFLOW_TEST
 #define STACK_OVERFLOW_TEST \
-        testl $7680,%esp;    \
+        testl $(THREAD_SIZE - 512),%esp;    \
         jnz   10f;            \
         call  stack_overflow; \
 10:

_


-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
