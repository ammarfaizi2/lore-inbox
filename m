Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262175AbTFTCs2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 22:48:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262176AbTFTCs1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 22:48:27 -0400
Received: from dp.samba.org ([66.70.73.150]:10457 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262175AbTFTCsZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 22:48:25 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andi Kleen <ak@muc.de>
Cc: torvalds@transmeta.com, akpm@digeo.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove spinlock workaround for pre 2.95 gccs 
In-reply-to: Your message of "Thu, 19 Jun 2003 23:18:19 +0200."
             <20030619211819.GA12716@averell> 
Date: Fri, 20 Jun 2003 13:00:56 +1000
Message-Id: <20030620030225.952512C05E@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030619211819.GA12716@averell> you write:
> Advantage is that gcc 2.95 and 3.x compiled kernels are now binary
> compatible. Unfortunately module loading still checks the compiler
> version, but I guess that could be taken out now. As far as I know
> there should be no compiler related incompatibilities now.

Good point, Andi.  And if any particular arch has compiler version
issues it can add it back in the arch-specific part.

Patch is as trivial.  If noone else can think of any problems?
Cheers,
Rusty.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.72-bk2/include/linux/vermagic.h working-2.5.72-bk2-compiler-version/include/linux/vermagic.h
--- linux-2.5.72-bk2/include/linux/vermagic.h	2003-02-18 11:18:56.000000000 +1100
+++ working-2.5.72-bk2-compiler-version/include/linux/vermagic.h	2003-06-20 12:57:51.000000000 +1000
@@ -19,5 +19,4 @@
 #define VERMAGIC_STRING 						\
 	UTS_RELEASE " "							\
 	MODULE_VERMAGIC_SMP MODULE_VERMAGIC_PREEMPT 			\
-	MODULE_ARCH_VERMAGIC 						\
-	"gcc-" __stringify(__GNUC__) "." __stringify(__GNUC_MINOR__)
+	MODULE_ARCH_VERMAGIC

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
