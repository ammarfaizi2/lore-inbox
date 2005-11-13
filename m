Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750748AbVKMB0M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750748AbVKMB0M (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 20:26:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750749AbVKMB0L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 20:26:11 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:56850 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750748AbVKMB0K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 20:26:10 -0500
Date: Sun, 13 Nov 2005 02:26:09 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Michael Buesch <mbuesch@freenet.de>, Linus Torvalds <torvalds@osdl.org>,
       Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [2.6 patch] PPC_PREP: remove unneeded exports
Message-ID: <20051113012608.GH21448@stusta.de>
References: <Pine.LNX.4.64.0511111753080.3263@g5.osdl.org> <200511122237.17157.mbuesch@freenet.de> <20051112215304.GB21448@stusta.de> <200511122257.05552.mbuesch@freenet.de> <20051112222045.GC21448@stusta.de> <1131834667.7406.49.camel@gaston>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1131834667.7406.49.camel@gaston>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 13, 2005 at 09:31:06AM +1100, Benjamin Herrenschmidt wrote:
> 
> > ucSystemType is a variable that is EXPORT_SYMBOL'ed but never used in 
> > any way.
> > 
> > _prep_type is a variable that is needlessly EXPORT_SYMBOL'ed.
> 
> Therse are old PREP stuffs
>...

Is the patch below OK?

> Ben.

cu
Adrian


<--  snip  -->


This patch removes the EXPORT_SYMBOL'ed but completely unused variable 
ucSystemType and removes the unneeded EXPORT_SYMBOL(_prep_type).


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 arch/powerpc/kernel/ppc_ksyms.c |    5 -----
 arch/ppc/kernel/ppc_ksyms.c     |    4 ----
 arch/ppc/platforms/prep_setup.c |    1 -
 include/asm-powerpc/processor.h |    1 -
 4 files changed, 11 deletions(-)

--- linux-2.6.15-rc1/include/asm-powerpc/processor.h.old	2005-11-13 01:44:12.000000000 +0100
+++ linux-2.6.15-rc1/include/asm-powerpc/processor.h	2005-11-13 01:44:25.000000000 +0100
@@ -68,7 +68,6 @@
  * vendor. Board revision is also made available. This will be moved
  * elsewhere soon
  */
-extern unsigned char ucSystemType;
 extern unsigned char ucBoardRev;
 extern unsigned char ucBoardRevMaj, ucBoardRevMin;
 
--- linux-2.6.15-rc1/arch/ppc/platforms/prep_setup.c.old	2005-11-13 01:44:36.000000000 +0100
+++ linux-2.6.15-rc1/arch/ppc/platforms/prep_setup.c	2005-11-13 01:44:40.000000000 +0100
@@ -72,7 +72,6 @@
 
 TODC_ALLOC();
 
-unsigned char ucSystemType;
 unsigned char ucBoardRev;
 unsigned char ucBoardRevMaj, ucBoardRevMin;
 
--- linux-2.6.15-rc1/arch/ppc/kernel/ppc_ksyms.c.old	2005-11-13 01:44:49.000000000 +0100
+++ linux-2.6.15-rc1/arch/ppc/kernel/ppc_ksyms.c	2005-11-13 01:44:54.000000000 +0100
@@ -82,10 +82,6 @@
 EXPORT_SYMBOL(ISA_DMA_THRESHOLD);
 EXPORT_SYMBOL(DMA_MODE_READ);
 EXPORT_SYMBOL(DMA_MODE_WRITE);
-#if defined(CONFIG_PPC_PREP)
-EXPORT_SYMBOL(_prep_type);
-EXPORT_SYMBOL(ucSystemType);
-#endif
 
 #if !defined(__INLINE_BITOPS)
 EXPORT_SYMBOL(set_bit);
--- linux-2.6.15-rc1/arch/powerpc/kernel/ppc_ksyms.c.old	2005-11-13 01:45:06.000000000 +0100
+++ linux-2.6.15-rc1/arch/powerpc/kernel/ppc_ksyms.c	2005-11-13 01:45:12.000000000 +0100
@@ -76,11 +76,6 @@
 EXPORT_SYMBOL(sys_sigreturn);
 #endif
 
-#if defined(CONFIG_PPC_PREP)
-EXPORT_SYMBOL(_prep_type);
-EXPORT_SYMBOL(ucSystemType);
-#endif
-
 EXPORT_SYMBOL(strcpy);
 EXPORT_SYMBOL(strncpy);
 EXPORT_SYMBOL(strcat);

