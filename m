Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267552AbUI1FxP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267552AbUI1FxP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 01:53:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267553AbUI1FxP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 01:53:15 -0400
Received: from ozlabs.org ([203.10.76.45]:11401 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S267552AbUI1FxM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 01:53:12 -0400
Date: Tue, 28 Sep 2004 15:52:07 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Andrew Morton <akpm@osdl.org>
Cc: Anton Blanchard <anton@samba.org>, Paul Mackerras <paulus@samba.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       trivial@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: [TRIVIAL, PPC64] Squash childregs warnings
Message-ID: <20040928055207.GB21117@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Andrew Morton <akpm@osdl.org>, Anton Blanchard <anton@samba.org>,
	Paul Mackerras <paulus@samba.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	trivial@rustcorp.com.au, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, please apply.

Squash a couple of "pointer from integer" warnings recently
introduced.

Signed-off-by: David Gibson <dwg@au1.ibm.com>

Index: working-2.6/arch/ppc64/kernel/process.c
===================================================================
--- working-2.6.orig/arch/ppc64/kernel/process.c	2004-09-24 10:14:09.000000000 +1000
+++ working-2.6/arch/ppc64/kernel/process.c	2004-09-27 15:58:57.422805488 +1000
@@ -410,7 +410,7 @@
 		unsigned long childregs = (unsigned long)current->thread_info +
 						THREAD_SIZE;
 		childregs -= sizeof(struct pt_regs);
-		current->thread.regs = childregs;
+		current->thread.regs = (struct pt_regs *)childregs;
 	}
 
 	regs->nip = entry;
Index: working-2.6/arch/ppc64/kernel/sys_ppc32.c
===================================================================
--- working-2.6.orig/arch/ppc64/kernel/sys_ppc32.c	2004-09-24 10:14:09.000000000 +1000
+++ working-2.6/arch/ppc64/kernel/sys_ppc32.c	2004-09-27 15:59:11.094856016 +1000
@@ -642,7 +642,7 @@
 		unsigned long childregs = (unsigned long)current->thread_info +
 						THREAD_SIZE;
 		childregs -= sizeof(struct pt_regs);
-		current->thread.regs = childregs;
+		current->thread.regs = (struct pt_regs *)childregs;
 	}
 
 	/*


-- 
David Gibson			| For every complex problem there is a
david AT gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
