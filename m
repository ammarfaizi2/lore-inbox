Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267409AbUIKEh0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267409AbUIKEh0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 00:37:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267433AbUIKEh0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 00:37:26 -0400
Received: from ozlabs.org ([203.10.76.45]:56035 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S267409AbUIKEhZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 00:37:25 -0400
Date: Sat, 11 Sep 2004 14:33:03 +1000
From: Anton Blanchard <anton@samba.org>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: paulus@samba.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [ppc64] Remove -Wno-uninitialized
Message-ID: <20040911043303.GB6005@krispykreme>
References: <200409101520.12653.jbarnes@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409101520.12653.jbarnes@engr.sgi.com>
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Sorry if you already got these fixes, but err may be used uninitialized in 
> mempolicy.c in both compat_set_mempolicy and compat_mbind.  This patch fixes 
> that by setting them both to 0.

Thanks Jesse, I wonder why I missed this. Yuck, that would explain it.

Andrew: A follow up patch fixing a bunch of ppc64 warnings is on the way.

Anton

===== arch/ppc64/Makefile 1.47 vs edited =====
--- 1.47/arch/ppc64/Makefile	Mon Aug 23 06:24:25 2004
+++ edited/arch/ppc64/Makefile	Sat Sep 11 14:30:01 2004
@@ -26,8 +26,7 @@
 
 LDFLAGS		:= -m elf64ppc
 LDFLAGS_vmlinux	:= -Bstatic -e $(KERNELLOAD) -Ttext $(KERNELLOAD)
-CFLAGS		+= -msoft-float -pipe -Wno-uninitialized -mminimal-toc \
-		   -mtraceback=none
+CFLAGS		+= -msoft-float -pipe -mminimal-toc -mtraceback=none
 
 ifeq ($(CONFIG_POWER4_ONLY),y)
 	CFLAGS += $(call cc-option,-mcpu=power4)
