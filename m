Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262837AbVBCEsP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262837AbVBCEsP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 23:48:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262850AbVBCErp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 23:47:45 -0500
Received: from mx1.redhat.com ([66.187.233.31]:40637 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262837AbVBCErS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 23:47:18 -0500
Date: Wed, 2 Feb 2005 23:47:02 -0500
From: Dave Jones <davej@redhat.com>
To: tglx@linutronix.de, akpm@osdl.org, torvalds@osdl.org, dwmw2@infradead.org,
       albert_herranz@yahoo.es
Cc: linux-kernel@vger.kernel.org
Subject: ppc32 MMCR0_PMXE saga.
Message-ID: <20050203044702.GA1089@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, tglx@linutronix.de,
	akpm@osdl.org, torvalds@osdl.org, dwmw2@infradead.org,
	albert_herranz@yahoo.es, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm at a loss to explain whats been happening with this symbol.


ChangeSet 1.2370, 2005/01/11 17:41:32-08:00, tglx@linutronix.de

    [PATCH] ppc: remove duplicate define

    The MMCR0_PMXE is already defined in reg.h, so no need to redefine it here.

    Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Linus Torvalds <torvalds@osdl.org>

ChangeSet 1.2514, 2005/01/12 09:02:21-08:00, dwmw2@infradead.org

    [PATCH] ppc: fix removed MMCR0_PMXE define

    In ChangeSet 1.2370, 2005/01/11 17:41:32-08:00, tglx@linutronix.de wrote:
    >
    >         [PATCH] ppc: remove duplicate define
    >
    >         The MMCR0_PMXE is already defined in reg.h...

    Er, no it's not. But perhaps it should be...

ChangeSet 1.1992.2.33, 2005/02/02 08:36:04-08:00, albert_herranz@yahoo.es

    [PATCH] ppc32: perfctl-ppc: fix duplicate mmcr0 define

    Fix a compilation warning due to a duplicate definition of MMCR0_PMXE.

    The definition comes in perfctr-ppc.patch, but was recently introduced too
    in Linus tree.

    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Linus Torvalds <torvalds@osdl.org>


Clearly it *is* needed, as without it, this happens ..

arch/ppc/kernel/perfmon.c:55: error: `MMCR0_PMXE' undeclared (first use in this function)

grep shows no occurances of MMCR0_PMXE in include/asm-ppc that I can
see, so that last changeset is very confusing.

		Dave

Unbreak ppc32 perfctr build.

Signed-off-by: Dave Jones <davej@redhat.com>


--- linux-2.6.10/include/asm-ppc/reg.h~	2005-02-02 23:28:14.000000000 -0500
+++ linux-2.6.10/include/asm-ppc/reg.h	2005-02-02 23:28:36.000000000 -0500
@@ -333,6 +333,7 @@
 #define MMCR0_PMC2_CYCLES	0x1
 #define MMCR0_PMC2_ITLB		0x7
 #define MMCR0_PMC2_LOADMISSTIME	0x5
+#define MMCR0_PMXE	(1 << 26)
 
 /* Short-hand versions for a number of the above SPRNs */
 #define CTR	SPRN_CTR	/* Counter Register */
