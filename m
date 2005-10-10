Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751005AbVJJX2J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751005AbVJJX2J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 19:28:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751014AbVJJX2J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 19:28:09 -0400
Received: from ns1.suse.de ([195.135.220.2]:12745 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751005AbVJJX2I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 19:28:08 -0400
From: Andi Kleen <ak@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH for 2.6.14] i386: Don't discard upper 32bits of HWCR on K8
Date: Tue, 11 Oct 2005 01:28:33 +0200
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org, discuss@x86-64.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510110128.34077.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Need to use long long, not long when RMWing a MSR. I think
it's harmless right now, but still should be better fixed
if AMD adds any bits in the upper 32bit of HWCR.

Bug was introduced with the TLB flush filter fix for i386

Signed-off-by: Andi Kleen <ak@suse.de>

Index: linux/arch/i386/kernel/cpu/amd.c
===================================================================
--- linux.orig/arch/i386/kernel/cpu/amd.c
+++ linux/arch/i386/kernel/cpu/amd.c
@@ -29,7 +29,7 @@ static void __init init_amd(struct cpuin
 	int r;
 
 #ifdef CONFIG_SMP
-	unsigned long value;
+	unsigned long long value;
 
 	/* Disable TLB flush filter by setting HWCR.FFDIS on K8
 	 * bit 6 of msr C001_0015
