Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265835AbTGDHrM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 03:47:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265836AbTGDHrM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 03:47:12 -0400
Received: from [66.212.224.118] ([66.212.224.118]:60684 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S265835AbTGDHrL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 03:47:11 -0400
Date: Fri, 4 Jul 2003 03:50:27 -0400 (EDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
X-X-Sender: zwane@montezuma.mastecende.com
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Andrew Morton <akpm@osdl.org>, Helge Hafting <helgehaf@aitel.hist.no>,
       zboszor@freemail.hu, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.74-mm1
In-Reply-To: <Pine.LNX.4.53.0307040307090.24383@montezuma.mastecende.com>
Message-ID: <Pine.LNX.4.53.0307040346310.24383@montezuma.mastecende.com>
References: <3F0407D1.8060506@freemail.hu> <3F042AEE.2000202@freemail.hu>
 <20030703122243.51a6d581.akpm@osdl.org> <20030703200858.GA31084@hh.idb.hist.no>
 <20030703141508.796e4b82.akpm@osdl.org> <20030704055315.GW26348@holomorphy.com>
 <Pine.LNX.4.53.0307040307090.24383@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Jul 2003, Zwane Mwaikambo wrote:

> The second one is correct. So one definite failing piece of code was in 
> the cpus_or() path, i'm not so sure about the others. I have attached the 
> test case. Bill says his gcc 3.3 works...

Uninlining bitmap_or fixes the test case with -O2 Could you try the 
following patch with your kernels?

--- linux-2.5.74-cpumask/include/linux/bitmap.h.orig	2003-07-04 03:48:22.746229592 -0400
+++ linux-2.5.74-cpumask/include/linux/bitmap.h	2003-07-04 03:49:39.606545048 -0400
@@ -100,7 +100,7 @@
 	bitmap_copy(dst, __shl_tmp, bits);
 }
 
-static inline void bitmap_and(volatile unsigned long *dst, const volatile unsigned long *bitmap1, const volatile unsigned long *bitmap2, int bits)
+static void bitmap_and(volatile unsigned long *dst, const volatile unsigned long *bitmap1, const volatile unsigned long *bitmap2, int bits)
 {
 	int k;
 
@@ -108,7 +108,7 @@
 		dst[k] = bitmap1[k] & bitmap2[k];
 }
 
-static inline void bitmap_or(volatile unsigned long *dst, const volatile unsigned long *bitmap1, const volatile unsigned long *bitmap2, int bits)
+static void bitmap_or(volatile unsigned long *dst, const volatile unsigned long *bitmap1, const volatile unsigned long *bitmap2, int bits)
 {
 	int k;
 

-- 
function.linuxpower.ca
