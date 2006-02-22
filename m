Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932189AbWBVHUJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932189AbWBVHUJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 02:20:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932190AbWBVHUJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 02:20:09 -0500
Received: from pcls2.std.com ([192.74.137.142]:30336 "EHLO TheWorld.com")
	by vger.kernel.org with ESMTP id S932189AbWBVHUI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 02:20:08 -0500
From: Alan Curry <pacman@TheWorld.com>
Message-Id: <200602220642.BAA1170849@shell.TheWorld.com>
Subject: Re: [PATCH] powerpc: fix altivec_unavailable_exception Oopses
To: galak@kernel.crashing.org (Kumar Gala)
Date: Wed, 22 Feb 2006 01:42:37 -0500 (EST)
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <4A2CF403-20CC-4AE9-B955-9BA2E92A5474@kernel.crashing.org> from "Kumar Gala" at Feb 21, 2006 06:52:16 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kumar Gala writes the following:
>
>Would you mine providing a patch for arch/ppc/kernel/head.S and  
>adding a signed-off-by line.

OK, combined patch... applies clean to 2.6.16-rc4, applies with fuzz to
2.6.15.4, both compiled and tested. Patch prevents Oopsing of
CONFIG_ALTIVEC=n kernel by user executing altivec instruction in both cases.

Signed-off-by: Alan Curry <pacman@TheWorld.com>

--- arch/ppc/kernel/head.S.orig	2006-02-21 20:58:08.000000000 -0500
+++ arch/ppc/kernel/head.S	2006-02-21 20:58:11.000000000 -0500
@@ -751,6 +751,7 @@ AltiVecUnavailable:
 #ifdef CONFIG_ALTIVEC
 	bne	load_up_altivec		/* if from user, just load it up */
 #endif /* CONFIG_ALTIVEC */
+	addi	r3,r1,STACK_FRAME_OVERHEAD
 	EXC_XFER_EE_LITE(0xf20, altivec_unavailable_exception)
 
 #ifdef CONFIG_PPC64BRIDGE
--- arch/powerpc/kernel/head_32.S.orig	2006-02-21 15:58:18.000000000 -0500
+++ arch/powerpc/kernel/head_32.S	2006-02-21 15:59:23.000000000 -0500
@@ -714,6 +714,7 @@ AltiVecUnavailable:
 #ifdef CONFIG_ALTIVEC
 	bne	load_up_altivec		/* if from user, just load it up */
 #endif /* CONFIG_ALTIVEC */
+	addi	r3,r1,STACK_FRAME_OVERHEAD
 	EXC_XFER_EE_LITE(0xf20, altivec_unavailable_exception)
 
 PerformanceMonitor:
