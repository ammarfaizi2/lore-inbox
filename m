Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266520AbTAJWIS>; Fri, 10 Jan 2003 17:08:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266379AbTAJWIS>; Fri, 10 Jan 2003 17:08:18 -0500
Received: from vana.vc.cvut.cz ([147.32.240.58]:4992 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id <S266520AbTAJWIQ>;
	Fri, 10 Jan 2003 17:08:16 -0500
Date: Fri, 10 Jan 2003 23:16:49 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: rusty@rustcorp.com.au
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] module-init-tools-0.9.7, depmod and GPL-only symbols
Message-ID: <20030110221649.GA5371@vana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rusty,
   I finally got 2.5.56 running with configuration I always used (== almost
everything modular), and I found that module-init-tools-0.9.7 has small
problem with GPL-only symbols: depmod ignores them :-(

   As I did not notice any newer version, please apply patch below if you
did not do something simillar already.

   Of course you can create better solution, which will actually check
license and so on, but I just decided to leave this task on kernel, as
I believe that we do not want such code duplication between kernel and
module-init-tools.
						Thanks,
							Petr Vandrovec


diff -ur module-init-tools-0.9.7.src/moduleops_core.c module-init-tools-0.9.7/moduleops_core.c
--- module-init-tools-0.9.7.src/moduleops_core.c	2002-12-26 07:04:42.000000000 +0100
+++ module-init-tools-0.9.7/moduleops_core.c	2003-01-10 23:08:47.000000000 +0100
@@ -30,6 +30,9 @@
 	ksyms = PERBIT(load_section)(module->mmap, "__ksymtab", &size);
 	for (i = 0; i < size / sizeof(struct PERBIT(kernel_symbol)); i++)
 		add_symbol(ksyms[i].name, module);
+	ksyms = PERBIT(load_section)(module->mmap, "__gpl_ksymtab", &size);
+	for (i = 0; i < size / sizeof(struct PERBIT(kernel_symbol)); i++)
+		add_symbol(ksyms[i].name, module);
 }
 
 /* Calculate the dependencies for this module */
