Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750733AbWDKKyr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750733AbWDKKyr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 06:54:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750735AbWDKKyr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 06:54:47 -0400
Received: from mx1.suse.de ([195.135.220.2]:18351 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750733AbWDKKyq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 06:54:46 -0400
Date: Tue, 11 Apr 2006 12:54:45 +0200
From: "Andi Kleen" <ak@suse.de>
To: torvalds@osdl.org
Cc: discuss@x86-64.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [4/7] i386: Remove bogus special case code from AMD core 
 parsing
Message-ID: <443B8AF5.mailFPE1C8SDP@suse.de>
User-Agent: nail 10.6 11/15/03
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It's not actually needed and would break non power of two number
of cores.

Follows similar earlier x86-64 patch.

Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/i386/kernel/cpu/amd.c |    2 --
 1 files changed, 2 deletions(-)

Index: linux/arch/i386/kernel/cpu/amd.c
===================================================================
--- linux.orig/arch/i386/kernel/cpu/amd.c
+++ linux/arch/i386/kernel/cpu/amd.c
@@ -212,8 +212,6 @@ static void __init init_amd(struct cpuin
 
 	if (cpuid_eax(0x80000000) >= 0x80000008) {
 		c->x86_max_cores = (cpuid_ecx(0x80000008) & 0xff) + 1;
-		if (c->x86_max_cores & (c->x86_max_cores - 1))
-			c->x86_max_cores = 1;
 	}
 
 	if (cpuid_eax(0x80000000) >= 0x80000007) {
