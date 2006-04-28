Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965188AbWD1F2t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965188AbWD1F2t (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 01:28:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965189AbWD1F2t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 01:28:49 -0400
Received: from cantor2.suse.de ([195.135.220.15]:22936 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S965188AbWD1F2s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 01:28:48 -0400
Date: Fri, 28 Apr 2006 07:28:46 +0200
From: "Andi Kleen" <ak@suse.de>
To: torvalds@osdl.org
Cc: discuss@x86-64.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [3/4] i386: Fix overflow in e820_all_mapped
Message-ID: <4451A80E.mailNZX1XN4A8@suse.de>
User-Agent: nail 10.6 11/15/03
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The 32bit version of e820_all_mapped() needs to use u64 to avoid
overflows on PAE systems.  Pointed out by Jan Beulich

Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/i386/kernel/setup.c |    2 +-
 include/asm-i386/e820.h  |    3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

Index: linux/arch/i386/kernel/setup.c
===================================================================
--- linux.orig/arch/i386/kernel/setup.c
+++ linux/arch/i386/kernel/setup.c
@@ -970,7 +970,7 @@ efi_memory_present_wrapper(unsigned long
   * not-overlapping, which is the case
   */
 int __init
-e820_all_mapped(unsigned long start, unsigned long end, unsigned type)
+e820_all_mapped(u64 start, u64 end, unsigned type)
 {
 	int i;
 	for (i = 0; i < e820.nr_map; i++) {
Index: linux/include/asm-i386/e820.h
===================================================================
--- linux.orig/include/asm-i386/e820.h
+++ linux/include/asm-i386/e820.h
@@ -36,8 +36,7 @@ struct e820map {
 
 extern struct e820map e820;
 
-extern int e820_all_mapped(unsigned long start, unsigned long end,
-			   unsigned type);
+extern int e820_all_mapped(u64 start, u64 end, unsigned type);
 
 #endif/*!__ASSEMBLY__*/
 
