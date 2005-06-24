Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261440AbVFXMgK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261440AbVFXMgK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 08:36:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261902AbVFXMgK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 08:36:10 -0400
Received: from 41.150.104.212.access.eclipse.net.uk ([212.104.150.41]:3789
	"EHLO pinky.shadowen.org") by vger.kernel.org with ESMTP
	id S261440AbVFXMgA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 08:36:00 -0400
Date: Fri, 24 Jun 2005 13:35:49 +0100
To: rmk+lkml@arm.linux.org.uk, haveblue@us.ibm.com
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: Finding what change broke ARM
Message-ID: <20050624123549.GA10636@shadowen.org>
References: <20050624101951.B23185@flint.arm.linux.org.uk> <20050624105328.C23185@flint.arm.linux.org.uk> <20050624113258.A27909@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050624113258.A27909@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.9i
From: Andy Whitcroft <apw@shadowen.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Well, this fixes the problem, but I doubt people will like it.

This looks like a problem with the way the configuration options where
changed to allow more than two memory models for SPARSMEM.  I think the
right fix is the patch below.  Russell could you try this one instead.
Dave, you did most of the work on the configuration side could you look
this over (assuming it works!).

-apw

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
---
 Kconfig |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)
diff -upN reference/arch/arm/Kconfig current/arch/arm/Kconfig
--- reference/arch/arm/Kconfig
+++ current/arch/arm/Kconfig
@@ -161,7 +161,6 @@ config ARCH_RPC
 config ARCH_SA1100
 	bool "SA1100-based"
 	select ISA
-	select DISCONTIGMEM
 
 config ARCH_S3C2410
 	bool "Samsung S3C2410"
@@ -345,7 +344,7 @@ config PREEMPT
 
 config ARCH_DISCONTIGMEM_ENABLE
 	bool
-	default (ARCH_LH7A40X && !LH7A40X_CONTIGMEM)
+	default (ARCH_LH7A40X && !LH7A40X_CONTIGMEM) || ARCH_SA1100
 	help
 	  Say Y to support efficient handling of discontiguous physical memory,
 	  for architectures which are either NUMA (Non-Uniform Memory Access)
