Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262373AbVEMN46@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262373AbVEMN46 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 09:56:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262371AbVEMN45
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 09:56:57 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:2309 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262373AbVEMN4s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 09:56:48 -0400
Date: Fri, 13 May 2005 15:56:39 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] mm/nommu.c: try to fix __vmalloc
Message-ID: <20050513135639.GA16549@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus changed the second argument of __vmalloc from int to unsigned int 
breaking the compilation for CONFIG_MMU=n configurations (since he only 
changed vmalloc.c but not nommu.c).

Is this patch the correct fix, or do I oversee an underlying problem?

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.12-rc4-mm1/mm/nommu.c.old	2005-05-13 06:51:33.000000000 +0200
+++ linux-2.6.12-rc4-mm1/mm/nommu.c	2005-05-13 06:55:33.000000000 +0200
@@ -146,7 +146,7 @@
 	kfree(addr);
 }
 
-void *__vmalloc(unsigned long size, int gfp_mask, pgprot_t prot)
+void *__vmalloc(unsigned long size, unsigned int __nocast gfp_mask, pgprot_t prot)
 {
 	/*
 	 * kmalloc doesn't like __GFP_HIGHMEM for some reason

