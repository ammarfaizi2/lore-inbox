Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261252AbUJ3TF2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261252AbUJ3TF2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 15:05:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261253AbUJ3TF2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 15:05:28 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:5354 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S261252AbUJ3TFT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 15:05:19 -0400
Date: Sat, 30 Oct 2004 12:05:18 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, mporter@kernel.crashing.org,
       takeharu1219@ybb.ne.jp
Subject: Re: [patch 3/8] KGDB support for ppc32
Message-ID: <20041030190517.GG15699@smtp.west.cox.net>
References: <2.29102004.trini@kernel.crashing.org> <1.29102004.trini@kernel.crashing.org> <3.29102004.trini@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.29102004.trini@kernel.crashing.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 29, 2004 at 11:33:29AM -0700, Tom Rini wrote:
> 
> Cc: Matt Porter <mporter@kernel.crashing.org>
> This adds KGDB support for ppc32 and was done by myself.  Note that this
> currently doesn't work on 40x || BOOKE, but that problem is more generic (the
> current ppc stub doesn't work either) and Matt Porter is close to having a
> tested solution now.

As Matt has posted his work which makes KGDB functional again, the
following small patch is needed on top of this to make 40x || BOOKE work
with this stub.

Signed-off-by: Tom Rini <trini@kernel.crashing.org>

 linux-2.6.10-rc1/arch/ppc/kernel/kgdb.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)
--- linux-2.6.10-rc1/arch/ppc/kernel/kgdb.c
+++ linux-2.6.10-rc1/arch/ppc/kernel/kgdb.c
@@ -54,7 +54,7 @@
 	{ 0x0d00, 0x04 /* SIGILL */  },		/* reserved */
 	{ 0x0e00, 0x04 /* SIGILL */  },		/* reserved */
 	{ 0x0f00, 0x04 /* SIGILL */  },		/* reserved */
-	{ 0x2000, 0x05 /* SIGTRAP */},		/* debug */
+	{ 0x2002, 0x05 /* SIGTRAP */},		/* debug */
 #else
 	{ 0x0200, 0x0b /* SIGSEGV */ },		/* machine check */
 	{ 0x0300, 0x0b /* SIGSEGV */ },		/* address error (store) */
@@ -240,8 +240,8 @@
 			if (remcom_in_buffer[0] == 's')
 			{
 #if defined (CONFIG_40x) || defined(CONFIG_BOOKE)
+				mtspr(SPRN_DBCR0, mfspr(SPRN_DBCR0) | DBCR0_IC);
 				linux_regs->msr |= MSR_DE;
-				current->thread.dbcr0 |= (DBCR0_IDM | DBCR0_IC);
 #else
 				linux_regs->msr |= MSR_SE;
 #endif

-- 
Tom Rini
http://gate.crashing.org/~trini/
