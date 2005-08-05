Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263011AbVHESo6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263011AbVHESo6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 14:44:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263075AbVHESow
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 14:44:52 -0400
Received: from silver.veritas.com ([143.127.12.111]:44327 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S263093AbVHESoj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 14:44:39 -0400
Date: Fri, 5 Aug 2005 19:46:24 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Dominik Karall <dominik.karall@gmx.net>
cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] preempt-trace.patch (mono preempt-trace)
In-Reply-To: <200508051958.12853.dominik.karall@gmx.net>
Message-ID: <Pine.LNX.4.61.0508051939390.6479@goblin.wat.veritas.com>
References: <20050607042931.23f8f8e0.akpm@osdl.org> <200508051626.56910.dominik.karall@gmx.net>
 <20050805152245.GA12650@elte.hu> <200508051958.12853.dominik.karall@gmx.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 05 Aug 2005 18:44:37.0091 (UTC) FILETIME=[BAD77B30:01C599ED]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Aug 2005, Dominik Karall wrote:
> On Friday 05 August 2005 17:22, Ingo Molnar wrote:
> >
> > please enable CONFIG_FRAME_POINTERS!
> 
> I'm sorry, but I think I can't enable CONFIG_FRAME_POINTERS.
> Depends on: DEBUG_KERNEL && (X86 && !X86_64 || CRIS || M68K || M68KNOMMU || 
> FRV || UML)
> 
> Seems to be disabled for x86_64.

It is disabled for x86_64, but not for any very good reason (beyond
reducing the test matrix).  I work with CONFIG_FRAME_POINTERS on x86_64
with no trouble, just add in the patch below, make oldconfig, choose
frame pointers and rebuild).  But I can't guarantee it'll actually
reveal the info Ingo and all are longing to see.

Hugh

--- 2.6.13-rc5/lib/Kconfig.debug	2005-06-17 20:48:29.000000000 +0100
+++ linux/lib/Kconfig.debug	2005-07-29 18:40:28.000000000 +0100
@@ -151,7 +151,7 @@ config DEBUG_FS
 
 config FRAME_POINTER
 	bool "Compile the kernel with frame pointers"
-	depends on DEBUG_KERNEL && ((X86 && !X86_64) || CRIS || M68K || M68KNOMMU || FRV || UML)
+	depends on DEBUG_KERNEL && (X86 || CRIS || M68K || M68KNOMMU || FRV || UML)
 	default y if DEBUG_INFO && UML
 	help
 	  If you say Y here the resulting kernel image will be slightly larger
