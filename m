Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750893AbWG0LnS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750893AbWG0LnS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 07:43:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751308AbWG0LnR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 07:43:17 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:63643 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750893AbWG0LnR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 07:43:17 -0400
Date: Thu, 27 Jul 2006 13:40:59 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch -mm] s390: remove s390 touch_nmi_watchdog() define
Message-ID: <20060727114059.GB9594@osiris.boeblingen.de.ibm.com>
References: <20060727015639.9c89db57.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060727015639.9c89db57.akpm@osdl.org>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Remove s390 touch_nmi_watchdog() define to avoid compile warnings.

touch_nmi_watchdog() got converted to touch_softlockup_watchdog() which
in case of !CONFIG_DETECT_SOFTLOCKUP is also a nop, just like we want it
on s390.

In file included from kernel/sched.c:23:
include/linux/nmi.h:20:1: warning: "touch_nmi_watchdog" redefined
In file included from include/linux/nmi.h:8,
                 from kernel/sched.c:23:
include/asm/irq.h:22:1: warning: this is the location of the previous definition

Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

 include/asm-s390/irq.h |    3 ---
 1 files changed, 3 deletions(-)

Index: linux-2.6.18-rc2-mm1/include/asm-s390/irq.h
===================================================================
--- linux-2.6.18-rc2-mm1.orig/include/asm-s390/irq.h	2006-07-27 13:25:11.000000000 +0200
+++ linux-2.6.18-rc2-mm1/include/asm-s390/irq.h	2006-07-27 13:34:53.000000000 +0200
@@ -19,8 +19,5 @@
 	NR_IRQS,
 };
 
-#define touch_nmi_watchdog() do { } while(0)
-
 #endif /* __KERNEL__ */
 #endif
-
