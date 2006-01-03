Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965084AbWACXgU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965084AbWACXgU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 18:36:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965108AbWACXgT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 18:36:19 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:38625 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S965093AbWACXfv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 18:35:51 -0500
Date: Tue, 3 Jan 2006 15:35:45 -0800
From: Jason Uhlenkott <jasonuhl@sgi.com>
To: ak@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] x86_64: fix IRQ vector reservations
Message-ID: <20060103233544.GA393161@dragonfly.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It looks like the new scalable TLB flush code for x86_64 is claiming
one more IRQ vector than it actually uses.

Signed-off-by: Jason Uhlenkott <jasonuhl@sgi.com>


Index: linux/include/asm-x86_64/hw_irq.h
===================================================================
--- linux.orig/include/asm-x86_64/hw_irq.h	2006-01-02 19:21:10.000000000 -0800
+++ linux/include/asm-x86_64/hw_irq.h	2006-01-03 15:18:36.923399691 -0800
@@ -46,8 +46,6 @@
  *  some of the following vectors are 'rare', they are merged
  *  into a single vector (CALL_FUNCTION_VECTOR) to save vector space.
  *  TLB, reschedule and local APIC vectors are performance-critical.
- *
- *  Vectors 0xf0-0xf9 are free (reserved for future Linux use).
  */
 #define SPURIOUS_APIC_VECTOR	0xff
 #define ERROR_APIC_VECTOR	0xfe
@@ -56,8 +54,8 @@
 #define KDB_VECTOR		0xfb	/* reserved for KDB */
 #define THERMAL_APIC_VECTOR	0xfa
 #define THRESHOLD_APIC_VECTOR   0xf9
-#define INVALIDATE_TLB_VECTOR_END	0xf8
-#define INVALIDATE_TLB_VECTOR_START	0xf0	/* f0-f8 used for TLB flush */
+#define INVALIDATE_TLB_VECTOR_END	0xf7
+#define INVALIDATE_TLB_VECTOR_START	0xf0	/* f0-f7 used for TLB flush */
 
 #define NUM_INVALIDATE_TLB_VECTORS	8
 
