Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261849AbVDKQrB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261849AbVDKQrB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 12:47:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261858AbVDKQn7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 12:43:59 -0400
Received: from bernache.ens-lyon.fr ([140.77.167.10]:25321 "EHLO
	bernache.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S261849AbVDKQkH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 12:40:07 -0400
Date: Mon, 11 Apr 2005 18:39:30 +0200
From: Benoit Boissinot <benoit.boissinot@ens-lyon.org>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, paulus@samba.org
Subject: [2.6 ppc patch] fix compilation error in include/asm-m68k/setup.h
Message-ID: <20050411163930.GA12136@ens-lyon.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
X-Spam-Report: *  1.1 NO_DNS_FOR_FROM Domain in From header has no MX or A DNS records
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

make defconfig give the following error on ppc (gcc-4):

include/asm-m68k/setup.h:365: error: array type has incomplete element
type

The following patch solves it.

Signed-Off-By: Benoit Boissinot <benoit.boissinot@ens-lyon.org>

--- ./include/asm-m68k/setup.h.orig	2004-12-24 22:35:00.000000000 +0100
+++ ./include/asm-m68k/setup.h	2005-04-11 14:19:25.000000000 +0200
@@ -360,14 +360,14 @@ extern int m68k_is040or060;
 #define COMMAND_LINE_SIZE	CL_SIZE
 
 #ifndef __ASSEMBLY__
-extern int m68k_num_memory;		/* # of memory blocks found (and used) */
-extern int m68k_realnum_memory;		/* real # of memory blocks found */
-extern struct mem_info m68k_memory[NUM_MEMINFO];/* memory description */
-
 struct mem_info {
 	unsigned long addr;		/* physical address of memory chunk */
 	unsigned long size;		/* length of memory chunk (in bytes) */
 };
+
+extern int m68k_num_memory;		/* # of memory blocks found (and used) */
+extern int m68k_realnum_memory;		/* real # of memory blocks found */
+extern struct mem_info m68k_memory[NUM_MEMINFO];/* memory description */
 #endif
 
 #endif /* __KERNEL__ */
