Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262109AbVFHFdR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262109AbVFHFdR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 01:33:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262110AbVFHFdR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 01:33:17 -0400
Received: from ozlabs.org ([203.10.76.45]:29902 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262109AbVFHFdO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 01:33:14 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17062.33591.132405.686993@cargo.ozlabs.ibm.com>
Date: Wed, 8 Jun 2005 15:33:43 +1000
From: Paul Mackerras <paulus@samba.org>
To: torvalds@osdl.org, akpm@osdl.org
CC: anton@samba.org, linux-kernel@vger.kernel.org, amavin@redhat.com
Subject: [PATCH] ppc64 kprobes: don't eat dabr/iabr exceptions
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ananth N Mavinakayanahalli <amavin@redhat.com>

Kprobes was eating the hardware instruction and data address
breakpoint exceptions.  This patch fixes it; kprobes doesn't use those
exceptions at all and should ignore them.

Signed-off-by: Ananth N Mavinakayanahalli <amavin@redhat.com>
Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -urN linux-2.6/arch/ppc64/kernel/kprobes.c g5-ppc64/arch/ppc64/kernel/kprobes.c
--- linux-2.6/arch/ppc64/kernel/kprobes.c	2005-04-26 15:37:55.000000000 +1000
+++ g5-ppc64/arch/ppc64/kernel/kprobes.c	2005-06-08 15:16:51.000000000 +1000
@@ -237,8 +237,6 @@
 	 */
 	preempt_disable();
 	switch (val) {
-	case DIE_IABR_MATCH:
-	case DIE_DABR_MATCH:
 	case DIE_BPT:
 		if (kprobe_handler(args->regs))
 			ret = NOTIFY_STOP;
