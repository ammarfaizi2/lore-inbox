Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262190AbVDMDTM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262190AbVDMDTM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 23:19:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262191AbVDLTch
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 15:32:37 -0400
Received: from fire.osdl.org ([65.172.181.4]:10953 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262190AbVDLKcP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:32:15 -0400
Message-Id: <200504121032.j3CAW2Bk005479@shell0.pdx.osdl.net>
Subject: [patch 088/198] x86_64: Correct wrong comment in local.h
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, ak@suse.de
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:31:55 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: "Andi Kleen" <ak@suse.de>

local_t is actually a win over atomic_t because it does not need lock
prefixes.

Signed-off-by: Andi Kleen <ak@suse.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/include/asm-x86_64/local.h |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

diff -puN include/asm-x86_64/local.h~x86_64-correct-wrong-comment-in-localh include/asm-x86_64/local.h
--- 25/include/asm-x86_64/local.h~x86_64-correct-wrong-comment-in-localh	2005-04-12 03:21:24.242451488 -0700
+++ 25-akpm/include/asm-x86_64/local.h	2005-04-12 03:21:24.245451032 -0700
@@ -45,7 +45,8 @@ static __inline__ void local_sub(unsigne
 		:"ir" (i), "m" (v->counter));
 }
 
-/* On x86, these are no better than the atomic variants. */
+/* On x86-64 these are better than the atomic variants on SMP kernels
+   because they dont use a lock prefix. */
 #define __local_inc(l)		local_inc(l)
 #define __local_dec(l)		local_dec(l)
 #define __local_add(i,l)	local_add((i),(l))
_
