Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261233AbVCAEbd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261233AbVCAEbd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 23:31:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261234AbVCAEbd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 23:31:33 -0500
Received: from gate.crashing.org ([63.228.1.57]:45753 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261233AbVCAEbQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 23:31:16 -0500
Subject: [PATCH] ppc64: Fix zImage wrapper incorrect size to flush_cache()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Content-Type: text/plain
Date: Tue, 01 Mar 2005 15:29:25 +1100
Message-Id: <1109651365.7669.21.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

This patch fixes a bug in the ppc64 zImage wrapper causing it to
pass an incorrect size to flush_cache() when flushing the data and
instruction caches prior to jumping to the kernel entry. This causes
crashes on firmare environment that do strict MMU mapping only of
actually allocated areas

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>


--- dingo/2.6.10-bk5/arch/ppc64/boot/main.c	2004-12-25 08:35:50.000000000 +1100
+++ 2.6.10-bk5/arch/ppc64/boot/main.c	2005-02-16 17:10:49.194263268 +1100
@@ -200,7 +200,7 @@
 	vmlinux.addr += (unsigned long)elf64ph->p_offset;
 	vmlinux.size -= (unsigned long)elf64ph->p_offset;
 
-	flush_cache((void *)vmlinux.addr, vmlinux.memsize);
+	flush_cache((void *)vmlinux.addr, vmlinux.size);
 
 	if (a1)
 		printf("initrd head: 0x%lx\n\r", *((u32 *)initrd.addr));


